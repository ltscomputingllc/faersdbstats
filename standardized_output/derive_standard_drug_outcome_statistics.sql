------------------------------
--
-- This SQL script creates a statistics table called standard_drug_outcome_stats (using the counts from the previously calculated 2x2 contingency table)
-- with the following statistics for each drug/outcome pair:
--
-- 1) Case count
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
--
-- Standard deviations are obtained from Douglas G Altman's Practical Statistics for Medical Research. 1999. Chapter 10.11. Page 267 
--
-- LTS COMPUTING LLC
------------------------------

set search_path = faers;

drop table if exists standard_drug_outcome_statistics;
create table standard_drug_outcome_statistics as
select 
drug_concept_id, outcome_concept_id, cast(null as integer) as snomed_outcome_concept_id,
count_a as case_count,
round((count_a / (count_a + count_b)) / (count_c / (count_c + count_d)),5) as prr,
round(exp(ln((count_a / (count_a + count_b)) / (count_c / (count_c + count_d)))+1.96*sqrt((1.0/count_a)-(1.0/(count_a+count_b))+(1.0/count_c)-(1.0/(count_c+count_d)))),5) as prr_95_percent_upper_confidence_limit,
round(exp(ln((count_a / (count_a + count_b)) / (count_c / (count_c + count_d)))-1.96*sqrt((1.0/count_a)-(1.0/(count_a+count_b))+(1.0/count_c)-(1.0/(count_c+count_d)))),5) as prr_95_percent_lower_confidence_limit,
round(((count_a / count_c) / (count_b / count_d)),5) as ror,
round(exp((ln((count_a / count_c) / (count_b / count_d)))+1.96*sqrt((1.0/count_a)+(1.0/count_b)+(1.0/count_c)+(1.0/count_d))),5) as ror_95_percent_upper_confidence_limit,
round(exp((ln((count_a / count_c) / (count_b / count_d)))-1.96*sqrt((1.0/count_a)+(1.0/count_b)+(1.0/count_c)+(1.0/count_d))),5) as ror_95_percent_lower_confidence_limit
from standard_drug_outcome_contingency_table;
