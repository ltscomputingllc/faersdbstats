--######################################################
--# 1) Create country_code reference table 
--# 2) Populate it with ISO 3166-1 country data
--# 3) Insert non-standard country names to country code mappings based on analysis of the reporter_country field in the legacy and current data
--#
--# This table is used to map between legacy reporter_country (country name) and current reporter_country (country 2 char code)
--#
--# LTS Computing LLC
--######################################################

set search_path = ${DATABASE_SCHEMA};

-- drop table if exists country_code;
create table if not exists country_code
(
country_name varchar,
country_code varchar
);
-- truncate country_code;

-- data pulled from curl -L https://datahub.io/core/country-list/r/0.csv > ISO_3166-1_country_codes.csv
/* moved ISO_3166-1_country_codes.csvcreate into /data */
/* integrated into Pentaho LoadOrangeBook transformation */

/*COPY country_code FROM 'ISO_3166-1_country_codes.csv' WITH DELIMITER E',' CSV HEADER QUOTE E'"';*/

--# Insert non-standard country names to country code mappings based on analysis of the reporter_country field in the legacy and current data
insert into country_code values('ALAND ISLANDS', 'AX');
insert into country_code values('BOLIVIA','BO');
insert into country_code values('BOSNIA AND HERZEGOWINA','BA');
insert into country_code values('CAPE VERDE','CV');
insert into country_code values('CONGO, THE DEMOCRATIC REPUBLIC OF THE','CD');
insert into country_code values('COTE D''IVOIRE','CI');
insert into country_code values('CROATIA (local name: Hrvatska)','HR');
insert into country_code values('CURACAO','CW');
insert into country_code values('European Union','??');
insert into country_code values('FRANCE, METROPOLITAN', 'FR');
insert into country_code values('KOREA, DEMOCRATIC PEOPLE''S REPUBLIC OF','KP');
insert into country_code values('KOREA, REPUBLIC OF','KR');
insert into country_code values('LIBYAN ARAB JAMAHIRIYA','LY');
insert into country_code values('MACAU','MO');
insert into country_code values('MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF','MK');
insert into country_code values('MICRONESIA, FEDERATED STATES OF','FM');
insert into country_code values('MOLDOVA, REPUBLIC OF','MD');
insert into country_code values('NETHERLANDS ANTILLES','AN');
insert into country_code values('NETHERLANDS ANTILLES (retired code)','AN');
insert into country_code values('PALESTINIAN TERRITORY, OCCUPIED','PS');
insert into country_code values('REUNION','RE');
insert into country_code values('SERBIA AND MONTENEGRO','CS');
insert into country_code values('SERBIA AND MONTENEGRO (see individual countries)','CS');
insert into country_code values('SLOVAKIA (Slovak Republic)','SK');
insert into country_code values('SVALBARD AND JAN MAYEN ISLANDS','SJ');
insert into country_code values('UNITED KINGDOM','GB');
insert into country_code values('UNITED STATES','US');
insert into country_code values('VATICAN CITY STATE (HOLY SEE)','VA');
insert into country_code values('VENEZUELA','VE');
insert into country_code values('WALLIS AND FUTUNA ISLANDS', 'WF');
insert into country_code values('YUGOSLAVIA','YU');
insert into country_code values('ZAIRE','CD');




















