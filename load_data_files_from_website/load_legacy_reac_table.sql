--######################################################
--# Create legacy reaction staging tables DDL and
--# Load legacy FAERS data files into the reac_legacy table
--#
--# LTS Computing LLC
--######################################################

set search_path = faers;

drop table if exists reac_legacy;
create table reac_legacy
(
ISR varchar,
PT varchar,
FILENAME varchar
);
truncate reac_legacy;

\COPY reac_legacy FROM '/home/faersdbstats/load_data_files_from_website/ascii/all_reac_legacy_data_with_filename.txt' WITH DELIMITER E'$' CSV HEADER QUOTE E'\b' ;
select distinct filename from reac_legacy order by 1 ;

