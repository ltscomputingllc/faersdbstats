#!/bin/sh
# this script downloads all the current ASCII format FAERS files from the FDA website
# as of May 15th 2018
#
# LTS Computing LLC
################################################################


# 19q1| https://fis.fda.gov/content/Exports/faers_ascii_2019Q1.zip
# 18a4| https://fis.fda.gov/content/Exports/faers_ascii_2018q4.zip
# 18q3| https://fis.fda.gov/content/Exports/faers_ascii_2018q3.zip
# 18q2| https://fis.fda.gov/content/Exports/faers_ascii_2018q2.zip
# 18q1| https://fis.fda.gov/content/Exports/faers_ascii_2018q1.zip

# FAERS ASCII 2021 Q1
fileyearquarter=21q1
wget https://fis.fda.gov/content/Exports/faers_ascii_2021q1.zip
unzip faers_ascii_2021q1.zip
mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"


# FAERS ASCII 2020 Q4
# fileyearquarter=20q4
# wget https://fis.fda.gov/content/Exports/faers_ascii_2020q4.zip
# unzip faers_ascii_2020q4.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"


# # FAERS ASCII 2020 Q3
# fileyearquarter=20q3
# wget https://fis.fda.gov/content/Exports/faers_ascii_2020q3.zip
# unzip faers_ascii_2020q3.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"


# # FAERS ASCII 2020 Q2
# fileyearquarter=20q2
# wget https://fis.fda.gov/content/Exports/faers_ascii_2020q2.zip
# unzip faers_ascii_2020q2.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"


# # FAERS ASCII 2020 Q1
# fileyearquarter=20q1
# wget https://fis.fda.gov/content/Exports/faers_ascii_2020q1.zip
# unzip faers_ascii_2020q1.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"


# # FAERS ASCII 2019 Q4
# fileyearquarter=19q4
# wget https://fis.fda.gov/content/Exports/faers_ascii_2019q4.zip
# unzip faers_ascii_2019q4.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"


# # FAERS ASCII 2019 Q3
# fileyearquarter=19q3
# wget https://fis.fda.gov/content/Exports/faers_ascii_2019q3.zip
# unzip faers_ascii_2019q3.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"


# # FAERS ASCII 2019 Q2
# fileyearquarter=19q2
# wget https://fis.fda.gov/content/Exports/faers_ascii_2019q2.zip
# unzip faers_ascii_2019q2.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"


# # FAERS ASCII 2019 Q1
# fileyearquarter=19q1
# wget https://fis.fda.gov/content/Exports/faers_ascii_2019q1.zip
# unzip faers_ascii_2019q1.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2018 q4
# fileyearquarter=18q4
# wget https://fis.fda.gov/content/Exports/faers_ascii_2018q4.zip
# unzip faers_ascii_2018q4.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2018 q3
# fileyearquarter=18q3
# wget https://fis.fda.gov/content/Exports/faers_ascii_2018q3.zip
# unzip faers_ascii_2018q3.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2018 q2
# fileyearquarter=18q2
# wget https://fis.fda.gov/content/Exports/faers_ascii_2018q2.zip
# unzip faers_ascii_2018q2.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"


