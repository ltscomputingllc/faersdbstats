-- This SQL generates the set of unmatched drug names with a dummy source_id and a source frequency based on frequency of cases
-- In postgres SQL client save the results to a csv file and then import that csv file to usagi for manual code curation
--
-- LTS Computing LLC
--------------------------------------------
set search_path = faers;

select row_number() over () as source_code, 
upper(drug_name_original) as source_code_description, 
count(*) as frequency -- (case frequency)
from combined_drug_mapping where concept_id is null
group by upper(drug_name_original)
order by count(*) desc
