------------------------------
--
-- This SQL script converts the unique legacy LAERS and current FAERS case reactions (adverse event outcomes) MedDRA preferred terms 
-- into MedDRA concept ids in a new table called standard_case_outcome 
--
-- LTS COMPUTING LLC
------------------------------

set search_path = faers;

-- create indexes on reac table for improved performance in this SQL
drop index if exists ix_reac_1;
drop index if exists ix_reac_2;
create index ix_reac_1 on reac (upper(pt));
create index ix_reac_2 on reac (primaryid);
analyze verbose reac;

-- create indexes on reac_legacy table for improved performance in this SQL
drop index if exists ix_reac_legacy_1;
drop index if exists ix_reac_legacy_2;
create index ix_reac_legacy_1 on reac_legacy (upper(pt));
create index ix_reac_legacy_2 on reac_legacy (isr);
analyze verbose reac_legacy;

drop table if exists standard_case_outcome;
create table standard_case_outcome as
select distinct a.primaryid, a.isr, b.pt, c.concept_id as outcome_concept_id, cast(null as integer) as snomed_outcome_concept_id
from unique_all_case a
inner join reac b
on a.primaryid = b.primaryid
inner join staging_vocabulary.concept c
on upper(b.pt) = upper(c.concept_name)
and c.vocabulary_id = 'MedDRA'
where a.isr is null
union
select distinct a.primaryid, a.isr, b.pt, c.concept_id as outcome_concept_id, cast(null as integer) as snomed_outcome_concept_id
from unique_all_case a
inner join reac_legacy b
on a.isr = b.isr
inner join staging_vocabulary.concept c
on upper(b.pt) = upper(c.concept_name)
and c.vocabulary_id = 'MedDRA'
where a.isr is not null;
