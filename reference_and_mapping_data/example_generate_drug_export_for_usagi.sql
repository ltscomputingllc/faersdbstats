-- this is an example of preparing an import file for usagi - it exports the top 100 unmatched drug names with a dummy source_id and a count of case frequency 
-- in postgres client save the results to a csv file and then import that csv file to usagi for manual code curation
--------------------------------------------
select row_number() over() as source_id, upper(drug_name_original) as drug_name_original, count(*) as case_frequency
from combined_drug_mapping
where concept_id is null
group by upper(drug_name_original) 
order by count(*) desc
limit 100