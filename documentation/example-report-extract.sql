-- Example of pulling reports for tizanidine



/*
python3 getDrugNameMatches.py -d 1 -s 'tizanidine|TIZANIDINE HYDROCHLORIDE|Zanaflex|ZANAFLEX (tizanidine hcl)|ZANAFLEX (tizanidine hydrochloride)|ZANAFLEX (tizanidine hcl 4mg) tablet|TERNELIN|SIRDALUD' -f drugs-unmapped-June2019.csv > /tmp/tizanidine-likely-mispelled.txt

Searching for string matches to TIZANIDINE|TIZANIDINE HYDROCHLORIDE|ZANAFLEX|ZANAFLEX (TIZANIDINE HCL)|ZANAFLEX (TIZANIDINE HYDROCHLORIDE)|ZANAFLEX (TIZANIDINE HCL 4MG) TABLET|TERNELIN|SIRDALUD using input file drugs-unmapped-June2019.csv and 1 allowed character replacements.
Input file drugs-unmapped-June2019.csv has 356124 lines.

NOTE: There is a record that has no pipes - assuming end of file. Total number of lines processed: 356123. Total lines in file:356124


Total length of unmapped drug strings input from the file (removing duplicates): 356108

NOTE: these drug strings could not be processed because they contain more than one pipe symbol. These will need to be corrected BOTH in the database and in   the input file:
"CELECOXIB;IBUPROFEN|NAPROXEN;PLA(IBUPROFEN)"|2
"PROACTIV CLEANSER 2.5% BENZOYL PEROXIED GUTHY|RENKER"|2
"|LISINOPRIL"|1
"CELECOXIB;IBUPROFEN|NAPROXEN;PLACEBO"|1
"|METOPROLOL"|1
"ATORVASTATIN | LOVASTATIN| YEAST EXTRACT FROM MONASCUS PURPUREUS"|1
"|ATENOLOL"|1
"|SIMVAST ATIN"|1
"|SPIRONOLACTONE"|1
"|MONTELUKAST"|1
"CADD SOLIS |V PUMP"|1
"FARXIGA(DAPAG|IFLOZIN PROPANEDIOL) 5 MG TABLET"|1

MATCH RESULTS:
BIZANIDINE
CANAFLEX
DIZANIDINE
FANAFLEX
LANAFLEX
LIZANIDINE
PIZANIDINE
RIZANIDINE
SANAFLEX
SIDALUD
SIDALUD (SIRDALUD)
SIRADALUD
SIRALUD
SIRALUD 2
SIRDALUD (TIZANDINE HYDROCHLORIDE)
SIRDALUD (TYIZANIDINE HYDROCHLORIDE)
SIRDALUD /00740702/ (SIRDALUD - TIZANADINE HYDROCHLORIDE) 2MG (NOT SPE
SIRDALUD /00740702/ (SIRDALUD - TIZANDINE HYDROCHLORIDE) (NOT SPECIFIE
SIRDALUD/00740702/(SIRDALUD TIZANADINE HYDROCHLORIDE)
SIRDALUL
SIRDALUT
TANAFLEX
TAZANIDINE
TAZANIDINE 4MG 2X/DAY
TAZANIDINE HYDROCHLORIDE (TAZANIDINE HYDROCHLORIDE)
TERNALIN
TERNELIN (TERNELIN - TIZANADINE HYDROCHLORIDE)
TERNELIN (TIAZANIDINE HYDROCHLORIDE)
TERNELLIN
THIZANIDINE HCL
TIANIDINE 4 MG
TIAZANIDINE (TIAZANIDINE)
TICANIDINE
TIDANIDINE
TIDANIDINE HYDROCHLORIDE
TIIZANIDINE
TINZANIDINE
TINZANIDINE HYDROCHLORIDE
TIRANIDINE
TISANIDINE
TITANIDINE
TIVANIDINE
TIVANIDINE HCL
TIXANIDINE
TIZAMIDINE
TIZANADINE 4 MG
TIZANADINE HCL
TIZANADINE HCL (UNKNOWN)
TIZANADINE HYDROCHLORIDE
TIZANDIDINE
TIZANDINE 4MG
TIZANDINE 8MG
TIZANDINE HYDROCHLORIDE
TIZANDINE HYDROCHLORIDE (TIZANDINE HYDROCHLORIDE)
TIZANEDINE
TIZANICINE
TIZANIDANE
TIZANIDENE
TIZANIDIE
TIZANIDIN ACTAVIS
TIZANIDIN EOLAPATADINE
TIZANIDIN TEVA 2MG
TIZANIDINE HYDROCHLORIDE (TIZANADINE HYDROCHLORIDE)
TIZANIDINE HYDROCHLORIDE (TIZANTIDINE HYDROCHLORIDE)
TIZANIDINEM
TIZANIDINI HYDROCLORIDUM
TIZANIDINIE
TIZANINDINE
TIZANISINE
TIZANITINE HCL
TIZANNIDINE (ZARAFLEX)
TIZANOIDINE
TIZANTIDINE
TIZATIDINE
TIZENIDINE
TIZENIDINE (UNKNOWN)
TIZIANIDINE
TIZIANIDINE HCL
TIZINIDINE
TIZNIDINE
TIZONIDINE
TRIZANIDINE
TRIZANIDINE HCL
TYZANIDINE
TYZANIDINE MUSCLE RELAXANT
TZANIDINE
XANAFLEX
XANAFLEX 4MG UNKNOWN
XANAFLEX MUSCLE RELAXER
ZAMAFLEX
ZANAFIEX
ZANAFLAX
ZANAFLAX (NOS)
ZANAFLEX (TIZADNIDINE HYDROCHLORIDE)
ZANAFLEX (TIZANDIDINE HYDROCHLORIDE)
ZANAFLEX (TIZANIDFINE HYDROCHLORIDE) (TIZANIDINE HYDROCHLORDIE)
ZANAFLEX (TYZANIDINE HYDROCHLORIDE)
ZANAFLEZ
ZANAFLUX
ZANALLEX
ZANAPLEX
ZANASLEX
ZANEFLEX
ZANFLEX
ZANIFLEX
ZANNAFLEX
ZANOFLEX
ZANTAFLEX
ZEANAFLEX
ZENAFLEX
ZONAFLEX

*/

 
 
 
 -- Query the standardized drug - outcome count tables using the drug concept ids for all reports involving tizanidine and 1 character name variations
