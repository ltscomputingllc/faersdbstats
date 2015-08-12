#!/bin/sh
##########################################################################
# create the combined legacy indication files with the filename appended as the last column
#
# LTS Computing LLC
##########################################################################

# process the first file - including adding "filename" column name to the header line at the start of the file
f="INDI04Q1.TXT"
thefilenamenosuffix=$(basename $f .TXT)
# remove windows carriage return, fix bad data records with embedded \n, add on the "filename" column name to the header line and add the filename as the last column on each line
# output to the all data file
sed 's/\r//g' $f | sed '1,1 s/$/\$FILENAME/' | sed "2,$ s/$/\$$f/" > all_indi_legacy_data_with_filename.txt

# process the other files and concatenate to the all data file
FILES="
INDI04Q2.TXT  INDI04Q3.TXT  INDI04Q4.TXT  INDI05Q1.TXT  INDI05Q2.TXT  INDI05Q3.TXT  INDI05Q4.TXT  INDI06Q1.TXT  INDI06Q2.TXT  INDI06Q3.TXT  INDI06Q4.TXT  INDI07Q1.TXT  INDI07Q2.TXT
INDI07Q3.TXT  INDI07Q4.TXT  INDI08Q1.TXT  INDI08Q2.TXT  INDI08Q3.TXT  INDI08Q4.TXT  INDI09Q1.TXT  INDI09Q2.TXT  INDI09Q3.TXT  INDI09Q4.TXT  INDI10Q1.TXT  INDI10Q2.TXT  INDI10Q3.TXT  INDI10Q4.TXT
INDI11Q1.TXT  INDI11Q2.TXT  INDI11Q3.TXT  INDI11Q4.TXT  INDI12Q1.TXT  INDI12Q2.TXT  INDI12Q3.TXT
"
for f in $FILES
do
        thefilenamenosuffix=$(basename $f .TXT)
        # remove windows carriage return,fix bad data records with embedded \n, remove the header line and add the filename as the last column on each line
        sed 's/\r//g' $f | sed '1,1d' | sed "1,$ s/$/\$$f/" >> all_indi_legacy_data_with_filename.txt
done

