--######################################################
--# Create demo staging tables DDL and
--# Load current FAERS data files into the demo table
--#
--# LTS Computing LLC
--######################################################

set search_path = faers;

drop table if exists demo_staging_version_A;
create table demo_staging_version_A
(
primaryid varchar,
caseid varchar,
caseversion varchar,
i_f_code varchar,
event_dt varchar,
mfr_dt varchar,
init_fda_dt varchar,
fda_dt varchar,
rept_cod varchar,
mfr_num varchar,
mfr_sndr varchar,
age varchar,
age_cod varchar,
gndr_cod varchar,
e_sub varchar,
wt varchar,
wt_cod varchar,
rept_dt varchar,
to_mfr varchar,
occp_cod varchar,
reporter_country varchar,
occr_country varchar,
filename varchar
);
truncate demo_staging_version_A;

\COPY demo_staging_version_A FROM '/home/faersdbstats/load_data_files_from_website/ascii/all_version_A_demo_data_with_filename.txt' WITH DELIMITER E'$' CSV HEADER QUOTE E'\b' ;
select distinct filename from demo_staging_version_A order by 1;

drop table if exists demo_staging_version_B;
create table demo_staging_version_B
(
primaryid varchar,
caseid varchar,
caseversion varchar,
i_f_code varchar,
event_dt varchar,
mfr_dt varchar,
init_fda_dt varchar,
fda_dt varchar,
rept_cod varchar,
auth_num varchar,
mfr_num varchar,
mfr_sndr varchar,
lit_ref varchar,
age varchar,
age_cod varchar,
age_grp varchar,
sex varchar,
e_sub varchar,
wt varchar,
wt_cod varchar,
rept_dt varchar,
to_mfr varchar,
occp_cod varchar,
reporter_country varchar,
occr_country varchar,
filename varchar
);
truncate demo_staging_version_B;

\COPY demo_staging_version_B FROM '/home/faersdbstats/load_data_files_from_website/ascii/all_version_B_demo_data_with_filename.txt' WITH DELIMITER E'$' CSV HEADER QUOTE E'\b' ;
select distinct filename from demo_staging_version_B order by 1;

drop table if exists demo;
create table demo as
select
primaryid,
caseid,
caseversion,
i_f_code,
event_dt,
mfr_dt,
init_fda_dt,
fda_dt,
rept_cod,
null as auth_num,
mfr_num,
mfr_sndr,
null as lit_ref,
age,
age_cod,
null as age_grp,
gndr_cod as sex,
e_sub,
wt,
wt_cod,
rept_dt,
to_mfr,
occp_cod,
reporter_country,
occr_country,
filename
from demo_staging_version_A
union all
select * from demo_staging_version_B;

select distinct filename from demo order by 1;
