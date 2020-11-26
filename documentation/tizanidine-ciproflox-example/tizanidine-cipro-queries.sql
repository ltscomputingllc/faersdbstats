-- FAERS exploration for Tizanidine and ciprofloxacine

-- SUBSET OF HOIs --
--Hypotension
--Drop blood pressure
--Syncope
--Bradycardia
--Shock
--Falls
--Fractures
--Laceration
--Wounds
--Cardiac arrest
--Cardio-respiratory arrest
with  tizs as (
  select distinct upper(d.drugname)
  from faers.drug d 
  where upper(d.drugname) like '%TIZANIDINE%'
), tizStandardMap as (
  select distinct drug.drug_name_original, drug.standard_concept_id 
  from faers.standard_combined_drug_mapping drug 
  where drug.standard_concept_id is not null
    and 
   (upper(drug.drug_name_original) in (select * from tizs)
      or upper(drug.drug_name_original ) in ('BIZANIDINE','CANAFLEX','DIZANIDINE','FANAFLEX','LANAFLEX','LIZANIDINE','PIZANIDINE','RIZANIDINE','SANAFLEX','SIDALUD','SIDALUD (SIRDALUD)','SIRADALUD','SIRALUD','SIRALUD 2','SIRDALUD (TIZANDINE HYDROCHLORIDE)','SIRDALUD (TYIZANIDINE HYDROCHLORIDE)','SIRDALUD /00740702/ (SIRDALUD - TIZANADINE HYDROCHLORIDE) 2MG (NOT SPE','SIRDALUD /00740702/ (SIRDALUD - TIZANDINE HYDROCHLORIDE) (NOT SPECIFIE','SIRDALUD/00740702/(SIRDALUD TIZANADINE HYDROCHLORIDE)','SIRDALUL','SIRDALUT','TANAFLEX','TAZANIDINE','TAZANIDINE 4MG 2X/DAY','TAZANIDINE HYDROCHLORIDE (TAZANIDINE HYDROCHLORIDE)','TERNALIN','TERNELIN (TERNELIN - TIZANADINE HYDROCHLORIDE)','TERNELIN (TIAZANIDINE HYDROCHLORIDE)','TERNELLIN','THIZANIDINE HCL','TIANIDINE 4 MG','TIAZANIDINE (TIAZANIDINE)','TICANIDINE','TIDANIDINE','TIDANIDINE HYDROCHLORIDE','TIIZANIDINE','TINZANIDINE','TINZANIDINE HYDROCHLORIDE','TIRANIDINE','TISANIDINE','TITANIDINE','TIVANIDINE','TIVANIDINE HCL','TIXANIDINE','TIZAMIDINE','TIZANADINE 4 MG','TIZANADINE HCL','TIZANADINE HCL (UNKNOWN)','TIZANADINE HYDROCHLORIDE','TIZANDIDINE','TIZANDINE 4MG','TIZANDINE 8MG','TIZANDINE HYDROCHLORIDE','TIZANDINE HYDROCHLORIDE (TIZANDINE HYDROCHLORIDE)','TIZANEDINE','TIZANICINE','TIZANIDANE','TIZANIDENE','TIZANIDIE','TIZANIDIN ACTAVIS','TIZANIDIN EOLAPATADINE','TIZANIDIN TEVA 2MG','TIZANIDINE HYDROCHLORIDE (TIZANADINE HYDROCHLORIDE)','TIZANIDINE HYDROCHLORIDE (TIZANTIDINE HYDROCHLORIDE)','TIZANIDINEM','TIZANIDINI HYDROCLORIDUM','TIZANIDINIE','TIZANINDINE','TIZANISINE','TIZANITINE HCL','TIZANNIDINE (ZARAFLEX)','TIZANOIDINE','TIZANTIDINE','TIZATIDINE','TIZENIDINE','TIZENIDINE (UNKNOWN)','TIZIANIDINE','TIZIANIDINE HCL','TIZINIDINE','TIZNIDINE','TIZONIDINE','TRIZANIDINE','TRIZANIDINE HCL','TYZANIDINE','TYZANIDINE MUSCLE RELAXANT','TZANIDINE','XANAFLEX','XANAFLEX 4MG UNKNOWN','XANAFLEX MUSCLE RELAXER','ZAMAFLEX','ZANAFIEX','ZANAFLAX','ZANAFLAX (NOS)','ZANAFLEX (TIZADNIDINE HYDROCHLORIDE)','ZANAFLEX (TIZANDIDINE HYDROCHLORIDE)','ZANAFLEX (TIZANIDFINE HYDROCHLORIDE) (TIZANIDINE HYDROCHLORDIE)','ZANAFLEX (TYZANIDINE HYDROCHLORIDE)','ZANAFLEZ','ZANAFLUX','ZANALLEX','ZANAPLEX','ZANASLEX','ZANEFLEX','ZANFLEX','ZANIFLEX','ZANNAFLEX','ZANOFLEX','ZANTAFLEX','ZEANAFLEX','ZENAFLEX','ZONAFLEX'))
), meddraStandardMap as (
 select c.concept_id, c.concept_name
 from staging_vocabulary.concept c 
 where c.concept_code in ('10021097','10005734','10042772','10006093','10040560','10016173','10017076','10023572','10052428','10007515','10007617','10047065','10022891','10047065','10007541','10007541','10022117','10022117','10022117','10022117','10007541','10007541')
), stats as ( 
  select * 
  from faers.standard_drug_outcome_statistics dos
  where dos.drug_concept_id in (select distinct standard_concept_id from tizStandardMap)
   and dos.outcome_concept_id in (select distinct concept_id from meddraStandardMap)
  order by dos.drug_concept_id, dos.outcome_concept_id 
)
select c1.concept_name drug_name, c1.concept_code  drug_rxnorm, c2.concept_name meddra_ae_name, c2.concept_code meddra_ae_code, stats.* 
from  stats inner join staging_vocabulary.concept c1 on stats.drug_concept_id = c1.concept_id 
  inner join staging_vocabulary.concept c2 on stats.outcome_concept_id = c2.concept_id 
 ;

