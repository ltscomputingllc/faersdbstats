-- Example of pulling reports for Humira


-- STAGE 0 -- if you know the primary ID of a report 

--- In this example, information from a report with primary id 108056851 is retrieved. In this case, the report refers to drugs that were mapped to standardized drug concepts.
--- Note that you can use a similar query for reports that refer to drugs not mapped to standardized drug concepts but need to comment out the lines indicated below with  '-- ***'
select drug.primaryid, drug.caseid, drug.drug_seq, drug.role_cod, drug.drugname, drug.prod_ai, drug.val_vbm, drug.route, drug.dose_vbm, drug.cum_dose_chr, drug.cum_dose_unit, drug.dechal, drug.rechal, drug.lot_num, drug.exp_dt, drug.nda_num, drug.dose_amt, drug.dose_unit, drug.dose_form, drug.dose_freq, drug.filename, 
       string_agg(distinct sdod.drug_concept_id::text, ';') drug_concept_id, string_agg(distinct cd.concept_name, ';') standard_drug_name, -- ***
       string_agg(distinct co.concept_name, ';') standard_outcome_name, string_agg(distinct sdod.outcome_concept_id::text, ';') outcome_concept_id, string_agg(distinct sdod.snomed_outcome_concept_id::text, ';') snomed_outcome_concept_id,  -- ***          
       demo.caseversion, demo.i_f_code, demo.event_dt, demo.mfr_dt, demo.init_fda_dt, demo.fda_dt, demo.rept_cod, demo.auth_num, demo.mfr_num, demo.mfr_sndr, demo.lit_ref, demo.age, demo.age_cod, demo.age_grp, demo.sex, demo.e_sub, demo.wt, demo.wt_cod, demo.rept_dt, demo.to_mfr, demo.occp_cod, demo.reporter_country, demo.occr_country, demo.filename, 
       indi.indi_drug_seq, indi.indi_pt, indi.filename, 
       rpsr.rpsr_cod, rpsr.filename
from faers.drug inner join faers.demo demo on demo.primaryid = drug.primaryid
   inner join faers.standard_drug_outcome_drilldown sdod on sdod.caseid = drug.caseid -- ***
   inner join staging_vocabulary.concept cd on sdod.drug_concept_id = cd.concept_id -- ***
   inner join staging_vocabulary.concept co on sdod.outcome_concept_id = co.concept_id -- ***
   left outer join faers.indi indi on indi.primaryid = drug.primaryid and indi.indi_drug_seq = drug.drug_seq
   left outer join faers.rpsr rpsr on rpsr.primaryid = drug.primaryid
where drug.primaryid = '108056851'
GROUP BY drug.primaryid, drug.caseid, drug.drug_seq, drug.role_cod, drug.drugname, drug.prod_ai, drug.val_vbm, drug.route, drug.dose_vbm, drug.cum_dose_chr, drug.cum_dose_unit, drug.dechal, drug.rechal, drug.lot_num, drug.exp_dt, drug.nda_num, drug.dose_amt, drug.dose_unit, drug.dose_form, drug.dose_freq, drug.filename,         
         demo.caseversion, demo.i_f_code, demo.event_dt, demo.mfr_dt, demo.init_fda_dt, demo.fda_dt, demo.rept_cod, demo.auth_num, demo.mfr_num, demo.mfr_sndr, demo.lit_ref, demo.age, demo.age_cod, demo.age_grp, demo.sex, demo.e_sub, demo.wt, demo.wt_cod, demo.rept_dt, demo.to_mfr, demo.occp_cod, demo.reporter_country, demo.occr_country, demo.filename, 
         indi.indi_drug_seq, indi.indi_pt, indi.filename, 
         rpsr.rpsr_cod, rpsr.filename
ORDER BY drug.drug_seq
;


-- STAGE I -- USING STANDARDIZED DATA 

-- i.1 this gets the standard concept_id (OMOP) in RxNorm for the ingredient adalimumab because the standardized database only has 1) ingredients for single drug products and 2)clinical drug forms for combination products.
select * from staging_vocabulary.concept where vocabulary_id = 'RxNorm' and concept_name ='adalimumab'; -- lower case ingredients
-- adalimumab : 1119119 (omop id), 327361 (rxnorm)


