------------------------------
--
-- This SQL script creates natural product (NP)/outcome combination case counts (counts for pairs NP concept_id, outcome (reaction) Meddra concept_id) 
-- and stores the combination case counts in a new table called standard_np_outcome_count
--
-- LTS COMPUTING LLC
------------------------------

-- set search_path = faers;

drop table if exists scratch_rich.standard_np_outcome_count;
create table scratch_rich.standard_np_outcome_count as
select drug_concept_id, outcome_concept_id, count(*) as drug_outcome_pair_count, cast(null as integer) as snomed_outcome_concept_id
from (
	select 'PRIMARYID' || a.primaryid as case_key, a.standard_concept_id as drug_concept_id, b.outcome_concept_id, cast(null as integer) as snomed_outcome_concept_id
	from scratch_rich.standard_case_np a
	inner join faers.standard_case_outcome b
	on a.primaryid = b.primaryid and a.isr is null and b.isr is null
	union 
	select 'ISR' || a.isr as case_key, a.standard_concept_id as drug_concept_id, b.outcome_concept_id, cast(null as integer) as snomed_outcome_concept_id
	from scratch_rich.standard_case_np a
	inner join faers.standard_case_outcome b
	on a.isr = b.isr and a.isr is not null and b.isr is not null
) aa
group by drug_concept_id, outcome_concept_id;
