------------------------------
--
-- This SQL script creates a statistics table called standard_all_drug_outcome_stats with the following statistics
-- for all (legacy drugs and current drugs combined) drug/outcome pairs:
--
-- 1) case_count
-- 2) Proportional Reporting Ratio (PRR) along with the 95% CI upper and lower values
-- 3) Reporting Odds Ratio (ROR) along with the 95% CI upper and lower values
--
-- PRR for pair:(drug P, outcome R) is calculated as (A / (A + B)) / (C / (C + D)
--
-- ROR for pair:(drug P, outcome R) is calculated as (A / C) / (B / D)
--
-- Where:
--		A = case_count for the pair:(drug P, outcome R)
--		B = sum(case_count) for all pairs:(drug P, all outcomes except outcome R)
--		C = sum(case_count) for all pairs:(all drugs except drug P, outcome R)
--		D = sum(case_count) for all pairs:(all drugs except drug P, all outcomes except outcome R)
--
-- Note if C is 0 then the resulting PRR and ROR values will be null. Potentially a relatively high constant value
-- could be assigned instead, to indicate a potential PRR and ROR signal in these cases.
--
-- LTS COMPUTING LLC
------------------------------

set search_path = faers;

drop table if exists standard_all_drug_outcome_statistics;
create table standard_all_drug_outcome_statistics as
select 
drug_concept_id, outcome_concept_id, 
count_a as case_count,
(count_a / (count_a + count_b)) / (count_c / (count_c + count_d)) as prr,
(ln((count_a / (count_a + count_b)) / (count_c / (count_c + count_d)))+1.96)*sqrt((1/count_a)+(1/count_b)+(1/count_c)+(1/count_d)) as prr_95_percent_upper_confidence_limit,
(ln((count_a / (count_a + count_b)) / (count_c / (count_c + count_d)))-1.96)*sqrt((1/count_a)+(1/count_b)+(1/count_c)+(1/count_d)) as prr_95_percent_lower_confidence_limit,
((count_a / count_c) / (count_b / count_d)) as ror,
(ln((count_a / count_c) / (count_b / count_d))+1.96)*sqrt((1/count_a)+(1/count_b)+(1/count_c)+(1/count_d)) as ror_95_percent_upper_confidence_limit,
(ln((count_a / count_c) / (count_b / count_d))-1.96)*sqrt((1/count_a)+(1/count_b)+(1/count_c)+(1/count_d)) as ror_95_percent_lower_confidence_limit
from standard_all_drug_outcome_contingency_table;
