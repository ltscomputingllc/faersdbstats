#!/bin/sh
##########################################################################
# create the combined legacy demographic files with the filename appended as the last column
# NOTE the demographic file formats are in two versions
# We will call the file format before 2005 Q3 version A and everything from 2005 Q3 onwards, version B
#
# LTS Computing LLC
##########################################################################

# load the demographic format A files:

# process the first format A file - including adding "filename" column name to the header line at the start of the file
f="DEMO04Q1.TXT"
thefilenamenosuffix=$(basename $f .TXT)
# remove windows carriage return, fix bad data records with embedded \n, add on the "filename" column name to the header line and add the filename as the last column on each line
# output to the format A all data file
sed 's/\r$//' $f | sed 'N;s/\n\$/\$/' | sed '1,1 s/$/\$FILENAME/' | sed "2,$ s/$/$f/" > all_version_A_demo_legacy_data_with_filename.txt

# process the other format A files and concatenate to the format A all data file
FILES="
DEMO04Q2.TXT DEMO04Q3.TXT DEMO04Q4.TXT
DEMO05Q1.TXT DEMO05Q2.TXT
"
for f in $FILES
do
        thefilenamenosuffix=$(basename $f .TXT)
        # remove windows carriage return,fix bad data records with embedded \n, remove the header line and add the filename as the last column on each line
        sed 's/\r$//' $f | sed 'N;s/\n\$/\$/' | sed '1,1d' | sed "1,$ s/$/$f/" >> all_version_A_demo_legacy_data_with_filename.txt
done

# load the demographic format B files:

# process the first format B file - including adding "filename" column name to the header line at the start of the file
f="DEMO05Q3.TXT"
thefilenamenosuffix=$(basename $f .TXT)
# remove windows carriage return, fix bad data records with embedded \n, add on the "filename" column name to the header line and add the filename as the last column on each line
# output to the format B all data file
sed 's/\r$//' $f | sed 'N;s/\n\$/\$/' | sed '1,1 s/$/\$FILENAME/' | sed "2,$ s/$/$f/" > all_version_B_demo_legacy_data_with_filename.txt

# process the other format B files and concatenate to the format B all data file
FILES="
DEMO05Q4.TXT
DEMO06Q1.TXT  DEMO06Q2.TXT  DEMO06Q3.TXT  DEMO06Q4.TXT
DEMO07Q1.TXT  DEMO07Q2.TXT  DEMO07Q3.TXT  DEMO07Q4.TXT
DEMO08Q1.TXT  DEMO08Q2.TXT  DEMO08Q3.TXT  DEMO08Q4.TXT
DEMO09Q1.TXT  DEMO09Q2.TXT  DEMO09Q3.TXT  DEMO09Q4.TXT
DEMO10Q1.TXT  DEMO10Q2.TXT  DEMO10Q3.TXT  DEMO10Q4.TXT
DEMO11Q1.TXT  DEMO11Q2.TXT  DEMO11Q3.TXT  DEMO11Q4.TXT
DEMO12Q1.TXT  DEMO12Q2.TXT  DEMO12Q3.TXT
"
for f in $FILES
do
        thefilenamenosuffix=$(basename $f .TXT)
        # remove windows carriage return, fix bad data records with embedded \n, remove the header line and add the filename as the last column on each line
        sed 's/\r$//' $f | sed 'N;s/\n\$/\$/' | sed '1,1d' | sed "1,$ s/$/$f/" >> all_version_B_demo_legacy_data_with_filename.txt
done

# fix problem data record - remove embedded $ field separator in string
sed -i 's/8129732$8401177$I$$8129732-9$20120126$20120206$20120210$EXP$JP-CUBIST-$E2B0000000182$CUBIST PHARMACEUTICALS, INC.$85$YR$M$Y$$$20120210$PH$$$$JAPAN$DEMO12Q1.TXT/8129732$8401177$I$$8129732-9$20120126$20120206$20120210$EXP$JP-CUBIST-E2B0000000182$CUBIST PHARMACEUTICALS, INC.$85$YR$M$Y$$$20120210$PH$$$$JAPAN$DEMO12Q1.TXT/' all_version_B_demo_legacy_data_with_filename.txt