# # FAERS ASCII 2018 q1
# fileyearquarter=18q1
# wget https://fis.fda.gov/content/Exports/faers_ascii_2018q1.zip
# unzip faers_ascii_2018q1.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2017 q4
# fileyearquarter=17q4
# wget https://fis.fda.gov/content/Exports/faers_ascii_2017q4.zip
# unzip faers_ascii_2017q4.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2017 Q3
# fileyearquarter=17q3
# #wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM590948.zip
# wget https://fis.fda.gov/content/Exports/faers_ascii_2017q3.zip
# unzip faers_ascii_2017q3.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2017 Q2
# fileyearquarter=17q2
# #wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM578242.zip
# wget https://fis.fda.gov/content/Exports/faers_ascii_2017q2.zip
# unzip faers_ascii_2017q2.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2017 Q1
# fileyearquarter=17q1
# #wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM562290.zip
# wget https://fis.fda.gov/content/Exports/faers_ascii_2017q1.zip
# unzip faers_ascii_2017q1.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2016 Q4
# fileyearquarter=16q4
# #wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM546946.zip
# wget https://fis.fda.gov/content/Exports/faers_ascii_2016q4.zip
# unzip faers_ascii_2016q4.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2016 Q3
# fileyearquarter=16q3
# #wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM534900.zip
# wget https://fis.fda.gov/content/Exports/faers_ascii_2016q3.zip
# unzip faers_ascii_2016q3.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2016 Q2
# fileyearquarter=16q2
# #wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM521951.zip
# wget https://fis.fda.gov/content/Exports/faers_ascii_2016q2.zip
# unzip faers_ascii_2016q2.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2016 Q1
# fileyearquarter=16q1
# #wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM509489.zip
# wget https://fis.fda.gov/content/Exports/faers_ascii_2016q1.zip
# unzip faers_ascii_2016q1.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2015 Q4
# fileyearquarter=15q4
# #wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM492340.zip
# wget https://fis.fda.gov/content/Exports/faers_ascii_2015q4.zip
# unzip faers_ascii_2015q4.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2015 Q3
# fileyearquarter=15q3
# #wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM477190.zip
# wget https://fis.fda.gov/content/Exports/faers_ascii_2015q3.zip
# unzip faers_ascii_2015q3.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2015 Q2
# fileyearquarter=15q2
# #wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM463272.zip
# wget https://fis.fda.gov/content/Exports/faers_ascii_2015q2.zip
# unzip faers_ascii_2015q2.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2015 Q1
# fileyearquarter=15q1
# #wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM458083.zip
# wget https://fis.fda.gov/content/Exports/faers_ascii_2015q1.zip
# unzip faers_ascii_2015q1.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"


# # FAERS ASCII 2014 Q4
# fileyearquarter=14q4
# #wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM451489.zip
# wget https://fis.fda.gov/content/Exports/faers_ascii_2014q4.zip
# unzip faers_ascii_2014q4.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2014 Q3
# fileyearquarter=14q3
# #wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM443579.zip
# wget https://fis.fda.gov/content/Exports/faers_ascii_2014q3.zip
# unzip faers_ascii_2014q3.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2014 Q2
# fileyearquarter=14q2
# #wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM429323.zip
# wget https://fis.fda.gov/content/Exports/faers_ascii_2014q2.zip
# unzip faers_ascii_2014q2.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2014 Q1
# fileyearquarter=14q1
# #wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM419914.zip
# wget https://fis.fda.gov/content/Exports/faers_ascii_2014q1.zip
# unzip faers_ascii_2014q1.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2013 Q4
# fileyearquarter=13q4
# #wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM409890.zip
# wget https://fis.fda.gov/content/Exports/faers_ascii_2013q4.zip
# unzip faers_ascii_2013q4.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2013 Q3
# fileyearquarter=13q3
# #wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM399592.zip
# wget https://fis.fda.gov/content/Exports/faers_ascii_2013q3.zip
# unzip faers_ascii_2013q3.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2013 Q2
# fileyearquarter=13q2
# #wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM395994.zip
# wget https://fis.fda.gov/content/Exports/faers_ascii_2013q2.zip
# unzip faers_ascii_2013q2.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2013 Q1
# fileyearquarter=13q1
# #wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM387233.zip
# wget https://fis.fda.gov/content/Exports/faers_ascii_2013q1.zip
# unzip faers_ascii_2013q1.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv Readme.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # FAERS ASCII 2012 Q4
# fileyearquarter=12q4
# #wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM364757.zip
# wget https://fis.fda.gov/content/Exports/faers_ascii_2012q4.zip
# unzip faers_ascii_2012q4.zip
# mv FAQs.pdf "ascii/FAQs${fileyearquarter}.pdf"
# mv FAQs.doc "ascii/FAQs${fileyearquarter}.doc"
# mv Readme.pdf "ascii/Readme${fileyearquarter}.pdf"
# mv README.doc "ascii/Readme${fileyearquarter}.doc"
# mv ascii/ASC_NTS.pdf "ascii/ASC_NTS${fileyearquarter}.pdf"
# mv ascii/ASC_NTS.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# # cleanup from miscellaneous sub-directory names
# mv ASCII/* ascii
# mv asci/* ascii
# mv asii/* ascii
# rmdir ASCII
# rmdir asci
# rmdir asii
