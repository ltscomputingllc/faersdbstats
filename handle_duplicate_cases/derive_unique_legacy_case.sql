------------------------------
--
-- This SQL script eliminates duplicate legacy reports based on identified duplicate 'key' demographic fields from reports with multiple case ids producing two new tables:
-- 1) duplicate_legacy_case table
-- 2) unique_legacy_case table
--
-- We followed the de-duplication process outlined in: 
--		Data Mining Techniques in Pharmacovigilance: Analysis of the Publicly Accessible FDA Adverse Event Reporting System (AERS)  
-- and use the same demographic key fields:  age, event_dt, sex, reporter_country.
-- 
-- Note. We will only process unique legacy case reports in downstream processing
--	
--
-- LTS COMPUTING LLC
------------------------------

set search_path = faers;

-- generate a table to lookup concatenated string of drugnames by primaryid
drop table if exists drugname_legacy_list;
create table drugname_legacy_list as
select isr, upper(string_agg(drugname, '|' order by drugname)) as drugname_list 
from drug_legacy group by isr;

-- generate a table to lookup concatenated string of reaction preferred terms by primaryid
drop table if exists reac_pt_legacy_list;
create table reac_pt_legacy_list as
select isr, upper(string_agg(pt, '|' order by pt)) as reac_pt_list from reac_legacy group by isr;

-- generate a table of distinct demographics by case id
drop table if exists casedemo_legacy;
create table casedemo_legacy as
select "CASE", i_f_cod, event_dt, age, gndr_cod, reporter_country, dwik.isr,
drugname_list, reac_pt_list, filename
from demo_legacy_with_imputed_keys dwik
inner join drugname_legacy_list dl
on dwik.isr = dl.isr 
inner join reac_pt_legacy_list rpl
on dwik.isr = rpl.isr;

-- determine duplicate cases that are not linked by case id based on matching combination of 
-- demographics, drug names  and reaction preferred terms.
-- Typically this is case report information about the same patient that is submitted from two different sources 
-- (e.g health care professional and manufacturer or two different manufacturers)
drop table if exists duplicate_legacy_case;
create table duplicate_legacy_case as
with cte as (
select event_dt, age, gndr_cod, reporter_country, drugname_list, reac_pt_list, count(*)
from casedemo_legacy 
group by event_dt, age, gndr_cod, reporter_country, drugname_list, reac_pt_list
having count(distinct "CASE") > 1
)
select cte.*, c.isr, c."CASE", c.i_f_cod, c.filename
from cte 
inner join casedemo_legacy c
on cte.event_dt = c.event_dt and cte.age = c.age and cte.gndr_cod = c.gndr_cod and cte.reporter_country = c.reporter_country 
and cte.drugname_list = c.drugname_list and cte.reac_pt_list = c.reac_pt_list;

--select * from duplicate_legacy_case order by event_dt, age, gndr_cod, reporter_country, drugname_list, reac_pt_list, "CASE" limit 100 

-- create unique_legacy_case table with just the latest (max(isr)) to get the latest row for each case - get the latest case (either initial case if single case or a follow-on case if multiple cases)
drop table if exists unique_legacy_case;  
create table unique_legacy_case as
select cast(isr as varchar) as isr
from (
	select isr  -- get the latest row for each case
	from (
		select max(cast(isr as bigint)) as isr
		from casedemo_legacy
		group by "CASE"
	) a 
	except
	(
		select cast(isr as bigint) -- remove duplicate rows from processing 
		from duplicate_legacy_case
		WHERE isr IN 
			(SELECT isr
			 FROM (	
				SELECT row_number() 
				OVER (PARTITION BY event_dt, age, gndr_cod, reporter_country, drugname_list, reac_pt_list order by cast(isr as bigint) desc ), isr
				FROM duplicate_legacy_case
				) x 
			 WHERE x.row_number > 1)
	)
	union
	(
		select cast(isr as bigint) -- retain the first row from each group of duplicates (the one with the highest isr) 
		from duplicate_legacy_case
		WHERE isr IN 
			(SELECT isr
			 FROM (	
				SELECT row_number() 
				OVER (PARTITION BY event_dt, age, gndr_cod, reporter_country, drugname_list, reac_pt_list order by cast(isr as bigint) desc ), isr
				FROM duplicate_legacy_case
				) x 
			 WHERE x.row_number = 1)
	) 
) isrs;
