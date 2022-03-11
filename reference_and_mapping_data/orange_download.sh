#!/bin/bash 

#source ../../config.config

cd ${BASE_FILE_DIR} 

#maybe set ${JOB_START_TIME} to prepend log filenames


#echo "Begin log "
#echo ${Internal.Job.Name}

echo "Pwd is "
pwd

#rm -rf ${CEM_DOWNLOAD_DATA_FOLDER}
rm -rf ${BASE_FILE_DIR}/data

echo CEM_ORANGE_BOOK_DOWNLOAD_URL is $CEM_ORANGE_BOOK_DOWNLOAD_URL

mkdir data
cd data

echo pwd is
pwd


curl -f ${CEM_ORANGE_BOOK_DOWNLOAD_URL} -JLO && echo "SUCCESS!" ||
    echo "It did not download double check your URL and that the file does not exist in pwd" |

#works
#curl -f 'https://www.fda.gov/media/76860/download' -JLO && echo "SUCCESS!" ||
#    echo "It did not download double check your URL"

filename=$(find . -maxdepth 1 -name "EOBZIP_*")

#take off ./
#filename=${filename:2}


filename="EOBZIP_2022_01.zip"

if test -z "$filename"
then
    echo "Could not get filename" 2> error.txt
else
    # figure out how to use zipinfo as a test < shows it's downloaded and actually a zip
    filenameis="downloaded filename is "${filename}
    echo $filenameis

    zipinfo $filename

    cd ${FAERSDBSTATS_REPO_LOCATION}/${CEM_DOWNLOAD_DATA_FOLDER} 

    echo changed directories to
    pwd

    rm -rf orange-book-data-files

    #mkdir -p "orange-book-data-files"/${CEM_DOWNLOAD_YEAR}/${CEM_DOWNLOAD_MONTH}
    mkdir -p "orange-book-data-files"

    echo BASE_FILE_DIR is
    echo ${BASE_FILE_DIR}

    #unzip $filename -d "orange-book-data-files"/${CEM_DOWNLOAD_YEAR}/${CEM_DOWNLOAD_MONTH}
    unzip ${BASE_FILE_DIR}/data/$filename -d "orange-book-data-files"

    echo in ${FAERSDBSTATS_REPO_LOCATION}/${CEM_DOWNLOAD_DATA_FOLDER}/orange-book-data-files line counts are as follows
    wc -l orange-book-data-files/exclusivity.txt
    wc -l orange-book-data-files/patent.txt #do we use this? 
    wc -l orange-book-data-files/products.txt 
fi

#echo the location of the log file is 
#pwd 

# {
    #exec 1>> output.txt
    #exec 2>> error.txt
# }
#or
#exec >logfile.txt 2>&1

#echo "End " ${Internal.Job.Name} " log " >> error.txt >> output.txt

