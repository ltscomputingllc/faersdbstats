

-- Drop table 
DROP TABLE scratch_rich.tiz_1a2_inh_all_cell_a; 
CREATE TABLE scratch_rich.tiz_1a2_inh_all_cell_a ( 
    caseid varchar NULL, 
    isr varchar NULL, 
    outcome_concept_id int8 NULL, 
    smq_name varchar NULL, 
    smq_codes varchar NULL, 
    concept_code varchar NULL, 
    concept_name varchar NULL, 
    inhibitor varchar NULL, 
    drug_concept_id int8 NULL, 
    drug_concept_name varchar NULL, 
    drug_name varchar NULL 
); 
CREATE INDEX tiz_1a2_inh_all_cell_a_caseid_idx ON scratch_rich.tiz_1a2_inh_all_cell_a USING btree (caseid); 
CREATE INDEX tiz_1a2_inh_all_cell_a_isr_idx ON scratch_rich.tiz_1a2_inh_all_cell_a USING btree (isr); 


--- FAERS drill down
drop table if exists scratch_rich.tiz_1a2_cell_a_full_faers;
with standardS as (
   select  scoc.caseid caseid,
       string_agg(distinct scoc.drug_concept_id::text, ';') standard_drug_concept_id, 
       string_agg(distinct scoc.outcome_concept_id::text, ';') standard_outcome_concept_id, 
       string_agg(distinct scoc.snomed_outcome_concept_id::text, ';') standard_outcome_snomed_id,
       string_agg(distinct s.concept_code::text, ';') meddra_code,
       string_agg(distinct s.concept_name::text, ';') meddra_name,
       s.smq_name,
       s.inhibitor
   from scratch_rich.tiz_1a2_inh_all_cell_a s inner join faers.standard_drug_outcome_drilldown scoc on scoc.caseid = s.caseid   
   group by scoc.caseid, s.smq_name, s.inhibitor 
 ), combined as ( 
  select 
     drug.*, 
       demo.caseversion, demo.i_f_code, demo.event_dt, demo.mfr_dt, demo.init_fda_dt, demo.fda_dt, demo.rept_cod, demo.auth_num, demo.mfr_num, demo.mfr_sndr, demo.lit_ref, 
       demo.age, demo.age_cod, demo.age_grp, demo.sex, demo.e_sub, demo.wt, demo.wt_cod, demo.rept_dt, demo.to_mfr, demo.occp_cod,
       demo.reporter_country, demo.occr_country, demo.filename demo_filename,
       standardS.standard_drug_concept_id, standardS.standard_outcome_concept_id, standardS.standard_outcome_snomed_id,
       standardS.meddra_code, standardS.meddra_name, standardS.smq_name, standardS.inhibitor
    from standardS inner join faers.drug  on standardS.caseid = drug.caseid 
       inner join faers.demo  on demo.caseid = standardS.caseid
 )
