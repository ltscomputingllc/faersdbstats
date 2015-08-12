#!/bin/sh
##########################################################################
# create the combined legacy drug files with the filename appended as the last column
#
# LTS Computing LLC
##########################################################################

# process the first file - including adding "filename" column name to the header line at the start of the file
f="DRUG04Q1.TXT"
thefilenamenosuffix=$(basename $f .TXT)
requirednumberoffields="13"
# remove control-H (ascii 08) and windows line feed chars, fix bad data records with embedded \n, add on the "filename" column name to the header line and add the filename as the last column on each line
# output to the all data file
sed 's/[\x08\r]//g' $f | awk -F '$' -v numfields=$requirednumberoffields '(NR == 1) {print;next} (NF >= numfields) {print;next} (NF <numfields) {printf("%s",$0)}' | awk -F '$' -v numfields=$requirednumberoffields '(NF <= numfields) {print;next} (NF > numfields) {for (i=1; i<numfields; i++) printf("%s$",$i); printf("\n"); for (i=numfields; i<=NF; i++) {if (i<NF) {printf("%s$",$i) } else {printf("%s",$i)}}{if (i<NF) {printf("%s$",$i) } else {printf("%s",$i)}}; printf("\n")}' | sed '1,1 s/$/\$FILENAME/' | sed "2,$ s/$/$f/" >all_drug_legacy_data_with_filename.txt

# process the other files and concatenate to the all data file
#cat /dev/null > all_drug_legacy_data_with_filename3.txt
FILES="
DRUG04Q2.TXT  DRUG04Q3.TXT  DRUG04Q4.TXT  DRUG05Q1.TXT  DRUG05Q2.TXT  DRUG05Q3.TXT  DRUG05Q4.TXT  DRUG06Q1.TXT  DRUG06Q2.TXT  DRUG06Q3.TXT  DRUG06Q4.TXT  DRUG07Q1.TXT  DRUG07Q2.TXT
DRUG07Q3.TXT  DRUG07Q4.TXT  DRUG08Q1.TXT  DRUG08Q2.TXT  DRUG08Q3.TXT  DRUG08Q4.TXT  DRUG09Q1.TXT  DRUG09Q2.TXT  DRUG09Q3.TXT  DRUG09Q4.TXT  DRUG10Q1.TXT  DRUG10Q2.TXT  DRUG10Q3.TXT  DRUG10Q4.TXT
DRUG11Q1.TXT  DRUG11Q2.TXT  DRUG11Q3.TXT  DRUG11Q4.TXT  DRUG12Q1.TXT  DRUG12Q2.TXT  DRUG12Q3.TXT
"
for f in $FILES
do
        thefilenamenosuffix=$(basename $f .TXT)
        # remove control-H (ascii 08) and windows line feed chars, fix bad data records with embedded \n, remove the header line and add the filename as the last column on each line
        sed 's/[\x08\r]//g' $f | sed '1,1d' | awk -F '$' -v numfields=$requirednumberoffields '(NR == 1) {print;next} (NF >= numfields) {print;next} (NF <numfields) {printf("%s",$0)}' | awk -F '$' -v numfields=$requirednumberoffields '(NF <= numfields) {print;next} (NF > numfields) {for (i=1; i<numfields; i++) printf("%s$",$i); printf("\n"); for (i=numfields; i<=NF; i++) {if (i<NF) {printf("%s$",$i) } else {printf("%s",$i)}}; printf("\n")}' | sed "1,$ s/$/$f/" >> all_drug_legacy_data_with_filename.txt
done

# fix 4 remaining problem data records
sed -i -e 's/6750381$1013798159$SS$MORPHINE SULFATE$1$ORAL$30 MG, TID, ORAL$D$D$$$$6750381$1013798165$C$KADIAN$1$$$$$$$$DRUG10Q2.TXT/6750381$1013798159$SS$MORPHINE SULFATE$1$ORAL$30 MG, TID, ORAL$D$D$$$$DRUG10Q2.TXT\n6750381$1013798165$C$KADIAN$1$$$$$$$$DRUG10Q2.TXT/' -e 's/7475791$1016572490$SS$DOXORUBICIN (DOXORUBICIN) (INJECTION)$2$INTRAVENOUS$25 MG\/M2 MILLIGRAM(S)\/SQ. METER, DAY 1 AND 15, EVERY 28 DAYS, INTRAVENOUS (NOT OTHERWISE SPECIFIED)$$$$$$7475791$1016572486$SS$PROCARBAZINE HYDROCHLORIDE$1$ORAL$40 MG\/M2 MILLIGRAMS(S)\/SQ. METER, DAY 1-14, ORAL$$$$$$DRUG11Q2.TXT/7475791$1016572490$SS$DOXORUBICIN (DOXORUBICIN) (INJECTION)$2$INTRAVENOUS$25 MG\/M2 MILLIGRAM(S)\/SQ. METER, DAY 1 AND 15, EVERY 28 DAYS, INTRAVENOUS (NOT OTHERWISE SPECIFIED)$$$$$$DRUG11Q2.TXT\n7475791$1016572486$SS$PROCARBAZINE HYDROCHLORIDE$1$ORAL$40 MG\/M2 MILLIGRAMS(S)\/SQ. METER, DAY 1-14, ORAL$$$$$$DRUG11Q2.TXT/' -e 's/7652730$1017255397$SS$BEVACIZUMAB (RHUMAB VEGF)$2$$920 MG$$$$$$7652731$1017185840$PS$DYSPORT$1$INTRAMUSCULAR$150 UNITS (150 UNITS, SINGLE CYCLE), INTRAMUSCULAR$N$D$825C$$$DRUG11Q3.TXT/7652730$1017255397$SS$BEVACIZUMAB (RHUMAB VEGF)$2$$920 MG$$$$$$DRUG11Q3.TXT\n7652731$1017185840$PS$DYSPORT$1$INTRAMUSCULAR$150 UNITS (150 UNITS, SINGLE CYCLE), INTRAMUSCULAR$N$D$825C$$$DRUG11Q3.TXT/' -e 's/7941354$1018188213$SS$MEMANTINE HYDROCHLORIDE$1$ORAL$15 MG (15 MG, 1 IN 1 D),ORAL$D$D$$$$7941355$1018142414$SS$DROSPIRENONE AND ETHINYL ESTRADIOL$1$$UNK$$$93657A$$021098$DRUG11Q4.TXT/7941354$1018188213$SS$MEMANTINE HYDROCHLORIDE$1$ORAL$15 MG (15 MG, 1 IN 1 D),ORAL$D$D$$$$DRUG11Q4.TXT\n7941355$1018142414$SS$DROSPIRENONE AND ETHINYL ESTRADIOL$1$$UNK$$$93657A$$021098$DRUG11Q4.TXT/' all_drug_legacy_data_with_filename.txt

