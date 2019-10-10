--######################################################
--# Create legacy rpsrcation staging tables DDL and
--# Load legacy FAERS data files into the rpsr_legacy table
--#
--# LTS Computing LLC
--######################################################

set search_path = faers;

drop table if exists rpsr_legacy;
create table rpsr_legacy
(
ISR varchar,
RPSR_COD varchar,
FILENAME varchar
);
truncate rpsr_legacy;

\COPY rpsr_legacy FROM '/home/faersdbstats/load_data_files_from_website/ascii/all_rpsr_legacy_data_with_filename.txt' WITH DELIMITER E'$' CSV HEADER QUOTE E'\b' ;
select distinct filename from rpsr_legacy order by 1 ;
