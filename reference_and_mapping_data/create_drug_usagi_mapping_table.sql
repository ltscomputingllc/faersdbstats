-- USAGI manually mapped drug names mapping table
--
-- LTS Computing LLC
-----------------------------------------------------------------------------------------------
set search_path = faers;

drop table if exists drug_usagi_mapping;
CREATE TABLE drug_usagi_mapping
(
  drug_name_original text,
  concept_name character varying(1000),
  concept_class_id character varying(500),
  concept_id integer,
  update_method text
)
