-- FAERS exploration for Tizanidine and 1A2 inhibitors

-- SUBSET OF HOIs --
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
      or upper(drug.drug_name_original ) in ('ZANAFLEX','BIZANIDINE','CANAFLEX','DIZANIDINE','FANAFLEX','LANAFLEX','LIZANIDINE','PIZANIDINE','RIZANIDINE','SANAFLEX','SIDALUD','SIDALUD (SIRDALUD)','SIRADALUD','SIRALUD','SIRALUD 2','SIRDALUD (TIZANDINE HYDROCHLORIDE)','SIRDALUD (TYIZANIDINE HYDROCHLORIDE)','SIRDALUD /00740702/ (SIRDALUD - TIZANADINE HYDROCHLORIDE) 2MG (NOT SPE','SIRDALUD /00740702/ (SIRDALUD - TIZANDINE HYDROCHLORIDE) (NOT SPECIFIE','SIRDALUD/00740702/(SIRDALUD TIZANADINE HYDROCHLORIDE)','SIRDALUL','SIRDALUT','TANAFLEX','TAZANIDINE','TAZANIDINE 4MG 2X/DAY','TAZANIDINE HYDROCHLORIDE (TAZANIDINE HYDROCHLORIDE)','TERNALIN','TERNELIN (TERNELIN - TIZANADINE HYDROCHLORIDE)','TERNELIN (TIAZANIDINE HYDROCHLORIDE)','TERNELLIN','THIZANIDINE HCL','TIANIDINE 4 MG','TIAZANIDINE (TIAZANIDINE)','TICANIDINE','TIDANIDINE','TIDANIDINE HYDROCHLORIDE','TIIZANIDINE','TINZANIDINE','TINZANIDINE HYDROCHLORIDE','TIRANIDINE','TISANIDINE','TITANIDINE','TIVANIDINE','TIVANIDINE HCL','TIXANIDINE','TIZAMIDINE','TIZANADINE 4 MG','TIZANADINE HCL','TIZANADINE HCL (UNKNOWN)','TIZANADINE HYDROCHLORIDE','TIZANDIDINE','TIZANDINE 4MG','TIZANDINE 8MG','TIZANDINE HYDROCHLORIDE','TIZANDINE HYDROCHLORIDE (TIZANDINE HYDROCHLORIDE)','TIZANEDINE','TIZANICINE','TIZANIDANE','TIZANIDENE','TIZANIDIE','TIZANIDIN ACTAVIS','TIZANIDIN EOLAPATADINE','TIZANIDIN TEVA 2MG','TIZANIDINE HYDROCHLORIDE (TIZANADINE HYDROCHLORIDE)','TIZANIDINE HYDROCHLORIDE (TIZANTIDINE HYDROCHLORIDE)','TIZANIDINEM','TIZANIDINI HYDROCLORIDUM','TIZANIDINIE','TIZANINDINE','TIZANISINE','TIZANITINE HCL','TIZANNIDINE (ZARAFLEX)','TIZANOIDINE','TIZANTIDINE','TIZATIDINE','TIZENIDINE','TIZENIDINE (UNKNOWN)','TIZIANIDINE','TIZIANIDINE HCL','TIZINIDINE','TIZNIDINE','TIZONIDINE','TRIZANIDINE','TRIZANIDINE HCL','TYZANIDINE','TYZANIDINE MUSCLE RELAXANT','TZANIDINE','XANAFLEX','XANAFLEX 4MG UNKNOWN','XANAFLEX MUSCLE RELAXER','ZAMAFLEX','ZANAFIEX','ZANAFLAX','ZANAFLAX (NOS)','ZANAFLEX (TIZADNIDINE HYDROCHLORIDE)','ZANAFLEX (TIZANDIDINE HYDROCHLORIDE)','ZANAFLEX (TIZANIDFINE HYDROCHLORIDE) (TIZANIDINE HYDROCHLORDIE)','ZANAFLEX (TYZANIDINE HYDROCHLORIDE)','ZANAFLEZ','ZANAFLUX','ZANALLEX','ZANAPLEX','ZANASLEX','ZANEFLEX','ZANFLEX','ZANIFLEX','ZANNAFLEX','ZANOFLEX','ZANTAFLEX','ZEANAFLEX','ZENAFLEX','ZONAFLEX'))
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
into scratch_rich.tiz_stats
from  stats inner join staging_vocabulary.concept c1 on stats.drug_concept_id = c1.concept_id 
  inner join staging_vocabulary.concept c2 on stats.outcome_concept_id = c2.concept_id 
 ;



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
      or upper(drug.drug_name_original ) in ('ZANAFLEX','BIZANIDINE','CANAFLEX','DIZANIDINE','FANAFLEX','LANAFLEX','LIZANIDINE','PIZANIDINE','RIZANIDINE','SANAFLEX','SIDALUD','SIDALUD (SIRDALUD)','SIRADALUD','SIRALUD','SIRALUD 2','SIRDALUD (TIZANDINE HYDROCHLORIDE)','SIRDALUD (TYIZANIDINE HYDROCHLORIDE)','SIRDALUD /00740702/ (SIRDALUD - TIZANADINE HYDROCHLORIDE) 2MG (NOT SPE','SIRDALUD /00740702/ (SIRDALUD - TIZANDINE HYDROCHLORIDE) (NOT SPECIFIE','SIRDALUD/00740702/(SIRDALUD TIZANADINE HYDROCHLORIDE)','SIRDALUL','SIRDALUT','TANAFLEX','TAZANIDINE','TAZANIDINE 4MG 2X/DAY','TAZANIDINE HYDROCHLORIDE (TAZANIDINE HYDROCHLORIDE)','TERNALIN','TERNELIN (TERNELIN - TIZANADINE HYDROCHLORIDE)','TERNELIN (TIAZANIDINE HYDROCHLORIDE)','TERNELLIN','THIZANIDINE HCL','TIANIDINE 4 MG','TIAZANIDINE (TIAZANIDINE)','TICANIDINE','TIDANIDINE','TIDANIDINE HYDROCHLORIDE','TIIZANIDINE','TINZANIDINE','TINZANIDINE HYDROCHLORIDE','TIRANIDINE','TISANIDINE','TITANIDINE','TIVANIDINE','TIVANIDINE HCL','TIXANIDINE','TIZAMIDINE','TIZANADINE 4 MG','TIZANADINE HCL','TIZANADINE HCL (UNKNOWN)','TIZANADINE HYDROCHLORIDE','TIZANDIDINE','TIZANDINE 4MG','TIZANDINE 8MG','TIZANDINE HYDROCHLORIDE','TIZANDINE HYDROCHLORIDE (TIZANDINE HYDROCHLORIDE)','TIZANEDINE','TIZANICINE','TIZANIDANE','TIZANIDENE','TIZANIDIE','TIZANIDIN ACTAVIS','TIZANIDIN EOLAPATADINE','TIZANIDIN TEVA 2MG','TIZANIDINE HYDROCHLORIDE (TIZANADINE HYDROCHLORIDE)','TIZANIDINE HYDROCHLORIDE (TIZANTIDINE HYDROCHLORIDE)','TIZANIDINEM','TIZANIDINI HYDROCLORIDUM','TIZANIDINIE','TIZANINDINE','TIZANISINE','TIZANITINE HCL','TIZANNIDINE (ZARAFLEX)','TIZANOIDINE','TIZANTIDINE','TIZATIDINE','TIZENIDINE','TIZENIDINE (UNKNOWN)','TIZIANIDINE','TIZIANIDINE HCL','TIZINIDINE','TIZNIDINE','TIZONIDINE','TRIZANIDINE','TRIZANIDINE HCL','TYZANIDINE','TYZANIDINE MUSCLE RELAXANT','TZANIDINE','XANAFLEX','XANAFLEX 4MG UNKNOWN','XANAFLEX MUSCLE RELAXER','ZAMAFLEX','ZANAFIEX','ZANAFLAX','ZANAFLAX (NOS)','ZANAFLEX (TIZADNIDINE HYDROCHLORIDE)','ZANAFLEX (TIZANDIDINE HYDROCHLORIDE)','ZANAFLEX (TIZANIDFINE HYDROCHLORIDE) (TIZANIDINE HYDROCHLORDIE)','ZANAFLEX (TYZANIDINE HYDROCHLORIDE)','ZANAFLEZ','ZANAFLUX','ZANALLEX','ZANAPLEX','ZANASLEX','ZANEFLEX','ZANFLEX','ZANIFLEX','ZANNAFLEX','ZANOFLEX','ZANTAFLEX','ZEANAFLEX','ZENAFLEX','ZONAFLEX'))
), meddraStandardMap as (
 select c.concept_id, c.concept_name
 from staging_vocabulary.concept c 
 where c.concept_code in ('10021097','10005734','10042772','10006093','10040560','10016173','10017076','10023572','10052428','10007515','10007617','10047065','10022891','10047065','10007541','10007541','10022117','10022117','10022117','10022117','10007541','10007541')
), contTable as ( 
  select * 
  from faers.standard_drug_outcome_contingency_table dos
  where dos.drug_concept_id in (select distinct standard_concept_id from tizStandardMap)
   and dos.outcome_concept_id in (select distinct concept_id from meddraStandardMap)
  order by dos.drug_concept_id, dos.outcome_concept_id 
)
select c1.concept_name drug_name, c1.concept_code  drug_rxnorm, c2.concept_name meddra_ae_name, c2.concept_code meddra_ae_code, contTable.*
into scratch_rich.tiz_contingency_tab
from  contTable inner join staging_vocabulary.concept c1 on contTable.drug_concept_id = c1.concept_id 
  inner join staging_vocabulary.concept c2 on contTable.outcome_concept_id = c2.concept_id
 ;


