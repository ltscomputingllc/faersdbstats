------------------------------
--
-- This SQL script creates legacy drug/outcome combination counts (counts for pairs of drug RxNorm concept_id, outcome (reaction) Meddra concept_id) and store the counts in a new table called standard_legacy_drug_outcome_count
--
-- LTS COMPUTING LLC
------------------------------

set search_path = faers;

drop table if exists standard_legacy_drug_outcome_count;
create table standard_legacy_drug_outcome_count as
select a.concept_id, b.outcome_concept_id, count(*) as drug_outcome_pair_count
from standard_drug_legacy a
inner join standard_legacy_drug_outcome b
on a.isr = b.isr
group by a.concept_id, b.outcome_concept_id
	
