import json

f = open("xaa-subset-to-100-expert-filtered-METAMAP.json","r")
mm = json.load(f)
f.close()

len(mm['AllDocuments'])
# 1979

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
                    #outL.append(newl)

#for elt in outL:
#    print("\t".join(elt))

    

