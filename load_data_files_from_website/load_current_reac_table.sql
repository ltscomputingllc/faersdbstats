--######################################################
--# Create reac staging tables DDL and
--# Load current FAERS data files into the reac table
--#
--# LTS Computing LLC
--######################################################

set search_path = faers;

drop table if exists reac_staging_version_A ;
create table reac_staging_version_A
(
primaryid varchar,
caseid varchar,
pt varchar,
filename varchar
);
truncate reac_staging_version_A;

\COPY reac_staging_version_A FROM '/home/faersdbstats/load_data_files_from_website/ascii/all_version_A_reac_data_with_filename.txt' WITH DELIMITER E'$' CSV HEADER QUOTE E'\b' ;
select distinct filename from reac_staging_version_A order by 1;

drop table if exists reac_staging_version_B;
create table reac_staging_version_B
(
primaryid varchar,
caseid varchar,
pt varchar,
drug_rec_act varchar,
filename varchar
);
truncate reac_staging_version_B;

\COPY reac_staging_version_B FROM '/home/faersdbstats/load_data_files_from_website/ascii/all_version_B_reac_data_with_filename.txt' WITH DELIMITER E'$' CSV HEADER QUOTE E'\b' ;
select distinct filename from reac_staging_version_B order by 1;

drop table if exists reac;
create table reac as
select
primaryid,
caseid,
pt,
null as drug_rec_act,
filename
from reac_staging_version_A
union all
select * from reac_staging_version_B;

select filename, count(*) from reac group by filename order by filename;
