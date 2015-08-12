#!/bin/sh
##########################################################################
# create the combined legacy therapy files with the filename appended as the last column
#
# LTS Computing LLC
##########################################################################

# process the first file - including adding "filename" column name to the header line at the start of the file
f="THER04Q1.TXT"
thefilenamenosuffix=$(basename $f .TXT)
# remove windows carriage return, fix bad data records with embedded \n, add on the "filename" column name to the header line and add the filename as the last column on each line
# output to the all data file
sed 's/\r//g' $f | sed '1,1 s/$/\$FILENAME/' | sed "2,$ s/$/$f/" > all_ther_legacy_data_with_filename.txt

# process the other files and concatenate to the all data file
FILES="
THER04Q2.TXT  THER04Q3.TXT  THER04Q4.TXT  THER05Q1.TXT  THER05Q2.TXT  THER05Q3.TXT  THER05Q4.TXT  THER06Q1.TXT  THER06Q2.TXT  THER06Q3.TXT  THER06Q4.TXT  THER07Q1.TXT  THER07Q2.TXT
THER07Q3.TXT  THER07Q4.TXT  THER08Q1.TXT  THER08Q2.TXT  THER08Q3.TXT  THER08Q4.TXT  THER09Q1.TXT  THER09Q2.TXT  THER09Q3.TXT  THER09Q4.TXT  THER10Q1.TXT  THER10Q2.TXT  THER10Q3.TXT  THER10Q4.TXT
THER11Q1.TXT  THER11Q2.TXT  THER11Q3.TXT  THER11Q4.TXT  THER12Q1.TXT  THER12Q2.TXT  THER12Q3.TXT
"
for f in $FILES
do
        thefilenamenosuffix=$(basename $f .TXT)
        # remove windows carriage return,fix bad data records with embedded \n, remove the header line and add the filename as the last column on each line
        sed 's/\r//g' $f | sed '1,1d' | sed "1,$ s/$/$f/" >> all_ther_legacy_data_with_filename.txt
done

