#!/bin/sh
##########################################################################
# create the combined therapy files with the filename appended as the last column
#
# LTS Computing LLC
##########################################################################

# load the ther files

# thefilenamenoprefix=ther12q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, add on the filename column name to the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1 s/$/\$filename/' | sed "2,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER13Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER13Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER13Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER13Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER14Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER14Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER14Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER14Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER15Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER15Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER15Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER15Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER16Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER16Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER16Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER16Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER17Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER17Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER17Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER17Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER18Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER18Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER18Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER18Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER19Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER19Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER19Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER19Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER20Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=THER20Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=THER20Q3
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# concatenate all the ther files with filenames together into a single file for loading
cat ther12q4_with_filename.txt THER*_with_filename.txt  > all_ther_data_with_filename.txt
