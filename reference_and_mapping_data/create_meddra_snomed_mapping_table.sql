-- Create a mapping table from MedDRA to SNOMED-CT. 
-- We will use this table to map indications and reactions from MedDRA preferred term concepts to SNOMED-CT concepts/
--
-- LTS Computing LLC
-----------------------------------------------------------------------------------------------
set search_path = faers;

drop table if exists meddra_snomed_mapping;
create table meddra_snomed_mapping as
SELECT z.SNOMED_CONCEPT_ID, z.SNOMED_CONCEPT_NAME, z.SNOMED_CONCEPT_CODE, z.MEDDRA_CONCEPT_ID, z.MEDDRA_CONCEPT_NAME, z.MEDDRA_CONCEPT_CODE, z.MEDDRA_CLASS_ID
FROM (
      SELECT ca.max_levels_of_separation, ca.min_levels_of_separation, c.concept_id AS MEDDRA_CONCEPT_ID,
	     c.concept_code AS MEDDRA_CONCEPT_CODE, c.concept_name AS MEDDRA_CONCEPT_NAME, c.concept_class_id AS MEDDRA_CLASS_ID,
	     c2.concept_id AS SNOMED_CONCEPT_ID, c2.concept_name AS SNOMED_CONCEPT_NAME, c2.concept_code AS SNOMED_CONCEPT_CODE,
	     ROW_NUMBER() OVER(PARTITION BY c.CONCEPT_ID ORDER BY c.CONCEPT_ID, ca.min_levels_of_separation, ca.max_levels_of_separation, c.CONCEPT_ID, c2.CONCEPT_ID) AS ROW_NUM
      FROM cdmv5.CONCEPT c JOIN cdmv5.concept_ancestor ca ON ca.ancestor_concept_id = c.concept_id
      JOIN cdmv5.CONCEPT c2 ON c2.concept_id = ca.descendant_concept_id
	     AND c2.vocabulary_id = 'SNOMED'
	     AND c2.CONCEPT_CLASS_ID = 'Clinical Finding'
	     AND c2.INVALID_REASON IS NULL
      WHERE c.vocabulary_id = 'MedDRA'
      AND c.INVALID_REASON IS NULL
) z
WHERE z.ROW_NUM = 1;