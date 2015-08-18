------------------------------
--
-- This SQL script copies the standard output tables and the source data tables to the "standard" and "source" schemas
--
-- LTS COMPUTING LLC
------------------------------

set search_path = standard;

drop table if exists standard_drug_outcome_count;
create table standard_drug_outcome_count as select * from faers.standard_drug_outcome_count;
drop table if exists standard_drug_outcome_contingency_table;
create table standard_drug_outcome_contingency_table as select * from faers.standard_drug_outcome_contingency_table;

drop table if exists standard_legacy_drug_outcome_count;
create table standard_legacy_drug_outcome_count as select * from faers.standard_legacy_drug_outcome_count;
drop table if exists standard_legacy_drug_outcome_contingency_table;
create table standard_legacy_drug_outcome_contingency_table as select * from faers.standard_legacy_drug_outcome_contingency_table;

drop table if exists standard_all_drug_outcome_count;
create table standard_all_drug_outcome_count as select * from faers.standard_all_drug_outcome_count;
drop table if exists standard_all_drug_outcome_contingency_table;
create table standard_all_drug_outcome_contingency_table as select * from faers.standard_all_drug_outcome_contingency_table;

drop table if exists standard_drug_outcome_statistics;
create table standard_drug_outcome_statistics as select * from faers.standard_drug_outcome_statistics;

drop table if exists standard_legacy_drug_outcome_statistics;
create table standard_legacy_drug_outcome_statistics as select * from faers.standard_legacy_drug_outcome_statistics;

drop table if exists standard_all_drug_outcome_statistics;
create table standard_all_drug_outcome_statistics as select * from faers.standard_all_drug_outcome_statistics;

drop table if exists standard_case_indication;
create table standard_case_indication as select * from faers.standard_case_indication;

drop table if exists standard_legacy_case_indication;
create table standard_legacy_case_indication as select * from faers.standard_legacy_case_indication;

drop table if exists standard_case_outcome;
create table standard_case_outcome as select * from faers.standard_case_outcome;

drop table if exists standard_legacy_case_outcome;
create table standard_legacy_case_outcome as select * from faers.standard_legacy_caseoutcome;

drop table if exists standard_case_outcome_category;
create table standard_case_outcome_category as select * from faers.standard_case_outcome_category;

drop table if exists standard_legacy_case_outcome_category;
create table standard_legacy_case_outcome_category as select * from faers.standard_legacy_case_outcome_category;

-----------------------------------------
set search_path = source;

drop table if exists demo;
create table demo as select * from faers.demo;

drop table if exists demo_legacy;
create table demo_legacy as select * from faers.demo_legacy;

drop table if exists drug;
create table drug as select * from faers.drug;

drop table if exists drug_legacy;
create table drug_legacy as select * from faers.drug_legacy;

drop table if exists indi;
create table indi as select * from faers.indi;

drop table if exists indi_legacy;
create table indi_legacy as select * from faers.indi_legacy;

drop table if exists outc;
create table outc as select * from faers.outc;

drop table if exists outc_legacy;
create table outc_legacy as select * from faers.outc_legacy;

drop table if exists reac;
create table reac as select * from faers.reac;

drop table if exists reac_legacy;
create table reac_legacy as select * from faers.reac_legacy;

drop table if exists rpsr;
create table rpsr as select * from faers.rpsr;

drop table if exists rpsr_legacy;
create table rpsr_legacy as select * from faers.rpsr_legacy;

drop table if exists ther;
create table ther as select * from faers.ther;

drop table if exists ther_legacy;
create table ther_legacy as select * from faers.ther_legacy;