-------------------------------

-- TIZANIDINE --

-- Query the standardized drug - outcome count tables using the drug concept ids for all reports involving tizanidine and 1 character name variations
--- 1. obtain the case ids for reports mentioning the drug names
drop table if exists scratch_rich.tizSpecific;
with  tizs as (
  select distinct upper(d.drugname)
  from faers.drug d 
  where upper(d.drugname) like '%TIZANIDINE%'
)
   select distinct drug.caseid
   into scratch_rich.tizSpecific
   from faers.drug drug 
   where upper(drug.drugname) in (select * from tizs)
     or upper(drug.drugname) in ('BIZANIDINE','CANAFLEX','DIZANIDINE','FANAFLEX','LANAFLEX','LIZANIDINE','PIZANIDINE','RIZANIDINE','SANAFLEX','SIDALUD','SIDALUD (SIRDALUD)','SIRADALUD','SIRALUD','SIRALUD 2','SIRDALUD (TIZANDINE HYDROCHLORIDE)','SIRDALUD (TYIZANIDINE HYDROCHLORIDE)','SIRDALUD /00740702/ (SIRDALUD - TIZANADINE HYDROCHLORIDE) 2MG (NOT SPE','SIRDALUD /00740702/ (SIRDALUD - TIZANDINE HYDROCHLORIDE) (NOT SPECIFIE','SIRDALUD/00740702/(SIRDALUD TIZANADINE HYDROCHLORIDE)','SIRDALUL','SIRDALUT','TANAFLEX','TAZANIDINE','TAZANIDINE 4MG 2X/DAY','TAZANIDINE HYDROCHLORIDE (TAZANIDINE HYDROCHLORIDE)','TERNALIN','TERNELIN (TERNELIN - TIZANADINE HYDROCHLORIDE)','TERNELIN (TIAZANIDINE HYDROCHLORIDE)','TERNELLIN','THIZANIDINE HCL','TIANIDINE 4 MG','TIAZANIDINE (TIAZANIDINE)','TICANIDINE','TIDANIDINE','TIDANIDINE HYDROCHLORIDE','TIIZANIDINE','TINZANIDINE','TINZANIDINE HYDROCHLORIDE','TIRANIDINE','TISANIDINE','TITANIDINE','TIVANIDINE','TIVANIDINE HCL','TIXANIDINE','TIZAMIDINE','TIZANADINE 4 MG','TIZANADINE HCL','TIZANADINE HCL (UNKNOWN)','TIZANADINE HYDROCHLORIDE','TIZANDIDINE','TIZANDINE 4MG','TIZANDINE 8MG','TIZANDINE HYDROCHLORIDE','TIZANDINE HYDROCHLORIDE (TIZANDINE HYDROCHLORIDE)','TIZANEDINE','TIZANICINE','TIZANIDANE','TIZANIDENE','TIZANIDIE','TIZANIDIN ACTAVIS','TIZANIDIN EOLAPATADINE','TIZANIDIN TEVA 2MG','TIZANIDINE HYDROCHLORIDE (TIZANADINE HYDROCHLORIDE)','TIZANIDINE HYDROCHLORIDE (TIZANTIDINE HYDROCHLORIDE)','TIZANIDINEM','TIZANIDINI HYDROCLORIDUM','TIZANIDINIE','TIZANINDINE','TIZANISINE','TIZANITINE HCL','TIZANNIDINE (ZARAFLEX)','TIZANOIDINE','TIZANTIDINE','TIZATIDINE','TIZENIDINE','TIZENIDINE (UNKNOWN)','TIZIANIDINE','TIZIANIDINE HCL','TIZINIDINE','TIZNIDINE','TIZONIDINE','TRIZANIDINE','TRIZANIDINE HCL','TYZANIDINE','TYZANIDINE MUSCLE RELAXANT','TZANIDINE','XANAFLEX','XANAFLEX 4MG UNKNOWN','XANAFLEX MUSCLE RELAXER','ZAMAFLEX','ZANAFIEX','ZANAFLAX','ZANAFLAX (NOS)','ZANAFLEX (TIZADNIDINE HYDROCHLORIDE)','ZANAFLEX (TIZANDIDINE HYDROCHLORIDE)','ZANAFLEX (TIZANIDFINE HYDROCHLORIDE) (TIZANIDINE HYDROCHLORDIE)','ZANAFLEX (TYZANIDINE HYDROCHLORIDE)','ZANAFLEZ','ZANAFLUX','ZANALLEX','ZANAPLEX','ZANASLEX','ZANEFLEX','ZANFLEX','ZANIFLEX','ZANNAFLEX','ZANOFLEX','ZANTAFLEX','ZEANAFLEX','ZENAFLEX','ZONAFLEX')
 ;
 CREATE INDEX tizspecific_caseid_idx ON scratch_rich.tizspecific USING btree (caseid)

 --- 2. standard summary of the reports using standardized terms and outcomes
 drop table if exists scratch_rich.standardSummary;
 select cd.concept_name standard_drug_name,
        co.concept_name standard_outcome_name,
        sdod.*,
        sco.pt
 into scratch_rich.standardSummary
 from faers.standard_drug_outcome_drilldown sdod inner join scratch_rich.tizSpecific on sdod.caseid = tizSpecific.caseid
    inner join staging_vocabulary.concept cd on sdod.drug_concept_id = cd.concept_id
    inner join staging_vocabulary.concept co on sdod.outcome_concept_id = co.concept_id
    inner join faers.standard_case_outcome sco on sco.primaryid = sdod.primaryid and sdod.outcome_concept_id = sco.outcome_concept_id 
