--######################################################
--# Create outc staging tables DDL and
--# Load current FAERS data files into the outc table
--#
--# LTS Computing LLC
--######################################################

set search_path = faers;

drop table if exists outc;
create table outc
(
primaryid varchar,
caseid varchar,
outc_code varchar,
filename varchar
);
truncate outc;

\COPY outc FROM '/home/faersdbstats/load_data_files_from_website/ascii/all_outc_data_with_filename.txt' WITH DELIMITER E'$' CSV HEADER QUOTE E'\b' ;
select filename, count(*) from outc group by filename order by 1

