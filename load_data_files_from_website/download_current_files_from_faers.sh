#!/bin/sh
# this script downloads all the current ASCII format FAERS files from the FDA website
# as of May 15th 2018
#
# LTS Computing LLC
################################################################

# FAERS ASCII 2017 Q4
fileyearquarter=17q4
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM605569.zip
unzip UCM605569.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2017 Q3
fileyearquarter=17q3
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM590948.zip
unzip UCM590948.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2017 Q2
fileyearquarter=17q2
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM578242.zip
unzip UCM578242.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2017 Q1
fileyearquarter=17q1
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM562290.zip
unzip UCM562290.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2016 Q4
fileyearquarter=16q4
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM546946.zip
unzip UCM546946.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2016 Q3
fileyearquarter=16q3
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM534900.zip
unzip UCM534900.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2016 Q2
fileyearquarter=16q2
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM521951.zip
unzip UCM521951.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2016 Q1
fileyearquarter=16q1
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM509489.zip
unzip UCM509489.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2015 Q4
fileyearquarter=15q4
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM492340.zip
unzip UCM492340.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2015 Q3
fileyearquarter=15q3
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM477190.zip
unzip UCM477190.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2015 Q2
fileyearquarter=15q2
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM463272.zip
unzip UCM463272.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2015 Q1
fileyearquarter=15q1
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM458083.zip
unzip UCM458083.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"


# FAERS ASCII 2014 Q4
fileyearquarter=14q4
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM451489.zip
unzip UCM451489.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2014 Q3
fileyearquarter=14q3
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM443579.zip
unzip UCM443579.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2014 Q2
fileyearquarter=14q2
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM429323.zip
unzip UCM429323.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2014 Q1
fileyearquarter=14q1
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM419914.zip
unzip UCM419914.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2013 Q4
fileyearquarter=13q4
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM409890.zip
unzip UCM409890.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2013 Q3
fileyearquarter=13q3
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM399592.zip
unzip UCM399592.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2013 Q2
fileyearquarter=13q2
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM395994.zip
unzip UCM395994.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2013 Q1
fileyearquarter=13q1
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM387233.zip
unzip UCM387233.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2012 Q4
fileyearquarter=12q4
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM364757.zip
unzip UCM364757.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv README.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# cleanup from miscellaneous sub-directory names
mv ASCII/* ascii
mv asci/* ascii
mv asii/* ascii
rmdir ASCII
rmdir asci
rmdir asii
