------------------------------
--
-- Create standard_drug_outcome_drilldown table for use in joins to get all cases for a drug/outcome pair count
--
-- LTS COMPUTING LLC
------------------------------

set search_path = faers;

-- create indexes to speed up this SQL

drop index if exists standard_case_drug_ix_1;
create index standard_case_drug_ix_1 on standard_case_drug(primaryid);
drop index if exists standard_case_drug_ix_2;
create index standard_case_drug_ix_2 on standard_case_drug(isr);
drop index if exists standard_case_drug_ix_3;
create index standard_case_drug_ix_3 on standard_case_drug(standard_concept_id);

drop index if exists standard_case_outcome_ix_1;
create index standard_case_outcome_ix_1 on standard_case_outcome(primaryid);
drop index if exists standard_case_outcome_ix_2;
create index standard_case_outcome_ix_2 on standard_case_outcome(isr);
drop index if exists standard_case_outcome_ix_3;
create index standard_case_outcome_ix_3 on standard_case_outcome(outcome_concept_id);

drop index if exists standard_drug_outcome_count_ix_1;
create index standard_drug_outcome_count_ix_1 on standard_drug_outcome_count(drug_concept_id);
drop index if exists standard_drug_outcome_count_ix_2;
create index standard_drug_outcome_count_ix_2 on standard_drug_outcome_count(outcome_concept_id);

drop table if exists standard_drug_outcome_drilldown;
create table standard_drug_outcome_drilldown as
select 
a.drug_concept_id, 
a.outcome_concept_id, 
a.snomed_outcome_concept_id, 
b.primaryid, null as isr, null as caseid
from standard_drug_outcome_count a
inner join standard_case_drug b
on a.drug_concept_id = b.standard_concept_id
inner join standard_case_outcome c
on a.outcome_concept_id = c.outcome_concept_id
and b.primaryid = c.primaryid
union
select
a.drug_concept_id,  
a.outcome_concept_id, 
a.snomed_outcome_concept_id,  
null as primary_id, b.isr, null as caseid
from standard_drug_outcome_count a
inner join standard_case_drug b
on a.drug_concept_id = b.standard_concept_id
inner join standard_case_outcome c
on a.outcome_concept_id = c.outcome_concept_id
and b.isr = c.isr;

-- populate the caseids that have a primaryid
update standard_drug_outcome_drilldown a
set caseid = b.caseid
from unique_all_case b
where a.primaryid = b.primaryid;

-- populate the caseids that have an isr
update standard_drug_outcome_drilldown a
set caseid = b.caseid
from unique_all_case b
where a.isr = b.isr
and a.caseid is null;
