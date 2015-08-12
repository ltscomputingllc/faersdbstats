#!/bin/sh
##########################################################################
# create the combined legacy reaction files with the filename appended as the last column
#
# LTS Computing LLC
##########################################################################

# process the first file - including adding "filename" column name to the header line at the start of the file
f="REAC04Q1.TXT"
thefilenamenosuffix=$(basename $f .TXT)
# remove windows carriage return, fix bad data records with embedded \n, add on the "filename" column name to the header line and add the filename as the last column on each line
# output to the all data file
sed 's/\r//g' $f | sed '1,1 s/$/\$FILENAME/' | sed "2,$ s/$/$f/" > all_reac_legacy_data_with_filename.txt

# process the other files and concatenate to the all data file
FILES="
REAC04Q2.TXT  REAC04Q3.TXT  REAC04Q4.TXT  REAC05Q1.TXT  REAC05Q2.TXT  REAC05Q3.TXT  REAC05Q4.TXT  REAC06Q1.TXT  REAC06Q2.TXT  REAC06Q3.TXT  REAC06Q4.TXT  REAC07Q1.TXT  REAC07Q2.TXT
REAC07Q3.TXT  REAC07Q4.TXT  REAC08Q1.TXT  REAC08Q2.TXT  REAC08Q3.TXT  REAC08Q4.TXT  REAC09Q1.TXT  REAC09Q2.TXT  REAC09Q3.TXT  REAC09Q4.TXT  REAC10Q1.TXT  REAC10Q2.TXT  REAC10Q3.TXT  REAC10Q4.TXT
REAC11Q1.TXT  REAC11Q2.TXT  REAC11Q3.TXT  REAC11Q4.TXT  REAC12Q1.TXT  REAC12Q2.TXT  REAC12Q3.TXT
"
for f in $FILES
do
        thefilenamenosuffix=$(basename $f .TXT)
        # remove windows carriage return,fix bad data records with embedded \n, remove the header line and add the filename as the last column on each line
        sed 's/\r//g' $f | sed '1,1d' | sed "1,$ s/$/$f/" >> all_reac_legacy_data_with_filename.txt
done