select combined.caseid, null isr, combined.drug_seq, combined.drugname,
          string_agg(distinct combined.role_cod, ';') role_cod,  
          string_agg(distinct combined.prod_ai, ';') prod_ai, 
          string_agg(distinct combined.val_vbm, ';') val_vbm, 
          string_agg(distinct combined.route, ';') route, 
          string_agg(distinct combined.dose_vbm, ';') dose_vbm,
          string_agg(distinct combined.cum_dose_chr, ';') cum_dose_chr, 
          string_agg(distinct combined.cum_dose_unit, ';') cum_dose_unit, 
          string_agg(distinct combined.dechal, ';') dechal, 
          string_agg(distinct combined.rechal, ';') rechal, 
          string_agg(distinct combined.lot_num, ';') lot_num, 
          string_agg(distinct combined.exp_dt, ';') exp_dt, 
          string_agg(distinct combined.nda_num, ';') nda_num, 
          string_agg(distinct combined.dose_amt, ';') dose_amt, 
          string_agg(distinct combined.dose_unit, ';') dose_unit, 
          string_agg(distinct combined.dose_form, ';') dose_form, 
          string_agg(distinct combined.dose_freq, ';') dose_freq, 
          string_agg(distinct combined.filename, ';') filename, 
       combined.standard_drug_concept_id, combined.standard_outcome_concept_id, combined.standard_outcome_snomed_id, 
       combined.meddra_code, combined.meddra_name, 
       combined.smq_name, combined.inhibitor,
          string_agg(distinct combined.caseversion, ';') caseversion, 
          string_agg(distinct combined.i_f_code, ';') I_f_code, 
          string_agg(distinct combined.event_dt, ';') event_dt, 
          string_agg(distinct combined.mfr_dt, ';') mfr_dt, 
          string_agg(distinct combined.init_fda_dt, ';') init_fda_dt, 
          string_agg(distinct combined.fda_dt,  ';') fda_dt,
          string_agg(distinct combined.rept_cod, ';') rept_cod, 
          string_agg(distinct combined.auth_num, ';') auth_num, 
          string_agg(distinct combined.mfr_num, ';') mfr_num, 
          string_agg(distinct combined.mfr_sndr, ';') mfr_sndr, 
          string_agg(distinct combined.lit_ref, ';') lit_ref, 
          string_agg(distinct combined.age, ';') age, 
          string_agg(distinct combined.age_cod, ';') age_cod, 
          string_agg(distinct combined.age_grp, ';') age_grp, 
          string_agg(distinct combined.sex, ';') sex, 
          string_agg(distinct combined.e_sub, ';') e_sub, 
          string_agg(distinct combined.wt, ';') wt, 
          string_agg(distinct combined.wt_cod, ';') wt_cod, 
          string_agg(distinct combined.rept_dt, ';') rept_dt, 
          string_agg(distinct combined.to_mfr, ';') to_mfr, 
          string_agg(distinct combined.occp_cod, ';') occp_cod,
          string_agg(distinct combined.reporter_country, ';') reporter_country, 
          string_agg(distinct combined.occr_country, ';') occr_country, 
          string_agg(distinct combined.filename, ';') demo_filename, 
       string_agg(distinct outc.outc_code, ';') outc_code, string_agg(distinct outc.filename, ';') outc_filename, 
       string_agg(distinct indi.indi_drug_seq, ';') indi_drug_seq, string_agg(distinct indi.indi_pt, ';') indi_pt, string_agg(distinct indi.filename, ';') indi_filename, 
       string_agg(distinct rpsr.rpsr_cod, ';') rpsr_cod, string_agg(distinct rpsr.filename, ';') rpsr_filename 
 into scratch_rich.tiz_1a2_cell_a_full_faers
 from combined 
   left outer join faers.outc outc on outc.caseid = combined.caseid
   left outer join faers.indi indi on indi.caseid = combined.caseid and indi.indi_drug_seq = combined.drug_seq
   left outer join faers.rpsr rpsr on rpsr.caseid = combined.caseid
 GROUP BY combined.caseid, combined.drug_seq, combined.drugname,        
         combined.standard_drug_concept_id, combined.standard_outcome_concept_id, combined.standard_outcome_snomed_id,
         combined.meddra_code, combined.meddra_name, combined.smq_name, combined.inhibitor
;