;
CREATE INDEX standardsummary_primaryid_idx ON scratch_rich.standardsummary (primaryid);

-- 3. obtain the complete case report data
select drug.primaryid, drug.caseid, drug.drug_seq, drug.role_cod, drug.drugname, drug.prod_ai, drug.val_vbm, drug.route, drug.dose_vbm, drug.cum_dose_chr, 
       drug.cum_dose_unit, drug.dechal, drug.rechal, drug.lot_num, drug.exp_dt, drug.nda_num, drug.dose_amt, drug.dose_unit, drug.dose_form, drug.dose_freq, drug.filename, 
       string_agg(distinct standardSummary.drug_concept_id::text, ';') drug_concept_id, string_agg(distinct standardSummary.standard_drug_name, ';') standard_drug_name, 
       string_agg(distinct standardSummary.standard_outcome_name, ';') standard_outcome_name, string_agg(distinct standardSummary.outcome_concept_id::text, ';') outcome_concept_id, string_agg(distinct standardSummary.snomed_outcome_concept_id::text, ';') snomed_outcome_concept_id, 
       string_agg(distinct scoc.outc_code, ';') standard_outcome_code, string_agg(distinct scoc.snomed_concept_id::text, ';') standard_outcome_snomed, 
       demo.caseversion, demo.i_f_code, demo.event_dt, demo.mfr_dt, demo.init_fda_dt, demo.fda_dt, demo.rept_cod, demo.auth_num, demo.mfr_num, demo.mfr_sndr, demo.lit_ref, demo.age, demo.age_cod, demo.age_grp, demo.sex, demo.e_sub, demo.wt, demo.wt_cod, demo.rept_dt, demo.to_mfr, demo.occp_cod, demo.reporter_country, demo.occr_country, demo.filename, 
       indi.indi_drug_seq, indi.indi_pt, indi.filename, 
       rpsr.rpsr_cod, rpsr.filename 
from faers.drug drug inner join scratch_rich.standardSummary on drug.primaryid = standardSummary.primaryid
   inner join faers.demo demo on demo.primaryid = standardSummary.primaryid
   left outer join faers.standard_case_outcome_category scoc on scoc.primaryid = standardSummary.primaryid
   left outer join faers.indi indi on indi.primaryid = standardSummary.primaryid and indi.indi_drug_seq = drug.drug_seq
   left outer join faers.rpsr rpsr on rpsr.primaryid = standardSummary.primaryid
GROUP BY drug.primaryid, drug.caseid, drug.drug_seq, drug.role_cod, drug.drugname, drug.prod_ai, drug.val_vbm, drug.route, drug.dose_vbm, drug.cum_dose_chr, drug.cum_dose_unit, drug.dechal, drug.rechal, drug.lot_num, drug.exp_dt, drug.nda_num, drug.dose_amt, drug.dose_unit, drug.dose_form, drug.dose_freq, drug.filename,         
         demo.caseversion, demo.i_f_code, demo.event_dt, demo.mfr_dt, demo.init_fda_dt, demo.fda_dt, demo.rept_cod, demo.auth_num, demo.mfr_num, demo.mfr_sndr, demo.lit_ref, demo.age, demo.age_cod, demo.age_grp, demo.sex, demo.e_sub, demo.wt, demo.wt_cod, demo.rept_dt, demo.to_mfr, demo.occp_cod, demo.reporter_country, demo.occr_country, demo.filename, 
         indi.indi_drug_seq, indi.indi_pt, indi.filename,
         rpsr.rpsr_cod, rpsr.filename
