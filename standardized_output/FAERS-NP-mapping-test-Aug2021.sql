-- Ran over g_substance_reg
select *
from (
 select substance_uuid, name, related_latin_binomial, 
        max(case when related_common_name = '' then ltcnt.common_name 
             else related_common_name
        end) related_common_name
 from scratch_sanya.test_srs_np inner join scratch_sanya.lb_to_common_names_tsv ltcnt on upper(test_srs_np.related_latin_binomial) = upper(ltcnt.latin_binomial)
 group by substance_uuid, name, related_latin_binomial
 union 
 select test_srs_np.substance_uuid, upper(ltcnt.common_name) common_name, related_latin_binomial, 
	     max(case when related_common_name = '' then ltcnt.common_name 
             else related_common_name
         end) related_common_name
 from scratch_sanya.test_srs_np inner join scratch_sanya.lb_to_common_names_tsv ltcnt on upper(test_srs_np.related_latin_binomial) = upper(ltcnt.latin_binomial)
 group by test_srs_np.substance_uuid, upper(ltcnt.common_name), related_latin_binomial
 ) t
 where related_common_name != '' and related_common_name is not null
 order by substance_uuid 
;


-- Ran to preserve the original NP mapping in the concept table that we know has a number of issues so that where 
-- we can base our reference set on identity 
select *
into scratch_rich.np_concepts_first_run
FROM staging_vocabulary.concept cascade WHERE concept_id BETWEEN -9999999 AND -7000000 
;

-- Test queries to show how to get the first round mappings
select distinct fdtn.np_name, fdtn.concept_id, fdtn.drug_name_original
from scratch_rich.faers_drug_to_np fdtn inner join scratch_rich.np_concepts_first_run c on fdtn.concept_id = c.concept_id 
where c.concept_class_id = 'Scrub-palmetto'
order by fdtn.np_name 
;

select distinct fdtn.np_name, fdtn.concept_id, fdtn.drug_name_original
from scratch_rich.faers_drug_to_np fdtn inner join scratch_rich.np_concepts_first_run c on fdtn.concept_id = c.concept_id 
where c.concept_class_id = 'Flax seed'
order by fdtn.np_name 
;

-------- Now we can replace the NP mapping concepts in the staging_vocab mapping table

--- RUN AS SUPER USER ON THE DATABASE OF INTEREST
--alter table staging_vocabulary.concept disable trigger all;
--alter table staging_vocabulary.vocabulary disable trigger all;
--alter table staging_vocabulary.domain  disable trigger all;
--alter table staging_vocabulary.concept_class disable trigger all;
--
--DELETE FROM staging_vocabulary.concept cascade WHERE concept_id BETWEEN -9999999 AND -7000000 ;
--DELETE FROM staging_vocabulary.vocabulary cascade WHERE vocabulary_concept_id BETWEEN -9999999 AND -7000000 ;
--DELETE FROM staging_vocabulary.domain cascade WHERE domain_concept_id BETWEEN -9999999 AND -7000000 ;
--DELETE FROM staging_vocabulary.concept_class cascade WHERE concept_class_concept_id BETWEEN -9999999 AND -7000000 ;
--
--alter table staging_vocabulary.concept enable trigger all;
--alter table staging_vocabulary.vocabulary enable trigger all;
--alter table staging_vocabulary.domain  enable trigger all;
--alter table staging_vocabulary.concept_class enable trigger all;

---- and then run the insert statements 


-- 1) In the faers schema of the database created by the https://github.com/dbmi-pitt/faersdbstats project, map the unmapped drug strings 
-- to the newly added NP concepts:
set search_path to scratch_aug2021_amia;
drop table if exists  scratch_aug2021_amia.np_names_clean;
drop table if exists  scratch_aug2021_amia.upper_unmap_orig_drug_names;
drop table if exists scratch_aug2021_amia.faers_drug_to_np;

