#!/bin/sh
##########################################################################
# create the combined indication files with the filename appended as the last column
#
# LTS Computing LLC
##########################################################################

# load the indication files: indi12q4.txt INDI13Q1.txt  INDI13Q2.txt  INDI13Q3.txt  INDI13Q4.txt  INDI14Q1.txt  INDI14Q2.txt  INDI14Q3.txt  INDI14Q4.txt

thefilenamenoprefix=indi12q4
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, add on the filename column name to the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1 s/$/\$filename/' | sed "2,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=INDI13Q1
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=INDI13Q2
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=INDI13Q3
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=INDI13Q4
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=INDI14Q1
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=INDI14Q2
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=INDI14Q3
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=INDI14Q4
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=INDI15Q1
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=INDI15Q2
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=INDI15Q3
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=INDI15Q4
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=INDI16Q1
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=INDI16Q2
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=INDI16Q3
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=INDI16Q4
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

thefilenamenoprefix=INDI17Q1
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"

# concatenate all the indication files with filenames together into a single file for loading
cat indi12q4_with_filename.txt INDI*_with_filename.txt  > all_indi_data_with_filename.txt
