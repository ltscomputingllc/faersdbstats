--######################################################
--# Create legacy therapy staging tables DDL and
--# Load legacy FAERS data files into the ther_legacy table
--#
--# LTS Computing LLC
--######################################################

set search_path = faers;

drop table if exists ther_legacy;
create table ther_legacy
(
ISR varchar,
DRUG_SEQ varchar,
START_DT varchar,
END_DT varchar,
DUR varchar,
DUR_COD varchar,
FILENAME varchar
);
truncate ther_legacy;

\COPY ther_legacy FROM '/home/faersdbstats/load_data_files_from_website/ascii/all_ther_legacy_data_with_filename.txt' WITH DELIMITER E'$' CSV HEADER QUOTE E'\b' ;
select distinct filename from ther_legacy order by 1 ;