ORDER BY drug.primaryid, drug.drug_seq::integer
;


-- ciprofloxacine --

-- Query the standardized drug - outcome count tables using the drug concept ids for all reports involving ciprofloxacine and 1 character name variations
--- 1. obtain the case ids for reports mentioning the drug names
drop table if exists scratch_rich.ciproSpecific;
with  cipros as (
  select distinct upper(d.drugname)
  from faers.drug d 
  where upper(d.drugname) like '%CIPROFLOXACIN%'
)
   select distinct drug.caseid
   into scratch_rich.ciproSpecific
   from faers.drug drug 
   where upper(drug.drugname) in (select * from cipros)
     or upper(drug.drugname) in ('CIPROFLOXACIN','CIPROFLOXACIN 250 MG ORAL TABLET','CIPROFLOXACIN 750 MG ORAL TABLET','CIPROFLOXACIN 100 MG ORAL TABLET [CIPRO]','CIPROFLOXACIN 50 MG/ML ORAL SUSPENSION [CIPRO]','CIPROFLOXACIN 100 MG/ML ORAL SUSPENSION [CIPRO]','CIPROFLOXACIN 250 MG ORAL CAPSULE','CIPROFLOXACIN 500 MG ORAL CAPSULE','CIPROFLOXACIN 3.5 MG/ML OPHTHALMIC SOLUTION','CIPROFLOXACIN 2 MG/ML','CIPROFLOXACIN 250 MG','CIPROFLOXACIN 500 MG','CIPROFLOXACIN 750 MG','CIPROFLOXACIN 50 MG/ML','CIPROFLOXACIN 100 MG/ML','CIPROFLOXACIN 3.5 MG/ML','CIPROFLOXACIN 0.003 MG/MG','CIPROFLOXACIN 3 MG/ML','24 HR CIPROFLOXACIN 500 MG EXTENDED RELEASE ORAL TABLET','24 HR CIPROFLOXACIN 500 MG EXTENDED RELEASE ORAL TABLET [PROQUIN]','CIPROFLOXACIN 500 MG EXTENDED RELEASE ORAL TABLET','CIPROFLOXACIN 2 MG/ML INJECTABLE SOLUTION [CIPRO]','24 HR CIPROFLOXACIN 1000 MG EXTENDED RELEASE ORAL TABLET [CIPRO]','CIPROFLOXACIN 2 MG/ML OTIC SOLUTION','CIPROFLOXACIN 3 MG/ML OPHTHALMIC SOLUTION [CILOXAN]','CIPROFLOXACIN 250 MG ORAL TABLET [CIPROXIN]','CIPROFLOXACIN 500 MG ORAL TABLET [CIPROXIN]','CIPROFLOXACIN 750 MG ORAL TABLET [CIPROXIN]','CIPROFLOXACIN 2 MG/ML INJECTABLE SOLUTION [CIPROXIN]','CIPROFLOXACIN 100 MG ORAL TABLET [CIPROXIN]','CIPROFLOXACIN 50 MG/ML ORAL SUSPENSION [CIPROXIN]','CIPROFLOXACIN 100 MG ORAL TABLET','CIPROFLOXACIN 250 MG ORAL TABLET [CIPRO]','CIPROFLOXACIN 500 MG ORAL TABLET [CIPRO]','CIPROFLOXACIN 750 MG ORAL TABLET [CIPRO]','CIPROFLOXACIN 3 MG/ML / DEXAMETHASONE 1 MG/ML [CIPRODEX]','CIPROFLOXACIN 250 MG [CIPRO]','CIPROFLOXACIN 750 MG [CIPRO]','CIPROFLOXACIN 100 MG [CIPRO]','CIPROFLOXACIN 50 MG/ML [CIPRO]','CIPROFLOXACIN 100 MG/ML [CIPRO]','CIPROFLOXACIN 2 MG/ML [CIPRO]','CIPROFLOXACIN 3 MG/ML [CILOXAN]','CIPROFLOXACIN 0.003 MG/MG [CILOXAN]','CIPROFLOXACIN 0.003 MG/MG OPHTHALMIC OINTMENT [CILOXAN]','CIPROFLOXACIN 2 MG/ML / HYDROCORTISONE 10 MG/ML OTIC SUSPENSION [CIPRO HC]','CIPROFLOXACIN 2 MG/ML [CETRAXAL]','CIPROFLOXACIN LACTATE','CIPROFLOXACIN 2 MG/ML / HYDROCORTISONE 10 MG/ML [CIPRO HC]','CIPROFLOXACIN 400 MG ORAL TABLET','CIPROFLOXACIN 2 MG/ML INJECTABLE SOLUTION','CIPROFLOXACIN 2 MG/ML / HYDROCORTISONE 10 MG/ML OTIC SUSPENSION','CIPROFLOXACIN 0.003 MG/MG OPHTHALMIC OINTMENT','CIPROFLOXACIN 3 MG/ML OPHTHALMIC SOLUTION','CIPROFLOXACIN 50 MG/ML ORAL SUSPENSION','CIPROFLOXACIN 500 MG ORAL TABLET','CIPROFLOXACIN 100 MG/ML ORAL SUSPENSION','CIPROFLOXACIN 100 MG','CIPROFLOXACIN 400 MG','24 HR CIPROFLOXACIN 500 MG EXTENDED RELEASE ORAL TABLET [CIPRO XR]','CIPROFLOXACIN 3 MG/ML / DEXAMETHASONE 1 MG/ML OTIC SUSPENSION','24 HR CIPROFLOXACIN 1000 MG EXTENDED RELEASE ORAL TABLET','CIPROFLOXACIN 3 MG/ML / DEXAMETHASONE 1 MG/ML OTIC SUSPENSION [CIPRODEX]','24 HR CIPROFLOXACIN 1000 MG EXTENDED RELEASE ORAL TABLET [CIPRO XR]','CIPROFLOXACIN 1000 MG','CIPROFLOXACIN 4 MG/ML INJECTABLE SOLUTION','CIPROFLOXACIN 1 MG/ML INJECTABLE SOLUTION','CIPROFLOXACIN 1 MG/ML','CIPROFLOXACIN 4 MG/ML','CIPROFLOXACIN 250 MG [CIPROFLAXACIN]','CIPROFLOXACIN 250 MG ORAL TABLET [CIPROFLAXACIN]','CIPROFLOXACIN 750 MG [CIPROFLAXACIN]','CIPROFLOXACIN 750 MG ORAL TABLET [CIPROFLAXACIN]','CIPROFLOXACIN 250 MG [CIPROXIN]','CIPROFLOXACIN 500 MG [CIPROXIN]','CIPROFLOXACIN 750 MG [CIPROXIN]','CIPROFLOXACIN 2 MG/ML [CIPROXIN]','CIPROFLOXACIN 100 MG [CIPROXIN]','CIPROFLOXACIN 50 MG/ML [CIPROXIN]','CIPROFLOXACIN 500 MG [CIPRO]','CIPROFLOXACIN 500 MG [CIPRO XR]','CIPROFLOXACIN 1000 MG [CIPRO XR]','CIPROFLOXACIN 1000 MG EXTENDED RELEASE ORAL TABLET','CIPROFLOXACIN 500 MG [PROQUIN]','{6 (CIPROFLOXACIN 100 MG ORAL TABLET) } PACK','CIPROFLOXACIN 1000 MG [CIPRO]','CIPROFLOXACIN 1000 MG EXTENDED RELEASE ORAL TABLET [CIPRO]','CIPROFLOXACIN 500 MG EXTENDED RELEASE ORAL TABLET [CIPRO]','{6 (CIPROFLOXACIN 100 MG ORAL TABLET [CIPRO]) } PACK [CIPRO CYSTITIS PACK]','CIPROFLOXACIN HYDROCHLORIDE','CIPROFLOXACIN 500 MG EXTENDED RELEASE ORAL TABLET [CIPRO XR]','CIPROFLOXACIN 1000 MG EXTENDED RELEASE ORAL TABLET [CIPRO XR]','CIPROFLOXACIN 500 MG EXTENDED RELEASE ORAL TABLET [PROQUIN]','CIPROFLOXACIN 2 MG/ML OTIC SOLUTION [CETRAXAL]','CIPROFLOXACIN 60 MG/ML','CIPROFLOXACIN OTIC SUSPENSION','CIPROFLOXACIN 60 MG/ML OTIC SUSPENSION','CIPROFLOXACIN 60 MG/ML [OTIPRIO]','CIPROFLOXACIN OTIC SUSPENSION [OTIPRIO]','CIPROFLOXACIN 60 MG/ML OTIC SUSPENSION [OTIPRIO]','CIPROFLOXACIN / DEXAMETHASONE OTIC PRODUCT','CIPROFLOXACIN / HYDROCORTISONE OTIC PRODUCT','CIPROFLOXACIN INJECTABLE PRODUCT','CIPROFLOXACIN OPHTHALMIC PRODUCT','CIPROFLOXACIN ORAL LIQUID PRODUCT','CIPROFLOXACIN ORAL PRODUCT','CIPROFLOXACIN OTIC PRODUCT','CIPROFLOXACIN PILL','CIPROFLOXACIN / FLUOCINOLONE OTIC PRODUCT','CIPROFLOXACIN 3 MG/ML / FLUOCINOLONE ACETONIDE 0.25 MG/ML [OTOVEL]','CIPROFLOXACIN / DEXAMETHASONE OTIC SUSPENSION','CIPROFLOXACIN / DEXAMETHASONE OTIC SUSPENSION [CIPRODEX]','CIPROFLOXACIN / HYDROCORTISONE OTIC SUSPENSION','CIPROFLOXACIN / HYDROCORTISONE OTIC SUSPENSION [CIPRO HC]','CIPROFLOXACIN 10 MG/ML','CIPROFLOXACIN 10 MG/ML INJECTABLE SOLUTION','CIPROFLOXACIN 10 MG/ML INJECTABLE SOLUTION [CIPRO I.V.]','CIPROFLOXACIN 2 MG/ML INJECTABLE SOLUTION [CIPRO I.V.]','CIPROFLOXACIN 24 HOUR EXTENDED RELEASE TABLET','CIPROFLOXACIN EXTENDED RELEASE ORAL TABLET [CIPRO XR]','CIPROFLOXACIN INJECTABLE SOLUTION','CIPROFLOXACIN INJECTABLE SOLUTION [CIPRO I.V.]','CIPROFLOXACIN INJECTABLE SOLUTION [CIPROXIN]','CIPROFLOXACIN OPHTHALMIC OINTMENT','CIPROFLOXACIN OPHTHALMIC OINTMENT [CILOXAN]','CIPROFLOXACIN OPHTHALMIC SOLUTION','CIPROFLOXACIN OPHTHALMIC SOLUTION [CILOXAN]','CIPROFLOXACIN ORAL CAPSULE','CIPROFLOXACIN ORAL SUSPENSION','CIPROFLOXACIN ORAL SUSPENSION [CIPRO]','CIPROFLOXACIN ORAL SUSPENSION [CIPROXIN]','CIPROFLOXACIN ORAL TABLET','CIPROFLOXACIN ORAL TABLET [CIPRO]','CIPROFLOXACIN ORAL TABLET [CIPROXIN]','CIPROFLOXACIN 10 MG/ML [CIPRO I.V.]','CIPROFLOXACIN 2 MG/ML [CIPRO I.V.]','CIPROFLOXACIN ORAL TABLET [CIPROFLAXACIN]','CIPROFLOXACIN EXTENDED RELEASE ORAL TABLET','CIPROFLOXACIN 500 MG EXTENDED RELEASE TABLET','CIPROFLOXACIN 500 MG EXTENDED RELEASE TABLET [PROQUIN]','CIPROFLOXACIN EXTENDED RELEASE ORAL TABLET [PROQUIN]','CIPROFLOXACIN 500 MG ORAL TABLET [PROFLOXACIN]','CIPROFLOXACIN 500 MG [PROFLOXACIN]','CIPROFLOXACIN ORAL TABLET [PROFLOXACIN]','CIPROFLOXACIN 24 HOUR EXTENDED RELEASE TABLET [PROQUIN]','CIPROFLOXACIN 400 MG/ML','CIPROFLOXACIN 400 MG/ML INJECTABLE SOLUTION','{6 (CIPROFLOXACIN 100 MG ORAL TABLET) } PACK [CIPRO CYSTITIS PACK]','CIPROFLOXACIN 10 MG/ML INJECTABLE SOLUTION [CIPRO]','CIPROFLOXACIN 10 MG/ML [CIPRO]','CIPROFLOXACIN EXTENDED RELEASE ORAL TABLET [CIPRO]','CIPROFLOXACIN INJECTABLE SOLUTION [CIPRO]','CIPROFLOXACIN OTIC SOLUTION','CIPROFLOXACIN OTIC SOLUTION [CETRAXAL]','24 HR CIPROFLOXACIN 500 MG EXTENDED RELEASE ORAL TABLET [CIPRO]','CIPROFLOXACIN 10 MG/ML','CIPROFLOXACIN 10 MG/ML INJECTABLE SOLUTION','CIPROFLOXACIN 10 MG/ML INJECTABLE SOLUTION [CIPRO]','CIPROFLOXACIN 10 MG/ML [CIPRO]','CIPROFLOXACIN / FLUOCINOLONE OTIC SOLUTION','CIPROFLOXACIN 3 MG/ML / FLUOCINOLONE ACETONIDE 0.25 MG/ML OTIC SOLUTION','CIPROFLOXACIN 3 MG/ML / FLUOCINOLONE ACETONIDE 0.025 MG/ML [OTOVEL]','CIPROFLOXACIN / FLUOCINOLONE OTIC SOLUTION [OTOVEL]','CIPROFLOXACIN 3 MG/ML / FLUOCINOLONE ACETONIDE 0.25 MG/ML OTIC SOLUTION [OTOVEL]','CIPROFLOXACIN INJECTION','100 ML CIPROFLOXACIN 2 MG/ML INJECTION','CIPROFLOXACIN 2 MG/ML INJECTION','200 ML CIPROFLOXACIN 2 MG/ML INJECTION','CIPROFLOXACIN INJECTION [CIPRO]','200 ML CIPROFLOXACIN 2 MG/ML INJECTION [CIPRO]','CIPROFLOXACIN 2 MG/ML INJECTION [CIPRO]','20 ML CIPROFLOXACIN 10 MG/ML INJECTION','CIPROFLOXACIN 10 MG/ML INJECTION','40 ML CIPROFLOXACIN 10 MG/ML INJECTION','C-FLOX           (CIRPROFLOXACIN)','CEPROFLOXACIN HYDROCHLORIDE','CIFLOX (CIPROFLOXAIN)','CIFPROFLOXACIN','CIOPROFLOXACIN','CIPLOFLOXACIN','CIPLROFLOXACIN','CIPOFLOXACIN','CIPOROFLOXACIN','CIPRFLOXACIN','CIPRFLOXACIN-DEXAMETHASONE','CIPRO (CIPROFLOACIN HYDROCHLORIDE)','CIPRO (CIPROFLOXACINE HYDROCHLORIDE)','CIPRO (CIPROFOXACIN HYDROCHLORIDE)','CIPROBAY (CIPROFLOXACINE)','CIPROFLAOXACIN (CIPROFLOAXACIN)','CIPROFLAXACIN -ORAL 750 MG','CIPROFLAXACIN HD','CIPROFLAXIN (CIPROGLOXACIN)','CIPROFLOCACIN','CIPROFLOXACAN','CIPROFLOXACAN 500 MG','CIPROFLOXACI','CIPROFLOXACI.GI LE','CIPROFLOXACID','CIPROFLOXACIIN','CIPROFLOXACIM','CIPROFLOXACIN (CIPROFLOCACIN HYDROCHLORIDE)','CIPROFLOXACIN HCL (CIPOROFLOXACIN HYDROCHLORIDE)','CIPROFLOXACINA (CIPROFLOXACINA) (CIPROFLOXACINA)','CIPROFLOXACINA 500 MG RATIOPHARM','CIPROFLOXACINA LABESFAL (CIPROFLOXACIN HYDROCHLORIDE MONOHYDRATE) (CIPROFLOXACIN HYDROCHLORIDE MONOHYDRATE)','CIPROFLOXACINA RANBAXY 500 MG COMPRIMIDOS REVESTIDOS','CIPROFLOXACINA RANBAXY 500MG COMPRIMIDOS REVESTIDOS','CIPROFLOXACINA RATIOPHARM 500 MG','CIPROFLOXACINA//CIPROFLOXACIN','CIPROFLOXACINE ','CIPROFLOXACINE                     /00697202/','CIPROFLOXACINE (CIPROFLOXACINE) (CIPROFLOXACINE)','CIPROFLOXACINE 500 MG','CIPROFLOXACINE 5MG BID','CIPROFLOXACINE ACTAVIS//CIPROFLOXACIN HYDROCHLORIDE','CIPROFLOXACINE BEXAL','CIPROFLOXACINE HCL','CIPROFLOXACINE MERCK','CIPROFLOXACINE RP TABLET 500MG','CIPROFLOXACINE RPG 250 MG COMPRIME PELLICULE','CIPROFLOXACINE TEVA 500 MG, COMPRIME PELLICULE SECABLE','CIPROFLOXACINE//CIPROFLOXACIN','CIPROFLOXACINHYDROCHLORIDE/DEXAMETHASONE','CIPROFLOXACINI HYDROCHLORIDUM','CIPROFLOXACINO                     /00697201/','CIPROFLOXACINO                     /00697202/','CIPROFLOXACINO 500MG','CIPROFLOXACINO RATIO 250 MG COMPRIMIDOS RECUBIERTOS CON PELICULA EFG,','CIPROFLOXACN  500 MG TAB  BAYER','CIPROFLOXACN 250 MG','CIPROFLOXACN 250 MG TAB','CIPROFLOXACN 500MG GENERIC','CIPROFLOXACN TAB','CIPROFLOXACN TAB 500MG','CIPROFLOXACON','CIPROFLOXAIN','CIPROFLOXAIN (CIPROFLOXAIN)','CIPROFLOXAMIN (CIPROFLOXAMIN) (TABLETS)','CIPROFLOXAXIN','CIPROFLOXAZIN','CIPROFLOXAZIN HCL','CIPROFLOXICIN 500 MG GENERIC BAYER','CIPROFLOXICIN 500 MG. ROUND WHITE OVAL','CIPROFLOXICIN 750 MG BAYER','CIPROFLOYACIN','CIPROFLOZACIN','CIPROFLXACIN HYDROCHLORIDE','CIPROGLOXACIN','CIPROLOXACIN (CIPROLFLOXACIN)','CIPROLOXACIN HCL (INGREDIENTS UNKNOWN)','CIPROPLOXACIN','CIPROXAN (CIPROFLOXAXIN HYDROCHLORIDE)','CIPROXLOXACIN','CIPRPOFLOXACIN HYDROCHLORIDE','CIPRROFLOXACIN IV','CIPXOFLOXACIN','CIROFLOXACIN','CIRPROFLOXACIN','CITROFLOXACIN','COPROFLOXACIN HCL','CPROFLOXACIN 250 MG TABLET TEVA','CYPROFLOXACIN HCL','GLIMEPIRIDE, NIASPAN, CALCIUM 600, CIPROFLOXACN, AMIODARONE','ZIPROFLOXACIN')
 ;
 CREATE INDEX ciprospecific_caseid_idx ON scratch_rich.ciproSpecific USING btree (caseid)

 --- 2. standard summary of the reports using standardized terms and outcomes
 drop table if exists scratch_rich.standardSummary;
 select cd.concept_name standard_drug_name,
        co.concept_name standard_outcome_name,
        sdod.*,
        sco.pt
 into scratch_rich.standardSummary
 from faers.standard_drug_outcome_drilldown sdod inner join scratch_rich.ciproSpecific on sdod.caseid = ciproSpecific.caseid
    inner join staging_vocabulary.concept cd on sdod.drug_concept_id = cd.concept_id
    inner join staging_vocabulary.concept co on sdod.outcome_concept_id = co.concept_id
    inner join faers.standard_case_outcome sco on sco.primaryid = sdod.primaryid and sdod.outcome_concept_id = sco.outcome_concept_id 
