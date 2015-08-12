------------------------------
--
-- This SQL script performs two tasks:
--
-- 1) Find active OMOP CDM vocabulary standard RxNorm codes for the legacy drugs we have mapped
-- 2) Map from the standard codes to standard codes with concept_class of 'Ingredient' or 'Clinical Drug Form' because We need to roll-up the safety signal stats that we generate to these two concept classes.
--
-- LTS COMPUTING LLC
------------------------------

set search_path = faers;

-- ====================== find active OMOP CDM vocabulary standard RxNorm codes ==============================

-- create combined drug legacy mapping table which will have OHDSI vocabulary standard codes assigned to it

drop table if exists standard_combined_drug_legacy_mapping;

create table standard_combined_drug_legacy_mapping as
select a.*, cast (concept_id as integer) as standard_concept_id from combined_drug_legacy_mapping a;

------------------------------------------------------

with cte1 as ( -- this is the 'input' set of non standard concepts that we want to process
select distinct scdm.concept_id
from standard_combined_drug_legacy_mapping scdm
INNER JOIN cdmv5.concept c 
on scdm.concept_id = c.concept_id 
and c.standard_concept is null 
--where --c.invalid_reason  in ('D', 'U') and 
--and c.concept_class_id  = 'Ingredient' 
--limit 10
),
--select * from cte1
cte2 as ( -- this is the 'output' set of standard concepts that we have found for the 'input' set of concepts
select * from cdmv5.concept_relationship  cr
inner join cdmv5.concept a
on cr.concept_id_1 = a.concept_id
and cr.invalid_reason is null
and a.vocabulary_id = 'RxNorm'
inner join cdmv5.concept b
on cr.concept_id_2 = b.concept_id
and b.vocabulary_id = 'RxNorm'
and b.standard_concept = 'S'
and b.concept_class_id in ('Ingredient','Clinical Drug Form')
and concept_id_1 in (select * from cte1)
)
--select * from cte2 order by 1,2
update standard_combined_drug_legacy_mapping scdm 
set -- concept_id = concept_id2 --, 
standard_concept_id = concept_id_2 -- update both the standard concept id and the original concept_id to the standard concept id we found
from cte2
where scdm.concept_id = cte2.concept_id_1;

------------------------------------------------------
-- convert standard branded drug form to standard clinical drug form

with cte1 as ( -- this is the 'input' set of non standard concepts that we want to process
select distinct scdm.concept_id
from standard_combined_drug_legacy_mapping scdm
INNER JOIN cdmv5.concept c 
on scdm.concept_id = c.concept_id 
--where --c.invalid_reason  in ('D', 'U') and 
and c.concept_class_id  = 'Branded Drug Form' 
--limit 10
),
--select * from cte1
cte2 as ( -- this is the 'output' set of standard concepts that we have found for the 'input' set of concepts
select * from cdmv5.concept_relationship  cr
inner join cdmv5.concept a
on cr.concept_id_1 = a.concept_id
and cr.invalid_reason is null
and a.vocabulary_id = 'RxNorm'
inner join cdmv5.concept b
on cr.concept_id_2 = b.concept_id
and b.vocabulary_id = 'RxNorm'
and b.standard_concept = 'S'
and b.concept_class_id in ('Ingredient','Clinical Drug Form')
and concept_id_1 in (select * from cte1)
)
--select * from cte2 order by 1,2
update standard_combined_drug_legacy_mapping scdm 
set -- concept_id = concept_id2 --, 
standard_concept_id = concept_id_2 -- update both the standard concept id and the original concept_id to the standard concept id we found
from cte2
where scdm.concept_id = cte2.concept_id_1;

------------------------------------------------------
-- convert brand name to standard ingredient

with cte1 as ( -- this is the 'input' set of non standard concepts that we want to process
select distinct scdm.concept_id
from standard_combined_drug_legacy_mapping scdm
INNER JOIN cdmv5.concept c 
on scdm.concept_id = c.concept_id 
--where --c.invalid_reason  in ('D', 'U') and 
and c.concept_class_id  = 'Brand Name' 
and c.invalid_reason is null
--limit 1000
),
--select * from cte1
cte2 as ( -- this is the 'output' set of standard concepts that we have found for the 'input' set of concepts
select * from cdmv5.concept_relationship  cr
left outer join cdmv5.concept a
on cr.concept_id_1 = a.concept_id
--and cr.invalid_reason is null
and a.vocabulary_id = 'RxNorm'
inner join cdmv5.concept b
on cr.concept_id_2 = b.concept_id
and b.vocabulary_id = 'RxNorm'
and b.standard_concept = 'S'
and b.concept_class_id in ('Ingredient','Clinical Drug Form')
and concept_id_1 in (select * from cte1)
and relationship_id = 'Tradename of'
)
--select * from cte2 order by 1,2
update standard_combined_drug_legacy_mapping scdm 
set -- concept_id = concept_id2 --, 
standard_concept_id = concept_id_2 -- update both the standard concept id and the original concept_id to the standard concept id we found
from cte2
where scdm.concept_id = cte2.concept_id_1;

------------------------------------------------------
-- convert U or D status rows to standard ingredient or clinical drug form

with cte1 as ( -- this is the 'input' set of non standard concepts that we want to process
select distinct scdm.concept_id
from standard_combined_drug_legacy_mapping scdm
INNER JOIN cdmv5.concept c 
on scdm.concept_id = c.concept_id 
and c.invalid_reason in ('U','D')
),
--select * from cte1
cte2 as ( -- this is the 'output' set of standard concepts that we have found for the 'input' set of concepts
select * from cdmv5.concept_relationship  cr
left outer join cdmv5.concept a
on cr.concept_id_1 = a.concept_id
--and cr.invalid_reason is null
and a.vocabulary_id = 'RxNorm'
inner join cdmv5.concept b
on cr.concept_id_2 = b.concept_id
and b.vocabulary_id = 'RxNorm'
and b.standard_concept = 'S'
and b.concept_class_id in ('Ingredient','Clinical Drug Form')
and concept_id_1 in (select * from cte1)
)
--select * from cte2 order by 1,2
update standard_combined_drug_legacy_mapping scdm 
set -- concept_id = concept_id2 --, 
standard_concept_id = concept_id_2 -- update both the standard concept id and the original concept_id to the standard concept id we found
from cte2
where scdm.concept_id = cte2.concept_id_1;

-------------------------------------------------------
-- create final table with just the standard ingredient and clinical drug form of the drugs

drop table if exists standard_drug_legacy;

create table standard_drug_legacy as
select a.isr, a.concept_id, c.concept_name, c.standard_concept, c.concept_class_id, c.valid_start_date, c.valid_end_date, c.invalid_reason
from standard_combined_drug_legacy_mapping a
inner join cdmv5.concept c
on a.standard_concept_id = c.concept_id
and c.concept_class_id in ('Ingredient','Clinical Drug Form')
and c.standard_concept = 'S';
