#!/bin/sh
# this script downloads all the legacy ASCII format FAERS files from the FDA website
# as of July 23rd 2015
#
# LTS Computing LLC
################################################################

# FAERS ASCII 2012 Q3
sleep 2
fileyearquarter=12Q3
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM337616.zip
unzip UCM337616.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2012 Q2
sleep 2
fileyearquarter=12Q2
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM319844.zip
unzip UCM319844.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2012 Q1
sleep 2
fileyearquarter=12Q1
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM307572.zip
unzip UCM307572.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2011 Q4
sleep 2
fileyearquarter=11Q4
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM300452.zip
unzip UCM300452.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2011 Q3
sleep 2
fileyearquarter=11Q3
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM287845.zip
unzip UCM287845.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2011 Q2
sleep 2
fileyearquarter=11Q2
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM278762.zip
unzip UCM278762.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2011 Q1
sleep 2
fileyearquarter=11Q1
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM270803.zip
unzip UCM270803.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2010 Q4
sleep 2
fileyearquarter=10Q4
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM251745.zip
unzip UCM251745.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2010 Q3
sleep 2
fileyearquarter=10Q3
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM244691.zip
unzip UCM244691.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2010 Q2
sleep 2
fileyearquarter=10Q2
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM232595.zip
unzip UCM232595.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2010 Q1
sleep 2
fileyearquarter=10Q1
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM220802.zip
unzip UCM220802.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2009 Q4
sleep 2
fileyearquarter=09Q4
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM213485.zip
unzip UCM213485.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2009 Q3
sleep 2
fileyearquarter=09Q3
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM197917.zip
unzip UCM197917.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2009 Q2
sleep 2
fileyearquarter=09Q2
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM186488.zip
unzip UCM186488.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2009 Q1
sleep 2
fileyearquarter=09Q1
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM173888.zip
unzip UCM173888.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2008 Q4
sleep 2
fileyearquarter=08Q4
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM150381.zip
unzip UCM150381.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2008 Q3
sleep 2
fileyearquarter=08Q3
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm085780.zip
unzip ucm085780.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2008 Q2
sleep 2
fileyearquarter=08Q2
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm085785.zip
unzip ucm085785.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2008 Q1
sleep 2
fileyearquarter=08Q1
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm085793.zip
unzip ucm085793.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2007 Q4
sleep 2
fileyearquarter=07Q4
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm085809.zip
unzip ucm085809.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2007 Q3
sleep 2
fileyearquarter=07Q3
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm083816.zip
unzip ucm083816.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2007 Q2
sleep 2
fileyearquarter=07Q2
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm083983.zip
unzip ucm083983.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2007 Q1
sleep 2
fileyearquarter=07Q1
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084042.zip
unzip ucm084042.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2006 Q4
sleep 2
fileyearquarter=06Q4
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084161.zip
unzip ucm084161.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2006 Q3
sleep 2
fileyearquarter=06Q3
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084206.zip
unzip ucm084206.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2006 Q2
sleep 2
fileyearquarter=06Q2
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084217.zip
unzip ucm084217.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2006 Q1
sleep 2
fileyearquarter=06Q1
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084242.zip
unzip ucm084242.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2005 Q4
sleep 2
fileyearquarter=05Q4
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084259.zip
unzip ucm084259.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2005 Q3
sleep 2
fileyearquarter=05Q3
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084277.zip
unzip ucm084277.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2005 Q2
sleep 2
fileyearquarter=05Q2
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084916.zip
unzip ucm084916.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2005 Q1
sleep 2
fileyearquarter=05Q1
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084918.zip
unzip ucm084918.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2004 Q4
sleep 2
fileyearquarter=04Q4
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084920.zip
unzip ucm084920.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2004 Q3
sleep 2
fileyearquarter=04Q3
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084922.zip
unzip ucm084922.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2004 Q2
sleep 2
fileyearquarter=04Q2
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084924.zip
unzip ucm084924.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2004 Q1
sleep 2
fileyearquarter=04Q1
wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084927.zip
unzip ucm084927.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"
