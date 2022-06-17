--######################################################
--# Create drug staging tables DDL and
--# Load current FAERS data files into the drug table
--#
--# LTS Computing LLC
--######################################################

set search_path = faers;

drop table if exists drug_staging_version_A ;
create table drug_staging_version_A
(
primaryid varchar,
caseid varchar,
drug_seq varchar,
role_cod varchar,
drugname varchar,
val_vbm varchar,
route varchar,
dose_vbm varchar,
cum_dose_chr varchar,
cum_dose_unit varchar,
dechal varchar,
rechal varchar,
lot_nbr varchar,
exp_dt varchar,
nda_num varchar,
dose_amt varchar,
dose_unit varchar,
dose_form varchar,
dose_freq varchar,
filename varchar
);
truncate drug_staging_version_A;

\COPY drug_staging_version_A FROM '/home/faersdbstats/load_data_files_from_website/ascii/all_version_A_drug_data_with_filename.txt' WITH DELIMITER E'$' CSV HEADER QUOTE E'\b' ;
select distinct filename from drug_staging_version_A order by 1;

drop table if exists drug_staging_version_B;
create table drug_staging_version_B
(
primaryid varchar,
caseid varchar,
drug_seq varchar,
role_cod varchar,
drugname varchar,
prod_ai varchar,
val_vbm varchar,
route varchar,
dose_vbm varchar,
cum_dose_chr varchar,
cum_dose_unit varchar,
dechal varchar,
rechal varchar,
lot_num varchar,
exp_dt varchar,
nda_num varchar,
dose_amt varchar,
dose_unit varchar,
dose_form varchar,
dose_freq varchar,
filename varchar
);
truncate drug_staging_version_B;


\COPY drug_staging_version_B FROM '/home/faersdbstats/load_data_files_from_website/ascii/all_version_B_drug_data_with_filename.txt' WITH DELIMITER E'$' CSV HEADER QUOTE E'\b' ;
select distinct filename from drug_staging_version_B order by 1;

drop table if exists drug;
create table drug as
select
primaryid,
caseid,
drug_seq,
role_cod,
drugname,
null as prod_ai,
val_vbm,
route,
dose_vbm,
cum_dose_chr,
cum_dose_unit,
dechal,
rechal,
lot_nbr as lot_num,
exp_dt,
nda_num,
dose_amt,
dose_unit,
dose_form,
dose_freq,
filename
from drug_staging_version_A
union all
select * from drug_staging_version_B;

select filename, count(*) from drug group by filename order by filename;
