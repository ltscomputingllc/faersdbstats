#!/bin/sh
##########################################################################
# create the combined legacy reporting source files with the filename appended as the last column
#
# LTS Computing LLC
##########################################################################

# process the first file - including adding "filename" column name to the header line at the start of the file
f="RPSR04Q1.TXT"
thefilenamenosuffix=$(basename $f .TXT)
# remove windows carriage return, fix bad data records with embedded \n, add on the "filename" column name to the header line and add the filename as the last column on each line
# output to the all data file
sed 's/\r//g' $f | sed '1,1 s/$/\$FILENAME/' | sed "2,$ s/$/$f/" > all_rpsr_legacy_data_with_filename.txt

# process the other files and concatenate to the all data file
FILES="
RPSR04Q2.TXT  RPSR04Q3.TXT  RPSR04Q4.TXT  RPSR05Q1.TXT  RPSR05Q2.TXT  RPSR05Q3.TXT  RPSR05Q4.TXT  RPSR06Q1.TXT  RPSR06Q2.TXT  RPSR06Q3.TXT  RPSR06Q4.TXT  RPSR07Q1.TXT  RPSR07Q2.TXT
RPSR07Q3.TXT  RPSR07Q4.TXT  RPSR08Q1.TXT  RPSR08Q2.TXT  RPSR08Q3.TXT  RPSR08Q4.TXT  RPSR09Q1.TXT  RPSR09Q2.TXT  RPSR09Q3.TXT  RPSR09Q4.TXT  RPSR10Q1.TXT  RPSR10Q2.TXT  RPSR10Q3.TXT  RPSR10Q4.TXT
RPSR11Q1.TXT  RPSR11Q2.TXT  RPSR11Q3.TXT  RPSR11Q4.TXT  RPSR12Q1.TXT  RPSR12Q2.TXT  RPSR12Q3.TXT
"
for f in $FILES
do
        thefilenamenosuffix=$(basename $f .TXT)
        # remove windows carriage return,fix bad data records with embedded \n, remove the header line and add the filename as the last column on each line
        sed 's/\r//g' $f | sed '1,1d' | sed "1,$ s/$/$f/" >> all_rpsr_legacy_data_with_filename.txt
done

