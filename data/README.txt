1. Exported unmapped drug names from FAERS to FAERS-drug-mapping-table-May2019-COPY-II.csv

2. Split the file into 10 parts using

$ split -n l/10 FAERS-drug-mapping-table-May2019-COPY-II.csv

3. xaa.csv was cleaned to remove stray symbols and noisy text and then loaded into open office and exported as xaa.xlsx

4. xaa.xlsx loaded into Usagi

5. Score matches from 1.0 to 9.4 were accepted because review indicated these are highly accurate

6. Picked drugs with at least 100 reports after sorting by frequency. Pharmacist review indicated which rows should be mapped

7. Ran xaa-subset-to-100-expert-filtered.txt through MetaMap and pharmacists reviewed to confirm mappings to Metathesaurus concepts

$ ./bin/metamap -G -I --JSONf 2 -R "RXNORM,ATC" --conj  /home/faersdbstats/data/xaa-subset-to-100-expert-filtered.txt /home/faersdbstats/data/xaa-subset-to-100-expert-filtered-METAMAP.json
$ python parse-METAMAP.py > xaa-subset-to-100-expert-filtered-METAMAP.tsv

8. YY cross-walked to RxNorm....
