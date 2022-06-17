------------------------------
--
-- This SQL script computes the 2x2 contingency table for all unique legacy and current case drug/outcome pairs in a table called standard_drug_current_outcome_contingency_table
--
--
-- LTS COMPUTING LLC
------------------------------

set search_path = faers;

drop index if exists standard_drug_outcome_count_ix;
create index standard_drug_outcome_count_ix on standard_drug_outcome_count(drug_concept_id, outcome_concept_id);
drop index if exists standard_drug_outcome_count_2_ix;
create index standard_drug_outcome_count_2_ix on standard_drug_outcome_count(drug_concept_id);
drop index if exists standard_drug_outcome_count_3_ix;
create index standard_drug_outcome_count_3_ix on standard_drug_outcome_count(outcome_concept_id);
drop index if exists standard_drug_outcome_count_4_ix;
create index standard_drug_outcome_count_4_ix on standard_drug_outcome_count(drug_outcome_pair_count);
analyze verbose standard_drug_outcome_count;

-- get count_d1 
drop table if exists standard_drug_outcome_count_d1;
create table standard_drug_outcome_count_d1 as
with cte as (
select sum(drug_outcome_pair_count) as count_d1 from standard_drug_outcome_count 
)  
select drug_concept_id, outcome_concept_id, count_d1
from standard_drug_outcome_count a,  cte; -- we need the same total for all rows so do cross join!

--============= On a 4+ CPU postgresql server, run the following 3 queries in 3 different postgresql sessions so they run concurrently!

-- get count_a and count_b 
set search_path = faers;
drop table if exists standard_drug_outcome_count_a_count_b;
create table standard_drug_outcome_count_a_count_b as
select drug_concept_id, outcome_concept_id, 
drug_outcome_pair_count as count_a, -- count of drug P and outcome R
(
	select sum(drug_outcome_pair_count)
	from standard_drug_outcome_count b
	where b.drug_concept_id = a.drug_concept_id and b.outcome_concept_id <> a.outcome_concept_id 
) as count_b -- count of drug P and not(outcome R)
from standard_drug_outcome_count a;

-- get count_c 
set search_path = faers;
drop table if exists standard_drug_outcome_count_c;
create table standard_drug_outcome_count_c as
select drug_concept_id, outcome_concept_id, 
(
	select sum(drug_outcome_pair_count) 
	from standard_drug_outcome_count c
	where c.drug_concept_id <> a.drug_concept_id and c.outcome_concept_id = a.outcome_concept_id 
) as count_c -- count of not(drug P) and outcome R
from standard_drug_outcome_count a; 

-- get count d2 
set search_path = faers;
drop table if exists standard_drug_outcome_count_d2;
create table standard_drug_outcome_count_d2 as
select drug_concept_id, outcome_concept_id, 
(
	select sum(drug_outcome_pair_count)
	from standard_drug_outcome_count d2
	where (d2.drug_concept_id = a.drug_concept_id) or (d2.outcome_concept_id = a.outcome_concept_id)
) as count_d2 -- count of all cases where drug P or outcome R 
from standard_drug_outcome_count a;

--=============

-- Only run the below query when ALL OF THE ABOVE 3 QUERIES HAVE COMPLETED!
-- combine all the counts into a single contingency table
drop table if exists standard_drug_outcome_contingency_table;
create table standard_drug_outcome_contingency_table as		-- 1 second
select ab.drug_concept_id, ab.outcome_concept_id, count_a, count_b, count_c, (count_d1 - count_d2) as count_d
from standard_drug_outcome_count_a_count_b ab
inner join standard_drug_outcome_count_c c
on ab.drug_concept_id = c.drug_concept_id and ab.outcome_concept_id = c.outcome_concept_id
inner join standard_drug_outcome_count_d1 d1
on ab.drug_concept_id = d1.drug_concept_id and ab.outcome_concept_id = d1.outcome_concept_id
inner join standard_drug_outcome_count_d2 d2
on ab.drug_concept_id = d2.drug_concept_id and ab.outcome_concept_id = d2.outcome_concept_id;

