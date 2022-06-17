--######################################################
--# Create FDA New Drug Application (NDA) Orange Book staging table DDL and
--# Load the data file into the nda table
--#
--# LTS Computing LLC
--######################################################
set search_path = ${DATABASE_SCHEMA};

--drop table if exists nda;
create table if not exists nda
(
ingredient varchar,
dfroute varchar,
trade_name varchar,
applicant varchar,
strength varchar,
appl_type varchar,
appl_no varchar,
product_no varchar,
te_code varchar,
approval_date varchar,
rld varchar,
rs varchar,
type varchar,
applicant_full_name varchar,
drug_form varchar,
route varchar
);
--truncate nda;

--drop index if exists ingredient_ix;
create index if not exists ingredient_ix on nda(appl_no, ingredient);

/* integrated into Pentaho LoadOrangeBook transformation */
/*\COPY nda FROM 'products.txt' WITH DELIMITER E'~' CSV HEADER QUOTE E'\b' ;*/

--BEGIN 
    --declare load_all_time = ${LOAD_ALL_TIME};
--if (@load_all_time = 1)
    --alter table nda add column drug_form varchar;
    --alter table nda add column route varchar;
--end if;

--END
update nda set drug_form = substring(dfroute from '(.*);');
update nda set route = substring(dfroute from ';(.*)');


select * from nda limit 20;