-- i.2 Query the standardized drug - outcome count tables using the drug concept ids for all reports involving adalimumab
-- The query can take 1+ hours to run.
with humiraSpecific as (
   select distinct drug.caseid
   from faers.drug drug 
   where drug.drugname ilike '%humira%'
 ), standardSummary as (
   select cd.concept_name standard_drug_name,
          co.concept_name standard_outcome_name,
          sdod.*           
   from faers.standard_drug_outcome_drilldown sdod inner join humiraSpecific on sdod.caseid = humiraSpecific.caseid
      inner join staging_vocabulary.concept cd on sdod.drug_concept_id = cd.concept_id
      inner join staging_vocabulary.concept co on sdod.outcome_concept_id = co.concept_id
)
select drug.primaryid, drug.caseid, drug.drug_seq, drug.role_cod, drug.drugname, drug.prod_ai, drug.val_vbm, drug.route, drug.dose_vbm, drug.cum_dose_chr, drug.cum_dose_unit, drug.dechal, drug.rechal, drug.lot_num, drug.exp_dt, drug.nda_num, drug.dose_amt, drug.dose_unit, drug.dose_form, drug.dose_freq, drug.filename, 
       string_agg(distinct standardSummary.drug_concept_id::text, ';') drug_concept_id, string_agg(distinct standardSummary.standard_drug_name, ';') standard_drug_name, 
       string_agg(distinct standardSummary.standard_outcome_name, ';') standard_outcome_name, string_agg(distinct standardSummary.outcome_concept_id::text, ';') outcome_concept_id, string_agg(distinct standardSummary.snomed_outcome_concept_id::text, ';') snomed_outcome_concept_id, 
       demo.caseversion, demo.i_f_code, demo.event_dt, demo.mfr_dt, demo.init_fda_dt, demo.fda_dt, demo.rept_cod, demo.auth_num, demo.mfr_num, demo.mfr_sndr, demo.lit_ref, demo.age, demo.age_cod, demo.age_grp, demo.sex, demo.e_sub, demo.wt, demo.wt_cod, demo.rept_dt, demo.to_mfr, demo.occp_cod, demo.reporter_country, demo.occr_country, demo.filename, 
       indi.indi_drug_seq, indi.indi_pt, indi.filename, 
       rpsr.rpsr_cod, rpsr.filename 
from faers.drug drug inner join standardSummary on drug.primaryid = standardSummary.primaryid
   inner join faers.demo demo on demo.primaryid = standardSummary.primaryid
   left outer join faers.indi indi on indi.primaryid = standardSummary.primaryid and indi.indi_drug_seq = drug.drug_seq
   left outer join faers.rpsr rpsr on rpsr.primaryid = standardSummary.primaryid
GROUP BY drug.primaryid, drug.caseid, drug.drug_seq, drug.role_cod, drug.drugname, drug.prod_ai, drug.val_vbm, drug.route, drug.dose_vbm, drug.cum_dose_chr, drug.cum_dose_unit, drug.dechal, drug.rechal, drug.lot_num, drug.exp_dt, drug.nda_num, drug.dose_amt, drug.dose_unit, drug.dose_form, drug.dose_freq, drug.filename,         
         demo.caseversion, demo.i_f_code, demo.event_dt, demo.mfr_dt, demo.init_fda_dt, demo.fda_dt, demo.rept_cod, demo.auth_num, demo.mfr_num, demo.mfr_sndr, demo.lit_ref, demo.age, demo.age_cod, demo.age_grp, demo.sex, demo.e_sub, demo.wt, demo.wt_cod, demo.rept_dt, demo.to_mfr, demo.occp_cod, demo.reporter_country, demo.occr_country, demo.filename, 
         indi.indi_drug_seq, indi.indi_pt, indi.filename, 
         rpsr.rpsr_cod, rpsr.filename
ORDER BY drug.primaryid, drug.drug_seq
;


-- STAGE II -- ensuring inclusion of reports with drug strings that were not mapped to the standard drug terminology (rxnorm)

-- ii.1 Use the custom script to pull all unmapped drug strings that have an exact match with any of the strings that identify a Humira drug product
-- $ python3 getDrugNameMatches.py -d 0 -s 'Humira|Adalimumab|Adalimumabum|Adalimumab|Adalimumab (Genetical Recombination)|D 2E7|LU 200134|Amgevita|Amjevita|Cyltezo|Humira|Humira [pediatric]|Humira 20mg|Humira 40mg|Humira 40mg/0,8ml|Humira 40mg/0,8ml für Kinder und Jugendliche|Humira 80mg|Humira AC' -f drugs-unmapped-June2019.csv
--
-- Results:

