#!/usr/bin/python3

# getDrugNameMatches.py

# Accepts string input - expects the exact string for a drug of
# interest (could be ingredient generic or brand)

# Parameter specifies if the string results returned need to include
# exact match or a "fuzzy" to some metric of fuzzyness (e.g., 1,
# 2, or 3, character replacements)

# NOTE: this program uses a file of unmapped drug names pulled from
# the FAERS data base using the following query. The output was
# cleaned of quotes at the begining and end of lines, purely
# puctuatipn rows, and purely numeric rows:

# select distinct drug_name_original
#from faers.combined_drug_mapping cdm 
# where cdm.concept_id is null 
# ;

import sys
import getopt
import Levenshtein
import re
import codecs

def main(argv):
    distance = 0
    drugstring = ''
    drugstringL = None
    inputFName = ''
    outputFName = None

    linesN = 0
    dnFile = None
    lines = None
    badRecs = []
    originalStringsD = {}
    matches = []
    outString = ""

    try:
        opts, args = getopt.getopt(argv, 'hd:s:f:o:', ['distance=', 'drugstring=', 'inputfile=', 'outputfile='])
    except getopt.GetoptError:
        print('getDrugNameMatches.py -d <allowable number of character changes to match> -s <drug string - could be a single drug name or a quoted pipe-delimitted list of drug names e.g., "name 1|name 2|name 3". If the latter, names cannot include pipes.> -f <pipe delimited file (unix newlines) with unmapped drug strings as the first field and the count of reports as the second> -o <(optional) file to write the output to>')
        sys.exit(2)

    for opt, arg in opts:
      if opt == '-h':
         print('getDrugNameMatches.py -d <allowable number of character changes to match> -s <drug string - could be a single drug name or a quoted pipe-delimitted list of drug names e.g., "name 1|name 2|name 3". If the latter, names cannot include pipes.> -f <pipe delimited file (unix newlines) with unmapped drug strings as the first field and the count of reports as the second> -o <(optional) file to write the output to>')
         sys.exit()
         
      elif opt in ('-d', '--distance'):
          try:
              distance = int(arg)
          except ValueError:
              print('Please pass the allowable as a number of character changes to match - you passed',arg)
              sys.exit(2)
              
      elif opt in ("-s", "--drugstring"):
         drugstring = arg.upper()
         if drugstring.find('|') != -1:
             drugstringL = [x.strip() for x in drugstring.split('|')]

      elif opt in ("-f", "--inputfile"):
         inputFName = arg

      elif opt in ("-o", "--outputfile"):
         outputFName = arg

    outString += '\nSearching for string matches to ' + drugstring + ' using input file ' + inputFName + ' and ' + str(distance) + ' allowed character replacements.\n'

   
    try:
        dnFile = codecs.open(inputFName,'r','utf-8')
        
    except IOError:
        outString += '\nERROR: There was an error opening the file, please be sure it is a simple text file (i.e., not a Word document or similar) pipe delimited file (unix newlines) with unmapped drug strings as the first field and the count of reports as the second\n'
       
    lines = dnFile.read().split(u'\n')
    dnFile.close()
    
    linesN = len(lines)
    outString += 'Input file ' + str(inputFName) + ' has ' + str(linesN) + ' lines.'

    i = -1
    for elt in lines:
        i +=1
        
        pipeCnt = elt.count(u'|')
        if elt == 0:
            outString += '\n\nNOTE: Blank line. assuming end of file. Total number of lines processed: ' + str(i) + '. Total lines in file:' + str(linesN) + '\n'
            break
        
        if pipeCnt > 0:
            badRecs.append(elt)
            continue
            
        dname = elt.strip()
        originalStringsD[dname.upper()] = 1


    outString += '\n\nTotal length of unmapped drug strings input from the file (removing duplicates): ' + str(len(originalStringsD.keys())) + '\n'

    if distance == 0:
        if not drugstringL:
            matches = list(filter(lambda x: x.find(drugstring) != -1, originalStringsD.keys()))
        else:
            for delt in drugstringL:
                matches += list(filter(lambda x: x.find(delt) != -1, originalStringsD.keys()))
    else:
        ## Iterate through the list of umapped, split each by non-alphanumeric, iterate through that list, anything that matches based on the distance is a hit
        if not drugstringL:
            for k in originalStringsD.keys():
                kL = re.split(u'[^a-zA-Z]', k)
                subMatches = filter(lambda x:  Levenshtein.distance(drugstring, x) == distance, kL)
                if len(list(subMatches)) > 0:
                    matches.append(k)
        else:
            for delt in drugstringL:
                for k in originalStringsD.keys():
                    kL = re.split(u'[^a-zA-Z]', k)
                    subMatches = filter(lambda x: Levenshtein.distance(delt, x) == distance, kL)
                    if len(list(subMatches)) > 0:
                        matches.append(k)

    sortedMatches = list(set(matches))
    sortedMatches.sort()

    outString += '\n\n\nNOTE: these drug strings could not be processed because they contain one or more pipe symbols. These will need to be corrected BOTH in the database and in   the input file:\n' + "\n".join(badRecs) + '\n'
    
    outString += '\n\n\nMATCH RESULTS:\n' + '\n'.join(sortedMatches) + '\n'

    if outputFName:
        oFile = codecs.open(outputFName, 'w','utf-8')
        oFile.write(outString)
        oFile.close()
    else:
        print(outString)
    
if __name__ == "__main__":
   main(sys.argv[1:])


    
