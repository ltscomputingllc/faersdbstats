------------------------------
--
-- This SQL script computes the 2x2 contingency table for each drug/outcome pair across the combined drug outcome pairs 
-- (legacy and current (LAERS and FAERS) databases) in a table called standard_all_drug_outcome_contingency_table
--
--
-- LTS COMPUTING LLC
------------------------------

set search_path = faers;

drop table if exists standard_all_drug_outcome_count;
create table standard_all_drug_outcome_count as
select concept_id, outcome_concept_id, sum(drug_outcome_pair_count) as drug_outcome_pair_count 
from
(
select * from standard_drug_legacy_outcome_count
union all
select * from standard_drug_outcome_count
) allcounts
group by concept_id, outcome_concept_id;

drop index if exists ix_standard_all_drug_outcome_count;
create index ix_standard_all_drug_outcome_count on standard_all_drug_outcome_count(concept_id, outcome_concept_id);
drop index if exists ix_standard_all_drug_outcome_count_2;
create index ix_standard_all_drug_outcome_count_2  on standard_all_drug_outcome_count  using btree  (concept_id);
drop index if exists ix_standard_all_drug_outcome_count_3;
create index ix_standard_all_drug_outcome_count_3  on standard_all_drug_outcome_count  using btree  (outcome_concept_id);
analyze verbose standard_all_drug_outcome_count;

drop table if exists standard_all_drug_outcome_contingency_table;

create table standard_all_drug_outcome_contingency_table as
select 
concept_id, outcome_concept_id, count_a, count_b, count_c, (count_d1 - count_d2) as count_d
from 
 (
	select concept_id, outcome_concept_id, drug_outcome_pair_count as count_a, -- drug P and outcome R
		(
			select sum(drug_outcome_pair_count)
			from standard_all_drug_outcome_count b
			where b.concept_id = a.concept_id and b.outcome_concept_id <> a.outcome_concept_id 
		) as count_b, -- count of drug P and not(outcome R)
		(
			select sum(drug_outcome_pair_count) 
			from standard_all_drug_outcome_count c
			where c.concept_id <> a.concept_id and c.outcome_concept_id = a.outcome_concept_id 
		) as count_c, -- count of not(drug P) and outcome R
		(
			select sum(drug_outcome_pair_count)
			from standard_all_drug_outcome_count d1
		) as count_d1, -- count of all cases 
		(
			select sum(drug_outcome_pair_count)
			from standard_all_drug_outcome_count d2
			where (d2.concept_id = a.concept_id) or (d2.outcome_concept_id = a.outcome_concept_id)
		) as count_d2 -- count of all cases where drug P or outcome R 
	from standard_all_drug_outcome_count a -- count of all cases where drug P and outcome R
) contingencytable;
