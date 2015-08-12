------------------------------
--
-- This SQL script eliminates duplicate reports based on identified duplicate 'key' demographic fields from reports with multiple case ids producing two new tables:
-- 1) duplicate_case table
-- 2) unique_case table
--
-- We followed the de-duplication process outlined in: 
--		Data Mining Techniques in Pharmacovigilance: Analysis of the Publicly Accessible FDA Adverse Event Reporting System (AERS)  
-- and use the same demographic key fields:  age, event_date, sex, reporter_country.
-- 
-- Note. We will only process unique case reports in downstream processing
--	
--
-- LTS COMPUTING LLC
------------------------------

set search_path = faers;

-- generate a table to lookup concatenated string of drugnames by primaryid
drop table if exists drugname_list;
create table drugname_list as
select primaryid, upper(string_agg(drugname, '|' order by drugname)) as drugname_list from drug group by primaryid;

-- generate a table to lookup concatenated string of reaction preferred terms by primaryid
drop table if exists reac_pt_list;
create table reac_pt_list as
select primaryid, upper(string_agg(pt, '|' order by pt)) as reac_pt_list from reac group by primaryid;

-- generate a table of distinct demographics by caseid
drop table if exists casedemo;
create table casedemo as
select caseid, caseversion, i_f_code, event_dt, age, sex, reporter_country, dwik.primaryid,
drugname_list, reac_pt_list, filename
from demo_with_imputed_keys dwik
inner join drugname_list dl
on dwik.primaryid = dl.primaryid 
inner join reac_pt_list rpl
on dwik.primaryid = rpl.primaryid;

-- determine duplicate cases that are not linked by caseid based on matching combination of 
-- demographics, drug names  and reaction preferred terms.
-- Typically this is case report information about the same patient that is submitted from two different sources 
-- (e.g health care professional and manufacturer or two different manufacturers)
drop table if exists duplicate_case;
create table duplicate_case as
with cte as (
select event_dt, age, sex, reporter_country, drugname_list, reac_pt_list, count(*)
from casedemo 
group by event_dt, age, sex, reporter_country, drugname_list, reac_pt_list
having count(distinct caseid) > 1
)
select cte.*, c.primaryid, c.caseid, c.caseversion, c.i_f_code, c.filename
from cte 
inner join casedemo c
on cte.event_dt = c.event_dt and cte.age = c.age and cte.sex = c.sex and cte.reporter_country = c.reporter_country 
and cte.drugname_list = c.drugname_list and cte.reac_pt_list = c.reac_pt_list;

--select * from duplicate_case order by event_dt, age, sex, reporter_country, drugname_list, reac_pt_list, caseid, caseversion desc limit 100 

-- create unique_case table with just the latest (max(primaryid)) to get the latest row for each case - get the latest case (either initial case if single case or a follow-on case if multiple cases)
drop table if exists unique_case;  -- 876824 + 17223 = 
create table unique_case as
select cast(primaryid as varchar) as primaryid
from (
	select primaryid  -- get the latest row for each case
	from (
	select max(cast(primaryid as bigint)) as primaryid
	from casedemo
	group by caseid
	) a 
	except
	(
		select cast(primaryid as bigint) -- remove duplicate rows from processing 
		from duplicate_case
		WHERE primaryid IN 
			(SELECT primaryid
			 FROM (	
				SELECT row_number() 
				OVER (PARTITION BY event_dt, age, sex, reporter_country, drugname_list, reac_pt_list order by cast(primaryid as bigint) desc ), primaryid
				FROM duplicate_case
				) x 
			 WHERE x.row_number > 1)
	)
	union
	(
		select cast(primaryid as bigint) -- retain the first row from each group of duplicates (the one with the highest primaryid (combined caseid and case version)) 
		from duplicate_case
		WHERE primaryid IN 
			(SELECT primaryid
			 FROM (	
				SELECT row_number() 
				OVER (PARTITION BY event_dt, age, sex, reporter_country, drugname_list, reac_pt_list order by cast(primaryid as bigint) desc ), primaryid
				FROM duplicate_case
				) x 
			 WHERE x.row_number = 1)
	)
) primaryids;