with tizSpecific as (
   select distinct drug.caseid
   from faers.drug drug 
   where drug.drugname ilike '%tizanidine%'
     or upper(drug.drugname) in ('BIZANIDINE','CANAFLEX','DIZANIDINE','FANAFLEX','LANAFLEX','LIZANIDINE','PIZANIDINE','RIZANIDINE','SANAFLEX','SIDALUD','SIDALUD (SIRDALUD)','SIRADALUD','SIRALUD','SIRALUD 2','SIRDALUD (TIZANDINE HYDROCHLORIDE)','SIRDALUD (TYIZANIDINE HYDROCHLORIDE)','SIRDALUD /00740702/ (SIRDALUD - TIZANADINE HYDROCHLORIDE) 2MG (NOT SPE','SIRDALUD /00740702/ (SIRDALUD - TIZANDINE HYDROCHLORIDE) (NOT SPECIFIE','SIRDALUD/00740702/(SIRDALUD TIZANADINE HYDROCHLORIDE)','SIRDALUL','SIRDALUT','TANAFLEX','TAZANIDINE','TAZANIDINE 4MG 2X/DAY','TAZANIDINE HYDROCHLORIDE (TAZANIDINE HYDROCHLORIDE)','TERNALIN','TERNELIN (TERNELIN - TIZANADINE HYDROCHLORIDE)','TERNELIN (TIAZANIDINE HYDROCHLORIDE)','TERNELLIN','THIZANIDINE HCL','TIANIDINE 4 MG','TIAZANIDINE (TIAZANIDINE)','TICANIDINE','TIDANIDINE','TIDANIDINE HYDROCHLORIDE','TIIZANIDINE','TINZANIDINE','TINZANIDINE HYDROCHLORIDE','TIRANIDINE','TISANIDINE','TITANIDINE','TIVANIDINE','TIVANIDINE HCL','TIXANIDINE','TIZAMIDINE','TIZANADINE 4 MG','TIZANADINE HCL','TIZANADINE HCL (UNKNOWN)','TIZANADINE HYDROCHLORIDE','TIZANDIDINE','TIZANDINE 4MG','TIZANDINE 8MG','TIZANDINE HYDROCHLORIDE','TIZANDINE HYDROCHLORIDE (TIZANDINE HYDROCHLORIDE)','TIZANEDINE','TIZANICINE','TIZANIDANE','TIZANIDENE','TIZANIDIE','TIZANIDIN ACTAVIS','TIZANIDIN EOLAPATADINE','TIZANIDIN TEVA 2MG','TIZANIDINE HYDROCHLORIDE (TIZANADINE HYDROCHLORIDE)','TIZANIDINE HYDROCHLORIDE (TIZANTIDINE HYDROCHLORIDE)','TIZANIDINEM','TIZANIDINI HYDROCLORIDUM','TIZANIDINIE','TIZANINDINE','TIZANISINE','TIZANITINE HCL','TIZANNIDINE (ZARAFLEX)','TIZANOIDINE','TIZANTIDINE','TIZATIDINE','TIZENIDINE','TIZENIDINE (UNKNOWN)','TIZIANIDINE','TIZIANIDINE HCL','TIZINIDINE','TIZNIDINE','TIZONIDINE','TRIZANIDINE','TRIZANIDINE HCL','TYZANIDINE','TYZANIDINE MUSCLE RELAXANT','TZANIDINE','XANAFLEX','XANAFLEX 4MG UNKNOWN','XANAFLEX MUSCLE RELAXER','ZAMAFLEX','ZANAFIEX','ZANAFLAX','ZANAFLAX (NOS)','ZANAFLEX (TIZADNIDINE HYDROCHLORIDE)','ZANAFLEX (TIZANDIDINE HYDROCHLORIDE)','ZANAFLEX (TIZANIDFINE HYDROCHLORIDE) (TIZANIDINE HYDROCHLORDIE)','ZANAFLEX (TYZANIDINE HYDROCHLORIDE)','ZANAFLEZ','ZANAFLUX','ZANALLEX','ZANAPLEX','ZANASLEX','ZANEFLEX','ZANFLEX','ZANIFLEX','ZANNAFLEX','ZANOFLEX','ZANTAFLEX','ZEANAFLEX','ZENAFLEX','ZONAFLEX')
 ), standardSummary as (
   select cd.concept_name standard_drug_name,
          co.concept_name standard_outcome_name,
          sdod.*           
   from faers.standard_drug_outcome_drilldown sdod inner join tizSpecific on sdod.caseid = tizSpecific.caseid
      inner join staging_vocabulary.concept cd on sdod.drug_concept_id = cd.concept_id
      inner join staging_vocabulary.concept co on sdod.outcome_concept_id = co.concept_id
)
select drug.primaryid, drug.caseid, drug.drug_seq, drug.role_cod, drug.drugname, drug.prod_ai, drug.val_vbm, drug.route, drug.dose_vbm, drug.cum_dose_chr, drug.cum_dose_unit, drug.dechal, drug.rechal, drug.lot_num, drug.exp_dt, drug.nda_num, drug.dose_amt, drug.dose_unit, drug.dose_form, drug.dose_freq, drug.filename, 
       string_agg(distinct standardSummary.drug_concept_id::text, ';') drug_concept_id, string_agg(distinct standardSummary.standard_drug_name, ';') standard_drug_name, 
       string_agg(distinct standardSummary.standard_outcome_name, ';') standard_outcome_name, string_agg(distinct standardSummary.outcome_concept_id::text, ';') outcome_concept_id, string_agg(distinct standardSummary.snomed_outcome_concept_id::text, ';') snomed_outcome_concept_id, 
       string_agg(distinct scoc.outc_code, ';') standard_outcome_code, string_agg(distinct scoc.snomed_concept_id::text, ';') standard_outcome_snomed,
       demo.caseversion, demo.i_f_code, demo.event_dt, demo.mfr_dt, demo.init_fda_dt, demo.fda_dt, demo.rept_cod, demo.auth_num, demo.mfr_num, demo.mfr_sndr, demo.lit_ref, demo.age, demo.age_cod, demo.age_grp, demo.sex, demo.e_sub, demo.wt, demo.wt_cod, demo.rept_dt, demo.to_mfr, demo.occp_cod, demo.reporter_country, demo.occr_country, demo.filename, 
       indi.indi_drug_seq, indi.indi_pt, indi.filename, 
       rpsr.rpsr_cod, rpsr.filename 
