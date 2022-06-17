------------------------------
--
-- This SQL script copies the standard output tables and the source data tables to the "standard" and "source" schemas
--
-- LTS COMPUTING LLC
------------------------------

set search_path = standard;

--drop table if exists standard_case_indication;
create table if not exists standard_case_indication as select * from faers.standard_case_indication;

--drop table if exists standard_case_drug;
create table if not exists standard_case_drug as select * from faers.standard_case_drug;

--drop table if exists standard_case_outcome;
create table if not exists standard_case_outcome as select * from faers.standard_case_outcome;

--drop table if exists standard_case_outcome_category;
create table if not exists standard_case_outcome_category as select * from faers.standard_case_outcome_category;

--drop table if exists standard_drug_outcome_count;
create table if not exists standard_drug_outcome_count as select * from faers.standard_drug_outcome_count;

--drop table if exists standard_drug_outcome_contingency_table;
create table if not exists standard_drug_outcome_contingency_table as select * from faers.standard_drug_outcome_contingency_table;

--drop table if exists standard_drug_outcome_statistics;
create table if not exists standard_drug_outcome_statistics as select * from faers.standard_drug_outcome_statistics;

--drop table if exists standard_unique_all_case;
create table if not exists standard_unique_all_case as select * from faers.unique_all_case;

--drop table if exists standard_drug_outcome_drilldown;
create table if not exists standard_drug_outcome_drilldown as select * from faers.standard_drug_outcome_drilldown;

-----------------------------------------
set search_path = source;

--drop table if exists demo;
create table if not exists demo as select * from faers.demo;

--drop table if exists demo_legacy;
create table if not exists demo_legacy as select * from faers.demo_legacy;

--drop table if exists drug;
create table if not exists drug as select * from faers.drug;

--drop table if exists drug_legacy;
create table if not exists drug_legacy as select * from faers.drug_legacy;

--drop table if exists indi;
create table if not exists indi as select * from faers.indi;

--drop table if exists indi_legacy;
create table if not exists indi_legacy as select * from faers.indi_legacy;

--drop table if exists outc;
create table if not exists outc as select * from faers.outc;

--drop table if exists outc_legacy;
create table if not exists outc_legacy as select * from faers.outc_legacy;

--drop table if exists reac;
create table if not exists reac as select * from faers.reac;

--drop table if exists reac_legacy;
create table if not exists reac_legacy as select * from faers.reac_legacy;

--drop table if exists rpsr;
create table if not exists rpsr as select * from faers.rpsr;

--drop table if exists rpsr_legacy;
create table if not exists rpsr_legacy as select * from faers.rpsr_legacy;

--drop table if exists ther;
create table if not exists ther as select * from faers.ther;

--drop table if exists ther_legacy;
create table if not exists ther_legacy as select * from faers.ther_legacy;
