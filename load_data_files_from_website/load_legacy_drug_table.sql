--######################################################
--# Create legacy drug staging tables DDL and
--# Load legacy FAERS data files into the drug_legacy table
--#
--# LTS Computing LLC
--######################################################

set search_path = faers;

drop table drug_legacy;
create table drug_legacy
(
ISR varchar,
DRUG_SEQ varchar,
ROLE_COD varchar,
DRUGNAME varchar,
VAL_VBM varchar,
ROUTE varchar,
DOSE_VBM varchar,
DECHAL varchar,
RECHAL varchar,
LOT_NUM varchar,
EXP_DT varchar,
NDA_NUM varchar,
FILENAME varchar
);
truncate drug_legacy;

COPY drug_legacy FROM '/home/lee/data/inbound/faers/legacy/ascii/all_drug_legacy_data_with_filename.txt' WITH DELIMITER E'$' CSV HEADER QUOTE E'\b' ;
select distinct filename from drug_legacy order by 1 

