#!/bin/sh
##########################################################################
# create combined drug files with the filename appended as the last column
# NOTE the drug file formats are in two versions
# We will call the file format before 2014 Q3 version A and everything from 2014 Q3 onwards, version B
#
# LTS Computing LLC
##########################################################################

# load the drug files: drug12q4.txt DRUG13Q1.txt  DRUG13Q2.txt  DRUG13Q3.txt  DRUG13Q4.txt  DRUG14Q1.txt  DRUG14Q2.txt  DRUG14Q3.txt  DRUG14Q4.txt

# file format version A

thefilenamenoprefix=drug12q4
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, add on the filename column name to the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1 s/$/\$filename/' | sed "2,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=DRUG13Q1
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=DRUG13Q2
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=DRUG13Q3
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=DRUG13Q4
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=DRUG14Q1
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=DRUG14Q2
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# start of file format version B

thefilenamenoprefix=DRUG14Q3
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, add on the filename column name to the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1 s/$/\$filename/' | sed "2,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=DRUG14Q4
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# concatenate all the version A drug files with filenames together into a single file for loading
# drug12q4.txt DRUG13Q1.txt  DRUG13Q2.txt  DRUG13Q3.txt  DRUG13Q4.txt  DRUG14Q1.txt  DRUG14Q2.txt
cat drug12q4_with_filename.txt DRUG13Q1_with_filename.txt DRUG13Q2_with_filename.txt DRUG13Q3_with_filename.txt DRUG13Q4_with_filename.txt DRUG14Q1_with_filename.txt DRUG14Q2_with_filename.txt > all_version_A_drug_data_with_filename.txt

# concatenate all the version B drug files with filenames together into a single file for loading
# DRUG14Q3.txt  DRUG14Q4.txt
cat DRUG14Q3_with_filename.txt DRUG14Q4_with_filename.txt > all_version_B_drug_data_with_filename.txt