from faers.drug drug inner join standardSummary on drug.primaryid = standardSummary.primaryid
   inner join faers.demo demo on demo.primaryid = standardSummary.primaryid
   left outer join faers.standard_case_outcome_category scoc on scoc.primaryid = standardSummary.primaryid
   left outer join faers.indi indi on indi.primaryid = standardSummary.primaryid and indi.indi_drug_seq = drug.drug_seq
   left outer join faers.rpsr rpsr on rpsr.primaryid = standardSummary.primaryid
GROUP BY drug.primaryid, drug.caseid, drug.drug_seq, drug.role_cod, drug.drugname, drug.prod_ai, drug.val_vbm, drug.route, drug.dose_vbm, drug.cum_dose_chr, drug.cum_dose_unit, drug.dechal, drug.rechal, drug.lot_num, drug.exp_dt, drug.nda_num, drug.dose_amt, drug.dose_unit, drug.dose_form, drug.dose_freq, drug.filename,         
         demo.caseversion, demo.i_f_code, demo.event_dt, demo.mfr_dt, demo.init_fda_dt, demo.fda_dt, demo.rept_cod, demo.auth_num, demo.mfr_num, demo.mfr_sndr, demo.lit_ref, demo.age, demo.age_cod, demo.age_grp, demo.sex, demo.e_sub, demo.wt, demo.wt_cod, demo.rept_dt, demo.to_mfr, demo.occp_cod, demo.reporter_country, demo.occr_country, demo.filename, 
         indi.indi_drug_seq, indi.indi_pt, indi.filename, 
         rpsr.rpsr_cod, rpsr.filename
ORDER BY drug.primaryid, drug.drug_seq
;

