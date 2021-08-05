------------------------------
--
-- This SQL script computes the 2x2 contingency table for all unique legacy and current case natural product (NP)/outcome pairs in
--  a table called standard_np_class_outcome_contingency_table - this table is based on the counts rolled up to a preferred common name for
-- each NP
--
--
------------------------------

-- set search_path = faers;
set search_path to scratch_rich;

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
set search_path = scratch_rich;
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
set search_path = scratch_rich;
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
set search_path = scratch_rich;
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
set search_path = scratch_rich;
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