--- LAERS drill down
drop table if exists scratch_rich.tiz_1a2_inh_cell_a_full_laers;
with standardS as (
   select  scoc.isr s_isr,
       string_agg(distinct scoc.drug_concept_id::text, ';') standard_drug_concept_id, 
       string_agg(distinct scoc.outcome_concept_id::text, ';') standard_outcome_concept_id, 
       string_agg(distinct scoc.snomed_outcome_concept_id::text, ';') standard_outcome_snomed_id,
       string_agg(distinct s.concept_code::text, ';') meddra_code,
       string_agg(distinct s.concept_name::text, ';') meddra_name,
       s.smq_name,
       s.inhibitor
   from scratch_rich.tiz_1a2_inh_all_cell_a s  inner join faers.standard_drug_outcome_drilldown scoc on scoc.isr = s.isr   
   group by scoc.isr, s.smq_name, s.inhibitor
 ), combined as ( 
  select 
     drug.*, 
       demo.i_f_cod, demo.event_dt, demo.mfr_dt, demo.fda_dt, demo.rept_cod, demo.mfr_num, demo.mfr_sndr, 
       demo.age, demo.age_cod, demo.gndr_cod, demo.e_sub, demo.wt, demo.wt_cod, demo.rept_dt, demo.to_mfr, demo.occp_cod,
       demo.reporter_country, demo.filename demo_filename,
       standardS.*
    from standardS inner join faers.drug_legacy drug on standardS.s_isr = drug.isr 
       inner join faers.demo_legacy demo on demo.isr = standardS.s_isr
 )
  select null caseid, combined.isr, combined.drug_seq, combined.role_cod, combined.drugname, 
         null prod_ai, 
         string_agg(distinct combined.val_vbm, ';') val_vbm,
         string_agg(distinct combined.route, ';') route,
         string_agg(distinct combined.dose_vbm, ';') dose_vbm,
         null cum_dose_chr, 
         null cum_dose_unit, 
         string_agg(distinct combined.dechal, ';') dechal,
         string_agg(distinct combined.rechal, ';') rechal,
         string_agg(distinct combined.lot_num, ';') lot_num,
         string_agg(distinct combined.exp_dt, ';') exp_dt,
         string_agg(distinct combined.nda_num, ';') nda_num,
         null dose_amt, 
         null dose_unit, 
         null dose_form, 
         null dose_freq, 
         string_agg(distinct combined.filename, ';') filename,
       combined.standard_drug_concept_id, combined.standard_outcome_concept_id, combined.standard_outcome_snomed_id,
       combined.meddra_code, combined.meddra_name, 
       combined.smq_name, combined.inhibitor,
       null caseversion, 
        string_agg(distinct combined.i_f_cod, ';') i_f_cod,
        string_agg(distinct combined.event_dt, ';') event_dt,
        string_agg(distinct combined.mfr_dt, ';') mfr_dt,
        string_agg(distinct combined.fda_dt, ';') init_fda_dt,
        string_agg(distinct combined.rept_cod, ';') rept_cod,
       null auth_num, 
        string_agg(distinct combined.mfr_num, ';') mfr_num,
        string_agg(distinct combined.mfr_sndr, ';') mfr_sndr,
       null lit_ref, 
        string_agg(distinct combined.age, ';') age,
        string_agg(distinct combined.age_cod, ';') age_cod,
       null age_grp, 
        string_agg(distinct combined.gndr_cod, ';') sex,
        string_agg(distinct combined.e_sub, ';') e_sub,
        string_agg(distinct combined.wt, ';') wt,
        string_agg(distinct combined.wt_cod, ';') wt_cod,
        string_agg(distinct combined.rept_dt, ';') rept_dt,
        string_agg(distinct combined.to_mfr, ';') to_mfr,
        string_agg(distinct combined.occp_cod, ';') occp_cod,
        string_agg(distinct combined.reporter_country, ';') reporter_country,
       null occr_country, 
        string_agg(distinct combined.filename, ';') demo_filename,
        string_agg(distinct outc.outc_cod, ';') outc_code, string_agg(distinct outc.filename, ';') outc_filename, 
        string_agg(distinct indi.drug_seq, ';') indi_drug_seq, string_agg(distinct indi.indi_pt, ';') indi_pt, string_agg(distinct indi.filename, ';') indi_filename, 
        string_agg(distinct rpsr.rpsr_cod, ';') rpsr_cod, string_agg(distinct rpsr.filename, ';') rpsr_filename 
  into scratch_rich.tiz_1a2_inh_cell_a_full_laers
  from combined 
   left outer join faers.outc_legacy outc on outc.isr = combined.isr
   left outer join faers.indi_legacy indi on indi.isr = combined.isr and indi.drug_seq = combined.drug_seq
   left outer join faers.rpsr_legacy rpsr on rpsr.isr = combined.isr
  GROUP BY combined.isr, combined.drug_seq, combined.role_cod, combined.drugname,  combined.filename,         
         combined.standard_drug_concept_id, combined.standard_outcome_concept_id, combined.standard_outcome_snomed_id,       
         combined.meddra_code, combined.meddra_name, combined.smq_name, combined.inhibitor        
;
