--  HUMIRA 40 MG/0.8ML PREFILLED SYRINGE (ADALIBUMAB)
-- ADALIMUMAB (HUMIRA 40 MG/ 0.8 ML PRE-FILLED SYRINGE)
-- ADALIMUMAB (HUMIRA USA/)
-- ADALIMUMAB 40 MG UNDER THE SKIN ONCE WEEKLY
-- ADALIMUMAB 40 MG/INJECTOR HUMIRA/ABBOT LABORATORIES
-- ADALIMUMAB 40MG/0.8 ML ABBOT
-- ADALIMUMAB 40MG/0.8ML ABBOTT
-- ADALIMUMAB OR PLACEBO
-- ADALIMUMAB-HUMIRA-
-- BENDRYL/HUMIRA/IBUPROFEN
-- CP-690,550;ADALIMUMAB;METHOTREXATE;PLACE(PLACEBO)
-- HUMIRA                                  /USA/
-- HUMIRA             NO LONGER HAVE INFO
-- HUMIRA   (ACTIVE CONSTITUENT -ADALIMUMAB)
-- HUMIRA  NOT SURE GIVEN EVERY 2 WEEKS    ABBOTT
-- HUMIRA (ALL OTHER THERAPEUTIC PRODUCTS)
-- HUMIRA - ABBOTT 40 MG
-- HUMIRA /USA/
-- HUMIRA 1 SHOT
-- HUMIRA 20 MG/0.4 ML PRE-FILLED SYRINGE
-- HUMIRA 20MG/0.4ML ABBVIE
-- HUMIRA 40 INJECTION LIQUID 50MG/ML PEN 0.8ML
-- HUMIRA 40 INJVLST 50MG/ML PEN 0,8ML
-- HUMIRA 40 MG / 0.8 ML PRE-FILLED SYRINGE ( HUMIRA ) ( ADAMUMAB )
-- HUMIRA 40 MG ABBOTT
-- HUMIRA 40 MG ABBVIE
-- HUMIRA 40 MG EVERY OTHER WEEK
-- HUMIRA 40 MG INJEKTIONSLOESUNG
-- HUMIRA 40 MG PEN ABBVIE HUMIRA
-- HUMIRA 40 MG PER ABBOTT Q WEEK SUBCUTANEOUS
-- HUMIRA 40 MG Q 14 D
-- HUMIRA 40 MG SQ WEEKLY ABBOTT
-- HUMIRA 40 MG/  0.8 ML PRE-FILLED SYRINGE (HUMIRA) (ADALIMUMBA)
-- HUMIRA 40 MG/ 0.8 ML PEN
-- HUMIRA 40 MG/ 0.8 ML PRE-FILLED HYRINGE (HUMIRA) (ADALIMUMAB)  (ADALIM
-- HUMIRA 40 MG/ 0.8 ML PRE-FILLED SYRINGE (HUMIRA) (ADALIMUMA) (ADALIMUM
-- HUMIRA 40 MG/ 0.8 ML PRE-FILLED SYRINGE (HUMIRA) (ADALIMUMAB) (ADALIMU
-- HUMIRA 40 MG/ 0.8 ML PRE-FILLED SYRINGE (HUMIRA) (ADLAMUMAB)
-- HUMIRA 40 MG/ 0.8 ML VIAL KIT
-- HUMIRA 40 MG/ 70.8 ML PRE-FILLED SYRINGE
-- HUMIRA 40 MG/0.8 L PRE-FILLED SYRINGE (HUMIRA) (ADALIMUMAB) (ADALIMUMA
-- HUMIRA 40 MG/0.8 ML PRE-FILLED SYRINGE (HUMIRA) (ADALIMUMB)
-- HUMIRA 40 MG/0.8 MLPRE-FILLED SYRINGE (HUMIRA) (ADALIMIMAB)  (ADALIMIM
-- HUMIRA 40 ONE SHOT Q 2 WEEKS
-- HUMIRA 40MG 50 Q 14 DAYS
-- HUMIRA 40MG PFS/ABBOTT LABS
-- HUMIRA 40MG SC QOW
-- HUMIRA 40MG/0,8ML
-- HUMIRA 40MG/0.8 ML ABBOT LABRATORIES
-- HUMIRA 40MG/0.8 ML PRE-FILLED SRYINGE (HUMIRA) (ADALIMUMAB) (ADALIMUMA
-- HUMIRA 40MG/0.8 PFS
-- HUMIRA 40MG/0.8ML PEN
-- HUMIRA 40MG/0.8ML PEN ABBVIE
-- HUMIRA ? D/C'ED PRIOR TO STARTING ON STELARA OVER A YEAR AGO
-- HUMIRA BUPROPION AMITRIPTYLINE
-- HUMIRA NO STUDY MEDICATION
-- HUMIRA PEN 40 MG
-- HUMIRA PEN 40 MG ABBOTT
-- HUMIRA PEN 40 MG/ 0.8ML ABBOTT
-- HUMIRA PEN 40 MG/0.8 ML
-- HUMIRA PEN, 40 MG, ABBVIE
-- HUMIRA PEN, 40/0.8 MG/ML, ABBOTT LABORATORIES - ADALIMUMAB -
-- HUMIRA PFS
-- HUMIRA PFS 40 MG ABB VIE
-- HUMIRA(R) (ADALIMUMAB) 40 MG ABBOTT
-- HUMIRA, 40 MG, ABBVIE
-- HUMIRA, 40 MG/0.08 ML, ABBOTT
-- HUMIRA-PEN
-- METHOTREXATE W/ HUMIRA
-- PRE HUMIRA PEN


--ii.2 query the database using these drug strings - when satisfied, export to a CSV file that can then be loaded into Excel
with humiras as (
 select * 
 from faers.drug d
 where d.drugname in ('HUMIRA 40 MG/0.8ML PREFILLED SYRINGE (ADALIBUMAB)','ADALIMUMAB (HUMIRA 40 MG/ 0.8 ML PRE-FILLED SYRINGE)','ADALIMUMAB (HUMIRA USA/)','ADALIMUMAB 40 MG UNDER THE SKIN ONCE WEEKLY','ADALIMUMAB 40 MG/INJECTOR HUMIRA/ABBOT LABORATORIES','ADALIMUMAB 40MG/0.8 ML ABBOT','ADALIMUMAB 40MG/0.8ML ABBOTT','ADALIMUMAB OR PLACEBO','ADALIMUMAB-HUMIRA-','BENDRYL/HUMIRA/IBUPROFEN','CP-690,550;ADALIMUMAB;METHOTREXATE;PLACE(PLACEBO)','HUMIRA                                  /USA/','HUMIRA             NO LONGER HAVE INFO','HUMIRA   (ACTIVE CONSTITUENT -ADALIMUMAB)','HUMIRA  NOT SURE GIVEN EVERY 2 WEEKS    ABBOTT','HUMIRA (ALL OTHER THERAPEUTIC PRODUCTS)','HUMIRA - ABBOTT 40 MG','HUMIRA /USA/','HUMIRA 1 SHOT','HUMIRA 20 MG/0.4 ML PRE-FILLED SYRINGE','HUMIRA 20MG/0.4ML ABBVIE','HUMIRA 40 INJECTION LIQUID 50MG/ML PEN 0.8ML','HUMIRA 40 INJVLST 50MG/ML PEN 0,8ML','HUMIRA 40 MG / 0.8 ML PRE-FILLED SYRINGE ( HUMIRA ) ( ADAMUMAB )','HUMIRA 40 MG ABBOTT','HUMIRA 40 MG ABBVIE','HUMIRA 40 MG EVERY OTHER WEEK','HUMIRA 40 MG INJEKTIONSLOESUNG','HUMIRA 40 MG PEN ABBVIE HUMIRA','HUMIRA 40 MG PER ABBOTT Q WEEK SUBCUTANEOUS','HUMIRA 40 MG Q 14 D','HUMIRA 40 MG SQ WEEKLY ABBOTT','HUMIRA 40 MG/  0.8 ML PRE-FILLED SYRINGE (HUMIRA) (ADALIMUMBA)','HUMIRA 40 MG/ 0.8 ML PEN','HUMIRA 40 MG/ 0.8 ML PRE-FILLED HYRINGE (HUMIRA) (ADALIMUMAB)  (ADALIM','HUMIRA 40 MG/ 0.8 ML PRE-FILLED SYRINGE (HUMIRA) (ADALIMUMA) (ADALIMUM','HUMIRA 40 MG/ 0.8 ML PRE-FILLED SYRINGE (HUMIRA) (ADALIMUMAB) (ADALIMU','HUMIRA 40 MG/ 0.8 ML PRE-FILLED SYRINGE (HUMIRA) (ADLAMUMAB)','HUMIRA 40 MG/ 0.8 ML VIAL KIT','HUMIRA 40 MG/ 70.8 ML PRE-FILLED SYRINGE','HUMIRA 40 MG/0.8 L PRE-FILLED SYRINGE (HUMIRA) (ADALIMUMAB) (ADALIMUMA','HUMIRA 40 MG/0.8 ML PRE-FILLED SYRINGE (HUMIRA) (ADALIMUMB)','HUMIRA 40 MG/0.8 MLPRE-FILLED SYRINGE (HUMIRA) (ADALIMIMAB)  (ADALIMIM','HUMIRA 40 ONE SHOT Q 2 WEEKS','HUMIRA 40MG 50 Q 14 DAYS','HUMIRA 40MG PFS/ABBOTT LABS','HUMIRA 40MG SC QOW','HUMIRA 40MG/0,8ML','HUMIRA 40MG/0.8 ML ABBOT LABRATORIES','HUMIRA 40MG/0.8 ML PRE-FILLED SRYINGE (HUMIRA) (ADALIMUMAB) (ADALIMUMA','HUMIRA 40MG/0.8 PFS','HUMIRA 40MG/0.8ML PEN','HUMIRA 40MG/0.8ML PEN ABBVIE','HUMIRA ? D/C''ED PRIOR TO STARTING ON STELARA OVER A YEAR AGO','HUMIRA BUPROPION AMITRIPTYLINE','HUMIRA NO STUDY MEDICATION','HUMIRA PEN 40 MG','HUMIRA PEN 40 MG ABBOTT','HUMIRA PEN 40 MG/ 0.8ML ABBOTT','HUMIRA PEN 40 MG/0.8 ML','HUMIRA PEN, 40 MG, ABBVIE','HUMIRA PEN, 40/0.8 MG/ML, ABBOTT LABORATORIES - ADALIMUMAB -','HUMIRA PFS','HUMIRA PFS 40 MG ABB VIE','HUMIRA(R) (ADALIMUMAB) 40 MG ABBOTT','HUMIRA, 40 MG, ABBVIE','HUMIRA, 40 MG/0.08 ML, ABBOTT','HUMIRA-PEN','METHOTREXATE W/ HUMIRA','PRE HUMIRA PEN')
)
select humiras.primaryid, humiras.caseid, humiras.drug_seq, humiras.role_cod, humiras.drugname, humiras.prod_ai, humiras.val_vbm, humiras.route, humiras.dose_vbm, humiras.cum_dose_chr, humiras.cum_dose_unit, humiras.dechal, humiras.rechal, humiras.lot_num, humiras.exp_dt, humiras.nda_num, humiras.dose_amt, humiras.dose_unit, humiras.dose_form, humiras.dose_freq, humiras.filename, 
       demo.caseversion, demo.i_f_code, demo.event_dt, demo.mfr_dt, demo.init_fda_dt, demo.fda_dt, demo.rept_cod, demo.auth_num, demo.mfr_num, demo.mfr_sndr, demo.lit_ref, demo.age, demo.age_cod, demo.age_grp, demo.sex, demo.e_sub, demo.wt, demo.wt_cod, demo.rept_dt, demo.to_mfr, demo.occp_cod, demo.reporter_country, demo.occr_country, demo.filename, 
       indi.indi_drug_seq, indi.indi_pt, indi.filename, 
       rpsr.rpsr_cod, rpsr.filename  
from humiras inner join faers.standard_case_outcome on humiras.primaryid = standard_case_outcome.primaryid
 inner join faers.demo demo on demo.primaryid = standard_case_outcome.primaryid
 left outer join faers.indi indi on indi.primaryid = standard_case_outcome.primaryid and indi.indi_drug_seq = humiras.drug_seq
 left outer join faers.rpsr rpsr on rpsr.primaryid = standard_case_outcome.primaryid
GROUP BY humiras.primaryid, humiras.caseid, humiras.drug_seq, humiras.role_cod, humiras.drugname, humiras.prod_ai, humiras.val_vbm, humiras.route, humiras.dose_vbm, humiras.cum_dose_chr, humiras.cum_dose_unit, humiras.dechal, humiras.rechal, humiras.lot_num, humiras.exp_dt, humiras.nda_num, humiras.dose_amt, humiras.dose_unit, humiras.dose_form, humiras.dose_freq, humiras.filename, 
         demo.caseversion, demo.i_f_code, demo.event_dt, demo.mfr_dt, demo.init_fda_dt, demo.fda_dt, demo.rept_cod, demo.auth_num, demo.mfr_num, demo.mfr_sndr, demo.lit_ref, demo.age, demo.age_cod, demo.age_grp, demo.sex, demo.e_sub, demo.wt, demo.wt_cod, demo.rept_dt, demo.to_mfr, demo.occp_cod, demo.reporter_country, demo.occr_country, demo.filename, 
         indi.indi_drug_seq, indi.indi_pt, indi.filename, 
         rpsr.rpsr_cod, rpsr.filename
ORDER BY humiras.primaryid, humiras.drug_seq
;



