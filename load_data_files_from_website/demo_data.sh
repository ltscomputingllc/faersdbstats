#!/bin/bash
##########################################################################
# create the combined demographic files with the filename appended as the last column
# NOTE the demographic file formats are in two versions
# We will call the file format before 2014 Q3 version A and everything from 2014 Q3 onwards, version B
#
# LTS Computing LLC
##########################################################################

. ../faers.config


if [ ${LOAD_NEW_DATA} = "1" ];
then
# echo "new quarter is "
# echo ${LOAD_NEW_QUARTER}

# echo "new year is "
# echo ${LOAD_NEW_YEAR}

fileyearquarter="${LOAD_NEW_YEAR}${LOAD_NEW_QUARTER}"

echo "fileyearquarter is "
echo fileyearquarter

#fileyearquarter=21q1
wget https://fis.fda.gov/content/Exports/faers_ascii_${fileyearquarter}.zip
unzip faers_ascii_${fileyearquarter}.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

thefilenamenoprefix="DEMO${LOAD_NEW_YEAR}${LOAD_NEW_QUARTER}"

echo "thefilenamenoprefix is ${thefilenamenoprefix}"

#thefilenamenoprefix=DEMO20Q3
thefilename="${thefilenamenoprefix}.txt"
# remove windows carriage return, remove the header line and add the filename as the last column on each line
sed 's/\r$//' "${thefilename}"| sed '1,1d' | sed "1,$ s/$/\$${thefilename}/" >"${thefilenamenoprefix}_with_filename.txt"


else
echo "in the else"

fi