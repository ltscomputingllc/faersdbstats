------------------------------
-- Load results of USAGI manual mapping into drug_usagi_mapping table via the usagi_import table
--
-- First manually import the usagi mapping results into the usagi_import table using
-- the pgadmin SQL client table import functionality and then run the below insert query
--
-- LTS COMPUTING LLC
------------------------------
insert into drug_usagi_mapping
select a.source_code_description as drug_name_original , 
b.concept_name, b.concept_class_id, cast(a.target_concept_id as integer) as concept_id, cast ('usagi' as text) as update_method
from usagi_import a
inner join staging_vocabulary.concept b
on cast(a.target_concept_id as integer) = b.concept_id
