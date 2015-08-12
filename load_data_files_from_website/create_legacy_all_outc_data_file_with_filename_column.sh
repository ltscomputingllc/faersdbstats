#!/bin/sh
##########################################################################
# create the combined legacy outcome files with the filename appended as the last column
#
# LTS Computing LLC
##########################################################################

# process the first file - including adding "filename" column name to the header line at the start of the file
f="OUTC04Q1.TXT"
thefilenamenosuffix=$(basename $f .TXT)
# remove windows carriage return, fix bad data records with embedded \n, add on the "filename" column name to the header line and add the filename as the last column on each line
# output to the all data file
sed 's/\r//g' $f | sed '1,1 s/$/\$FILENAME/' | sed "2,$ s/$/$f/" > all_outc_legacy_data_with_filename.txt

# process the other files and concatenate to the all data file
FILES="
OUTC04Q2.TXT  OUTC04Q3.TXT  OUTC04Q4.TXT  OUTC05Q1.TXT  OUTC05Q2.TXT  OUTC05Q3.TXT  OUTC05Q4.TXT  OUTC06Q1.TXT  OUTC06Q2.TXT  OUTC06Q3.TXT  OUTC06Q4.TXT  OUTC07Q1.TXT  OUTC07Q2.TXT
OUTC07Q3.TXT  OUTC07Q4.TXT  OUTC08Q1.TXT  OUTC08Q2.TXT  OUTC08Q3.TXT  OUTC08Q4.TXT  OUTC09Q1.TXT  OUTC09Q2.TXT  OUTC09Q3.TXT  OUTC09Q4.TXT  OUTC10Q1.TXT  OUTC10Q2.TXT  OUTC10Q3.TXT  OUTC10Q4.TXT
OUTC11Q1.TXT  OUTC11Q2.TXT  OUTC11Q3.TXT  OUTC11Q4.TXT  OUTC12Q1.TXT  OUTC12Q2.TXT  OUTC12Q3.TXT
"
for f in $FILES
do
        thefilenamenosuffix=$(basename $f .TXT)
        # remove windows carriage return,fix bad data records with embedded \n, remove the header line and add the filename as the last column on each line
        sed 's/\r//g' $f | sed '1,1d' | awk '/\$$/ {print;next;} {printf("%s",$0);}' | sed "1,$ s/$/$f/" >> all_outc_legacy_data_with_filename.txt
done

