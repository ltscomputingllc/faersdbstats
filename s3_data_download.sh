#!/bin/bash
#shell options #-s enable (set) each optname #globstar enables ** recursive dir search

#source ../faers.config

#source ./faersdbstats/faers.config
 #export AWS_PROFILE=user1

export "AWS_ACCESS_KEY_ID=${AWS_S3_ACCESS_KEY}"
#echo "AWS_S3_ACCESS_KEY = ${AWS_S3_ACCESS_KEY}"

export "AWS_SECRET_ACCESS_KEY=${AWS_S3_SECRET_KEY}"
#echo "AWS_S3_BUCKET_NAME=${AWS_S3_BUCKET_NAME}"

export "AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}"

aws configure list

#exit;

shopt -s globstar
cd ${BASE_FILE_DIR}

#check if /data_from s3 does not exist then either create it or delete and recreate it
if [ ! -d "data_from_s3" ]; then
    echo data_from_s3 does not exist, will make - line 8
	mkdir data_from_s3
else 
    echo data_from_s3 does exist, will remove and recreate - line 11
	rm -r data_from_s3
	mkdir data_from_s3
fi
cd data_from_s3

#if LOAD_NEW_DATA
if [ "${LOAD_ALL_TIME}" = 1 ]; then

    #download s3://..data_test to local/data_from_s3
    echo data will be downloaded to ${BASE_FILE_DIR}/data_from_s3/
    aws s3 cp s3://napdi-cem-sandbox-files/data_test/ ${BASE_FILE_DIR}/data_from_s3/ --recursive --exclude "*" --include "*.txt"

    #locally loop through domains and create one staged import file ("domain".txt ie demo.txt)
    curdir=`pwd`;
    headempty=0
    echo 'pwd is ';
    echo `pwd` it should be path/to/data_from_s3;
    for domain in demo drug indi outc reac rpsr ther; do
        echo 'domain is '$domain;
        #mkdir $domain #throws error because aws cp created it
        cd $domain
        #for name in "${BASE_FILE_DIR}"/data_from_s3/**/*.txt; do #if data_from_s3 isn't specified it might run /all_data/ and take forever
        for name in ./**/*.txt; do
        echo 'name is '$name;
            if [ $headempty = 0 ]; then
                #put header row into drug.txt
                head -1 --quiet $name > $domain.txt
                
                headempty=1 &&
                #tail outputs last -n+2 lines of a file #-q does not output the filename
                tail -n +2 --quiet $name >> $domain.txt
            else
                #tail outputs last -n+2 lines of a file #-q does not output the filename
                tail -n +2 --quiet $name >> $domain.txt
            fi
            #break 60
        done; #end for name in ./**/*.txt; do
        #reset headempty for next domain
        headempty=0
        cd $curdir
        #break 60
    done; #end for domain in drug demo; do 
else #not LOAD_ALL_DATA equivalent to LOAD_NEW_DATA
    echo ONLY LOADING NEW DATA
    
        #download s3://..data_test to local/data_from_s3
        echo data will be downloaded to ${BASE_FILE_DIR}/data_from_s3/

        #locally loop through domains and create one staged import file ("domain".txt ie demo.txt)
        curdir=`pwd`;
        headempty=0
        echo 'pwd is ';
        echo `pwd` it should be path/to/data_from_s3 aka BASE_FILE_DIR;

        #make use case for legacy data faers_or_laers
        if [ ${LOAD_NEW_YEAR} -le 2012 ]
        then
            faers_or_laers='laers';
        else
            faers_or_laers='faers';
        fi

        for domain in demo drug indi outc reac rpsr ther; do # indi rpsr outc; do
            newpath=s3://napdi-cem-sandbox-files/$faers_or_laers/data_test/$domain/${LOAD_NEW_YEAR}/${LOAD_NEW_QUARTER}
            #newpath=s3://napdi-cem-sandbox-files/$faers_or_laers/data/$domain/${LOAD_NEW_YEAR}/${LOAD_NEW_QUARTER}
            state=`aws s3 ls $newpath`
            if [ -z "$state" ]
                then
                    >&2 echo $newpath does not exist, check config and s3                
                    exit 1
                else
                    echo $newpath' Path exists'                
                    aws s3 cp $newpath ${BASE_FILE_DIR}/data_from_s3/$domain/${LOAD_NEW_YEAR}/${LOAD_NEW_QUARTER} --recursive --exclude "*" --include "*.txt"
                    #mkdir $domain #throws error because aws cp created it
                    cd "$domain"
                    #for name in "${BASE_FILE_DIR}"/data_from_s3/**/*.txt; do #if data_from_s3 isn't specified it might run /all_data/ and take forever
                    echo $(ls ./**)
                    for name in ./**/*.txt; do
                        echo 'name is '$name;
                            if [ $headempty = 0 ]; then
                                #put header row into drug.txt
                                head -1 --quiet $name > $domain.txt
                                
                                headempty=1 &&
                                #tail outputs last -n+2 lines of a file #-q does not output the filename
                                tail -n +2 --quiet $name >> $domain.txt
                            else
                                #tail outputs last -n+2 lines of a file #-q does not output the filename
                                tail -n +2 --quiet $name >> $domain.txt
                            fi #end if [ $headempty = 0 ]; then
                            #break 60
                    done; #end for name in ./**/*.txt; do
            fi #end if [ -z "$state" ]
        #reset headempty for next domain
        headempty=0
        echo pwd is `pwd`
        echo '$curdir is '$curdir
        cd $curdir #not sure if needed
        #break 60
    done; #end for domain in demo drug; do
    #done;
fi #end if [ "${LOAD_ALL_TIME}" = 1 ]; then