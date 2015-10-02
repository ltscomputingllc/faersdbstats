--------------------------------------------------------------------------------------------------------------------------------------
-- Export the original FAERS current and legacy source data from the staging tables as CSV files.
-- Export the standardized data tables produced by this ETL process as CSV files.
-- Compress the CSV files to a single gzip file using: gzip -c *.csv > faersdbstats.gz
--
-- LTS Computing LLC
--------------------------------------------------------------------------------------------------------------------------------------

-- export the original FAERS current and legacy source data from the staging tables as CSV files


set search_path = faers;

-- export the legacy FAERS source data
copy demo_legacy to '/data/outbound/demo_legacy.csv' CSV header;
copy drug_legacy to '/data/outbound/drug_legacy.csv' CSV header;
copy reac_legacy to '/data/outbound/reac_legacy.csv' CSV header;
copy outc_legacy to '/data/outbound/outc_legacy.csv' CSV header;
copy rpsr_legacy to '/data/outbound/rpsr_legacy.csv' CSV header;
copy ther_legacy to '/data/outbound/ther_legacy.csv' CSV header;
copy indi_legacy to '/data/outbound/indi_legacy.csv' CSV header;


-- export the current FAERS source data
copy demo to '/data/outbound/demo.csv' CSV header;
copy drug to '/data/outbound/drug.csv' CSV header;
copy reac to '/data/outbound/reac.csv' CSV header;
copy outc to '/data/outbound/outc.csv' CSV header;
copy rpsr to '/data/outbound/rpsr.csv' CSV header;
copy ther to '/data/outbound/ther.csv' CSV header;
copy indi to '/data/outbound/indi.csv' CSV header;


-- export the standardized data tables produced by this ETL process as CSV files.

set search_path = standard;

copy standard_case_drug to '/data/outbound/standard_case_drug.csv' CSV header;
copy standard_case_indication to '/data/outbound/standard_case_indication.csv' CSV header;
copy standard_case_outcome to '/data/outbound/standard_case_outcome.csv' CSV header;
copy standard_case_outcome_category to '/data/outbound/standard_case_outcome_category.csv' CSV header;
copy standard_drug_outcome_contingency_table to '/data/outbound/standard_drug_outcome_contingency_table.csv' CSV header;
copy standard_drug_outcome_count to '/data/outbound/standard_drug_outcome_count.csv' CSV header;
copy standard_drug_outcome_statistics to '/data/outbound/standard_drug_outcome_statistics.csv' CSV header;
copy standard_unique_all_case to '/data/outbound/standard_unique_all_case.csv' CSV header;
copy standard_drug_outcome_drilldown to '/data/outbound/standard_drug_outcome_drilldown.csv' CSV header;
