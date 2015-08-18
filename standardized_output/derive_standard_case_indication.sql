------------------------------
--
-- This SQL script converts the FAERS indication MedDRA preferred terms into MedDRA concept ids (limited to the cases in the unique_case table) 
-- in a new table called standard_case_indication 
-- Note. We use a regex to remove leading white space in the indication preferred term field
--
-- LTS COMPUTING LLC
------------------------------

set search_path = faers;

drop table if exists standard_case_indication;
create table standard_case_indication as
select distinct a.primaryid, b.indi_pt, c.concept_id as indication_concept_id
from unique_case a
inner join indi b
on a.primaryid = b.primaryid
inner join cdmv5.concept c
on upper(regexp_replace(b.indi_pt,'^ +','','gi')) = upper(c.concept_name) 
and c.vocabulary_id = 'MedDRA'; 