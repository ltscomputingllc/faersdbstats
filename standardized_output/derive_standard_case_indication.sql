------------------------------
--
-- This SQL script converts the indication MedDRA preferred terms into MedDRA concept ids for all unique legacy and current cases
-- in a new table called standard_case_indication 
-- Note. We use a regex to remove leading white space in the indication preferred term field
--
-- LTS COMPUTING LLC
------------------------------

set search_path = faers;

drop table if exists standard_case_indication; 
create table standard_case_indication as
select distinct a.primaryid, a.isr, indi_drug_seq, b.indi_pt, c.concept_id as indication_concept_id, cast(null as integer) as snomed_indication_concept_id
from unique_all_case a
inner join indi b
on a.primaryid = b.primaryid
inner join staging_vocabulary.concept c
on upper(regexp_replace(b.indi_pt,'^ +','','gi')) = upper(c.concept_name) 
and c.vocabulary_id = 'MedDRA'
where a.isr is null
union
select distinct a.primaryid, a.isr, drug_seq, b.indi_pt, c.concept_id as indication_concept_id, cast(null as integer) as snomed_indication_concept_id
from unique_all_case a
inner join indi_legacy b
on a.isr = b.isr
inner join staging_vocabulary.concept c
on upper(regexp_replace(b.indi_pt,'^ +','','gi')) = upper(c.concept_name) 
and c.vocabulary_id = 'MedDRA'
where a.isr is not null;
