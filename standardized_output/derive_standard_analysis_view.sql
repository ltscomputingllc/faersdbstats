------------------------------
--
-- This SQL script creates an view for analysis of the standardized FAERS legacy and current data
--
-- LTS COMPUTING LLC
------------------------------

set search_path = standard


drop index if exists standard_case_drug_ix_1;
create index standard_case_drug_ix_1 on standard_case_drug(primaryid);
drop index if exists standard_case_drug_ix_2;
create index standard_case_drug_ix_2 on standard_case_drug(isr);

drop index if exists standard_case_outcome_ix_1;
create index standard_case_outcome_ix_1 on standard_case_outcome(primaryid);
drop index if exists standard_case_outcome_ix_2;
create index standard_case_outcome_ix_2 on standard_case_outcome(isr);

drop index if exists standard_case_indication_ix_1;
create index standard_case_indication_ix_1 on standard_case_indication(primaryid);
drop index if exists standard_case_indication_ix_2;
create index standard_case_indication_ix_2 on standard_case_indication(isr);

drop index if exists standard_case_outcome_category_ix_1;
create index standard_case_outcome_category_ix_1 on standard_case_outcome_category(primaryid);
drop index if exists standard_case_outcome_category_ix_2;
create index standard_case_outcome_category_ix_2 on standard_case_outcome_category(isr);

drop view if exists standard_analysis;
create view standard_analysis as
select a.primaryid, null as isr, a.standard_concept_id as drug_concept_id, a.concept_name as drug_name, a.concept_class_id, 
       b.pt as outcome_name, b.outcome_concept_id as outcome_concept_id, b.snomed_outcome_concept_id, 
       c.indi_pt as indication_name, c.indication_concept_id, c.snomed_indication_concept_id,
       d.outc_code as case_outcome, d.snomed_concept_id as case_outcome_snomed_concept_id
from standard_case_drug a
left outer join standard_case_outcome b
on a.primaryid = b.primaryid and a.isr is null and b.isr is null
left outer join standard_case_indication c
on a.primaryid = c.primaryid
left outer join standard_case_outcome_category d
on a.primaryid = d.primaryid
union
select null as primaryid, a.isr, a.standard_concept_id as drug_concept_id, a.concept_name as drug_name, a.concept_class_id, 
       b.pt as outcome_name, b.outcome_concept_id as outcome_concept_id, b.snomed_outcome_concept_id, 
       c.indi_pt as indication_name, c.indication_concept_id, c.snomed_indication_concept_id,
       d.outc_code as case_outcome, d.snomed_concept_id as case_outcome_snomed_concept_id
from standard_case_drug a
left outer join standard_case_outcome b
on a.isr = b.isr and a.isr is not null and b.isr is not null
left outer join standard_case_indication c
on a.isr = c.isr and a.isr is not null and c.isr is not null
left outer join standard_case_outcome_category d
on a.isr = d.isr and a.isr is not null and d.isr is not null;