;
CREATE INDEX standardsummary_primaryid_idx ON scratch_rich.standardsummary (primaryid);

-- 3. obtain the complete case report data
select drug.primaryid, drug.caseid, drug.drug_seq, drug.role_cod, drug.drugname, drug.prod_ai, drug.val_vbm, drug.route, drug.dose_vbm, drug.cum_dose_chr, 
       drug.cum_dose_unit, drug.dechal, drug.rechal, drug.lot_num, drug.exp_dt, drug.nda_num, drug.dose_amt, drug.dose_unit, drug.dose_form, drug.dose_freq, drug.filename, 
       string_agg(distinct standardSummary.drug_concept_id::text, ';') drug_concept_id, string_agg(distinct standardSummary.standard_drug_name, ';') standard_drug_name, 
       string_agg(distinct standardSummary.standard_outcome_name, ';') standard_outcome_name, string_agg(distinct standardSummary.outcome_concept_id::text, ';') outcome_concept_id, string_agg(distinct standardSummary.snomed_outcome_concept_id::text, ';') snomed_outcome_concept_id, 
       string_agg(distinct scoc.outc_code, ';') standard_outcome_code, string_agg(distinct scoc.snomed_concept_id::text, ';') standard_outcome_snomed, 
       demo.caseversion, demo.i_f_code, demo.event_dt, demo.mfr_dt, demo.init_fda_dt, demo.fda_dt, demo.rept_cod, demo.auth_num, demo.mfr_num, demo.mfr_sndr, demo.lit_ref, demo.age, demo.age_cod, demo.age_grp, demo.sex, demo.e_sub, demo.wt, demo.wt_cod, demo.rept_dt, demo.to_mfr, demo.occp_cod, demo.reporter_country, demo.occr_country, demo.filename, 
       indi.indi_drug_seq, indi.indi_pt, indi.filename, 
       rpsr.rpsr_cod, rpsr.filename 
