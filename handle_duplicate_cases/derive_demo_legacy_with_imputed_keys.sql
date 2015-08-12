------------------------------
--
-- This SQL script performs single imputation of missing 'key' demographic fields for multiple reports within the same legacy case producing a new table demo_legacy_with_imputed_keys.
--
-- We followed the single imputation process in: 
--		Data Mining Techniques in Pharmacovigilance: Analysis of the Publicly Accessible FDA Adverse Event Reporting System (AERS)  
-- and use the same demographic key fields:  age, event_dt, sex, reporter_country.
-- 
-- The 'key' demographic fields are required in later processing to remove duplicate cases.
--
-- Note. After single imputation, it then removes any demographic case rows from the new table demo_legacy_with_imputed_keys 
-- where one or more of the key demo fields are still not populated.
-- i.e. we will only process case which have fully populated key demographic fields in downstream processing!
-- 
-- we will only impute single missing case demo key values for a case where there is at least one case record
-- with a fully populated set of demo keys 
-- and we populate (impute) the value of a missing demo key field using the max value of the demo key field for the same case.
--
--	
--
-- LTS COMPUTING LLC
------------------------------

set search_path = faers;
--select * from demo_legacy limit 1
-- create table of default demo legacy key values for each case where all the key fields are populated on at least on report for that case
drop table if exists demo_legacy_with_imputed_keys;
create table demo_legacy_with_imputed_keys as select * from demo_legacy; 

drop table if exists default_demo_legacy_keys; -- 885976
create table default_demo_legacy_keys as 
	select "CASE", max(event_dt) as default_event_dt, max(age) as default_age, max(gndr_cod) as default_gndr_cod, max(reporter_country) as default_reporter_country
	from demo_legacy 
	where event_dt is not null and age is not null and gndr_cod is not null and reporter_country is not null
	group by "CASE";

-- single imputation of missing event_dt  -- 1113
update demo_legacy_with_imputed_keys a
set event_dt = default_event_dt 
from default_demo_legacy_keys ddk
where a."CASE" = ddk."CASE"
and a.event_dt is null and a.age is not null and a.gndr_cod is not null and a.reporter_country is not null;

-- single imputation of missing age 
update demo_legacy_with_imputed_keys a -- 1587
set age = default_age 
from default_demo_legacy_keys ddk
where a."CASE" = ddk."CASE"
and a.event_dt is not null and a.age is null and a.gndr_cod is not null and a.reporter_country is not null;

-- single imputation of missing sex
update demo_legacy_with_imputed_keys a -- 74
set gndr_cod = default_gndr_cod 
from default_demo_legacy_keys ddk
where a."CASE" = ddk."CASE"
and a.event_dt is not null and a.age is not null and a.gndr_cod is null and a.reporter_country is not null;

-- single imputation of missing reporter_country
update demo_legacy_with_imputed_keys a -- 0
set reporter_country = default_reporter_country 
from default_demo_legacy_keys ddk
where a."CASE" = ddk."CASE"
and a.event_dt is not null and a.age is not null and a.gndr_cod is not null and a.reporter_country is null;

-- remove any cases which still do not have fully populated demo key fields -- 1,955,729; 903,201
delete from demo_legacy_with_imputed_keys where event_dt is null or age is null or gndr_cod is null or reporter_country is null;

