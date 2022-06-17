#!/bin/sh
# this script downloads all the legacy ASCII format FAERS files from the FDA website
# as of July 23rd 2015
#
# LTS Computing LLC
################################################################

# 12q3| https://fis.fda.gov/content/Exports/aers_ascii_2012q3.zip
# 12q2| https://fis.fda.gov/content/Exports/aers_ascii_2012q2.zip
# 12q1| https://fis.fda.gov/content/Exports/aers_ascii_2012q1.zip
# 11q4| https://fis.fda.gov/content/Exports/aers_ascii_2011q4.zip
# 11q3| https://fis.fda.gov/content/Exports/aers_ascii_2011q3.zip
# 11q2| https://fis.fda.gov/content/Exports/aers_ascii_2011q2.zip
# 11q1| https://fis.fda.gov/content/Exports/aers_ascii_2011q1.zip
# 10q4| https://fis.fda.gov/content/Exports/aers_ascii_2010q4.zip
# 10q3| https://fis.fda.gov/content/Exports/aers_ascii_2010q3.zip
# 10q2| https://fis.fda.gov/content/Exports/aers_ascii_2010q2.zip
# 10q1| https://fis.fda.gov/content/Exports/aers_ascii_2010q1.zip
# 9q4| https://fis.fda.gov/content/Exports/aers_ascii_2009q4.zip
# 9q3| https://fis.fda.gov/content/Exports/aers_ascii_2009q3.zip
# 9q2| https://fis.fda.gov/content/Exports/aers_ascii_2009q2.zip
# 9q1| https://fis.fda.gov/content/Exports/aers_ascii_2009q1.zip
# 8q4| https://fis.fda.gov/content/Exports/aers_ascii_2008q4.zip
# 8q3| https://fis.fda.gov/content/Exports/aers_ascii_2008q3.zip
# 8q2| https://fis.fda.gov/content/Exports/aers_ascii_2008q2.zip
# 8q1| https://fis.fda.gov/content/Exports/aers_ascii_2008q1.zip
# 7q4| https://fis.fda.gov/content/Exports/aers_ascii_2007q4.zip
# 7q3| https://fis.fda.gov/content/Exports/aers_ascii_2007q3.zip
# 7q2| https://fis.fda.gov/content/Exports/aers_ascii_2007q2.zip
# 7q1| https://fis.fda.gov/content/Exports/aers_ascii_2007q1.zip
# 6q4|https://fis.fda.gov/content/Exports/aers_ascii_2006q4.zip
# 6q3| https://fis.fda.gov/content/Exports/aers_ascii_2006q3.zip
# 6q2| https://fis.fda.gov/content/Exports/aers_ascii_2006q2.zip
# 6q1| https://fis.fda.gov/content/Exports/aers_ascii_2006q1.zip
# 5q4| https://fis.fda.gov/content/Exports/aers_ascii_2005q4.zip
# 5q3| https://fis.fda.gov/content/Exports/aers_ascii_2005q3.zip
# 5q2| https://fis.fda.gov/content/Exports/aers_ascii_2005q2.zip
# 5q1| https://fis.fda.gov/content/Exports/aers_ascii_2005q1.zip
# 4q4| https://fis.fda.gov/content/Exports/aers_ascii_2004q4.zip
# 4q3| https://fis.fda.gov/content/Exports/aers_ascii_2004q3.zip
# 4q2| https://fis.fda.gov/content/Exports/aers_ascii_2004q2.zip
# 4q1| https://fis.fda.gov/content/Exports/aers_ascii_2004q1.zip


