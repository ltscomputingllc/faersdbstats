set search_path = faers;

-- Transform the LAERS legacy demo data into the same format as the FAERS current data so we can combine demographic data across both databases and run logic to remove duplicate cases across them both
-- There is no real LAERS case version so we default to '0' to ensure that LAERS data will sort before FAERS data case version (FAERS case version is always populated and never less than '1')
-- There is no real LAERS primaryid but we generate it from CASE and case version
-- We translate LAERS country names to FAERS 2 char country codes with a join to the country_code table
--
-- We perform single imputation of missing 'key' demographic fields for multiple reports within the same case producing a new table demo_with_imputed_keys.
--
-- We followed the single imputation process in: 
--		Data Mining Techniques in Pharmacovigilance: Analysis of the Publicly Accessible FDA Adverse Event Reporting System (AERS)  
-- and use the same demographic key fields:  age, event_dt, sex, reporter_country.
-- 
-- The 'key' demographic fields are required in later processing to remove duplicate cases.
-- 
-- We will only impute single missing case demo key values for a case where there is at least one case record with a fully populated set of demo keys 
-- and we populate (impute) the value of a missing demo key field using the max value of the demo key field for the same case.
--
-- LTS Computing LLC
-------------------------------

-- generate a table to lookup concatenated string of current drugnames by primaryid
drop table if exists drugname_list;
create table drugname_list as
select primaryid, upper(string_agg(drugname, '|' order by drugname)) as drugname_list
from drug
group by primaryid;

-- generate a table to lookup concatenated string of reaction preferred terms by primaryid
drop table if exists reac_pt_list;
create table reac_pt_list as
select primaryid, upper(string_agg(pt, '|' order by pt)) as reac_pt_list
from reac
group by primaryid;

-- generate a table of current data demographics by caseid
drop table if exists casedemo;
create table casedemo as
select caseid, caseversion, i_f_code, event_dt, age, sex, reporter_country, d.primaryid, drugname_list, reac_pt_list, filename
from demo d
inner join drugname_list dl
on d.primaryid = dl.primaryid 
inner join reac_pt_list rpl
on d.primaryid = rpl.primaryid;

----------------------

-- generate a table to lookup concatenated string of legacy drugnames by isr
drop table if exists drugname_legacy_list;
create table drugname_legacy_list as
select isr, upper(string_agg(drugname, '|' order by drugname)) as drugname_list 
from drug_legacy
group by isr;

-- generate a table to lookup concatenated string of legacy reaction preferred terms by isr
drop table if exists reac_pt_legacy_list;
create table reac_pt_legacy_list as
select isr, upper(string_agg(pt, '|' order by pt)) as reac_pt_list
from reac_legacy
group by isr;

-- generate a table of legacy case demographics by case id
drop table if exists casedemo_legacy;
create table casedemo_legacy as
select "CASE", i_f_cod, event_dt, age, gndr_cod, reporter_country, d.isr, drugname_list, reac_pt_list, filename
from demo_legacy d
inner join drugname_legacy_list dl
on d.isr = dl.isr 
inner join reac_pt_legacy_list rpl
on d.isr = rpl.isr;

------------------------------

-- create a combined set of all case demographics with drug list and reaction (outcome) lists across all the LAERS legacy data and FAERS current data
drop table if exists all_casedemo;
create table all_casedemo as 
select 'FAERS' as database, caseid, cast(null as varchar) as isr, caseversion, i_f_code, event_dt, age, sex, reporter_country, primaryid, drugname_list, reac_pt_list, filename 
from casedemo 
union all
select 'LAERS' as database, "CASE" as caseid, isr, cast ('0' as varchar) as caseversion, i_f_cod as i_f_code, event_dt, age, gndr_cod as sex, e.country_code as reporter_country, cast("CASE" || '0' as varchar) as primaryid, drugname_list, reac_pt_list, filename
from casedemo_legacy a 
left outer join country_code e
on a.reporter_country = e.country_name

------------------------------

-- perform single imputation of missing 'key' demographic fields for multiple reports within the same case across all the legacy and current data

-- create table of default demo key values for each case where all the key fields are populated on at least one report for that case
drop table if exists default_all_casedemo_keys; 
create table default_all_casedemo_keys as 
	select caseid, max(event_dt) as default_event_dt, max(age) as default_age, max(sex) as default_sex, max(reporter_country) as default_reporter_country
	from all_casedemo 
	where event_dt is not null and age is not null and sex is not null and reporter_country is not null
	group by caseid;

-- single imputation of missing event_dt 
update all_casedemo a
set event_dt = default_event_dt 
from default_all_casedemo_keys d
where a.caseid = d.caseid
and a.event_dt is null and a.age is not null and a.sex is not null and a.reporter_country is not null;

-- single imputation of missing age 
update all_casedemo a 
set age = default_age 
from default_all_casedemo_keys d
where a.caseid = d.caseid
and a.event_dt is not null and a.age is null and a.sex is not null and a.reporter_country is not null;

-- single imputation of missing sex
update all_casedemo a 
set sex = default_sex 
from default_all_casedemo_keys d
where a.caseid = d.caseid
and a.event_dt is not null and a.age is not null and a.sex is null and a.reporter_country is not null;

-- single imputation of missing reporter_country
update all_casedemo a 
set reporter_country = default_reporter_country 
from default_all_casedemo_keys d
where a.caseid = d.caseid
and a.event_dt is not null and a.age is not null and a.sex is not null and a.reporter_country is null;

------------------------------

-- get the latest case row for each case across both the legacy LAERS and current FAERS data based on CASE ID
drop table if exists unique_all_casedemo;
create table unique_all_casedemo as
select database, caseid, isr, caseversion, i_f_code, event_dt, age, sex, reporter_country, primaryid, drugname_list, reac_pt_list, filename
from (
select *, 
row_number() over(partition by caseid order by primaryid desc, database desc, upper(filename) desc, i_f_code, isr desc) as row_num 
from all_casedemo 
) a where a.row_num = 1

-- get the latest case row unique key for each case across both the legacy LAERS and current FAERS data, while also removing any duplicates based on demographic key fields
-- NOTE. when using this table for subsequent joins in the ETL process, join to FAERS data using primaryid and join to LAERS data using isr
drop table if exists unique_all_case;   
create table unique_all_case as
select caseid, case when isr is not null then null else primaryid end as primaryid, isr 
from (
select caseid, primaryid,isr, 
row_number() over(partition by event_dt, age, sex, reporter_country, drugname_list, reac_pt_list 
order by primaryid desc, database desc, upper(filename) desc, i_f_code, isr desc) as row_num 
from unique_all_casedemo 
) a where a.row_num = 1

