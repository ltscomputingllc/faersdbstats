--######################################################
--# Create legacy indication staging tables DDL and
--# Load legacy FAERS data files into the indi_legacy table
--#
--# LTS Computing LLC
--######################################################

set search_path = faers;

drop table if exists indi_legacy;
create table indi_legacy
(
ISR varchar,
DRUG_SEQ varchar,
INDI_PT varchar,
FILENAME varchar
);
truncate indi_legacy;

\COPY indi_legacy FROM '/home/faersdbstats/load_data_files_from_website/ascii/all_indi_legacy_data_with_filename.txt' WITH DELIMITER E'$' CSV HEADER QUOTE E'\b' ;
select distinct filename from indi_legacy order by 1 ;

