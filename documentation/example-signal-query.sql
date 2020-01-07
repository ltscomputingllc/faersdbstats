set search_path to faers;
with signals as (
 select * 
 from standard_drug_outcome_statistics
 where case_count >= 10
  and prr > 3.0
 limit 100
 )
 select c1.concept_name, c2.concept_name, signals.*
 from staging_vocabulary.concept c1 inner join signals on signals.drug_concept_id = c1.concept_id
   inner join staging_vocabulary.concept c2 on signals.outcome_concept_id = c2.concept_id
;