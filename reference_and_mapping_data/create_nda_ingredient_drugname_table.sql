-- create a mapping table from FAERS drugname (based on current drugs) to FDA orange book NDA ingredient(s) using NDA number as the linkage
-- Notes.
-- 1) drugs with multiple ingredients are represented as a comma separated list of ingredients
--
-- LTS Computing LLC
-----------------------------------------------------------------------------------------------
create table nda_ingredient_drugname as
select  a.primaryid, a.drug_seq, upper(a.drugname) as drugname, b.ingredient
from drug a
left outer join 
(select distinct ingredient, appl_no
from nda
) as b
on a.nda_num = b.appl_no
and a.role_cod <> 'C'
where a.role_cod <> 'C' -- exclude concommitent medications