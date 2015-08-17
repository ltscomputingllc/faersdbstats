------------------------------
--
-- This SQL script converts the FAERS reactions (adverse event outcomes) MedDRA preferred terms into MedDRA concept ids (limited to the cases in the unique_case table) in a new table called standard_drug_outcome 
--
-- LTS COMPUTING LLC
------------------------------

set search_path = faers;

-- create indexes on reac table for improved performance in this SQL
drop index if exists ix_reac_1;
drop index if exists ix_reac_2;
drop index if exists ix_reac_3;
create index ix_reac_1 on reac (pt);
create index ix_reac_2 on reac (primaryid);
create index ix_reac_3 on standard_drug (primaryid);
analyze verbose reac;
analyze verbose standard_drug;

drop table if exists standard_drug_outcome;
create table standard_drug_outcome as
select distinct a.primaryid, b.pt, c.concept_id as outcome_concept_id
from unique_case a
inner join reac b
on a.primaryid = b.primaryid
inner join cdmv5.concept c
on upper(b.pt) = upper(c.concept_name)
and c.vocabulary_id = 'MedDRA'
