------------------------------
--
-- This SQL script converts the legacy FAERS reactions (adverse event outcomes) MedDRA preferred terms into MedDRA concept ids (limited to the cases in the unique_case table) in a new table called standard_legacy_case_outcome 
--
-- LTS COMPUTING LLC
------------------------------

set search_path = faers;

drop table if exists standard_legacy_case_outcome;
create table standard_legacy_case_outcome as
select distinct a.isr, b.pt, c.concept_id as outcome_concept_id
from unique_legacy_case a
inner join reac_legacy b
on a.isr = b.isr
inner join cdmv5.concept c
on upper(b.pt) = upper(c.concept_name)
and c.vocabulary_id = 'MedDRA';