select max(c.concept_id) as concept_id, 
       TRIM(both from upper(regexp_replace(regexp_replace(regexp_replace(c.concept_name, '\[.*\]','','g'), '\(.*\)','','g'),'''''','''','g'))) as np_name
into scratch_aug2021_amia.np_names_clean
 from staging_vocabulary.concept c 
 where c.concept_id >= -7999999
  and c.concept_id <= -7000000
 group by np_name
;
CREATE INDEX np_names_clean_np_name_idx ON scratch_aug2021_amia.np_names_clean (np_name);
CREATE INDEX np_names_clean_concept_id_idx ON scratch_aug2021_amia.np_names_clean (concept_id);

 select distinct TRIM(both from UPPER(c.drug_name_original)) drug_name_original
 into scratch_aug2021_amia.upper_unmap_orig_drug_names
 from faers.combined_drug_mapping c
 where c.concept_id is null
 ;
CREATE INDEX upper_unmap_orig_drug_names_drug_name_original_idx ON scratch_aug2021_amia.upper_unmap_orig_drug_names (drug_name_original);


-- ONLY 231 results but high quality
select cdm.drug_name_original, np_lb.concept_id, np_lb.np_name
into scratch_aug2021_amia.faers_drug_to_np
from scratch_aug2021_amia.upper_unmap_orig_drug_names cdm inner join scratch_aug2021_amia.np_names_clean np_lb on 
  cdm.drug_name_original = np_lb.np_name 
;
CREATE INDEX faers_drug_to_np_drug_name_original_idx ON scratch_aug2021_amia.faers_drug_to_np (drug_name_original);
CREATE INDEX faers_drug_to_np_np_name_idx ON scratch_aug2021_amia.faers_drug_to_np (np_name);


-- create the equivalent to standard_case_drug in the DB created by https://github.com/dbmi-pitt/faersdbstats but this one is for NPs:

set search_path to scratch_aug2021_amia;
drop table if exists scratch_aug2021_amia.standard_case_np;
select primaryid, isr, drug_seq, role_cod, max(ftonp.concept_id) as standard_concept_id
into scratch_aug2021_amia.standard_case_np
from faers.combined_drug_mapping cdm inner join scratch_aug2021_amia.faers_drug_to_np ftonp on 
            cdm.drug_name_original = ftonp.drug_name_original or cdm.drug_name_original = ftonp.np_name 
group by primaryid, isr, drug_seq, role_cod
;
CREATE INDEX faers_standard_case_np_concept_id_idx ON scratch_aug2021_amia.standard_case_np (standard_concept_id);
CREATE INDEX faers_standard_case_np_primaryid_idx ON scratch_aug2021_amia.standard_case_np (primaryid);



-- create natural product (NP)/outcome combination case counts (counts for pairs NP concept_id, outcome (reaction) Meddra concept_id) 
-- and store the combination case counts in a new table called standard_np_outcome_count

set search_path to scratch_aug2021_amia;

drop table if exists scratch_aug2021_amia.standard_np_outcome_count;
create table scratch_aug2021_amia.standard_np_outcome_count as
select drug_concept_id, outcome_concept_id, count(*) as drug_outcome_pair_count, cast(null as integer) as snomed_outcome_concept_id
from (
	select 'PRIMARYID' || a.primaryid as case_key, a.standard_concept_id as drug_concept_id, b.outcome_concept_id, cast(null as integer) as snomed_outcome_concept_id
	from scratch_aug2021_amia.standard_case_np a
	inner join faers.standard_case_outcome b
	on a.primaryid = b.primaryid and a.isr is null and b.isr is null
	union 
	select 'ISR' || a.isr as case_key, a.standard_concept_id as drug_concept_id, b.outcome_concept_id, cast(null as integer) as snomed_outcome_concept_id
	from scratch_aug2021_amia.standard_case_np a
	inner join faers.standard_case_outcome b
	on a.isr = b.isr and a.isr is not null and b.isr is not null
) aa
group by drug_concept_id, outcome_concept_id;


-- Now roll up the counts to the preferred term for the NP using the concept_class_id column of the concept table

drop table if exists scratch_aug2021_amia.standard_np_class_outcome_sum;
create table scratch_aug2021_amia.standard_np_class_outcome_sum as 
select c.concept_class_id np_class_id, outcome_concept_id, sum(snoc.drug_outcome_pair_count) as np_class_outcome_pair_sum
from scratch_aug2021_amia.standard_np_outcome_count snoc inner join staging_vocabulary.concept c on snoc.drug_concept_id = c.concept_id 
group by c.concept_class_id, outcome_concept_id
;


-- Computes the 2x2 contingency table for all unique legacy and current case natural product (NP)/outcome pairs in
-- a table called standard_np_current_outcome_contingency_table

```
set search_path to scratch_aug2021_amia;

drop index if exists standard_np_outcome_count_ix;
create index standard_np_outcome_count_ix on standard_np_outcome_count(drug_concept_id, outcome_concept_id);
drop index if exists standard_np_outcome_count_2_ix;
create index standard_np_outcome_count_2_ix on standard_np_outcome_count(drug_concept_id);
drop index if exists standard_np_outcome_count_3_ix;
create index standard_np_outcome_count_3_ix on standard_np_outcome_count(outcome_concept_id);
drop index if exists standard_np_outcome_count_4_ix;
create index standard_np_outcome_count_4_ix on standard_np_outcome_count(drug_outcome_pair_count);
analyze verbose standard_np_outcome_count;

-- get count_d1 
drop table if exists standard_np_outcome_count_d1;
create table standard_np_outcome_count_d1 as
with cte as (
select sum(drug_outcome_pair_count) as count_d1 from standard_np_outcome_count 
)  
select drug_concept_id, outcome_concept_id, count_d1
from standard_np_outcome_count a,  cte; -- we need the same total for all rows so do cross join!

-- get count_a and count_b 
set search_path = scratch_aug2021_amia;
drop table if exists standard_np_outcome_count_a_count_b;
create table standard_np_outcome_count_a_count_b as
select drug_concept_id, outcome_concept_id, 
drug_outcome_pair_count as count_a, -- count of drug P and outcome R
(
	select sum(drug_outcome_pair_count)
	from standard_np_outcome_count b
	where b.drug_concept_id = a.drug_concept_id and b.outcome_concept_id <> a.outcome_concept_id 
) as count_b -- count of drug P and not(outcome R)
from standard_np_outcome_count a;

-- get count_c 
-- set search_path = faers;
set search_path = scratch_aug2021_amia;
drop table if exists standard_np_outcome_count_c;
create table standard_np_outcome_count_c as
select drug_concept_id, outcome_concept_id, 
(
	select sum(drug_outcome_pair_count) 
	from standard_np_outcome_count c
	where c.drug_concept_id <> a.drug_concept_id and c.outcome_concept_id = a.outcome_concept_id 
) as count_c -- count of not(drug P) and outcome R
from standard_np_outcome_count a; 

-- get count d2 
set search_path = scratch_aug2021_amia;
drop table if exists standard_np_outcome_count_d2;
create table standard_np_outcome_count_d2 as
select drug_concept_id, outcome_concept_id, 
(
	select sum(drug_outcome_pair_count)
	from standard_np_outcome_count d2
	where (d2.drug_concept_id = a.drug_concept_id) or (d2.outcome_concept_id = a.outcome_concept_id)
) as count_d2 -- count of all cases where drug P or outcome R 
from standard_np_outcome_count a;



--=============

-- Only run the below query when ALL OF THE ABOVE 3 QUERIES HAVE COMPLETED!
-- combine all the counts into a single contingency table
set search_path = scratch_aug2021_amia;
drop table if exists standard_np_outcome_contingency_table;
create table standard_np_outcome_contingency_table as		-- 1 second
select ab.drug_concept_id, ab.outcome_concept_id, count_a, count_b, count_c, (count_d1 - count_d2) as count_d
from standard_np_outcome_count_a_count_b ab
inner join standard_np_outcome_count_c c
on ab.drug_concept_id = c.drug_concept_id and ab.outcome_concept_id = c.outcome_concept_id
inner join standard_np_outcome_count_d1 d1
on ab.drug_concept_id = d1.drug_concept_id and ab.outcome_concept_id = d1.outcome_concept_id
inner join standard_np_outcome_count_d2 d2
on ab.drug_concept_id = d2.drug_concept_id and ab.outcome_concept_id = d2.outcome_concept_id;


-- Create a statistics table called standard_np_outcome_stats (using the counts from the previously calculated 2x2 contingency table)
-- with the following statistics for each natural product (np)/outcome pair:


-- 1) Case count
-- 2) Proportional Reporting Ratio (PRR) along with the 95% CI upper and lower values
-- 3) Reporting Odds Ratio (ROR) along with the 95% CI upper and lower values
--
-- PRR for pair:(drug P, outcome R) is calculated as (A / (A + B)) / (C / (C + D)
--
-- ROR for pair:(drug P, outcome R) is calculated as (A / C) / (B / D)
--
-- Where:
--		A = case_count for the pair:(drug P, outcome R)
--		B = sum(case_count) for all pairs:(drug P, all outcomes except outcome R)
--		C = sum(case_count) for all pairs:(all drugs except drug P, outcome R)
--		D = sum(case_count) for all pairs:(all drugs except drug P, all outcomes except outcome R)
--
-- Note if C is 0 then the resulting PRR and ROR values will be null. Potentially a relatively high constant value
-- could be assigned instead, to indicate a potential PRR and ROR signal in these cases.
--
--
-- Standard deviations are obtained from Douglas G Altman's Practical Statistics for Medical Research. 1999. Chapter 10.11. Page 267 
--
------------------------------
SET search_path = scratch_aug2021_amia;

drop table if exists standard_np_outcome_statistics;
create table standard_np_outcome_statistics as
select 
drug_concept_id, outcome_concept_id, cast(null as integer) as snomed_outcome_concept_id,
count_a as case_count,
round((count_a / (count_a + count_b)) / (count_c / (count_c + count_d)),5) as prr,
round(exp(ln((count_a / (count_a + count_b)) / (count_c / (count_c + count_d)))+1.96*sqrt((1.0/count_a)-(1.0/(count_a+count_b))+(1.0/count_c)-(1.0/(count_c+count_d)))),5) as prr_95_percent_upper_confidence_limit,
round(exp(ln((count_a / (count_a + count_b)) / (count_c / (count_c + count_d)))-1.96*sqrt((1.0/count_a)-(1.0/(count_a+count_b))+(1.0/count_c)-(1.0/(count_c+count_d)))),5) as prr_95_percent_lower_confidence_limit,
round(((count_a / count_c) / (count_b / count_d)),5) as ror,
round(exp((ln((count_a / count_c) / (count_b / count_d)))+1.96*sqrt((1.0/count_a)+(1.0/count_b)+(1.0/count_c)+(1.0/count_d))),5) as ror_95_percent_upper_confidence_limit,
round(exp((ln((count_a / count_c) / (count_b / count_d)))-1.96*sqrt((1.0/count_a)+(1.0/count_b)+(1.0/count_c)+(1.0/count_d))),5) as ror_95_percent_lower_confidence_limit
from standard_np_outcome_contingency_table;


-- computes the 2x2 contingency table based on the counts rolled up to a preferred common name for each NP all unique legacy and current case natural product (NP)/outcome pairs in a table called standard_np_class_outcome_contingency_table - 


------------------------------
--
-- This SQL script computes the 2x2 contingency table for all unique legacy and current case natural product (NP)/outcome pairs in
--  a table called standard_np_class_outcome_contingency_table - this table is based on the counts rolled up to a preferred common name for
-- each NP
--
--
------------------------------

-- set search_path = faers;
set search_path to scratch_aug2021_amia;

drop index if exists standard_np_class_outcome_sum_ix;
create index standard_np_class_outcome_sum_ix on standard_np_class_outcome_sum(np_class_id, outcome_concept_id);
drop index if exists standard_np_class_outcome_sum_2_ix;
create index standard_np_class_outcome_sum_2_ix on standard_np_class_outcome_sum(np_class_id);
drop index if exists standard_np_class_outcome_sum_3_ix;
create index standard_np_class_outcome_sum_3_ix on standard_np_class_outcome_sum(outcome_concept_id);
drop index if exists standard_np_class_outcome_sum_4_ix;
create index standard_np_class_outcome_sum_4_ix on standard_np_class_outcome_sum(np_class_outcome_pair_sum);
analyze verbose standard_np_class_outcome_sum;

-- get count_d1 
drop table if exists standard_np_class_outcome_sum_d1;
create table standard_np_class_outcome_sum_d1 as
with cte as (
select sum(np_class_outcome_pair_sum) as count_d1 from standard_np_class_outcome_sum 
)  
select np_class_id, outcome_concept_id, count_d1
from standard_np_class_outcome_sum a,  cte; -- we need the same total for all rows so do cross join!

--============= On a 4+ CPU postgresql server, run the following 3 queries in 3 different postgresql sessions so they run concurrently!

-- get count_a and count_b 
-- set search_path = faers;
set search_path = scratch_aug2021_amia;
drop table if exists standard_np_class_outcome_sum_a_count_b;
create table standard_np_class_outcome_sum_a_count_b as
select np_class_id, outcome_concept_id, 
np_class_outcome_pair_sum as count_a, -- count of drug P and outcome R
(
	select sum(np_class_outcome_pair_sum)
	from standard_np_class_outcome_sum b
	where b.np_class_id = a.np_class_id and b.outcome_concept_id <> a.outcome_concept_id 
) as count_b -- count of drug P and not(outcome R)
from standard_np_class_outcome_sum a;

-- get count_c 
-- set search_path = faers;
set search_path = scratch_aug2021_amia;
drop table if exists standard_np_class_outcome_sum_c;
create table standard_np_class_outcome_sum_c as
select np_class_id, outcome_concept_id, 
(
	select sum(np_class_outcome_pair_sum) 
	from standard_np_class_outcome_sum c
	where c.np_class_id <> a.np_class_id and c.outcome_concept_id = a.outcome_concept_id 
) as count_c -- count of not(drug P) and outcome R
from standard_np_class_outcome_sum a; 

-- get count d2 
-- set search_path = faers;
set search_path = scratch_aug2021_amia;
drop table if exists standard_np_class_outcome_sum_d2;
create table standard_np_class_outcome_sum_d2 as
select np_class_id, outcome_concept_id, 
(
	select sum(np_class_outcome_pair_sum)
	from standard_np_class_outcome_sum d2
	where (d2.np_class_id = a.np_class_id) or (d2.outcome_concept_id = a.outcome_concept_id)
) as count_d2 -- count of all cases where drug P or outcome R 
from standard_np_class_outcome_sum a;

--=============

-- Only run the below query when ALL OF THE ABOVE 3 QUERIES HAVE COMPLETED!
-- combine all the counts into a single contingency table
set search_path = scratch_aug2021_amia;
drop table if exists standard_np_class_outcome_contingency_table;
create table standard_np_class_outcome_contingency_table as		-- 1 second
select ab.np_class_id, ab.outcome_concept_id, count_a, count_b, count_c, (count_d1 - count_d2) as count_d
from standard_np_class_outcome_sum_a_count_b ab
inner join standard_np_class_outcome_sum_c c
on ab.np_class_id = c.np_class_id and ab.outcome_concept_id = c.outcome_concept_id
inner join standard_np_class_outcome_sum_d1 d1
on ab.np_class_id = d1.np_class_id and ab.outcome_concept_id = d1.outcome_concept_id
inner join standard_np_class_outcome_sum_d2 d2
on ab.np_class_id = d2.np_class_id and ab.outcome_concept_id = d2.outcome_concept_id;


-- Calculating PV signals at the NP preferred term level


SET search_path = scratch_aug2021_amia;

drop table if exists standard_np_class_outcome_statistics;
create table standard_np_class_outcome_statistics as
select 
np_class_id, outcome_concept_id,
count_a as case_count,
round((count_a / (count_a + count_b)) / (count_c / (count_c + count_d)),5) as prr,
round(exp(ln((count_a / (count_a + count_b)) / (count_c / (count_c + count_d)))+1.96*sqrt((1.0/count_a)-(1.0/(count_a+count_b))+(1.0/count_c)-(1.0/(count_c+count_d)))),5) as prr_95_percent_upper_confidence_limit,
round(exp(ln((count_a / (count_a + count_b)) / (count_c / (count_c + count_d)))-1.96*sqrt((1.0/count_a)-(1.0/(count_a+count_b))+(1.0/count_c)-(1.0/(count_c+count_d)))),5) as prr_95_percent_lower_confidence_limit,
round(((count_a / count_c) / (count_b / count_d)),5) as ror,
round(exp((ln((count_a / count_c) / (count_b / count_d)))+1.96*sqrt((1.0/count_a)+(1.0/count_b)+(1.0/count_c)+(1.0/count_d))),5) as ror_95_percent_upper_confidence_limit,
round(exp((ln((count_a / count_c) / (count_b / count_d)))-1.96*sqrt((1.0/count_a)+(1.0/count_b)+(1.0/count_c)+(1.0/count_d))),5) as ror_95_percent_lower_confidence_limit
from standard_np_class_outcome_contingency_table sncoct 
;

-- Create a standard_np_outcome_drilldown table for use in joins to get all cases for a natural product (NP)/outcome pair count, This adds the preferred term of the NP using the concept_class_id from the the vocab concept table

-- set search_path = faers;
SET search_path = scratch_aug2021_amia;

-- create indexes to speed up this SQL

drop index if exists standard_case_np_ix_1;
create index standard_case_np_ix_1 on standard_case_np(primaryid);
drop index if exists standard_case_np_ix_2;
create index standard_case_np_ix_2 on standard_case_np(isr);
drop index if exists standard_case_np_ix_3;
create index standard_case_np_ix_3 on standard_case_np(standard_concept_id);

/* -- will already be done for the faers outcomes when drug data is processed
drop index if exists faers.standard_case_outcome_ix_1;
create index faers.standard_case_outcome_ix_1 on faers.standard_case_outcome(primaryid);
drop index if exists faers.standard_case_outcome_ix_2;
create index faers.standard_case_outcome_ix_2 on faers.standard_case_outcome(isr);
drop index if exists faers.standard_case_outcome_ix_3;
create index faers.standard_case_outcome_ix_3 on faers.standard_case_outcome(outcome_concept_id);
*/

drop index if exists standard_np_outcome_count_ix_1;
create index standard_np_outcome_count_ix_1 on standard_np_outcome_count(drug_concept_id);
drop index if exists standard_np_outcome_count_ix_2;
create index standard_np_outcome_count_ix_2 on standard_np_outcome_count(outcome_concept_id);

drop table if exists standard_np_outcome_drilldown;
create table standard_np_outcome_drilldown as
select 
concept.concept_class_id np_class_id,
a.drug_concept_id, 
a.outcome_concept_id, 
a.snomed_outcome_concept_id, 
b.primaryid, null as isr, null as caseid
from standard_np_outcome_count a
inner join standard_case_np b on a.drug_concept_id = b.standard_concept_id
inner join staging_vocabulary.concept on concept.concept_id = a.drug_concept_id
inner join faers.standard_case_outcome c on a.outcome_concept_id = c.outcome_concept_id
and b.primaryid = c.primaryid
union
select
concept.concept_class_id np_class_id,
a.drug_concept_id,  
a.outcome_concept_id, 
a.snomed_outcome_concept_id,  
null as primary_id, b.isr, null as caseid
from standard_np_outcome_count a
inner join standard_case_np b on a.drug_concept_id = b.standard_concept_id
inner join staging_vocabulary.concept on concept.concept_id = a.drug_concept_id
inner join faers.standard_case_outcome c on a.outcome_concept_id = c.outcome_concept_id
and b.isr = c.isr;

-- populate the caseids that have a primaryid
update standard_np_outcome_drilldown a
set caseid = b.caseid
from faers.unique_all_case b
where a.primaryid = b.primaryid;

-- populate the caseids that have an isr
update standard_np_outcome_drilldown a
set caseid = b.caseid
from faers.unique_all_case b
where a.isr = b.isr
and a.caseid is null;

CREATE INDEX standard_np_outcome_drilldown_np_class_id_idx ON scratch_aug2021_amia.standard_np_outcome_drilldown (np_class_id);
CREATE INDEX standard_np_outcome_drilldown_np_class_outcome_id_idx ON scratch_aug2021_amia.standard_np_outcome_drilldown (np_class_id,outcome_concept_id);
CREATE INDEX standard_np_outcome_drilldown_drug_concept_id_idx ON scratch_aug2021_amia.standard_np_outcome_drilldown (drug_concept_id);
CREATE INDEX standard_np_outcome_drilldown_drug_concept_outcome_id_idx ON scratch_aug2021_amia.standard_np_outcome_drilldown (drug_concept_id,outcome_concept_id);
CREATE INDEX standard_np_outcome_drilldown_outcome_concept_id_idx ON scratch_aug2021_amia.standard_np_outcome_drilldown (outcome_concept_id);
CREATE INDEX standard_np_outcome_drilldown_primaryid_idx ON scratch_aug2021_amia.standard_np_outcome_drilldown (primaryid);



-----------------------------------------------------------------------
-- VARIOUS TESTS ON THE DATA 
---------------------------------------------------------------------- 

--  249 from FAERS and 2 from LAERS
-- select count(distinct primaryid)
select count(distinct isr)
from scratch_aug2021_amia.standard_case_np scn inner join staging_vocabulary.concept c on scn.standard_concept_id = c.concept_id 
where c.concept_class_id = 'Kratom'
 --  and primaryid is not null
 and isr is not null
;

select *
from scratch_aug2021_amia.standard_case_np scn inner join staging_vocabulary.concept c on scn.standard_concept_id = c.concept_id 
 inner join faers.drug d on d.primaryid = scn.primaryid 
where c.concept_class_id = 'Kratom'
 and scn.primaryid is not null
order by scn.primaryid, scn.drug_seq::integer 
;

-- 2982 from FAERS and 900 from LAERS
select count(distinct primaryid)
-- select count(distinct isr)
from scratch_aug2021_amia.standard_case_np scn inner join staging_vocabulary.concept c on scn.standard_concept_id = c.concept_id 
where c.concept_class_id = 'Hemp extract'
and primaryid is not null
-- and isr is not null
;

select *
from scratch_aug2021_amia.standard_case_np scn inner join staging_vocabulary.concept c on scn.standard_concept_id = c.concept_id 
 inner join faers.drug d on d.primaryid = scn.primaryid 
where c.concept_class_id = 'Hemp extract'
 and scn.primaryid is not null
 -- and d.drugname like '%MARIJ%'
order by scn.primaryid, scn.drug_seq::integer 
;


select c.concept_class_id, regexp_replace(regexp_replace(regexp_replace(c.concept_name, '\[.*\]','','g'), '\(.*\)','','g'),'''''','''','g') concept_name 
from staging_vocabulary.concept c 
where c.concept_class_id = 'Ashwaganda'
;



-- 11 for FAERS and 1 for LAERS
select count(distinct isr)
-- select count(distinct primaryid)
from scratch_aug2021_amia.standard_case_np scn inner join staging_vocabulary.concept c on scn.standard_concept_id = c.concept_id 
where c.concept_class_id = 'Goldenseal'
-- and primaryid is not null
and isr is not null
;


--------
 
select * 
from scratch_aug2021_amia.standard_np_class_outcome_contingency_table snoct 
where snoct.np_class_id = 'Kratom'
and outcome_concept_id = 35104161
;
-- Kratom	35104161	7	1454	302	690525 

------------------------
select snos.np_class_id, c1.concept_name outcome, snos.* 
from scratch_aug2021_amia.standard_np_class_outcome_statistics snos 
   inner join staging_vocabulary.concept c1 on snos.outcome_concept_id = c1.concept_id 
where snos.np_class_id = 'Kratom'
 and ror_95_percent_lower_confidence_limit >= 2.0 
 and case_count >= 10
order by snos.case_count desc
;

--Kratom	Death	Kratom	35809059	85	30.79526	38.85335	24.40840	35.01626	45.28678	27.07497
--Kratom	Toxicity to various agents	Kratom	42889647	55	18.65895	24.65974	14.11841	20.20060	27.24878	14.97551
--Kratom	Accidental death	Kratom	35809056	27	324.02956	710.67157	147.74076	337.28457	745.18321	152.66163
--Kratom	Drug abuse	Kratom	36919127	19	3.94841	6.20840	2.51111	4.03253	6.42057	2.53268



 select snos.np_class_id, c1.concept_name outcome, snos.* 
 from scratch_aug2021_amia.standard_np_class_outcome_statistics snos 
   inner join staging_vocabulary.concept c1 on snos.outcome_concept_id = c1.concept_id 
 where ror_95_percent_lower_confidence_limit >= 2.0 
 and case_count >= 10
 order by snos.ror desc
;

select distinct t.np_class_id from (
 select snos.* 
 from scratch_aug2021_amia.standard_np_class_outcome_statistics snos 
   inner join staging_vocabulary.concept c1 on snos.outcome_concept_id = c1.concept_id 
 where ror_95_percent_lower_confidence_limit >= 2.0 
 and case_count >= 10
 order by snos.ror desc
) t
;

select distinct t.concept_name from (
 select c1.concept_name, snos.* 
 from scratch_aug2021_amia.standard_np_class_outcome_statistics snos 
   inner join staging_vocabulary.concept c1 on snos.outcome_concept_id = c1.concept_id 
 where ror_95_percent_lower_confidence_limit >= 2.0 
 and case_count >= 10
 order by snos.ror desc
) t
;

select *
from scratch_aug2021_amia.standard_np_outcome_drilldown snod 
where snod.np_class_id = 'Kratom'
;

select distinct fdtn.np_name, fdtn.concept_id, fdtn.drug_name_original
from scratch_aug2021_amia.faers_drug_to_np fdtn inner join staging_vocabulary.concept c on fdtn.concept_id = c.concept_id 
where c.concept_class_id = 'Scrub-palmetto'
order by fdtn.np_name 
;

select distinct fdtn.np_name, fdtn.concept_id, fdtn.drug_name_original
from scratch_aug2021_amia.faers_drug_to_np fdtn inner join staging_vocabulary.concept c on fdtn.concept_id = c.concept_id 
where c.concept_class_id = 'Green tea'
order by fdtn.np_name 
;


select distinct fdtn.np_name, fdtn.concept_id, fdtn.drug_name_original
from scratch_aug2021_amia.faers_drug_to_np fdtn inner join staging_vocabulary.concept c on fdtn.np_name = c.concept_name
-- where c.concept_class_id = upper('Flax seed')
order by fdtn.np_name 
;


-- using scratch_rich b/c this is the naive mapping with incorrect results
-- Note the use of the scratch_rich schema for drug_to_np and np_concepts_first_run (instead of staging_vocabulary.concept)
select distinct fdtn.np_name, fdtn.concept_id, fdtn.drug_name_original
from scratch_rich.faers_drug_to_np fdtn inner join scratch_rich.np_concepts_first_run c on fdtn.concept_id = c.concept_id 
where c.concept_class_id = 'Flax seed'
order by fdtn.np_name 
;


select *
from scratch_rich.faers_drug_to_np
limit 100
;

;

----------------------------------------------------------------------------------------------
-- QUERIES TO SUPPORT THE EXACT STRING MATCH NPDI ANALYSIS
----------------------------------------------------------------------------------------------

-- What NPs have greater than 5 case counts?
select distinct t.np_class_id from (
 select snos.* 
 from scratch_aug2021_amia.standard_np_class_outcome_statistics snos 
   inner join staging_vocabulary.concept c1 on snos.outcome_concept_id = c1.concept_id 
 where case_count >= 5
 order by snos.ror desc
) t
;

/*
Ashwaganda
Butcher's-broom
Cat's-claw
Cinnamon
Fenugreek
Feverfew
Flax seed
Ginger
Green tea
Guarana
Hemp extract
Horse-chestnut
Karcura
Kratom
Lion's-tooth
Maca
Miracle-fruit
Moringa
Niu bang zi
Panax ginseng
Purple-coneflower
Reishi
Rhodiola
Scrub-palmetto
Slippery elm
Soy
Stinging nettle
St. John's-wort
Swallowwort
Tang-kuei
Tulsi
Woodland hawthorn
Wood spider
*/

-- For those NPs with greater than 5 case counts, what NP-AE signals are there
-- using the lower 95% ROR of 2.0 as a threshold
select distinct t.np_class_id, t.concept_name, t.case_count, t.ror, t.ror_95_percent_lower_confidence_limit, t.ror_95_percent_upper_confidence_limit
from (
 select c1.concept_name, snos.* 
 from scratch_aug2021_amia.standard_np_class_outcome_statistics snos 
   inner join staging_vocabulary.concept c1 on snos.outcome_concept_id = c1.concept_id 
 where ror_95_percent_lower_confidence_limit >= 2.0 
 and case_count >= 5
 order by snos.ror desc
) t
;

/*
 Butcher's-broom	Diabetic ketoacidosis	5	274.88815	98.73310	765.33094
Butcher's-broom	Diarrhoea	5	7.42044	2.98602	18.44025
Butcher's-broom	Vomiting	5	9.74953	3.91913	24.25365
Cinnamon	Abdominal pain	16	3.37025	2.02701	5.60360
Cinnamon	Acute kidney injury	33	25.92118	17.05292	39.40133
Cinnamon	Anaphylactic reaction	6	19.89422	7.77144	50.92752
Cinnamon	Blister	5	5.09412	2.03123	12.77554
Cinnamon	Blood sodium decreased	5	13.94887	5.19990	37.41817
Cinnamon	Bradycardia	7	7.58108	3.42701	16.77057
Cinnamon	Cardiac flutter	5	37.86818	12.00193	119.48073
Cinnamon	Clostridium difficile infection	6	14.46719	5.85568	35.74304
Cinnamon	Confusional state	23	5.90254	3.82310	9.11303
Cinnamon	Dyskinesia	9	11.12631	5.41209	22.87376
Cinnamon	Electrocardiogram QT prolonged	9	20.80775	9.60830	45.06131
Cinnamon	Fall	24	3.35478	2.21236	5.08713
Cinnamon	Gastrointestinal haemorrhage	8	6.53511	3.12880	13.64987
Cinnamon	Haematemesis	9	12.93177	6.22783	26.85218
Cinnamon	Haematuria	6	5.30155	2.28618	12.29405
Cinnamon	Hallucination	12	8.52213	4.62121	15.71593
Cinnamon	Hypokalaemia	6	10.97393	4.54787	26.47991
Cinnamon	Hyponatraemia	19	18.18080	10.77156	30.68653
Cinnamon	International normalised ratio increased	7	9.77726	4.35761	21.93742
Cinnamon	Limb discomfort	5	5.40626	2.15040	13.59168
Cinnamon	Liver function test abnormal	6	13.83797	5.62461	34.04495
Cinnamon	Lower respiratory tract infection	7	7.14339	3.23837	15.75728
Cinnamon	Melaena	6	18.72369	7.36956	47.57087
Cinnamon	Muscle twitching	5	7.16095	2.80963	18.25125
Cinnamon	Myoclonus	5	22.08808	7.76964	62.79350
Cinnamon	Neutropenia	7	9.52641	4.25264	21.34031
Cinnamon	Neutropenic sepsis	5	265.10163	30.94774	2270.88883
Cinnamon	Orthostatic hypotension	10	48.38961	20.51254	114.15236
Cinnamon	Oxygen saturation decreased	7	10.04166	4.46790	22.56875
Cinnamon	Pneumonia aspiration	5	11.52227	4.37324	30.35795
Cinnamon	Swelling face	8	9.88200	4.63634	21.06269
Cinnamon	Swollen tongue	6	9.94467	4.15059	23.82707
Cinnamon	Syncope	8	5.66290	2.72581	11.76474
Cinnamon	Withdrawal syndrome	6	6.62815	2.83133	15.51652
Feverfew	Hypotension	5	4.91779	2.00829	12.04240
Feverfew	Migraine	6	7.39728	3.24254	16.87555
Flax seed	Angiopathy	9	10.81424	2.33631	50.05676
Flax seed	Application site erythema	15	9.01426	2.99136	27.16386
Flax seed	Arthritis	65	3.26045	2.24450	4.73626
Flax seed	Cataract	43	3.83190	2.36742	6.20230
Flax seed	Drug dose omission	89	3.40448	2.46441	4.70317
Flax seed	Drug ineffective for unapproved indication	18	4.80783	2.15956	10.70367
Flax seed	Dry eye	34	4.08905	2.35309	7.10568
Flax seed	Femur fracture	41	32.89648	10.18556	106.24637
Flax seed	Fluid retention	37	3.70846	2.21808	6.20028
Flax seed	Foot fracture	19	5.07519	2.29578	11.21954
Flax seed	Fracture nonunion	11	8.81232	2.45817	31.59138
Flax seed	Full blood count decreased	20	48.09143	6.45356	358.37351
Flax seed	Malnutrition	11	6.60910	2.10419	20.75864
Flax seed	Meniscus injury	8	9.61217	2.04097	45.26961
Flax seed	Ocular discomfort	9	21.62895	2.73996	170.73652
Flax seed	Plasma cell myeloma	19	15.22752	4.50559	51.46439
Flax seed	Product dose omission	56	4.08524	2.65628	6.28292
Flax seed	Seasonal allergy	13	10.41563	2.96771	36.55519
Flax seed	Secretion discharge	10	12.01644	2.63261	54.84863
Flax seed	Stress fracture	12	28.84303	3.75004	221.84289
Flax seed	Therapeutic response unexpected	52	3.20876	2.11777	4.86179
Flax seed	Therapy cessation	39	5.86498	3.27679	10.49747
Flax seed	Underdose	20	5.34258	2.43224	11.73533
Ginger	Adverse event	5	5.25867	2.07755	13.31064
Ginger	Blood cholesterol increased	8	5.28311	2.53330	11.01777
Ginger	Blood pressure systolic increased	8	18.64371	8.14839	42.65722
Ginger	Bone erosion	7	38.72411	14.02369	106.93028
Ginger	Bronchitis	58	19.65957	14.38774	26.86306
Ginger	Candida infection	8	15.40037	6.87730	34.48615
Ginger	Colitis	5	8.49686	3.25823	22.15824
Ginger	Colitis microscopic	54	352.70192	160.21357	776.45509
Ginger	Complication associated with device	8	177.16155	37.58790	835.00853
Ginger	Computerised tomogram abnormal	8	88.57805	26.64280	294.49118
Ginger	Contraindicated product administered	19	11.29230	6.80767	18.73124
Ginger	C-reactive protein increased	58	56.54562	38.35152	83.37108
Ginger	Diverticulitis	60	50.05153	34.58409	72.43665
Ginger	Drug hypersensitivity	38	9.31173	6.54131	13.25549
Ginger	Drug ineffective	60	3.25720	2.49342	4.25493
Ginger	Drug intolerance	58	20.73694	15.13858	28.40562
Ginger	Ear pain	8	7.69746	3.62662	16.33777
Ginger	Emotional disorder	8	6.55629	3.11460	13.80111
Ginger	Glaucoma	58	102.25015	64.19009	162.87705
Ginger	Hepatic enzyme increased	37	37.97073	24.44712	58.97530
Ginger	Hypersensitivity	44	13.46834	9.58059	18.93370
Ginger	Hypertension	47	9.64386	7.00870	13.26978
Ginger	Inflammation	8	6.80866	3.22856	14.35870
Ginger	Influenza	9	4.79986	2.40800	9.56753
Ginger	Infusion related reaction	8	8.23487	3.86487	17.54604
Ginger	Intestinal polyp	7	309.82629	38.09356	2519.90985
Ginger	Leukopenia	8	13.11803	5.94956	28.92359
Ginger	Limb discomfort	12	12.68118	6.66233	24.13756
Ginger	Liver disorder	8	16.10064	7.15633	36.22394
Ginger	Nephrolithiasis	15	10.75685	6.10548	18.95178
Ginger	Nervous system disorder	8	16.10064	7.15633	36.22394
Ginger	Ocular hyperaemia	8	8.43107	3.95139	17.98933
Ginger	Off label use	30	3.57653	2.45683	5.20652
Ginger	Oral herpes	8	11.06748	5.09127	24.05868
Ginger	Pneumonia	39	8.58098	6.06887	12.13295
Ginger	Psychotic disorder	8	6.00021	2.86203	12.57936
Ginger	Skin reaction	37	119.39171	64.40506	221.32395
Ginger	Synovitis	58	379.89737	173.10453	833.72754
Ginger	Therapeutic product effect decreased	9	11.72615	5.61402	24.49271
Ginger	Therapeutic product effect incomplete	7	11.06063	4.82363	25.36212
Ginger	Thyroid disorder	38	107.36256	59.72546	192.99506
Ginger	Treatment failure	39	135.71657	72.29045	254.79145
Ginger	Tumour marker increased	8	27.25101	11.27772	65.84820
Ginger	Vomiting	48	5.01393	3.70422	6.78673
Green tea	Abdominal pain upper	29	5.54865	3.75944	8.18940
Green tea	Asthenia	33	3.28815	2.30026	4.70030
Green tea	Back pain	27	3.49782	2.35616	5.19265
Green tea	Body temperature increased	23	43.05077	24.24209	76.45251
Green tea	Contraindicated product administered	13	7.15399	3.97397	12.87871
Green tea	Ear pain	23	33.32604	19.38367	57.29694
Green tea	Incorrect route of product administration	6	17.76268	6.88202	45.84593
Green tea	Joint swelling	26	5.55744	3.68519	8.38088
Green tea	Lower respiratory tract infection	23	28.69521	16.96144	48.54632
Green tea	Muscle spasticity	25	70.29735	37.45217	131.94742
Green tea	Night sweats	23	15.88564	9.84575	25.63071
Green tea	Peripheral swelling	25	6.44840	4.22655	9.83827
Green tea	Pruritus	25	3.46577	2.29956	5.22341
Green tea	Pruritus generalised	9	13.80673	6.52400	29.21918
Green tea	Rash	30	4.19950	2.87814	6.12751
Green tea	Respiratory disorder	23	43.05077	24.24209	76.45251
Green tea	Sinusitis	26	8.11286	5.32576	12.35853
Green tea	Urticaria	25	6.06396	3.98075	9.23733
Hemp extract	Accidental overdose	38	6.69540	3.42178	13.10088
Hemp extract	Acute respiratory distress syndrome	10	9.68071	2.12090	44.18693
Hemp extract	Aggression	93	6.22802	4.10368	9.45207
Hemp extract	Alcohol abuse	16	30.98718	4.10903	233.68150
Hemp extract	Alcohol poisoning	17	8.23077	2.76918	24.46410
Hemp extract	Apparent death	34	9.41302	4.17215	21.23724
Hemp extract	Atrial septal defect	10	19.36185	2.47831	151.26492
Hemp extract	Brain oedema	27	6.53849	2.97002	14.39448
Hemp extract	Cardiac arrest	178	9.91284	6.89684	14.24775
Hemp extract	Cardio-respiratory arrest	183	18.78447	11.70874	30.13616
Hemp extract	Coma	29	3.74524	2.00756	6.98700
Hemp extract	Completed suicide	320	41.86564	24.93867	70.28169
Hemp extract	Convulsion	54	3.17216	2.05657	4.89289
Hemp extract	C-reactive protein abnormal	58	7.03118	4.04163	12.23209
Hemp extract	Crohn's disease	45	4.36127	2.57483	7.38716
Hemp extract	Cyanosis	20	6.45607	2.59231	16.07864
Hemp extract	Deafness neurosensory	11	21.29898	2.74957	164.98841
Hemp extract	Delusion	22	4.73454	2.17968	10.28402
Hemp extract	Dependence	13	8.39087	2.39082	29.44873
Hemp extract	Drug abuse	456	36.00636	24.06526	53.87259
Hemp extract	Drug abuser	40	77.55023	10.66015	564.16090
Hemp extract	Drug dependence	203	14.67376	9.81817	21.93070
Hemp extract	Drug exposure during pregnancy	31	6.67406	3.17694	14.02075
Hemp extract	Drug screen positive	60	12.93412	6.41772	26.06713
Hemp extract	Drug toxicity	42	11.63197	5.22487	25.89591
Hemp extract	Drug use disorder	15	9.68262	2.80279	33.44993
Hemp extract	Drug withdrawal syndrome	130	5.74540	4.08032	8.08997
Hemp extract	Drug withdrawal syndrome neonatal	34	8.23621	3.81212	17.79459
Hemp extract	Erection increased	13	8.39087	2.39082	29.44873
Hemp extract	Euphoric mood	89	28.81741	12.60540	65.87998
Hemp extract	Exposure via ingestion	9	17.42490	2.20740	137.54949
Hemp extract	Foetal exposure during pregnancy	72	17.47075	8.41405	36.27590
Hemp extract	Generalised tonic-clonic seizure	29	14.04818	4.93803	39.96562
Hemp extract	Gun shot wound	13	12.58659	2.84004	55.78165
Hemp extract	Haemoglobin decreased	90	3.01116	2.16389	4.19019
Hemp extract	Hallucination, auditory	27	13.07818	4.57559	37.38069
Hemp extract	Herpes zoster	80	3.98053	2.71365	5.83886
Hemp extract	Homicidal ideation	15	29.04920	3.83684	219.93538
Hemp extract	Homicide	21	40.67967	5.47143	302.45016
Hemp extract	Hypoxic-ischaemic encephalopathy	12	11.61787	2.59993	51.91488
Hemp extract	Impaired driving ability	55	4.84778	2.95597	7.95036
Hemp extract	Intentional drug misuse	49	23.75759	8.57251	65.84108
Hemp extract	Intentional overdose	42	5.08794	2.86003	9.05136
Hemp extract	Intentional product use issue	62	3.43505	2.26897	5.20039
Hemp extract	Intentional self-injury	11	21.29898	2.74957	164.98841
Hemp extract	Interstitial lung disease	92	22.34354	10.84705	46.02485
Hemp extract	Maternal exposure during pregnancy	26	5.03661	2.42840	10.44615
Hemp extract	Mental disorder	40	3.69118	2.17608	6.26119
Hemp extract	Nodule	24	5.16541	2.40059	11.11454
Hemp extract	Odynophagia	12	7.74507	2.18536	27.44909
Hemp extract	Overdose	191	6.41911	4.78262	8.61555
Hemp extract	Paranoia	43	4.90277	2.79558	8.59826
Hemp extract	Pharyngitis streptococcal	16	6.19687	2.26985	16.91793
Hemp extract	Photosensitivity reaction	58	5.35648	3.25074	8.82627
Hemp extract	Poisoning	56	15.51891	7.07203	34.05481
Hemp extract	Premature baby	13	12.58659	2.84004	55.78165
Hemp extract	Pulmonary thrombosis	35	13.56705	5.31454	34.63417
Hemp extract	Pulse absent	10	9.68071	2.12090	44.18693
Hemp extract	Red blood cell sedimentation rate increased	45	8.72454	4.39615	17.31459
Hemp extract	Respiratory arrest	171	37.04438	18.94647	72.42962
Hemp extract	Respiratory depression	19	18.40066	4.28555	79.00594
Hemp extract	Road traffic accident	79	4.14325	2.80302	6.12431
Hemp extract	Sexually inappropriate behaviour	11	21.29898	2.74957	164.98841
Hemp extract	Substance abuse	466	920.81869	129.42412	6551.38350
Hemp extract	Substance use	16	30.98718	4.10903	233.68150
Hemp extract	Suicidal behaviour	12	7.74507	2.18536	27.44909
Hemp extract	Suicide attempt	55	5.33281	3.19580	8.89881
Hemp extract	Terminal state	36	69.78285	9.56669	509.02080
Hemp extract	Toxicity to various agents	249	5.46380	4.28684	6.96388
Hemp extract	Unresponsive to stimuli	45	5.13126	2.93626	8.96713
Hemp extract	Urine leukocyte esterase positive	10	9.68071	2.12090	44.18693
Horse-chestnut	Myalgia	5	4.89726	2.00432	11.96576
Kratom	Accidental death	27	337.28457	152.66163	745.18321
Kratom	Acute kidney injury	7	7.13704	3.30013	15.43499
Kratom	Coagulopathy	6	32.27688	12.77270	81.56434
Kratom	Death	85	35.01626	27.07497	45.28678
Kratom	Drug abuse	19	4.03253	2.53268	6.42057
Kratom	Drug dependence	9	3.94860	2.01892	7.72265
Kratom	Drug withdrawal syndrome neonatal	7	19.38968	8.58232	43.80628
Kratom	Foetal exposure during pregnancy	7	9.29105	4.26249	20.25191
Kratom	Intentional overdose	6	11.16699	4.78036	26.08623
Kratom	Seizure	8	6.30645	3.07231	12.94506
Kratom	Serotonin syndrome	6	13.19896	5.60586	31.07683
Kratom	Toxicity to various agents	55	20.20060	14.97551	27.24878
Lion's-tooth	Blood pressure increased	8	8.49643	4.15358	17.38003
Lion's-tooth	Disability	5	40.30061	15.33376	105.91917
Lion's-tooth	Drug hypersensitivity	7	6.58184	3.07626	14.08221
Lion's-tooth	Foot deformity	5	22.38245	8.82843	56.74559
Lion's-tooth	Hypoaesthesia	7	6.37363	2.98005	13.63168
Lion's-tooth	Rheumatoid arthritis	6	9.53421	4.17393	21.77829
Lion's-tooth	Therapeutic product effect decreased	5	26.50834	10.36822	67.77369
Lion's-tooth	Treatment noncompliance	6	24.24514	10.32385	56.93870
Lion's-tooth	Urticaria	6	5.92858	2.61352	13.44857
Lion's-tooth	Vertigo	7	14.46538	6.66762	31.38259
Lion's-tooth	Vision blurred	6	6.87469	3.02506	15.62325
Lion's-tooth	Visual impairment	7	10.98404	5.09395	23.68479
Miracle-fruit	Hyponatraemia	7	47.67904	21.52837	105.59514
Niu bang zi	Musculoskeletal stiffness	5	25.72611	10.30987	64.19408
Niu bang zi	Urticaria	5	13.78445	5.57353	34.09167
Panax ginseng	Drug interaction	12	17.10671	9.40966	31.09992
Purple-coneflower	Arthralgia	9	4.20019	2.15075	8.20253
Purple-coneflower	Serotonin syndrome	5	24.56410	9.68303	62.31468
Reishi	Nausea	8	4.38393	2.14430	8.96276
Scrub-palmetto	Actinic keratosis	5	7.61863	2.20506	26.32283
Scrub-palmetto	Acute myocardial infarction	12	4.35627	2.14244	8.85769
Scrub-palmetto	Aneurysm	5	19.04754	3.69475	98.19581
Scrub-palmetto	Arteriosclerosis	6	7.61949	2.45678	23.63112
Scrub-palmetto	Atrial fibrillation	48	4.83291	3.36459	6.94200
Scrub-palmetto	Atrial flutter	8	12.19455	3.98830	37.28583
Scrub-palmetto	Benign prostatic hyperplasia	10	12.70574	4.61649	34.96935
Scrub-palmetto	Blood blister	6	9.14354	2.78980	29.96781
Scrub-palmetto	Blood testosterone decreased	8	10.16195	3.52494	29.29562
Scrub-palmetto	Cardiac failure congestive	28	5.21534	3.22360	8.43770
Scrub-palmetto	Coronary artery disease	24	10.78008	5.78878	20.07506
Scrub-palmetto	Coronary artery occlusion	7	7.62035	2.67216	21.73133
Scrub-palmetto	Erectile dysfunction	31	6.96646	4.27931	11.34098
Scrub-palmetto	Flushing	57	3.23143	2.36886	4.40809
Scrub-palmetto	Haemorrhage	27	4.38605	2.73061	7.04508
Scrub-palmetto	Jaundice	12	5.08258	2.44729	10.55556
Scrub-palmetto	Libido decreased	14	3.81227	2.00617	7.24438
Scrub-palmetto	Malignant melanoma	8	5.54241	2.22863	13.78351
Scrub-palmetto	Mitral valve incompetence	8	6.09676	2.40547	15.45248
Scrub-palmetto	Multi-organ failure	10	6.35222	2.74353	14.70757
Scrub-palmetto	Myocardial infarction	46	3.03159	2.15275	4.26921
Scrub-palmetto	Nocturia	12	4.35627	2.14244	8.85769
Scrub-palmetto	Pharmaceutical product complaint	7	7.62035	2.67216	21.73133
Scrub-palmetto	Post procedural haemorrhage	7	6.66769	2.41717	18.39258
Scrub-palmetto	Prostate cancer	9	6.85974	2.78653	16.88694
Scrub-palmetto	Prostatitis	7	10.66885	3.38524	33.62373
Scrub-palmetto	Renal failure acute	13	4.95599	2.46432	9.96695
Scrub-palmetto	Renal failure chronic	5	12.69815	3.03399	53.14555
Scrub-palmetto	Sexual dysfunction	12	8.31793	3.66900	18.85746
Scrub-palmetto	Shock haemorrhagic	5	7.61863	2.20506	26.32283
Scrub-palmetto	Supraventricular tachycardia	7	5.33397	2.02974	14.01721
Scrub-palmetto	Urinary hesitation	7	26.67348	5.54000	128.42502
Scrub-palmetto	Urine flow decreased	6	22.86002	4.61301	113.28409
St. John's-wort	Agitation	22	4.51124	2.83828	7.17030
St. John's-wort	Attention deficit/hyperactivity disorder	6	13.48371	4.79632	37.90625
St. John's-wort	Cholecystitis chronic	5	12.63714	4.13171	38.65159
St. John's-wort	Cognitive disorder	15	4.10738	2.35520	7.16310
St. John's-wort	Crying	11	4.73837	2.45524	9.14457
St. John's-wort	Depressed mood	19	5.28080	3.18358	8.75958
St. John's-wort	Disturbance in attention	18	4.14779	2.49496	6.89554
St. John's-wort	Drug interaction	55	4.67202	3.47805	6.27586
St. John's-wort	Generalised anxiety disorder	7	70.81991	14.70569	341.05582
St. John's-wort	Hallucination, visual	5	6.73906	2.44769	18.55420
St. John's-wort	Mania	8	5.05778	2.32877	10.98486
St. John's-wort	Mood swings	11	5.30288	2.72761	10.30960
St. John's-wort	Nightmare	11	4.54482	2.36095	8.74877
St. John's-wort	Panic attack	19	4.53441	2.75390	7.46609
St. John's-wort	Personality disorder	7	35.40884	10.35990	121.02301
St. John's-wort	Self-injurious ideation	7	23.60515	7.92824	70.28080
St. John's-wort	Serotonin syndrome	21	14.71197	8.38047	25.82697
St. John's-wort	Sleep disorder	17	3.91610	2.32703	6.59030
St. John's-wort	Suicidal ideation	29	3.27382	2.20807	4.85396
St. John's-wort	Tension	7	10.11521	4.07971	25.07958
St. John's-wort	Tubulointerstitial nephritis	5	8.42423	2.96597	23.92725
St. John's-wort	Varicose vein	5	12.63714	4.13171	38.65159
St. John's-wort	Wound	8	8.09399	3.56231	18.39050
Swallowwort	Lactic acidosis	5	846.98980	285.83674	2509.79537
Tang-kuei	Abdominal pain	5	12.90319	5.20978	31.95764
Woodland hawthorn	Asthenia	7	13.24655	6.06788	28.91803
Woodland hawthorn	Breast cancer metastatic	5	442.40667	147.68327	1325.29338
Woodland hawthorn	Fatigue	9	8.34577	4.15962	16.74480
Woodland hawthorn	Malignant neoplasm progression	7	80.46541	35.92858	180.20978
Woodland hawthorn	Neutropenia	7	163.09238	70.64488	376.51878
Woodland hawthorn	Pain	7	8.30034	3.80944	18.08550
Woodland hawthorn	Tumour marker increased	7	454.50000	178.27226	1158.73467
Wood spider	Arthralgia	14	4.49948	2.62233	7.72035
Wood spider	Injection site pain	6	7.36397	3.22731	16.80288
 */


-- For NPDI PV purposes, we need to combine the drug drill down table with the NP drill down table
drop table if exists scratch_aug2021_amia.combined_np_drug_outcome_drilldown;
create table scratch_aug2021_amia.combined_np_drug_outcome_drilldown as
select '' as  np_class_id, drug_concept_id, outcome_concept_id, primaryid, isr, caseid 
from faers.standard_drug_outcome_drilldown 
union
select np_class_id, drug_concept_id, outcome_concept_id, primaryid, isr, caseid
from scratch_aug2021_amia.standard_np_outcome_drilldown 