select c.concept_name meddra_ae_name, c.concept_code meddra_ae, c.concept_id omop_ohdsi_ae
from staging_vocabulary.concept c 
where c.concept_code in ('10021097','10005734','10042772','10006093','10040560','10016173','10017076','10023572','10052428','10007515','10007617','10047065','10022891','10047065','10007541','10007541','10022117','10022117','10022117','10022117','10007541','10007541')
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
), drug_cnt as (
  select d2.primaryid, d2.caseid, max(d2.drug_seq::int) max_drug_ct
  from faers.drug d2 
  group by d2.primaryid, d2.caseid
)
   select distinct drug.caseid
   into scratch_rich.tizSpecific
   from faers.drug drug inner join drug_cnt on drug.primaryid = drug_cnt.primaryid and drug.caseid = drug_cnt.caseid
   where  drug.role_cod in ('SS','PS')
     and drug_cnt.max_drug_ct > 1
     and 
     (
      upper(drug.drugname) in (select * from tizs)
      or upper(drug.drugname) in ('ZANAFLEX','BIZANIDINE','CANAFLEX','DIZANIDINE','FANAFLEX','LANAFLEX','LIZANIDINE','PIZANIDINE','RIZANIDINE','SANAFLEX','SIDALUD','SIDALUD (SIRDALUD)','SIRADALUD','SIRALUD','SIRALUD 2','SIRDALUD (TIZANDINE HYDROCHLORIDE)','SIRDALUD (TYIZANIDINE HYDROCHLORIDE)','SIRDALUD /00740702/ (SIRDALUD - TIZANADINE HYDROCHLORIDE) 2MG (NOT SPE','SIRDALUD /00740702/ (SIRDALUD - TIZANDINE HYDROCHLORIDE) (NOT SPECIFIE','SIRDALUD/00740702/(SIRDALUD TIZANADINE HYDROCHLORIDE)','SIRDALUL','SIRDALUT','TANAFLEX','TAZANIDINE','TAZANIDINE 4MG 2X/DAY','TAZANIDINE HYDROCHLORIDE (TAZANIDINE HYDROCHLORIDE)','TERNALIN','TERNELIN (TERNELIN - TIZANADINE HYDROCHLORIDE)','TERNELIN (TIAZANIDINE HYDROCHLORIDE)','TERNELLIN','THIZANIDINE HCL','TIANIDINE 4 MG','TIAZANIDINE (TIAZANIDINE)','TICANIDINE','TIDANIDINE','TIDANIDINE HYDROCHLORIDE','TIIZANIDINE','TINZANIDINE','TINZANIDINE HYDROCHLORIDE','TIRANIDINE','TISANIDINE','TITANIDINE','TIVANIDINE','TIVANIDINE HCL','TIXANIDINE','TIZAMIDINE','TIZANADINE 4 MG','TIZANADINE HCL','TIZANADINE HCL (UNKNOWN)','TIZANADINE HYDROCHLORIDE','TIZANDIDINE','TIZANDINE 4MG','TIZANDINE 8MG','TIZANDINE HYDROCHLORIDE','TIZANDINE HYDROCHLORIDE (TIZANDINE HYDROCHLORIDE)','TIZANEDINE','TIZANICINE','TIZANIDANE','TIZANIDENE','TIZANIDIE','TIZANIDIN ACTAVIS','TIZANIDIN EOLAPATADINE','TIZANIDIN TEVA 2MG','TIZANIDINE HYDROCHLORIDE (TIZANADINE HYDROCHLORIDE)','TIZANIDINE HYDROCHLORIDE (TIZANTIDINE HYDROCHLORIDE)','TIZANIDINEM','TIZANIDINI HYDROCLORIDUM','TIZANIDINIE','TIZANINDINE','TIZANISINE','TIZANITINE HCL','TIZANNIDINE (ZARAFLEX)','TIZANOIDINE','TIZANTIDINE','TIZATIDINE','TIZENIDINE','TIZENIDINE (UNKNOWN)','TIZIANIDINE','TIZIANIDINE HCL','TIZINIDINE','TIZNIDINE','TIZONIDINE','TRIZANIDINE','TRIZANIDINE HCL','TYZANIDINE','TYZANIDINE MUSCLE RELAXANT','TZANIDINE','XANAFLEX','XANAFLEX 4MG UNKNOWN','XANAFLEX MUSCLE RELAXER','ZAMAFLEX','ZANAFIEX','ZANAFLAX','ZANAFLAX (NOS)','ZANAFLEX (TIZADNIDINE HYDROCHLORIDE)','ZANAFLEX (TIZANDIDINE HYDROCHLORIDE)','ZANAFLEX (TIZANIDFINE HYDROCHLORIDE) (TIZANIDINE HYDROCHLORDIE)','ZANAFLEX (TYZANIDINE HYDROCHLORIDE)','ZANAFLEZ','ZANAFLUX','ZANALLEX','ZANAPLEX','ZANASLEX','ZANEFLEX','ZANFLEX','ZANIFLEX','ZANNAFLEX','ZANOFLEX','ZANTAFLEX','ZEANAFLEX','ZENAFLEX','ZONAFLEX')
     )
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
       demo.caseversion, demo.i_f_code, demo.event_dt, demo.mfr_dt, demo.init_fda_dt, demo.fda_dt, demo.rept_cod, demo.auth_num, demo.mfr_num, demo.mfr_sndr, demo.lit_ref, 
       demo.age, demo.age_cod, demo.age_grp, demo.sex, demo.e_sub, demo.wt, demo.wt_cod, demo.rept_dt, demo.to_mfr, demo.occp_cod,
       demo.reporter_country, demo.occr_country, demo.filename demo_filename, 
       string_agg(distinct indi.indi_drug_seq, ';') indi_drug_seq, string_agg(distinct indi.indi_pt, ';') indi_pt, indi.filename indi_filename, 
       string_agg(distinct rpsr.rpsr_cod, ';') rpsr_cod, rpsr.filename rpsr_filename 
