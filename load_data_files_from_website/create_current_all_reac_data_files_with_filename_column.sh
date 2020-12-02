#!/bin/sh
##########################################################################
# create the combined reaction files with the filename appended as the last column
# NOTE the reaction file formats are in two versions
# We will call the file format before 2014 Q3 version A and everything from 2014 Q3 onwards, version B
#
# LTS Computing LLC
##########################################################################

# load the reaction files

# file format version A

# thefilenamenoprefix=reac12q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, add on the filename column name to the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1 s/$/\$filename/' | sed "2,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=REAC13Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=REAC13Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=REAC13Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=REAC13Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=REAC14Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=REAC14Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# # start of file format version B

# thefilenamenoprefix=REAC14Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, add on the filename column name to the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1 s/$/\$filename/' | sed "2,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=REAC14Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=REAC15Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"
# thefilenamenoprefix=REAC15Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"
# thefilenamenoprefix=REAC15Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"
# thefilenamenoprefix=REAC15Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=REAC16Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"
# thefilenamenoprefix=REAC16Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"
# thefilenamenoprefix=REAC16Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"
# thefilenamenoprefix=REAC16Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=REAC17Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=REAC17Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=REAC17Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=REAC17Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=REAC18Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=REAC18Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=REAC18Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=REAC18Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=REAC19Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=REAC19Q2
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=REAC19Q3
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=REAC19Q4
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=REAC20Q1
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=REAC20Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=REAC20Q3
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"


# concatenate all the version A reaction files with filenames together into a single file for loading
cat reac12q4_with_filename.txt REAC13Q1_with_filename.txt REAC13Q2_with_filename.txt REAC13Q3_with_filename.txt REAC13Q4_with_filename.txt REAC14Q1_with_filename.txt REAC14Q2_with_filename.txt > all_version_A_reac_data_with_filename.txt

# concatenate all the version B reaction files with filenames together into a single file for loading
cat REAC14Q3_with_filename.txt REAC14Q4_with_filename.txt REAC15Q1_with_filename.txt REAC15Q2_with_filename.txt REAC15Q3_with_filename.txt REAC15Q4_with_filename.txt REAC16Q1_with_filename.txt REAC16Q2_with_filename.txt REAC16Q3_with_filename.txt REAC16Q4_with_filename.txt REAC17Q1_with_filename.txt REAC17Q2_with_filename.txt REAC17Q3_with_filename.txt REAC17Q4_with_filename.txt REAC18Q1_with_filename.txt REAC18Q2_with_filename.txt REAC18Q3_with_filename.txt REAC18Q4_with_filename.txt REAC19Q1_with_filename.txt REAC19Q2_with_filename.txt REAC19Q3_with_filename.txt REAC19Q4_with_filename.txt REAC20Q1_with_filename.txt REAC20Q2_with_filename.txt REAC20Q3_with_filename.txt > all_version_B_reac_data_with_filename.txt
