------------------------------
--
-- This SQL script creates drug/outcome combination counts (counts for pairs of drug RxNorm concept_id, outcome (reaction) Meddra concept_id) 
-- and stores the combination counts in a new table called standard_drug_outcome_count
--
-- LTS COMPUTING LLC
------------------------------

set search_path = faers;

drop table if exists standard_drug_outcome_count;
create table standard_drug_outcome_count as
select drug_concept_id, outcome_concept_id, count(*) as drug_outcome_pair_count
from (
	select a.standard_concept_id as drug_concept_id, b.outcome_concept_id
	from standard_drug a
	inner join standard_case_outcome b
	on a.primaryid = b.primaryid and a.isr is null and b.isr is null
	union all
	select a.standard_concept_id as drug_concept_id, b.outcome_concept_id
	from standard_drug a
	inner join standard_case_outcome b
	on a.isr = b.isr and a.isr is not null and b.isr is not null
) aa
group by drug_concept_id, outcome_concept_id