from faers.drug drug inner join scratch_rich.standardSummary on drug.primaryid = standardSummary.primaryid
   inner join faers.demo demo on demo.primaryid = standardSummary.primaryid
   left outer join faers.standard_case_outcome_category scoc on scoc.primaryid = standardSummary.primaryid
   left outer join faers.indi indi on indi.primaryid = standardSummary.primaryid and indi.indi_drug_seq = drug.drug_seq
   left outer join faers.rpsr rpsr on rpsr.primaryid = standardSummary.primaryid
GROUP BY drug.primaryid, drug.caseid, drug.drug_seq, drug.role_cod, drug.drugname, drug.prod_ai, drug.val_vbm, drug.route, drug.dose_vbm, drug.cum_dose_chr, drug.cum_dose_unit, drug.dechal, drug.rechal, drug.lot_num, drug.exp_dt, drug.nda_num, drug.dose_amt, drug.dose_unit, drug.dose_form, drug.dose_freq, drug.filename,         
         demo.caseversion, demo.i_f_code, demo.event_dt, demo.mfr_dt, demo.init_fda_dt, demo.fda_dt, demo.rept_cod, demo.auth_num, demo.mfr_num, demo.mfr_sndr, demo.lit_ref, demo.age, demo.age_cod, demo.age_grp, demo.sex, demo.e_sub, demo.wt, demo.wt_cod, demo.rept_dt, demo.to_mfr, demo.occp_cod, demo.reporter_country, demo.occr_country, demo.filename, 
         indi.indi_drug_seq, indi.indi_pt, indi.filename,
         rpsr.rpsr_cod, rpsr.filename
ORDER BY drug.primaryid, drug.drug_seq::integer
;