--######################################################
--# Create rpsr staging tables DDL and
--# Load current FAERS data files into the rpsr table
--#
--# LTS Computing LLC
--######################################################

set search_path = faers;

drop table if exists rpsr;
create table rpsr
(
primaryid varchar,
caseid varchar,
rpsr_cod varchar,
filename varchar
);
truncate rpsr;

\COPY rpsr FROM '/home/faersdbstats/load_data_files_from_website/ascii/all_rpsr_data_with_filename.txt' WITH DELIMITER E'$' CSV HEADER QUOTE E'\b' ;
select filename, count(*) from rpsr group by filename order by 1;

