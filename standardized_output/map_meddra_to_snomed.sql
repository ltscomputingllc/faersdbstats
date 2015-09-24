------------------------------
-- map drug indications and adverse event outcomes (FAERS reactions) and associated drug/outcome pair counts from MedDRA preferred terms to SNOMED-CT concepts
--
-- LTS COMPUTING LLC
------------------------------

set search_path = faers;

-- populate standard_case_indication SNOMED-CT concepts
update standard_case_indication a
set snomed_indication_concept_id = snomed_concept_id
from meddra_snomed_mapping b
where a.indication_concept_id = b.meddra_concept_id;

-- populate standard_case_outcome SNOMED-CT concepts
update standard_case_outcome a
set snomed_outcome_concept_id = snomed_concept_id
from meddra_snomed_mapping b
where a.outcome_concept_id = b.meddra_concept_id;

-- populate standard_drug_outcome_count SNOMED-CT concepts
update standard_drug_outcome_count a
set snomed_outcome_concept_id = snomed_concept_id
from meddra_snomed_mapping b
where a.outcome_concept_id = b.meddra_concept_id;

-- populate standard_drug_outcome_statistics SNOMED-CT concepts
update standard_drug_outcome_statistics a
set snomed_outcome_concept_id = snomed_concept_id
from meddra_snomed_mapping b
where a.outcome_concept_id = b.meddra_concept_id;