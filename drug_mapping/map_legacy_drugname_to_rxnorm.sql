------------------------------
-- map legacy drug drugnames to rxnorm Vocabulary concept_ids
--
-- we will include non-standard and standard codes so we pick up brand names as well as ingredients etc
-- and roll-up to standard codes when we produce the statistics in a later process.
--
-- we map using the following precedence order.
--
-- regex drug name mapping
-- nda drug_name mapping
-- manual usagi drug name mapping
--
-- NOTES
--
-- 1. It is sufficient to re-use the usagi tables that were generated for mapping the current FAERS data.
-- 2. Active ingredient drug is not provided in the legacy FAERS data.

-- LTS COMPUTING LLC
------------------------------

-- temporarily create an index on concept table to improve performance of all the mapping lookups
-- we will then drop it at the end of this script
--create index vocab_concept_name_ix on cdmv5.concept(vocabulary_id, standard_concept, concept_name, concept_id);

set search_path = faers;

-- build a mapping table to generate a cleaned up version of the drugname for exact match joins to the concept table concept_name column 
-- for RxNorm concepts only 
-- NOTE we join to unique_case because we only need to map drugs for unique cases 
-- ie. where there are multiple versions we only process the case with the latest (max) caseversion)

drop table if exists drug_legacy_regex_mapping;

create table drug_legacy_regex_mapping as
select distinct drugname as drug_name_original, upper(drugname) as drug_name_clean, cast(null as integer) as concept_id, null as update_method
from drug_legacy a
inner join unique_legacy_case b on a.isr = b.isr
where role_cod <> 'C'; -- ignore concomitant drugs

-- create an index on the mapping table to improve performance
create index drug_name_clean_legacy_ix on drug_legacy_regex_mapping(drug_name_clean);

-- find exact mapping
UPDATE drug_legacy_regex_mapping a
SET update_method = 'regex legacy - upper' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean;

-- remove trailing spaces or period characters
update drug_legacy_regex_mapping
set drug_name_clean = regexp_replace(drug_name_clean, '[ \.]$', '', 'gi')
where concept_id is null;

-- find exact mapping
UPDATE drug_legacy_regex_mapping a
SET update_method = 'regex legacy - trailing space or period chars' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean
and a.concept_id is null;

-- remove multiple occurrences of white space '
update drug_legacy_regex_mapping
set drug_name_clean = regexp_replace(drug_name_clean, '(\S) +', '\1 ', 'gi')
where concept_id is null;

-- find exact mapping
UPDATE drug_legacy_regex_mapping a
SET update_method = 'regex legacy - remove multiple white space' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean
and a.concept_id is null;

-- remove trailing spaces
update drug_legacy_regex_mapping
set drug_name_clean = regexp_replace(drug_name_clean, ' +$', '', 'gi')
where concept_id is null;

-- find exact mapping
UPDATE drug_legacy_regex_mapping a
SET update_method = 'regex legacy - remove trailing spaces' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean
and a.concept_id is null;

-- remove leading spaces
update drug_legacy_regex_mapping
set drug_name_clean = regexp_replace(drug_name_clean, '^ +', '', 'gi')
where concept_id is null;

-- find exact mapping
UPDATE drug_legacy_regex_mapping a
SET update_method = 'regex legacy - remove leading spaces' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean
and a.concept_id is null;

-- remove single quotes and double quotes'
update drug_legacy_regex_mapping
set drug_name_clean = regexp_replace(drug_name_clean, '[''""]', '', 'gi')
where concept_id is null;

-- find exact mapping
UPDATE drug_legacy_regex_mapping a
SET update_method = 'regex legacy - remove single quotes' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean
and a.concept_id is null;

-- remove '^*$?' chars
update drug_legacy_regex_mapping
set drug_name_clean = regexp_replace(drug_name_clean, '[\*\^\$\?]', '', 'gi')
where concept_id is null;

-- find exact mapping
UPDATE drug_legacy_regex_mapping a
SET update_method = 'regex legacy - remove ^*$? punctuation chars' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean
and a.concept_id is null;

-- change \ to / char
update drug_legacy_regex_mapping
set drug_name_clean = regexp_replace(drug_name_clean, '\\', '/', 'gi')
where concept_id is null;