# FAERS ASCII 2012 Q3
sleep 2
fileyearquarter=12Q3
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM337616.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2012q3.zip
unzip aers_ascii_2012q3.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2012 Q2
sleep 2
fileyearquarter=12Q2
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM319844.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2012q2.zip
unzip aers_ascii_2012q2.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2012 Q1
sleep 2
fileyearquarter=12Q1
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM307572.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2012q1.zip
unzip aers_ascii_2012q1.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2011 Q4
sleep 2
fileyearquarter=11Q4
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM300452.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2011q4.zip
unzip aers_ascii_2011q4.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2011 Q3
sleep 2
fileyearquarter=11Q3
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM287845.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2011q3.zip
unzip aers_ascii_2011q3.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2011 Q2
sleep 2
fileyearquarter=11Q2
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM278762.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2011q2.zip
unzip aers_ascii_2011q2.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2011 Q1
sleep 2
fileyearquarter=11Q1
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM270803.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2011q1.zip
unzip aers_ascii_2011q1.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2010 Q4
sleep 2
fileyearquarter=10Q4
# get https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM251745.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2010q4.zip
unzip aers_ascii_2010q4.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2010 Q3
sleep 2
fileyearquarter=10Q3
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM244691.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2010q3.zip
unzip aers_ascii_2010q3.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2010 Q2
sleep 2
fileyearquarter=10Q2
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM232595.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2010q2.zip
unzip aers_ascii_2010q2.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2010 Q1
sleep 2
fileyearquarter=10Q1
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM220802.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2010q1.zip
unzip aers_ascii_2010q1.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2009 Q4
sleep 2
fileyearquarter=09Q4
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM213485.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2009q4.zip
unzip aers_ascii_2009q4.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2009 Q3
sleep 2
fileyearquarter=09Q3
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM197917.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2009q3.zip
unzip aers_ascii_2009q3.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2009 Q2
sleep 2
fileyearquarter=09Q2
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM186488.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2009q2.zip
unzip aers_ascii_2009q2.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2009 Q1
sleep 2
fileyearquarter=09Q1
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM173888.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2009q1.zip
unzip aers_ascii_2009q1.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2008 Q4
sleep 2
fileyearquarter=08Q4
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/UCM150381.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2008q4.zip
unzip aers_ascii_2008q4.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2008 Q3
sleep 2
fileyearquarter=08Q3
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm085780.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2008q3.zip
unzip aers_ascii_2008q3.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2008 Q2
sleep 2
fileyearquarter=08Q2
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm085785.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2008q2.zip
unzip aers_ascii_2008q2.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2008 Q1
sleep 2
fileyearquarter=08Q1
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm085793.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2008q1.zip
unzip aers_ascii_2008q1.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2007 Q4
sleep 2
fileyearquarter=07Q4
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm085809.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2007q4.zip
unzip aers_ascii_2007q4.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2007 Q3
sleep 2
fileyearquarter=07Q3
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm083816.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2007q3.zip
unzip aers_ascii_2007q3.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2007 Q2
sleep 2
fileyearquarter=07Q2
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm083983.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2007q2.zip
unzip aers_ascii_2007q2.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2007 Q1
sleep 2
fileyearquarter=07Q1
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084042.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2007q1.zip
unzip aers_ascii_2007q1.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2006 Q4
sleep 2
fileyearquarter=06Q4
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084161.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2006q4.zip
unzip aers_ascii_2006q4.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2006 Q3
sleep 2
fileyearquarter=06Q3
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084206.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2006q3.zip
unzip aers_ascii_2006q3.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2006 Q2
sleep 2
fileyearquarter=06Q2
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084217.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2006q2.zip
unzip aers_ascii_2006q2.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2006 Q1
sleep 2
fileyearquarter=06Q1
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084242.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2006q1.zip
unzip aers_ascii_2006q1.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2005 Q4
sleep 2
fileyearquarter=05Q4
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084259.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2005q4.zip
unzip aers_ascii_2005q4.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2005 Q3
sleep 2
fileyearquarter=05Q3
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084277.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2005q3.zip
unzip aers_ascii_2005q3.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2005 Q2
sleep 2
fileyearquarter=05Q2
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084916.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2005q2.zip
unzip aers_ascii_2005q2.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2005 Q1
sleep 2
fileyearquarter=05Q1
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084918.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2005q1.zip
unzip aers_ascii_2005q1.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2004 Q4
sleep 2
fileyearquarter=04Q4
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084920.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2004q4.zip
unzip aers_ascii_2004q4.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2004 Q3
sleep 2
fileyearquarter=04Q3
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084922.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2004q3.zip
unzip aers_ascii_2004q3.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2004 Q2
sleep 2
fileyearquarter=04Q2
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084924.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2004q2.zip
unzip aers_ascii_2004q2.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"

# FAERS ASCII 2004 Q1
sleep 2
fileyearquarter=04Q1
# wget https://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm084927.zip
wget https://fis.fda.gov/content/Exports/aers_ascii_2004q1.zip
unzip aers_ascii_2004q1.zip
mv README.doc "ascii/README${fileyearquarter}.doc"
mv "SIZE${fileyearquarter}.TXT" ascii
mv ascii/Asc_nts.doc "ascii/ASC_NTS${fileyearquarter}.doc"
