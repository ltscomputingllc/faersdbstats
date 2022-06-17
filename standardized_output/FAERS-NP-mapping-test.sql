-- Create a  table with the URI to the structurally diverse substances in G-SRS, the name of the substance of a child of the substance in G-SRS, 
-- and a preferred common name. Rows are appended to this table that have the the URI to the structurally diverse substances in G-SRS, 
-- an alternative common name (one per row), and the preferred common name. Additional rows are appended that have the the URI to the 
-- structurally diverse substances in G-SRS, a constituent of the structurally diverse substance (one per row), and the preferred common name.

-- NOTE: database needs to be g_substance_reg !!!
select max(ltcnt.common_name), test_srs_np.* 
from  scratch_sanya.test_srs_np inner join scratch_sanya.lb_to_common_names_tsv ltcnt on upper(test_srs_np.related_latin_binomial) = upper(ltcnt.latin_binomial)
where related_common_name = ''
;

select *
from (
 select substance_uuid, name, related_latin_binomial, 
        max(case when related_common_name = '' then ltcnt.common_name 
             else related_common_name
        end) related_common_name
 from scratch_sanya.test_srs_np inner join scratch_sanya.lb_to_common_names_tsv ltcnt on upper(test_srs_np.related_latin_binomial) = upper(ltcnt.latin_binomial)
 group by substance_uuid, name, related_latin_binomial
 union
 select substance_uuid, constituent_name, related_latin_binomial, 
         max(case when related_common_name = '' then ltcnt.common_name 
             else related_common_name
         end) related_common_name
 from scratch_sanya.test_srs_np_constituent tsnc inner join scratch_sanya.lb_to_common_names_tsv ltcnt on upper(tsnc.related_latin_binomial) = upper(ltcnt.latin_binomial)
 group by substance_uuid, constituent_name, related_latin_binomial
 union 
 select test_srs_np.substance_uuid, upper(ltcnt.common_name) common_name, related_latin_binomial, 
	     max(case when related_common_name = '' then ltcnt.common_name 
             else related_common_name
         end) related_common_name
 from scratch_sanya.test_srs_np inner join scratch_sanya.lb_to_common_names_tsv ltcnt on upper(test_srs_np.related_latin_binomial) = upper(ltcnt.latin_binomial)
 group by test_srs_np.substance_uuid, upper(ltcnt.common_name), related_latin_binomial
 ) t
 where related_common_name != '' and related_common_name is not null
 order by substance_uuid 
;


--- Test of using SRS concepts to map NPs in FAERS ---
select max(concept_id)
from staging_vocabulary

-- 3/26/21 -- needed to add these to the Concept table b/c they did not make it from SRS -- Not needed on 7/31/21
/*begin;
INSERT INTO staging_vocabulary.concept (concept_id, concept_name, domain_id, vocabulary_id, concept_class_id, standard_concept, concept_code, valid_start_date, valid_end_date, invalid_reason) 
    VALUES (-7984559, 'Green tea [Camellia sinensis]', 'NaPDI research', 'NAPDI', 'Green tea', '', 'af94397b-1888-4333-bdea-f0a868cb5a3e', '2000-01-01', '2099-02-22', '');

INSERT INTO staging_vocabulary.concept (concept_id, concept_name, domain_id, vocabulary_id, concept_class_id, standard_concept, concept_code, valid_start_date, valid_end_date, invalid_reason) 
    VALUES (-7984558, 'Kratom [Mitragyna speciosa]', 'NaPDI research', 'NAPDI', 'Kratom', '', 'c31862da-077c-4e8a-acb1-ffecc1542307', '2000-01-01', '2099-02-22', '');
   
INSERT INTO staging_vocabulary.concept (concept_id, concept_name, domain_id, vocabulary_id, concept_class_id, standard_concept, concept_code, valid_start_date, valid_end_date, invalid_reason) 
    VALUES (-7984557, 'Mitragynine [Mitragyna speciosa]', 'NaPDI research', 'NAPDI', 'Kratom', '', 'c31862da-077c-4e8a-acb1-ffecc1542307', '2000-01-01', '2099-02-22', ''); 
end;*/

-- how well did we get SRS concepts 
select *
from staging_vocabulary.concept c 
where c.concept_class_id = 'Licorice'
;

select *
from staging_vocabulary.concept c 
where c.concept_class_id = 'Green tea'
;

select *
from staging_vocabulary.concept c 
where c.concept_class_id = 'Hemp extract'
; 

select *
from staging_vocabulary.concept c 
where c.concept_class_id = 'Cinnamon'
; 

select *
from staging_vocabulary.concept c 
where c.concept_class_id = 'Goldenseal'
;

select *
from staging_vocabulary.concept c 
where c.concept_class_id = 'Kratom'
;



--- testing if we can get back the reports with unmapped drug strings
select *
from faers.combined_drug_mapping d 
where upper(d.drug_name_original) = 'BALLOTA NIGRA EXTRACT/COLA NITIDA/COLA NITIDA LEAF/CRATAEGUS LAEVIGATA EXTRACT/PASSIFLORA INCARNATA '
;

select *
from faers.drug_legacy d 
where d.drugname = 'BALLOTA NIGRA EXTRACT/COLA NITIDA/COLA NITIDA LEAF/CRATAEGUS LAEVIGATA EXTRACT/PASSIFLORA INCARNATA'
;



--------------------------------------------------------------

-- map from NPs loaded into the vocabulary to drug strings in the reports
---- the regex fixes quotes and removes bracketed and parenthetical parts
drop table if exists  scratch_rich.np_names_clean;
drop table if exists  scratch_rich.upper_unmap_orig_drug_names;
drop table if exists scratch_rich.faers_drug_to_np;