-- find exact mapping
UPDATE drug_legacy_regex_mapping a
SET update_method = 'regex legacy - change forward slash to back slash' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean
and a.concept_id is null;

-- remove spaces before closing parenthesis char
update drug_legacy_regex_mapping
set drug_name_clean = regexp_replace(drug_name_clean, ' +\)', ')', 'gi')
where concept_id is null;

-- find exact mapping
UPDATE drug_legacy_regex_mapping a
SET update_method = 'regex legacy - remove spaces before closing parenthesis' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean
and a.concept_id is null;

-- remove (UNKNOWN)
update drug_legacy_regex_mapping
set drug_name_clean = regexp_replace(drug_name_clean, '( *unknown *)', '', 'gi')
where concept_id is null;

-- find exact mapping
UPDATE drug_legacy_regex_mapping a
SET update_method = 'regex legacy - remove (unknown)' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean
and a.concept_id is null;

-- remove BLINDED
update drug_legacy_regex_mapping
set drug_name_clean = regexp_replace(drug_name_clean, ' *blinded *', '', 'gi')
where concept_id is null;

-- find exact mapping
UPDATE drug_legacy_regex_mapping a
SET update_method = 'regex legacy - remove blinded' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean
and a.concept_id is null;

-- create combined_drug_legacy_mapping table with the unique legacy cases
drop table if exists combined_drug_legacy_mapping;
create table combined_drug_legacy_mapping as
select a.isr, drugname as drug_name_original, cast(null as varchar) as lookup_value, cast(null as integer) as concept_id, cast(null as varchar) as update_method
from drug_legacy a
inner join unique_legacy_case b on a.isr = b.isr
WHERE a.role_cod <> 'C'; -- ignore concomitant drugs

-- update combined legacy drug mapping table with the drug mapping data in the drug_legacy_regex_mapping 
UPDATE combined_drug_legacy_mapping a
SET  update_method = b.update_method , lookup_value = drug_name_clean, concept_id = b.concept_id
FROM drug_legacy_regex_mapping b
WHERE upper(a.drug_name_original) = upper(b.drug_name_original);

--------------------------------------------------


-- create NDA (new drug application) number mapping table
-- (NDA num maps to ingredient(s) in the FDA orange book reference dataset)

-- note the following table should be created one time when the FDA orange book (NDA ingredient lookup) table is loaded
--drop table if exists nda_ingredient;
--create table nda_ingredient as
--select distinct appl_no, ingredient
--from nda; 

drop table if exists drug_legacy_nda_mapping;
create table drug_legacy_nda_mapping as
select distinct drugname as drug_name_original, nda_num, null as nda_ingredient, cast(null as integer) as concept_id, null as update_method
from drug_legacy a
inner join unique_legacy_case b on a.isr = b.isr
where role_cod <> 'C' -- ignore concomitant drugs
and nda_num is not null; -- where nda_num is populated

create index nda_num_legacy_ix on drug_legacy_nda_mapping(nda_num);

-- find exact mapping using the drug table nda_num, NDA to ingredient lookup
UPDATE drug_legacy_nda_mapping a
SET update_method = 'drug legacy nda_num ingredients' , nda_ingredient = nda_ingredient.ingredient, concept_id = b.concept_id
FROM cdmv5.concept b
inner join nda_ingredient
on upper(b.concept_name) = nda_ingredient.ingredient
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND nda_ingredient.appl_no = a.nda_num;

-- update combined legacy drug mapping table using drug_legacy_nda_mapping
UPDATE combined_drug_legacy_mapping a
SET  update_method = b.update_method , lookup_value = nda_ingredient, concept_id = b.concept_id
FROM drug_legacy_nda_mapping b
WHERE upper(a.drug_name_original) = upper(b.drug_name_original)
and a.concept_id is null;

-----------------------------------------------

-- we included some mappings of the top legacy drugs in the USAGI drug mapping table along with the mappings we previously created for the current data

-- update legacy combined drug mapping table using drug_usagi_mapping
-- manually curated drug mappings
UPDATE combined_drug_legacy_mapping a
SET  update_method = b.update_method , lookup_value = b.concept_name, concept_id = b.concept_id
FROM drug_usagi_mapping b
WHERE upper(a.drug_name_original) = upper(b.drug_name_original)
and a.concept_id is null;
-----------------------------------------------



