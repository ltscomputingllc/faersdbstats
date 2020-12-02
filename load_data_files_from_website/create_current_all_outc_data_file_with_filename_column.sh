#!/bin/sh
##########################################################################
# create the combined outcome files with the filename appended as the last column
#
# LTS Computing LLC
##########################################################################

# load the outcome files

# thefilenamenoprefix=outc12q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, add on the filename column name to the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1 s/$/\$filename/' | sed "2,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC13Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC13Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC13Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC13Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC14Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC14Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC14Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC14Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC15Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC15Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC15Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC15Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC16Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC16Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC16Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC16Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC17Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC17Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC17Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC17Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriage return, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC18Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriagereturn, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC18Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriagereturn, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC18Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriagereturn, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC18Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriagereturn, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC19Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriagereturn, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC19Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriagereturn, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC19Q3
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriagereturn, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC19Q4
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriagereturn, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC20Q1
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriagereturn, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# thefilenamenoprefix=OUTC20Q2
# thefilename="${thefilenamenoprefix}.txt"
# # remove windows carriagereturn, remove the header line and add the filename as the last column on each line
# sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=OUTC20Q3
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriagereturn, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# concatenate all the outcome files with filenames together into a single file for loading
cat outc12q4_with_filename.txt OUTC*_with_filename.txt  > all_outc_data_with_filename.txt