select max(c.concept_id) as concept_id, 
       TRIM(both from upper(regexp_replace(regexp_replace(regexp_replace(c.concept_name, '\[.*\]','','g'), '\(.*\)','','g'),'''''','''','g'))) as np_name
into scratch_rich.np_names_clean
 from staging_vocabulary.concept c 
 where c.concept_id >= -7999999
  and c.concept_id <= -7000000
 group by np_name
;
CREATE INDEX np_names_clean_np_name_idx ON scratch_rich.np_names_clean (np_name);
CREATE INDEX np_names_clean_concept_id_idx ON scratch_rich.np_names_clean (concept_id);

 select distinct TRIM(both from UPPER(c.drug_name_original)) drug_name_original
 into scratch_rich.upper_unmap_orig_drug_names
 from faers.combined_drug_mapping c
 where c.concept_id is null
 ;
CREATE INDEX upper_unmap_orig_drug_names_drug_name_original_idx ON scratch_rich.upper_unmap_orig_drug_names (drug_name_original);

select cdm.drug_name_original, np_lb.concept_id, np_lb.np_name
into scratch_rich.faers_drug_to_np
from scratch_rich.upper_unmap_orig_drug_names cdm inner join scratch_rich.np_names_clean np_lb on 
  cdm.drug_name_original like '%' || np_lb.np_name || '%'
;
CREATE INDEX faers_drug_to_np_drug_name_original_idx ON scratch_rich.faers_drug_to_np (drug_name_original);
CREATE INDEX faers_drug_to_np_np_name_idx ON scratch_rich.faers_drug_to_np (np_name);


-- older approach - too slow!
-- drop table if exists scratch_rich.faers_drug_to_np;
--with np_lb as ( 
--select max(c.concept_id) as concept_id, 
--       regexp_replace(regexp_replace(regexp_replace(c.concept_name, '\[.*\]','','g'), '\(.*\)','','g'),'''''','''','g') as np_name
-- from staging_vocabulary.concept c 
-- where c.concept_id >= -7999999
--  and c.concept_id <= -7000000
-- group by np_name
--), cdm as ( 
-- select distinct UPPER(c.drug_name_original) drug_name_original
-- from faers.combined_drug_mapping c
-- where c.concept_id is null
--) 
--select cdm.drug_name_original, np_lb.concept_id, np_lb.np_name
--into scratch_rich.faers_drug_to_np
--from cdm cross join np_lb
--where 
--  cdm.drug_name_original similar to concat('%', upper(np_lb.np_name), '%')
--  or 
--  cdm.drug_name_original = upper(np_lb.np_name)
--;
--CREATE INDEX faers_drug_to_np_drug_name_original_idx ON scratch_rich.faers_drug_to_np (drug_name_original);
--CREATE INDEX faers_drug_to_np_np_name_idx ON scratch_rich.faers_drug_to_np (np_name);


-- Test query showing that we have  the common nome, L.B., and NP constituents
select max(c.concept_id) as concept_id, 
       regexp_replace(regexp_replace(regexp_replace(c.concept_name, '\[.*\]','','g'), '\(.*\)','','g'),'''''','''','g') as np_name
 from staging_vocabulary.concept c 
 where c.concept_id >= -7999999
  and c.concept_id <= -7000000
  and (concept_name like '%MITRAG%'
       or concept_name like '%KRAT%')
 group by np_name
 ;
/*-7993824	"7-HYDROXYMITRAGYNINE" 
-7994038	KRATOM 
-7994037	KRATUM 
-7994035	MITRAGYNA SPECIOSA 
-7994036	MITRAGYNA SPECIOSA  HAVIL. 
-7994034	MITRAGYNA SPECIOSA WHOLE 
-7993823	MITRAGYNINE */

-- Now, we can create the equivalent to standard_case_drug for NPs
-- NOTE: because this seems to map to multiple SRS names, we could be mapping to the incorrect species 
-- we will need to address the abiguiity in the next iteration
drop table if exists scratch_rich.standard_case_np;
select primaryid, isr, drug_seq, role_cod, max(ftonp.concept_id) as standard_concept_id
into scratch_rich.standard_case_np
from faers.combined_drug_mapping cdm inner join scratch_rich.faers_drug_to_np ftonp on 
            cdm.drug_name_original = ftonp.drug_name_original or cdm.drug_name_original = ftonp.np_name 
--          (upper(TRIM(BOTH from cdm.drug_name_original)) = upper(TRIM(BOTH from ftonp.drug_name_original)) 
--           or 
--           upper(TRIM(BOTH from cdm.drug_name_original)) = upper(TRIM(BOTH from ftonp.np_name))
--          )
group by primaryid, isr, drug_seq, role_cod
;
CREATE INDEX faers_standard_case_np_concept_id_idx ON scratch_rich.standard_case_np (standard_concept_id);
CREATE INDEX faers_standard_case_np_primaryid_idx ON scratch_rich.standard_case_np (primaryid);


-- Test query to return all reports with any mention of Kratom by common name, L.B., or consitituent
-- This query uses the concept_class that all of the above should be mapped to
select *
from scratch_rich.standard_case_np scn inner join staging_vocabulary.concept c on scn.standard_concept_id = c.concept_id 
where c.concept_class_id = 'Kratom'
;

--  427 from FAERS and 10 from LAERS
select count(distinct primaryid)
--select count(distinct isr)
from scratch_rich.standard_case_np scn inner join staging_vocabulary.concept c on scn.standard_concept_id = c.concept_id 
where c.concept_class_id = 'Kratom'
  and primaryid is not null
 -- and isr is not null
;

select *
from scratch_rich.standard_case_np scn inner join staging_vocabulary.concept c on scn.standard_concept_id = c.concept_id 
 inner join faers.drug d on d.primaryid = scn.primaryid 
where c.concept_class_id = 'Kratom'
 and scn.primaryid is not null
order by scn.primaryid, scn.drug_seq::integer 
;

-- 330 from FAERS and 10 from LAERS
-- select count(distinct primaryid)
select count(distinct isr)
from scratch_rich.standard_case_np scn inner join staging_vocabulary.concept c on scn.standard_concept_id = c.concept_id 
where c.concept_class_id = 'Hemp extract'
 -- and primaryid is not null
and isr is not null
;

select *
from scratch_rich.standard_case_np scn inner join staging_vocabulary.concept c on scn.standard_concept_id = c.concept_id 
 inner join faers.drug d on d.primaryid = scn.primaryid 
where c.concept_class_id = 'Hemp extract'
 and scn.primaryid is not null
 and d.drugname like '%MARIJ%'
order by scn.primaryid, scn.drug_seq::integer 
;


-- 10 from LAERS
select count(distinct isr)
from scratch_rich.standard_case_np scn inner join staging_vocabulary.concept c on scn.standard_concept_id = c.concept_id 
where c.concept_class_id = 'Kratom'
 and isr is not null
;


select *
from scratch_rich.standard_case_np scn inner join staging_vocabulary.concept c on scn.standard_concept_id = c.concept_id 
 inner join faers.drug_legacy d on d.isr = scn.isr  
where c.concept_class_id = 'Kratom'
 and d.isr is not null
order by scn.primaryid, scn.drug_seq::integer 
;


-- 15 for FAERS and 4 for LAERS
-- select count(distinct isr)
select count(distinct primaryid)
from scratch_rich.standard_case_np scn inner join staging_vocabulary.concept c on scn.standard_concept_id = c.concept_id 
where c.concept_class_id = 'Goldenseal'
 and primaryid is not null
--and isr is not null
;


--------
select * 
from scratch_rich.standard_np_outcome_contingency_table snoct 
where snoct.drug_concept_id in (-7993824,-7994038,-7994037,-7994035,-7994036,-7994034,-7993823)
and outcome_concept_id = 35104161
;
/*
 * -7994038	35104161	6	982	303	690997
 * -7994035	35104161	1	110	308	691869
 */
-- Compare to 
select * 
from scratch_rich.standard_np_class_outcome_contingency_table snoct 
where snoct.np_class_id = 'Kratom'
and outcome_concept_id = 35104161
;
-- Kratom	35104161	7	1454	302	690525 

------------------------
select c1.concept_name np, c2.concept_name outcome, snos.* 
from scratch_rich.standard_np_outcome_statistics snos 
   inner join staging_vocabulary.concept c1 on snos.drug_concept_id = c1.concept_id 
   inner join staging_vocabulary.concept c2 on snos.outcome_concept_id = c2.concept_id 
where snos.drug_concept_id in (-7993824,-7994038,-7994037,-7994035,-7994036,-7994034,-7993823)
 and ror_95_percent_lower_confidence_limit >= 2.0 
 and case_count >= 10
order by snos.case_count desc
;

/*
 KRATOM [Mitragyna speciosa]	Death	-7994038	35809059		83	24.04754	29.65852	19.49807	26.16129	32.87100	20.82118
MITRAGYNINE [Mitragyna speciosa]	Toxicity to various agents	-7993823	42889647		71	94.64300	117.27809	76.37657	117.89004	153.65048	90.45245
KRATOM [Mitragyna speciosa]	Toxicity to various agents	-7994038	42889647		54	25.68566	33.45631	19.71984	27.11288	35.83993	20.51088
MITRAGYNINE [Mitragyna speciosa]	Drug interaction	-7993823	35809310		28	13.34377	19.06683	9.33853	14.39430	21.19800	9.77431
KRATOM [Mitragyna speciosa]	Accidental death	-7994038	35809056		27	497.15267	810.99879	304.76097	511.09245	840.43773	310.80886
KRATOM [Mitragyna speciosa]	Drug dependence	-7994038	36919128		19	22.01032	34.60162	14.00091	22.42228	35.55404	14.14069
MITRAGYNINE [Mitragyna speciosa]	Unresponsive to stimuli	-7993823	36718371		19	99.26000	155.54570	63.34182	104.78349	168.18982	65.28088
KRATOM [Mitragyna speciosa]	Seizure	-7994038	36776613		15	17.84940	29.68497	10.73274	18.10915	30.34842	10.80588
MITRAGYNINE [Mitragyna speciosa]	Pulmonary oedema	-7993823	35205259		14	39.26852	65.97405	23.37308	40.83050	70.03720	23.80349
MITRAGYNA SPECIOSA [WHO-DD] [Mitragyna speciosa]	Drug abuse	-7994035	36919127		14	99.77326	163.53741	60.87111	114.02920	200.48191	64.85701
MITRAGYNINE [Mitragyna speciosa]	Drug abuse	-7993823	36919127		14	31.01091	52.04192	18.47889	32.23585	55.23473	18.81334
KRATOM [Mitragyna speciosa]	Drug withdrawal syndrome	-7994038	35809369		13	15.54881	26.84402	9.00630	15.74279	27.37345	9.05386
MITRAGYNINE [Mitragyna speciosa]	Pulmonary congestion	-7993823	35205258		10	74.54546	138.99547	39.97991	76.66493	145.44035	40.41184
 */


select snos.np_class_id, c1.concept_name outcome, snos.* 
from scratch_rich.standard_np_class_outcome_statistics snos 
   inner join staging_vocabulary.concept c1 on snos.outcome_concept_id = c1.concept_id 
where snos.np_class_id = 'Kratom'
 and ror_95_percent_lower_confidence_limit >= 2.0 
 and case_count >= 10
order by snos.case_count desc
;

/*
Kratom	Toxicity to various agents	Kratom	42889647	134	45.55088	53.97506	38.44151	50.04961	60.23785	41.58455
Kratom	Death	Kratom	35809059	95	18.69343	22.79794	15.32788	19.92394	24.62373	16.12117
Kratom	Drug interaction	Kratom	35809310	38	4.42892	6.07052	3.23124	4.52048	6.24803	3.27060
Kratom	Drug abuse	Kratom	36919127	34	18.80321	26.38821	13.39843	19.22739	27.19421	13.59453
Kratom	Accidental death	Kratom	35809056	34	518.60454	841.47987	319.61628	530.93709	866.22242	325.42934
Kratom	Unresponsive to stimuli	Kratom	36718371	24	31.00625	46.71096	20.58163	31.50740	47.77228	20.78017
Kratom	Drug dependence	Kratom	36919128	24	18.94539	28.39856	12.63894	19.24510	29.03628	12.75556
Kratom	Seizure	Kratom	36776613	21	17.06143	26.28868	11.07292	17.29566	26.81255	11.15671
Kratom	Pulmonary oedema	Kratom	35205259	17	11.68368	18.85266	7.24080	11.80946	19.16086	7.27855
Kratom	Drug withdrawal syndrome	Kratom	35809369	14	11.33533	19.21146	6.68818	11.43533	19.47798	6.71357
Kratom	Cardiac arrest	Kratom	35204966	13	4.87856	8.40509	2.83166	4.91338	8.50619	2.83809
Kratom	Cardio-respiratory arrest	Kratom	35204970	12	8.90760	15.73207	5.04354	8.97309	15.92132	5.05714
Kratom	Pulmonary congestion	Kratom	35205258	11	20.08223	36.63592	11.00822	20.22700	37.06212	11.03907
Kratom	Accidental overdose	Kratom	36211491	10	13.24497	24.77772	7.08012	13.32936	25.04072	7.09531
Kratom	Withdrawal syndrome	Kratom	35809377	10	15.10688	28.29496	8.06567	15.20410	28.59690	8.08356
 */


select snos.np_class_id, c1.concept_name outcome, snos.* 
from scratch_rich.standard_np_class_outcome_statistics snos 
   inner join staging_vocabulary.concept c1 on snos.outcome_concept_id = c1.concept_id 
where snos.np_class_id like '%thistle%'
 and ror_95_percent_lower_confidence_limit >= 2.0 
 and case_count >= 10
order by snos.case_count desc
;

-- select count(distinct isr)
-- select count(distinct primaryid)
select distinct c.concept_name, c.concept_class_id 
from scratch_rich.standard_case_np scn inner join staging_vocabulary.concept c on scn.standard_concept_id = c.concept_id 
where c.concept_class_id like '%thistle%'
 and primaryid is not null
--and isr is not null
;



 select snos.np_class_id, c1.concept_name outcome, snos.* 
 from scratch_rich.standard_np_class_outcome_statistics snos 
   inner join staging_vocabulary.concept c1 on snos.outcome_concept_id = c1.concept_id 
 where ror_95_percent_lower_confidence_limit >= 2.0 
 and case_count >= 10
 order by snos.ror desc
;

select distinct t.np_class_id from (
 select snos.* 
 from scratch_rich.standard_np_class_outcome_statistics snos 
   inner join staging_vocabulary.concept c1 on snos.outcome_concept_id = c1.concept_id 
 where ror_95_percent_lower_confidence_limit >= 2.0 
 and case_count >= 10
 order by snos.ror desc
) t
;

select distinct t.concept_name from (
 select c1.concept_name, snos.* 
 from scratch_rich.standard_np_class_outcome_statistics snos 
   inner join staging_vocabulary.concept c1 on snos.outcome_concept_id = c1.concept_id 
 where ror_95_percent_lower_confidence_limit >= 2.0 
 and case_count >= 10
 order by snos.ror desc
) t
;

select *
from scratch_rich.standard_np_outcome_drilldown snod 
where snod.np_class_id = 'Kratom'
;

----------------------------------------------------------------------------------
select *
from scratch_rich.standard_case_np inner join staging_vocabulary.concept c on standard_case_np.standard_concept_id = c.concept_id 
order by primaryid, isr, drug_seq
;

-- some quick counts
select c.concept_class_id, count(*) cnt
from scratch_rich.standard_case_np inner join staging_vocabulary.concept c on standard_case_np.standard_concept_id = c.concept_id
where c.concept_class_id != 'NEEDS COMMON NAME'
group by c.concept_class_id
order by cnt desc 
;
/*
Turmeric	1227
Flax seed	1167
Cinnamon	872
Saw Palmetto	581
Ginkgo	491
Hemp extract	286
Valerian	286
Green tea	275
St. John's Wort	264
Licorice	178
Aloe vera	166
Horse Chestnut	164
Garcinia	163
Echinacea angustifolia	136
Dandelion	85
Cumin	68
Kratom	65
Chamomile (not specified)	55
Ragweed	53
Fenugreek	39
Goldenseal	37
Bladderwrack	26
Gentian Root	25
Feverfew	23
cola nut	22
Rose Hip	21
Beet root	20
Wild Yam	15
English Walnut	11
Yohimbe	9
Black pepper	9
Yerba Mate	9
Elderberry	8
Parsley	8
Ivy leaf	6
Wormwood	5
Spearmint	5
Echinacea purpurea	5
Horehound	5
onion	4
Peach	4
Catnip	3
Kale	2
Bloodroot	2
Coptis	1
Goat's rue	1
Carrot	1
Quassia	1
Leek	1
 */

select c.concept_name, count(*) cnt
from scratch_rich.standard_case_np inner join staging_vocabulary.concept c on standard_case_np.standard_concept_id = c.concept_id
where c.concept_class_id = 'NEEDS COMMON NAME'
group by c.concept_name
order by cnt desc 
;

/*
ORANGE [HOC] [Citrus sinensis]	185
ACHILLEA [MI] [Achillea millefolium]	35
NETTLE [VANDF] [Urtica dioica]	32
PECAN [Carya illinoinensis]	28
HAWTHORN (CRATAEGUS LAEVIGATA) [HOC] [Crataegus laevigata]	27
KAVA [VANDF] [Piper methysticum]	23
GERANIUM [MI] [Geranium maculatum]	22
SOLIDAGO [MART.] [Solidago canadensis]	21
CHIMAPHILA [MI] [Chimaphila umbellata]	21
PLANTAIN [MART.] [Plantago major]	20
RUMEX [VANDF] [Rumex crispus]	19
ELEUTHEROCOCCUS SENTICOSUS [WHO-DD] [Eleutherococcus senticosus]	18
FENNEL [MART.] [Foeniculum vulgare]	16
SOLANUM [MI] [Solanum carolinense]	11
BACOPA [HOC] [Bacopa monnieri]	10
SCUTELLARIA [VANDF] [Scutellaria lateriflora]	10
CRATAEGUS LAEVIGATA [WHO-DD] [Crataegus laevigata]	10
PIPER METHYSTICUM [HPUS] [Piper methysticum]	8
CHASTE TREE [Vitex agnus]	8
WITCH HAZEL [HOC] [Hamamelis virginiana]	7
PLANTAGO AFRA [WHO-DD] [Plantago virginica]	7
MULLEIN [VANDF] [Verbascum thapsus]	6
POPPY-SEED OIL [MART.] [Papaver somniferum]	6
RHEUM PALMATUM [WHO-DD] [Rheum palmatum]	6
ASTRAGALUS (ASTRAGALUS MEMBRANACEUS) [HOC] [Astragalus propinquus]	6
LEMON BALM [VANDF] [Melissa officinalis]	6
MELISSA [MART.] [Melissa officinalis]	6
YARROW [HOC] [Achillea millefolium]	5
MASTIC [MI] [Pistacia lentiscus]	5
CHIMAPHILA UMBELLATA [WHO-DD] [Chimaphila umbellata]	5
NEEM [HOC] [Azadirachta indica]	5
FOENICULUM VULGARE [WHO-DD] [Foeniculum vulgare]	4
MELISSA OFFICINALIS [WHO-DD] [Melissa officinalis]	4
CELANDINE [HOC] [Chelidonium majus]	4
ROSEMARY [HOC] [Rosmarinus officinalis]	4
SKULLCAP [MART.] [Scutellaria lateriflora]	4
CHELIDONIUM MAJUS [WHO-DD] [Chelidonium majus]	3
SWEET GUM [Liquidambar styraciflua]	3
HAMAMELIS VIRGINIANA [WHO-DD] [Hamamelis virginiana]	3
CHAI HU [Bupleurum chinense]	3
COMFREY [HOC] [Symphytum officinale]	3
ASTRAGALUS PROPINQUUS [WHO-DD] [Astragalus propinquus]	3
BERBERIS VULGARIS [WHO-DD] [Berberis vulgaris]	2
SISYMBRIUM OFFICINALE [WHO-DD] [Sisymbrium officinale]	2
SAPONARIA [MI] [Saponaria officinalis]	2
YERBA SANTA [VANDF] [Eriodictyon californicum]	2
ROSMARINUS OFFICINALIS [WHO-DD] [Rosmarinus officinalis]	2
BUPLEURUM (BUPLEURUM CHINENSE) [HOC] [Bupleurum chinense]	2
PLANTAGO MAJOR [WHO-DD] [Plantago major]	2
CHASTEBERRY [VANDF] [Vitex agnus]	2
BAI ZHU [Atractylodes macrocephala]	2
ERIGERON [MI] [Conyza canadensis]	2
ELEUTHERO [HOC] [Eleutherococcus senticosus]	2
AGATHOSMA BETULINA [WHO-DD] [Agathosma betulina]	2
SLOE [HOC] [Prunus spinosa]	1
ACHILLEA MILLEFOLIUM [WHO-DD] [Achillea millefolium]	1
AGNUS CASTUS [MI] [Vitex agnus]	1
BLACK WILLOW [HOC] [Salix nigra]	1
BUCHU [Agathosma betulina]	1
CLARY SAGE [HOC] [Salvia sclarea]	1
CLIVERS [MART.] [Galium aparine]	1
CNICUS BENEDICTUS [Centaurea benedicta]	1
FO-TI [HOC] [Reynoutria multiflora]	1
GALIUM APARINE [WHO-DD] [Galium aparine]	1
GRAVEL ROOT [MART.] [Eupatorium purpureum]	1
IODISED OIL [MART.] [Papaver somniferum]	1
JUNIPERUS VIRGINIANA [WHO-DD] [Juniperus virginiana]	1
LOVAGE [FHFI] [Levisticum officinale]	1
LYCIUM BARBARUM [WHO-DD] [Lycium barbarum]	1
MEADOWSWEET [HOC] [Filipendula ulmaria]	1
MELIA [HOC] [Melia azedarach]	1
MOTHERWORT [HOC] [Leonurus cardiaca]	1
MUSCADINE GRAPE [Vitis rotundifolia]	1
MUSTARD (BRASSICA JUNCEA VAR. RUGOSA) [HOC] [Brassica juncea]	1
PINUS MUGO [WHO-DD] [Pinus mugo]	1
PIPSISSEWA (CHIMAPHILA UMBELLATA) [HOC] [Chimaphila umbellata]	1
POKE [HOC] [Phytolacca americana]	1
POPPY SEED OIL [II] [Papaver somniferum]	1
POPPY SEED [Papaver somniferum]	1
PRUNUS SPINOSA [WHO-DD] [Prunus spinosa]	1
PTELEA TRIFOLIATA [HPUS] [Ptelea trifoliata]	1
RHEUM PALMATUM ROOT [WHO-DD] [Rheum palmatum]	1
RHUBARB (RHEUM PALMATUM) [Rheum palmatum]	1
SYMPHYTUM OFFICINALE [HPUS] [Symphytum officinale]	1
TEASEL [HOC] [Dipsacus fullonum]	1
URTICA DIOICA [WHO-DD] [Urtica dioica]	1
YELLOW DOCK [HOC] [Rumex crispus]	1
 */

select c.concept_class_id, scratch_rich.standard_case_np.role_cod, count(*) cnt
from scratch_rich.standard_case_np inner join staging_vocabulary.concept c on standard_case_np.standard_concept_id = c.concept_id
where c.concept_class_id != 'NEEDS COMMON NAME'
group by c.concept_class_id, scratch_rich.standard_case_np.role_cod 
order by cnt desc   

/*
Turmeric	C	1170
Flax seed	C	1157
Cinnamon	C	823
Saw Palmetto	C	554
Ginkgo	C	427
Green tea	C	257
Valerian	C	245
Hemp extract	C	187
St. John's Wort	C	174
Aloe vera	C	154
Licorice	C	154
Garcinia	C	143
Horse Chestnut	C	134
Echinacea angustifolia	C	129
Hemp extract	SS	98
Dandelion	C	81
Cumin	C	68
St. John's Wort	SS	62
Ginkgo	SS	61
Chamomile (not specified)	C	50
Kratom	PS	46
Turmeric	SS	44
Valerian	SS	40
Cinnamon	SS	39
Goldenseal	C	33
Fenugreek	C	30
Ragweed	SS	30
Horse Chestnut	SS	28
Saw Palmetto	SS	24
Gentian Root	C	23
St. John's Wort	I	21
Rose Hip	C	21
Ragweed	PS	21
cola nut	C	20
Beet root	C	20
Licorice	SS	19
Feverfew	C	19
Kratom	SS	16
Garcinia	SS	14
Turmeric	I	13
Wild Yam	C	12
Bladderwrack	SS	12
Green tea	SS	11
Bladderwrack	C	10
Black pepper	C	9
Fenugreek	SS	8
Parsley	C	8
Yohimbe	C	7
Flax seed	SS	7
English Walnut	SS	7
St. John's Wort	PS	7
Elderberry	C	7
Yerba Mate	C	7
Ivy leaf	C	6
Cinnamon	PS	6
Garcinia	I	6
Green tea	PS	6
Aloe vera	PS	6
Aloe vera	SS	6
Echinacea purpurea	C	5
Licorice	I	5
Spearmint	C	4
Cinnamon	I	4
onion	C	4
Feverfew	SS	4
Horehound	C	4
Wormwood	C	4
Bladderwrack	I	4
Chamomile (not specified)	SS	4
Echinacea angustifolia	SS	4
Kratom	C	3
Catnip	C	3
Echinacea angustifolia	I	3
English Walnut	C	3
Saw Palmetto	I	3
Ginkgo	I	3
Wild Yam	SS	2
Ragweed	C	2
Peach	SS	2
Dandelion	I	2
Bloodroot	C	2
Horse Chestnut	I	2
Yohimbe	PS	2
Kale	C	2
Goldenseal	PS	2
Goldenseal	SS	2
Dandelion	SS	2
cola nut	SS	2
Flax seed	I	2
Leek	C	1
Elderberry	SS	1
Quassia	C	1
Fenugreek	I	1
Valerian	I	1
Yerba Mate	SS	1
Gentian Root	I	1
Peach	PS	1
Spearmint	PS	1
Flax seed	PS	1
Carrot	C	1
Goat's rue	C	1
English Walnut	I	1
Green tea	I	1
Horehound	SS	1
Chamomile (not specified)	I	1
Hemp extract	I	1
Wormwood	SS	1
Gentian Root	SS	1
Peach	C	1
Wild Yam	PS	1
Yerba Mate	PS	1
Coptis	SS	1 
 */


-- Generated the NP disproportionality statistics and drill down by running the following
-- scripts in order
-- 1. derive_standard_NP_outcome_count.sql
-- 2. derive_standard_NP_outcome_contingency_table.sql
-- 3. derive_standard_np_outcome_statistics.sql
-- 4. derive_standard_np_outcome_drilldown.sql

--- test signal results 
select c1.concept_name np_name, c2.concept_name ae, 
       snos.case_count, snos.ror, snos.ror_95_percent_lower_confidence_limit, snos.ror_95_percent_upper_confidence_limit 
from scratch_rich.standard_np_outcome_statistics snos 
  inner join staging_vocabulary.concept c1 on c1.concept_id = snos.drug_concept_id 
  inner join staging_vocabulary.concept c2 on c2.concept_id = snos.outcome_concept_id 
  where snos.case_count >= 5
   and snos.ror_95_percent_lower_confidence_limit >= 2.0
 order by snos.ror_95_percent_lower_confidence_limit desc
 ;


/*
Mitragynine [Mitragyna speciosa]	Pulmonary congestion	6	689.21250	228.73146	2076.73168
RAGWEED [Ambrosia artemisiifolia]	Product administered to patient of inappropriate age	9	987.14371	211.68317	4603.35460
SOLANUM [MI] [Solanum carolinense]	Completed suicide	6	540.58824	191.82105	1523.48053
FUCUS [MI] [Fucus vesiculosus]	Congestive cardiomyopathy	5	402.29167	106.65261	1517.43671
HORSE CHESTNUT [Aesculus hippocastanum]	Coma	22	192.14499	85.15014	433.58351
Mitragynine [Mitragyna speciosa]	Toxicity to various agents	10	169.93519	80.67528	357.95309
Mitragynine [Mitragyna speciosa]	Pulmonary oedema	5	194.81972	70.64061	537.29326
RAGWEED [Ambrosia artemisiifolia]	Local reaction	6	161.59412	55.47302	470.72716
FUCUS [MI] [Fucus vesiculosus]	Interstitial lung disease	8	114.90795	50.31659	262.41517
HORSE CHESTNUT [Aesculus hippocastanum]	Pneumonia aspiration	21	86.12376	45.17266	164.19892
HORSE CHESTNUT [Aesculus hippocastanum]	Erection increased	6	203.37757	40.95427	1009.96649
ORANGE [HOC] [Citrus sinensis]	Cerebral venous thrombosis	6	168.44720	33.93318	836.18634
PECAN [Carya illinoinensis]	Throat irritation	6	78.24520	32.18473	190.22411
FUCUS [MI] [Fucus vesiculosus]	Cardiac failure	7	69.43182	30.08161	160.25660
CANNABIS SATIVA [WHO-DD] [Cannabis sativa]	Substance abuse	12	123.34271	27.58312	551.54834
FENUGREEK [VANDF] [Trigonella foenum]	Serotonin syndrome	6	65.40179	26.05090	164.19367
HYPERICUM [MI] [Hypericum perforatum]	Social anxiety disorder	6	215.49448	25.91853	1791.68615
HYPERICUM [MI] [Hypericum perforatum]	Self-injurious ideation	6	215.49448	25.91853	1791.68615
GOLDEN SEAL [Hydrastis canadensis]	Pain in jaw	5	64.27069	24.04750	171.77340
Green tea [Camellia sinensis]	Muscle spasticity	10	70.86124	22.19363	226.25034
RAGWEED [Ambrosia artemisiifolia]	Anaphylactic reaction	6	53.84118	21.73286	133.38662
ORANGE [HOC] [Citrus sinensis]	Product use issue	27	34.02652	21.01858	55.08480
Green tea [Camellia sinensis]	Skin irritation	16	45.56154	20.63418	100.60269
CANNABIS SATIVA [WHO-DD] [Cannabis sativa]	Synovitis	8	164.07715	20.50926	1312.64167
Kratom [Mitragyna speciosa]	Drug dependence	7	46.21921	19.84594	107.63993
HORSE CHESTNUT [Aesculus hippocastanum]	Increased appetite	7	52.81606	19.59707	142.34460
HYPERICUM [MI] [Hypericum perforatum]	Personality disorder	6	71.82748	17.93779	287.61550
HYPERICUM [MI] [Hypericum perforatum]	Generalised anxiety disorder	6	71.82748	17.93779	287.61550
CANNABIS SATIVA [WHO-DD] [Cannabis sativa]	Drug abuse	19	35.64481	16.93580	75.02173
Green tea [Camellia sinensis]	Skin burning sensation	24	28.64839	16.22361	50.58862
RAGWEED [Ambrosia artemisiifolia]	Wheezing	5	42.81988	16.20177	113.16925
HYPERICUM [MI] [Hypericum perforatum]	Attention deficit/hyperactivity disorder	6	53.86911	15.17757	191.19540
CANNABIS SATIVA [WHO-DD] [Cannabis sativa]	Respiratory arrest	20	29.49550	14.87246	58.49635
GLYCYRRHIZA [MI] [Glycyrrhiza glabra]	Interstitial lung disease	9	31.53735	14.44465	68.85626
CASSIA [HOC] [Cinnamomum cassia]	Orthostatic hypotension	10	31.89445	14.42312	70.52953
HYPERICUM [MI] [Hypericum perforatum]	Vulvovaginal dryness	5	59.79626	14.27029	250.56194
GLYCYRRHIZA [MI] [Glycyrrhiza glabra]	Hepatic function abnormal	5	42.48304	14.18419	127.24083
Kratom [Mitragyna speciosa]	Drug withdrawal syndrome	5	36.97573	13.92772	98.16428
HORSE CHESTNUT [Aesculus hippocastanum]	Gastrooesophageal reflux disease	23	22.01708	13.66984	35.46142
Green tea [Camellia sinensis]	Dry skin	31	21.25451	13.31656	33.92424
RAGWEED [Ambrosia artemisiifolia]	Urticaria	12	23.64969	12.79187	43.72368
HYPERICUM [MI] [Hypericum perforatum]	Libido decreased	5	44.84594	12.02420	167.25922
ORANGE [HOC] [Citrus sinensis]	Incorrect drug administration duration	7	28.10886	11.30716	69.87679
CURCUMA LONGA [WHO-DD] [Curcuma longa]	Laryngitis	5	40.91659	10.97202	152.58515
Green tea [Camellia sinensis]	Contraindicated product administered	8	28.29618	10.60274	75.51574
Kratom [Mitragyna speciosa]	Withdrawal syndrome	5	27.42761	10.56448	71.20779
Kratom [Mitragyna speciosa]	Toxicity to various agents	8	22.23372	10.51728	47.00247
CANNABIS SATIVA [WHO-DD] [Cannabis sativa]	Poisoning	9	26.38045	9.81277	70.92070
CANNABIS SATIVA [WHO-DD] [Cannabis sativa]	Psoriatic arthropathy	14	20.57419	9.79267	43.22594
HYPERICUM [MI] [Hypericum perforatum]	Polyneuropathy	5	29.89562	9.10850	98.12251
PECAN [Carya illinoinensis]	Urticaria	5	22.43811	8.89113	56.62595
GINKGO [Ginkgo biloba]	Low turnover osteopathy	7	33.56605	8.67419	129.88878
TANAKAN [Ginkgo biloba]	Renal failure	6	20.24218	8.61524	47.56060
Green tea [Camellia sinensis]	Respiratory disorder	10	18.89048	8.46985	42.13186
Green tea [Camellia sinensis]	Ear pain	10	18.89048	8.46985	42.13186
DANDELION [Taraxacum officinale]	Drug hypersensitivity	12	15.60774	8.35347	29.16172
Green tea [Camellia sinensis]	Colitis ischaemic	6	24.21599	8.12642	72.16140
Green tea [Camellia sinensis]	Body temperature increased	10	17.70933	8.02038	39.10293
Green tea [Camellia sinensis]	Skin exfoliation	14	15.30178	7.97086	29.37508
HORSE CHESTNUT [Aesculus hippocastanum]	Somnolence	27	11.85551	7.81319	17.98921
DANDELION [Taraxacum officinale]	Visual impairment	13	13.63923	7.52266	24.72908
GINKGO [Ginkgo biloba]	Pathological fracture	7	25.17381	7.36405	86.05598
CASSIA [HOC] [Cinnamomum cassia]	Acute kidney injury	15	12.62225	7.13969	22.31486
ORANGE [HOC] [Citrus sinensis]	Flatulence	14	12.41578	6.92670	22.25471
HYPERICUM [MI] [Hypericum perforatum]	Mania	7	16.77095	6.82284	41.22401
HYPERICUM [MI] [Hypericum perforatum]	Wound	6	17.95236	6.72413	47.92992
HYPERICUM [MI] [Hypericum perforatum]	Tension	6	17.95236	6.72413	47.92992
CANNABIS SATIVA [WHO-DD] [Cannabis sativa]	Cardiac arrest	21	11.40901	6.68081	19.48348
RAGWEED [Ambrosia artemisiifolia]	Off label use	14	11.46860	6.55894	20.05336
PECAN [Carya illinoinensis]	Cough	6	15.21305	6.52888	35.44817
CHAMOMILE [HOC] [Matricaria chamomilla]	Panic attack	7	14.42046	6.48205	32.08085
DANDELION [Taraxacum officinale]	Vertigo	9	12.87630	6.33087	26.18900
CINNAMON [HOC] [Cinnamomum verum]	Blood glucose increased	17	10.66654	6.31972	18.00318
CANNABIS SATIVA [WHO-DD] [Cannabis sativa]	Toxicity to various agents	23	10.11213	6.12635	16.69103
TURMERIC [Curcuma longa]	Carbohydrate antigen 125 increased	8	28.82230	6.11851	135.77241
DANDELION [Taraxacum officinale]	Vision blurred	14	10.29545	5.85785	18.09474
HYPERICUM [MI] [Hypericum perforatum]	Depressed mood	11	11.33393	5.73953	22.38127
CASSIA [HOC] [Cinnamomum cassia]	Hyponatraemia	11	11.01161	5.71516	21.21647
RAGWEED [Ambrosia artemisiifolia]	Erythema	7	12.00197	5.52401	26.07660
CANNABIS SATIVA [WHO-DD] [Cannabis sativa]	Cardio-respiratory arrest	10	12.07311	5.51990	26.40624
HYPERICUM [MI] [Hypericum perforatum]	Cognitive disorder	14	9.92510	5.47573	17.98986
Green tea [Camellia sinensis]	Pain of skin	6	14.12401	5.29236	37.69350
CASSIA [HOC] [Cinnamomum cassia]	Neutropenia	7	11.85235	5.18862	27.07425
PLANTAIN [MART.] [Plantago major]	Pruritus	5	12.75564	5.07034	32.08983
Green tea [Camellia sinensis]	Acne	13	9.46150	5.03796	17.76909
Green tea [Camellia sinensis]	Lower respiratory tract infection	9	10.61474	4.92378	22.88337
GINKGO [Ginkgo biloba]	Convulsion	15	9.40783	4.90244	18.05372
AESCULUS HIPPOCASTANUM [WHO-DD] [Aesculus hippocastanum]	Pyrexia	5	12.10929	4.85282	30.21646
VALERIANA OFFICINALIS [WHO-DD] [Valeriana officinalis]	Tachycardia	7	10.72848	4.83495	23.80591
SAW PALMETTO [HOC] [Serenoa repens]	Urine odour abnormal	5	16.58337	4.79706	57.32852
Green tea [Camellia sinensis]	Night sweats	10	9.76709	4.74953	20.08535
HORSE CHESTNUT [Aesculus hippocastanum]	Tinnitus	7	10.55273	4.73730	23.50708
HYPERICUM [MI] [Hypericum perforatum]	Sleep disorder	13	8.69463	4.72991	15.98267
CASSIA [HOC] [Cinnamomum cassia]	Lower respiratory tract infection	6	11.27301	4.63987	27.38890
CANNABIS SATIVA [WHO-DD] [Cannabis sativa]	Foetal exposure during pregnancy	5	14.62160	4.63584	46.11703
CANNABIS SATIVA [WHO-DD] [Cannabis sativa]	Euphoric mood	5	14.62160	4.63584	46.11703
HYPERICUM [MI] [Hypericum perforatum]	Suicidal ideation	14	7.78434	4.35433	13.91622
GOLDEN SEAL [Hydrastis canadensis]	Pain in extremity	7	9.33888	4.31103	20.23060
CINNAMON [HOC] [Cinnamomum verum]	Pancreatitis	5	10.91173	4.17669	28.50718
CASSIA [HOC] [Cinnamomum cassia]	Swelling face	9	8.48423	4.17293	17.24977
GINKGO [Ginkgo biloba]	Stress fracture	7	11.18673	4.16249	30.06449
LINUM USITATISSIMUM [Linum usitatissimum]	Flushing	25	6.59452	4.16007	10.45357
GINKGO [Ginkgo biloba]	Cerebral ischaemia	5	14.37260	4.15793	49.68129
Green tea [Camellia sinensis]	Erythema	24	6.29281	4.03036	9.82529
FLAX [HOC] [Linum usitatissimum]	Dyskinesia	9	9.56909	4.02838	22.73062
LINUM USITATISSIMUM [Linum usitatissimum]	Malnutrition	6	10.67559	3.87597	29.40376
ORANGE [HOC] [Citrus sinensis]	Rectal haemorrhage	5	10.00388	3.85051	25.99075
ORANGE [HOC] [Citrus sinensis]	Dysphagia	7	8.19071	3.69206	18.17079
FLAX [HOC] [Linum usitatissimum]	Hip arthroplasty	5	12.74235	3.68656	44.04304
CANNABIS SATIVA [WHO-DD] [Cannabis sativa]	Frequent bowel movements	7	8.96389	3.68283	21.81786
GINKGO [Ginkgo biloba]	Bone disorder	8	8.85371	3.66607	21.38211
CINNAMON (CINNAMOMUM CASSIA) [Cinnamomum cassia]	Chronic kidney disease	10	7.57154	3.65909	15.66731
DANDELION [Taraxacum officinale]	Blood pressure increased	13	6.42779	3.62606	11.39432
GLYCYRRHIZA [MI] [Glycyrrhiza glabra]	Hypokalaemia	5	9.09524	3.58263	23.09014
CINNAMON (CINNAMOMUM CASSIA) [Cinnamomum cassia]	Blood glucose decreased	7	8.40546	3.48106	20.29607
TANAKAN [Ginkgo biloba]	Confusional state	5	8.61465	3.47595	21.35018
SAW PALMETTO [HOC] [Serenoa repens]	Nocturia	5	10.36371	3.38742	31.70749
HYPERICUM [MI] [Hypericum perforatum]	Arthropathy	7	7.61933	3.36240	17.26567
GINKGO [Ginkgo biloba]	Anorexia	7	8.38932	3.29984	21.32854
HORSE CHESTNUT [Aesculus hippocastanum]	Dry mouth	7	7.19087	3.28391	15.74604
ORANGE [HOC] [Citrus sinensis]	Product use in unapproved indication	6	7.64780	3.24750	18.01041
CINNAMON (CINNAMOMUM CASSIA) [Cinnamomum cassia]	Dementia Alzheimer's type	5	9.26956	3.21711	26.70868
VALERIANA OFFICINALIS [WHO-DD] [Valeriana officinalis]	Sleep apnoea syndrome	5	8.12999	3.21643	20.54968
SERENOA REPENS [WHO-DD] [Serenoa repens]	Vertigo	5	7.95407	3.17652	19.91714
HYPERICUM [MI] [Hypericum perforatum]	Drug interaction	28	4.68853	3.14727	6.98458
DANDELION [Taraxacum officinale]	Hypoaesthesia	9	6.20587	3.12986	12.30494
LINUM USITATISSIMUM [Linum usitatissimum]	Crohn's disease	9	6.67980	3.10072	14.39012
CINNAMON (CINNAMOMUM CASSIA) [Cinnamomum cassia]	Blood glucose increased	21	4.90143	3.03751	7.90912
HORSE CHESTNUT [Aesculus hippocastanum]	Suicidal ideation	7	6.59054	3.01910	14.38680
CASSIA [HOC] [Cinnamomum cassia]	Confusional state	11	5.55260	2.96689	10.39184
CANNABIS SATIVA [WHO-DD] [Cannabis sativa]	Drug dependence	8	6.55860	2.95395	14.56192
ECHINACEA (ECHINACEA ANGUSTIFOLIA) [HPUS] [Echinacea angustifolia]	Thrombosis	5	7.39257	2.90025	18.84324
TURMERIC [Curcuma longa]	Injection site reaction	16	5.49654	2.86612	10.54107
VALERIAN [DSC] [Valeriana officinalis]	Insomnia	25	4.32978	2.85313	6.57067
GERANIUM [MI] [Geranium maculatum]	Diarrhoea	10	5.42107	2.84164	10.34193
FLAXSEED [Linum usitatissimum]	Restlessness	5	7.40121	2.77308	19.75343
FUCUS [MI] [Fucus vesiculosus]	Drug interaction	5	6.63391	2.68512	16.38986
CURCUMA LONGA [WHO-DD] [Curcuma longa]	Swelling	10	5.21106	2.66677	10.18275
TURMERIC [Curcuma longa]	Product dose omission	20	4.65705	2.65215	8.17754
CURCUMA LONGA [WHO-DD] [Curcuma longa]	Intentional product use issue	6	6.33649	2.63813	15.21952
CINNAMON [HOC] [Cinnamomum verum]	Weight decreased	17	4.34535	2.63743	7.15928
TURMERIC [Curcuma longa]	Liver function test increased	6	8.64203	2.63633	28.32904
CANNABIS SATIVA [WHO-DD] [Cannabis sativa]	Aggression	6	6.46585	2.57900	16.21066
Green tea [Camellia sinensis]	Inappropriate schedule of product administration	7	5.81679	2.57359	13.14702
FLAX [HOC] [Linum usitatissimum]	Activities of daily living impaired	6	6.95174	2.56890	18.81224
TURMERIC [Curcuma longa]	Chronic kidney disease	15	4.91753	2.54916	9.48627
SAW PALMETTO [HOC] [Serenoa repens]	Pollakiuria	10	5.19067	2.54827	10.57310
LINUM USITATISSIMUM [Linum usitatissimum]	Fluid retention	7	5.93204	2.51870	13.97113
FENUGREEK [VANDF] [Trigonella foenum]	Drug interaction	6	5.68844	2.49323	12.97848
CANNABIS SATIVA [WHO-DD] [Cannabis sativa]	Colitis ulcerative	5	6.82186	2.47646	18.79202
FLAX [HOC] [Linum usitatissimum]	Product substitution issue	12	4.78711	2.46279	9.30506
HYPERICUM [MI] [Hypericum perforatum]	Anxiety	21	3.86579	2.45418	6.08932
ALOE VERA [MART.] [Aloe vera]	Erythema	13	4.35634	2.44852	7.75066
SAW PALMETTO [HOC] [Serenoa repens]	Blood pressure systolic increased	5	6.90835	2.43150	19.62790
Green tea [Camellia sinensis]	Sinusitis	14	4.26985	2.42753	7.51034
FLAX [HOC] [Linum usitatissimum]	Loss of personal independence in daily activities	7	5.94913	2.42351	14.60367
ALOE VERA [MART.] [Aloe vera]	Skin burning sensation	6	5.71222	2.42209	13.47159
Green tea [Camellia sinensis]	Rash	27	3.62093	2.41655	5.42555
SAW PALMETTO [HOC] [Serenoa repens]	Myocardial infarction	14	4.31186	2.39141	7.77456
FLAX [HOC] [Linum usitatissimum]	Wound	6	6.37225	2.38969	16.99197
HYPERICUM [MI] [Hypericum perforatum]	Panic attack	7	5.23609	2.36337	11.60065
GINKGO [Ginkgo biloba]	Femur fracture	9	4.98042	2.33114	10.64052
Green tea [Camellia sinensis]	Eye swelling	5	6.13410	2.32821	16.16143
LINUM USITATISSIMUM [Linum usitatissimum]	Foot fracture	5	6.35054	2.28505	17.64920
TURMERIC [Curcuma longa]	Product storage error	7	6.30230	2.28425	17.38820
TURMERIC [Curcuma longa]	Red blood cell count decreased	15	4.32702	2.27956	8.21347
GINKGO [Ginkgo biloba]	Respiratory failure	10	4.64251	2.27334	9.48072
TURMERIC [Curcuma longa]	Breast cancer	8	5.76303	2.27329	14.60988
CURCUMA LONGA [WHO-DD] [Curcuma longa]	Sinusitis	12	4.15083	2.27004	7.58988
CINNAMON (CINNAMOMUM CASSIA) [Cinnamomum cassia]	Drug dose omission	12	4.23081	2.26805	7.89214
RAGWEED [Ambrosia artemisiifolia]	Pruritus	6	5.13685	2.25427	11.70541
CASSIA [HOC] [Cinnamomum cassia]	Fall	16	3.73906	2.23843	6.24569
CASSIA [HOC] [Cinnamomum cassia]	Seizure	5	5.62578	2.22651	14.21482
CANNABIS SATIVA [WHO-DD] [Cannabis sativa]	Dysstasia	5	6.01894	2.21796	16.33376
CHAMOMILE [HOC] [Matricaria chamomilla]	Anxiety	9	4.26245	2.16993	8.37285
VALERIANA OFFICINALIS [WHO-DD] [Valeriana officinalis]	Insomnia	13	3.80960	2.16650	6.69883
SAW PALMETTO [HOC] [Serenoa repens]	Death	20	3.47068	2.13947	5.63020
ECHINACEA (ECHINACEA ANGUSTIFOLIA) [HPUS] [Echinacea angustifolia]	Arthritis	6	4.88893	2.11510	11.30051
CASSIA [HOC] [Cinnamomum cassia]	Abdominal pain	11	3.91719	2.11192	7.26561
TURMERIC [Curcuma longa]	Injection site bruising	11	4.40417	2.07881	9.33068
FLAXSEED [Linum usitatissimum]	Product quality issue	6	4.93603	2.07585	11.73704
TURMERIC [Curcuma longa]	Photosensitivity reaction	6	6.17250	2.07345	18.37505
GINKGO [Ginkgo biloba]	Hyponatraemia	13	3.82103	2.07018	7.05267
HYPERICUM [MI] [Hypericum perforatum]	Disturbance in attention	7	4.48707	2.03997	9.86968
Green tea [Camellia sinensis]	Pruritus	25	3.08490	2.03395	4.67887
GARCINIA [HOC] [Garcinia gummi]	Gastrointestinal disorder	5	5.03249	2.00669	12.62079 
 */

