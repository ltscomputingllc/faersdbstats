--######################################################
--# Create indi staging tables DDL and
--# Load current FAERS data files into the indi table
--#
--# LTS Computing LLC
--######################################################

set search_path = faers;

drop table if exists indi ;
create table indi
(
primaryid varchar,
caseid varchar,
indi_drug_seq varchar,
indi_pt varchar,
filename varchar
);
truncate indi;

\COPY indi FROM '/home/faersdbstats/load_data_files_from_website/ascii/all_indi_data_with_filename.txt' WITH DELIMITER E'$' CSV HEADER QUOTE E'\b' ;
select filename, count(*) from indi group by filename order by 1;

