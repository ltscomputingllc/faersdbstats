--######################################################
--# Create FDA New Drug Application (NDA) Orange Book staging table DDL and
--# Load the data file into the nda table
--#
--# LTS Computing LLC
--######################################################
set search_path = faers;

drop table if exists nda;
create table nda
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
applicant_full_name varchar
);
truncate nda;

create index ingredient_ix on nda(appl_no, ingredient);

COPY nda FROM 'products.txt' WITH DELIMITER E'~' CSV HEADER QUOTE E'\b' ;

alter table nda add column drug_form varchar;
alter table nda add column route varchar;
update nda set drug_form = substring(dfroute from '(.*);');
update nda set route = substring(dfroute from ';(.*)');


select * from nda limit 20;
