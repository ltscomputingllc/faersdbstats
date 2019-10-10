--######################################################
--# Create therapy staging tables DDL and
--# Load current FAERS data files into the ther table
--#
--# LTS Computing LLC
--######################################################

set search_path = faers;

drop table if exists ther;
create table ther
(
primaryid varchar,
caseid varchar,
dsg_drug_seq varchar,
start_dt varchar,
end_dt varchar,
dur varchar,
dur_cod varchar,
filename varchar
);
truncate ther;

\COPY ther FROM '/home/faersdbstats/load_data_files_from_website/ascii/all_ther_data_with_filename.txt' WITH DELIMITER E'$' CSV HEADER QUOTE E'\b' ;
select filename, count(*) from ther group by filename order by 1 ;
