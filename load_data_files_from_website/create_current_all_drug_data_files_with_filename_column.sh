#!/bin/sh
##########################################################################
# create combined drug files with the filename appended as the last column
# NOTE the drug file formats are in two versions
# We will call the file format before 2014 Q3 version A and everything from 2014 Q3 onwards, version B
#
# LTS Computing LLC
##########################################################################


# load the drug files

# file format version A

# thefilenamenoprefix=drug12q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, add on the filename column name to the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1 s/$/\$filename/' | sed "2,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG13Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG13Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG13Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG13Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG14Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG14Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# # start of file format version B

# thefilenamenoprefix=DRUG14Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, add on the filename column name to the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1 s/$/\$filename/' | sed "2,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG14Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG15Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG15Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG15Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG15Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG16Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG16Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG16Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG16Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG17Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG17Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG17Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG17Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG18Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG18Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG18Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG18Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG19Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG19Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG19Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG19Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG20Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=DRUG20Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=DRUG20Q3
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# concatenate all the version A drug files with filenames together into a single file for loading
cat drug12q4_with_filename.txt DRUG13Q1_with_filename.txt DRUG13Q2_with_filename.txt DRUG13Q3_with_filename.txt DRUG13Q4_with_filename.txt DRUG14Q1_with_filename.txt DRUG14Q2_with_filename.txt > all_version_A_drug_data_with_filename.txt

# concatenate all the version B drug files with filenames together into a single file for loading
cat DRUG14Q3_with_filename.txt DRUG14Q4_with_filename.txt DRUG15Q1_with_filename.txt DRUG15Q2_with_filename.txt DRUG15Q3_with_filename.txt DRUG15Q4_with_filename.txt DRUG16Q1_with_filename.txt DRUG16Q2_with_filename.txt DRUG16Q3_with_filename.txt DRUG16Q4_with_filename.txt DRUG17Q1_with_filename.txt DRUG17Q2_with_filename.txt DRUG17Q3_with_filename.txt DRUG17Q4_with_filename.txt DRUG18Q1_with_filename.txt DRUG18Q2_with_filename.txt DRUG18Q3_with_filename.txt DRUG18Q4_with_filename.txt DRUG19Q1_with_filename.txt DRUG19Q2_with_filename.txt DRUG19Q3_with_filename.txt DRUG19Q4_with_filename.txt DRUG20Q1_with_filename.txt DRUG20Q2_with_filename.txt DRUG20Q3_with_filename.txt > all_version_B_drug_data_with_filename.txt