into scratch_rich.tiz_reports
from faers.drug drug inner join scratch_rich.standardSummary on drug.primaryid = standardSummary.primaryid
   inner join faers.demo demo on demo.primaryid = standardSummary.primaryid
   left outer join faers.standard_case_outcome_category scoc on scoc.primaryid = standardSummary.primaryid
   left outer join faers.indi indi on indi.primaryid = standardSummary.primaryid and indi.indi_drug_seq = drug.drug_seq
   left outer join faers.rpsr rpsr on rpsr.primaryid = standardSummary.primaryid
GROUP BY drug.primaryid, drug.caseid, drug.drug_seq, drug.role_cod, drug.drugname, drug.prod_ai, drug.val_vbm, drug.route, drug.dose_vbm, drug.cum_dose_chr, drug.cum_dose_unit, drug.dechal, drug.rechal, drug.lot_num, drug.exp_dt, drug.nda_num, drug.dose_amt, drug.dose_unit, drug.dose_form, drug.dose_freq, drug.filename,         
         demo.caseversion, demo.i_f_code, demo.event_dt, demo.mfr_dt, demo.init_fda_dt, demo.fda_dt, demo.rept_cod, demo.auth_num, demo.mfr_num, demo.mfr_sndr, demo.lit_ref, demo.age, demo.age_cod, demo.age_grp, demo.sex, demo.e_sub, demo.wt, demo.wt_cod, demo.rept_dt, demo.to_mfr, demo.occp_cod, demo.reporter_country, demo.occr_country, demo.filename, 
         indi.filename,
         rpsr.filename
