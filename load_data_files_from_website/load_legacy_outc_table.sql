--######################################################
--# Create legacy outc staging tables DDL and
--# Load legacy FAERS data files into the outc_legacy table
--#
--# LTS Computing LLC
--######################################################

set search_path = faers;

drop table if exists outc_legacy;
create table outc_legacy
(
ISR varchar,
OUTC_COD varchar,
FILENAME varchar
);
truncate outc_legacy;

\COPY outc_legacy FROM '/home/faersdbstats/load_data_files_from_website/ascii/all_outc_legacy_data_with_filename.txt' WITH DELIMITER E'$' CSV HEADER QUOTE E'\b' ;
select distinct filename from outc_legacy order by 1 ;

