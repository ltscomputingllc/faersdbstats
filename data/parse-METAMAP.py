#!/usr/bin/python

import json
import sys, getopt

def main(argv):
    inputfile = ''
  
    try:
        opts, args = getopt.getopt(argv,"hi:",["ifile="])
    except getopt.GetoptError:
        print 'parse-METAMAP.py -i <inputfile> '
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'parse-METAMAP.py -i <inputfile>'
            sys.exit()
        elif opt in ("-i", "--ifile"):
            inputfile = arg

    f = open(inputfile,"r")
    mm = json.load(f)
    f.close()

    # print "INFO: Number of documents in the json file: " + str(len(mm['AllDocuments']))
    

    ## Example mapping record
    # mm['AllDocuments'][0]['Document']['Utterances'][0]['Phrases'][0]['Mappings'][0]['MappingCandidates'][0]['Sources']

    print("UTTERANCE	CUI	PT	ST	SOURCES")
    outL = []
    for i in mm['AllDocuments']:
        for j in i['Document']['Utterances']:
            for k in j['Phrases']:
                for l in k['Mappings']:
                    for m in l['MappingCandidates']:
                        newl = []
                        newl.append(j['UttText'])
                        newl.append(m['CandidateCUI'])
                        newl.append(m['CandidatePreferred'])
                        newl.append(str(m['SemTypes']))
                        newl.append(str(m['Sources']))
                        print("\t".join(newl))

            
if __name__ == "__main__":
    main(sys.argv[1:])



    