ORDER BY drug.primaryid, drug.drug_seq::integer
;


-- 1A2 inhibitors --

-- Query the standardized drug - outcome count tables using the drug concept ids for all reports involving ciprofloxacine and 1 character name variations
--- 1. obtain the case ids for reports mentioning the drug names
drop table if exists scratch_rich.cyp1a2InhSpecific;
with  cipInh as (
  select distinct upper(d.drugname)
  from faers.drug d 
  where 
    upper(d.drugname) like '%CIPROFLOXACIN%'
    or upper(d.drugname) like '%CILOXAN%'
	or upper(d.drugname) like '%CIPRO HC%'
	or upper(d.drugname) like '%CIPRODEX%'
	or upper(d.drugname) like '%PROQUIN%'
	or upper(d.drugname) like '%CETRAXAL%'
	or upper(d.drugname) like '%OTIPRIO%'
	or upper(d.drugname) like '%OTOVEL%'
	or upper(d.drugname) like '%CLINAFLOXACIN%'
	or upper(d.drugname) like '%ENOXACIN%'
	or upper(d.drugname) like '%FLUVOXAMINE%'
	or upper(d.drugname) like '%LUVOX%'
	or upper(d.drugname) like '%METHOXSALEN%'
	or upper(d.drugname) like '%OXSORALEN%'
	or upper(d.drugname) like '%UVADEX%'
	or upper(d.drugname) like '%MEXILETINE%'
	or upper(d.drugname) like '%PHENYLPROPANOLAMINE%'
	or upper(d.drugname) like '%PIPEMIDIC ACID%'
	or upper(d.drugname) like '%PIPERINE%'
	or upper(d.drugname) like '%ROFECOXIB%'
	or upper(d.drugname) like '%VIOXX%'
	or upper(d.drugname) like '%VEMURAFENIB%'
	or upper(d.drugname) like '%ZELBORAF%'
	or upper(d.drugname) like '%ACCOLATE%'
	or upper(d.drugname) like '%ZAFIRLUKAST%'
	or upper(d.drugname) like '%ZILEUTON%'
	or upper(d.drugname) like '%ZYFLO%'
	or upper(d.drugname) like '%ETHINYL ESTRADIOL%'
   	or upper(d.drugname) in ('AFIRMELLE','ALTAVERA','ALYACEN','AMETHIA','AMETHIA LO','AMETHYST','ANNOVERA','APRI','ARANELLE','ASHLYNA','AUBRA','AUROVELA','AUROVELA FE','AVIANE','AYUNA','AZURETTE','BALCOLTRA','BALZIVA','BEKYREE','BEYAZ','BLISOVI','BREVICON','BRIELLYN','CAMRESE','CAMRESELO','CAZIANT','CESIA','CHARLOTTE','CHATEAL','CRYSELLE','CYCLAFEM','CYCLESSA','CYRED','DASETTA','DAYSEE','DELYLA','DEMULEN','DESOGEN','ELINEST','ELURYNG','EMOQUETTE','ENPRESSE','ENSKYCE','ESTARYLLA','ESTROSTEP FE','FALMINA','FAYOSIM','FEMCON FE','FEMHRT','FEMHRT','FEMYNOR','FYAVOLV','GENERESS FE','GIANVI','GILDAGIA','HAILEY','HAILEY FE','ICLEVIA','INTROVALE','ISIBLOOM','JAIMIESS','JASMIEL','JEVANTIQUE','JINTELI','JOLESSA','JULEBER','JUNEL','JUNEL FE','KAITLIB FE','KALLIGA','KARIVA','KELNOR','KIMIDESS','KURVELO','LARIN','LARIN FE','LARISSIA','LAYOLIS FE','LEENA','LESSINA','LEVLEN','LEVONEST','LEVORA','LILLOW','LO LOESTRIN FE','LO SIMPESSE','LO-ZUMANDIMINE','LO/OVRAL','LOESTRIN','LOESTRIN FE','LOJAIMIESS','LOMEDIA','LORYNA','LOSEASONIQUE','LOW-OGESTREL','LUTERA','LYBREL','MARLISSA','MELODETTA','MIBELAS','MICROGESTIN','MICROGESTIN FE','MILI','MINASTRIN','MIRCETTE','MODICON','MONO-LINYAH','MONONESSA','MYZILRA','NECON','NECON','NEXESTA FE','NIKKI','NORINYL','NORTREL','NUVARING','NYLIA','OCELLA','OGESTREL','ORSYTHIA','ORTHO TRI-CYCLEN','ORTHO TRI-CYCLEN LO','ORTHO-CEPT','ORTHO-CYCLEN','ORTHO-NOVUM','OVCON','PHILITH','PIMTREA','PIRMELLA','PORTIA','PREVIFEM','QUARTETTE','QUASENSE','RAJANI','RECLIPSEN','RIVELSA','SAFYRAL','SEASONALE','SEASONIQUE','SETLAKIN','SIMLIYA','SIMPESSE','SOLIA','SPRINTEC','SRONYX','SYEDA','TARINA','TARINA FE','TAYTULLA','TILIA FE','TRI FEMYNOR','TRI-ESTARYLLA','TRI-LEGEST FE','TRI-LINYAH','TRI-LO- ESTARYLLA','TRI-LO-MARZIA','TRI-LO-MILI','TRI-LO-SPRINTEC','TRI-MILI','TRI-NORINYL','TRI-PREVIFEM','TRI-SPRINTEC','TRI-VYLIBRA','TRI-VYLIBRA LO','TRINESSA','TRINESSA LO','TRIVORA','TWIRLA','TWIRLA','TYDEMY','VELIVET','VESTURA','VIENVA','VIORELE','VOLNEA','VYFEMLA','VYLIBRA','WERA','WYMZYA FE','XULANE','YASMIN','YAZ','ZARAH','ZENCHENT','ZENCHENT FE','ZOVIA','ZUMANDIMINE')
)
   select distinct d.caseid
   into scratch_rich.cyp1a2InhSpecific
   from faers.drug d 
   where upper(d.drugname) in (select * from cipInh)
   	or levenshtein(left(upper(d.drugname), 255),'CIPROFLOXACIN') = 1
	or levenshtein(left(upper(d.drugname), 255),'CLINAFLOXACIN') = 1
	or levenshtein(left(upper(d.drugname), 255),'FLUVOXAMINE') = 1
	or levenshtein(left(upper(d.drugname), 255),'METHOXSALEN') = 1
	or levenshtein(left(upper(d.drugname), 255),'OXSORALEN') = 1
	or levenshtein(left(upper(d.drugname), 255),'MEXILETINE') = 1
	or levenshtein(left(upper(d.drugname), 255),'PHENYLPROPANOLAMINE') = 1
	or levenshtein(left(upper(d.drugname), 255),'PIPEMIDIC ACID') = 1
	or levenshtein(left(upper(d.drugname), 255),'PIPERINE') = 1
	or levenshtein(left(upper(d.drugname), 255),'ROFECOXIB') = 1
	or levenshtein(left(upper(d.drugname), 255),'VEMURAFENIB') = 1
	or levenshtein(left(upper(d.drugname), 255),'ZELBORAF') = 1
	or levenshtein(left(upper(d.drugname), 255),'ACCOLATE') = 1
	or levenshtein(left(upper(d.drugname), 255),'ZAFIRLUKAST') = 1
	or levenshtein(left(upper(d.drugname), 255),'ZILEUTON') = 1
	or levenshtein(left(upper(d.drugname), 255),'ETHINYL ESTRADIOL') = 1
 ;
 CREATE INDEX cyp1a2InhSpecific_caseid_idx ON scratch_rich.cyp1a2InhSpecific USING btree (caseid)

 
 --- subset the tizanidine reports to those that also include the purported 1A2 inhibitors
select distinct cr.*
into scratch_rich.tiz_reports_cyp1a2
from scratch_rich.tiz_reports cr inner join scratch_rich.cyp1a2InhSpecific 
     on cr.caseid = cyp1a2InhSpecific.caseid
;
 