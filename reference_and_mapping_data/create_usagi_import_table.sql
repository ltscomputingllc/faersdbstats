-- Create staging table to import USAGI manually mapped drug names
--
-- LTS Computing LLC
-----------------------------------------------------------------------------------------------
set search_path = faers;

drop table if exists usagi_import;
CREATE TABLE usagi_import
(
  source_code character varying,
  source_concept_id character varying,
  source_vocabulary_id character varying,
  source_code_description character varying,
  target_concept_id character varying,
  target_vocabulary_id character varying,
  valid_start_date character varying,
  valid_end_date character varying,
  invalid_reason character varying
)
