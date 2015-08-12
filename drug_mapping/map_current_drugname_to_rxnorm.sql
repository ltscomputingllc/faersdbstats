------------------------------
-- map current drug drugnames to rxnorm Vocabulary concept_ids
--
-- we will include non-standard and standard codes so we pick up brand names as well as ingredients etc
-- and roll-up to standard codes when we produce the statistics in a later process.
--
-- we map using the following precedence order.
--
-- regex drug name mapping
-- active ingredient drug name mapping
-- nda drug_name mapping
-- manual usagi drug name mapping
--
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

drop table if exists drug_regex_mapping;

create table drug_regex_mapping as
select distinct drugname as drug_name_original, upper(drugname) as drug_name_clean, cast(null as integer) as concept_id, null as update_method
from drug a
inner join unique_case b on a.primaryid = b.primaryid
where role_cod <> 'C'; -- ignore concomitant drugs

-- create an index on the mapping table to improve performance
create index drug_name_clean_ix on drug_regex_mapping(drug_name_clean);

-- find exact mapping
UPDATE drug_regex_mapping a
SET update_method = 'regex upper' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean;

-- remove trailing spaces or period characters
update drug_regex_mapping
set drug_name_clean = regexp_replace(drug_name_clean, '[ \.]$', '', 'gi')
where concept_id is null;

-- find exact mapping
UPDATE drug_regex_mapping a
SET update_method = 'regex trailing space or period chars' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean
and a.concept_id is null;

-- remove multiple occurrences of white space '
update drug_regex_mapping
set drug_name_clean = regexp_replace(drug_name_clean, '(\S) +', '\1 ', 'gi')
where concept_id is null;

-- find exact mapping
UPDATE drug_regex_mapping a
SET update_method = 'regex remove multiple white space' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean
and a.concept_id is null;

-- remove trailing spaces
update drug_regex_mapping
set drug_name_clean = regexp_replace(drug_name_clean, ' +$', '', 'gi')
where concept_id is null;

-- find exact mapping
UPDATE drug_regex_mapping a
SET update_method = 'regex remove trailing spaces' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean
and a.concept_id is null;

-- remove leading spaces
update drug_regex_mapping
set drug_name_clean = regexp_replace(drug_name_clean, '^ +', '', 'gi')
where concept_id is null;

-- find exact mapping
UPDATE drug_regex_mapping a
SET update_method = 'regex remove leading spaces' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean
and a.concept_id is null;

-- remove single quotes and double quotes'
update drug_regex_mapping
set drug_name_clean = regexp_replace(drug_name_clean, '[''""]', '', 'gi')
where concept_id is null;

-- find exact mapping
UPDATE drug_regex_mapping a
SET update_method = 'regex remove single quotes' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean
and a.concept_id is null;

-- remove '^*$?' chars
update drug_regex_mapping
set drug_name_clean = regexp_replace(drug_name_clean, '[\*\^\$\?]', '', 'gi')
where concept_id is null;

-- find exact mapping
UPDATE drug_regex_mapping a
SET update_method = 'regex remove ^*$? punctuation chars' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean
and a.concept_id is null;

-- change \ to / char
update drug_regex_mapping
set drug_name_clean = regexp_replace(drug_name_clean, '\\', '/', 'gi')
where concept_id is null;

-- find exact mapping
UPDATE drug_regex_mapping a
SET update_method = 'regex change forward slash to back slash' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean
and a.concept_id is null;

-- remove spaces before closing parenthesis char
update drug_regex_mapping
set drug_name_clean = regexp_replace(drug_name_clean, ' +\)', ')', 'gi')
where concept_id is null;

-- find exact mapping
UPDATE drug_regex_mapping a
SET update_method = 'regex remove spaces before closing parenthesis' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean
and a.concept_id is null;

-- remove (UNKNOWN)
update drug_regex_mapping
set drug_name_clean = regexp_replace(drug_name_clean, '( *unknown *)', '', 'gi')
where concept_id is null;

-- find exact mapping
UPDATE drug_regex_mapping a
SET update_method = 'regex remove (unknown)' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean
and a.concept_id is null;

-- remove BLINDED
update drug_regex_mapping
set drug_name_clean = regexp_replace(drug_name_clean, ' *blinded *', '', 'gi')
where concept_id is null;

-- find exact mapping
UPDATE drug_regex_mapping a
SET update_method = 'regex remove blinded' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.drug_name_clean
and a.concept_id is null;
--------------------------------------------------

-- create active ingredient mapping table

drop table if exists drug_ai_mapping;
create table drug_ai_mapping as
select distinct drugname as drug_name_original, prod_ai, cast(null as integer) as concept_id, null as update_method
from drug a
inner join unique_case b on a.primaryid = b.primaryid
where role_cod <> 'C'; -- ignore concomitant drugs

create index prod_ai_ix on drug_ai_mapping(prod_ai);

-- find exact mapping using the active ingredient provided in the drug table
UPDATE drug_ai_mapping a
SET update_method = 'drug active ingredients' , concept_id = b.concept_id
FROM cdmv5.concept b
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND upper(b.concept_name) = a.prod_ai;

-----------------------------------------------

-- create NDA (new drug application) number mapping table
-- (NDA num maps to ingredient(s) in the FDA orange book reference dataset)

-- note the following table should be created one time when the FDA orange book (NDA ingredient lookup) table is loaded
drop table if exists nda_ingredient;
create table nda_ingredient as
select distinct appl_no, ingredient
from nda; 

drop table if exists drug_nda_mapping;
create table drug_nda_mapping as
select distinct drugname as drug_name_original, nda_num, null as nda_ingredient, cast(null as integer) as concept_id, null as update_method
from drug a
inner join unique_case b on a.primaryid = b.primaryid
where role_cod <> 'C' -- ignore concomitant drugs
and nda_num is not null; -- where nda_num is populated

create index nda_num_ix on drug_nda_mapping(nda_num);

-- find exact mapping using the drug table nda_num, NDA to ingredient lookup
UPDATE drug_nda_mapping a
SET update_method = 'drug nda_num ingredients' , nda_ingredient = nda_ingredient.ingredient, concept_id = b.concept_id
FROM cdmv5.concept b
inner join nda_ingredient
on upper(b.concept_name) = nda_ingredient.ingredient
WHERE b.vocabulary_id = 'RxNorm'
--AND b.standard_concept = 'S'
AND nda_ingredient.appl_no = a.nda_num;

-----------------------------------------------

-- combine all the different types of mapping into a single combined drug mapping table

drop table if exists combined_drug_mapping;
create table combined_drug_mapping as
select a.primaryid, drugname as drug_name_original, cast(null as varchar) as lookup_value, cast(null as integer) as concept_id, cast(null as varchar) as update_method
from drug a
inner join unique_case b on a.primaryid = b.primaryid
WHERE a.role_cod <> 'C'; -- ignore concomitant drugs

-- update using drug_regex_mapping 
UPDATE combined_drug_mapping a
SET  update_method = b.update_method , lookup_value = drug_name_clean, concept_id = b.concept_id
FROM drug_regex_mapping b
WHERE upper(a.drug_name_original) = upper(b.drug_name_original);

-- update using drug_ai_mapping
UPDATE combined_drug_mapping a
SET  update_method = b.update_method , lookup_value = prod_ai, concept_id = b.concept_id
FROM drug_ai_mapping b
WHERE upper(a.drug_name_original) = upper(b.drug_name_original)
and a.concept_id is null;

-- update using drug_nda_mapping
UPDATE combined_drug_mapping a
SET  update_method = b.update_method , lookup_value = nda_ingredient, concept_id = b.concept_id
FROM drug_nda_mapping b
WHERE upper(a.drug_name_original) = upper(b.drug_name_original)
and a.concept_id is null;

-- update using drug_usagi_mapping
-- manually curated drug mappings
UPDATE combined_drug_mapping a
SET  update_method = b.update_method , lookup_value = b.concept_name, concept_id = b.concept_id
FROM drug_usagi_mapping b
WHERE upper(a.drug_name_original) = upper(b.drug_name_original)
and a.concept_id is null;

