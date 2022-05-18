#!/bin/bash 

source ${FAERSDBSTATS_REPO_LOCATION}/faers.config

export "AWS_ACCESS_KEY_ID=${AWS_S3_ACCESS_KEY}"
#echo "AWS_S3_ACCESS_KEY = ${AWS_S3_ACCESS_KEY}"

export "AWS_SECRET_ACCESS_KEY=${AWS_S3_SECRET_KEY}"
#echo "AWS_S3_BUCKET_NAME=${AWS_S3_BUCKET_NAME}"

export "AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}"
#echo "AWS_S3_SECRET_KEY=${AWS_S3_SECRET_KEY}"

cd ${BASE_FILE_DIR} 

aws configure list

#maybe set ${JOB_START_TIME} to prepend log filenames


#echo "Begin log "
#echo ${Internal.Job.Name}

echo "Pwd is "
pwd

#rm -rf ${CEM_DOWNLOAD_DATA_FOLDER}
rm -rf ${BASE_FILE_DIR}/data

echo CEM_ORANGE_BOOK_DOWNLOAD_URL is $CEM_ORANGE_BOOK_DOWNLOAD_URL

mkdir ${CEM_DOWNLOAD_DATA_FOLDER}_setup
cd ${CEM_DOWNLOAD_DATA_FOLDER}_setup

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


filename=${CEM_ORANGE_BOOK_DOWNLOAD_FILENAME}

if test -z "$filename"
then
    echo "Could not get filename" 2> error.txt
else
    # figure out how to use zipinfo as a test < shows it's downloaded and actually a zip

    filenameis="downloaded filename is "${filename}
    echo $filenameis

    zipinfo $filename
    echo "BASE_FILE_DIR is ${BASE_FILE_DIR}"
    data_setup_path="${BASE_FILE_DIR}/${CEM_DOWNLOAD_DATA_FOLDER}_setup"

    cd "${data_setup_path}"

    echo "data_setup_path is ${data_setup_path}"

    echo changed directories to
    pwd

    rm -rf orange-book-data-files

    #mkdir -p "orange-book-data-files"/${CEM_DOWNLOAD_YEAR}/${CEM_DOWNLOAD_MONTH}
    mkdir -p "orange-book-data-files"

    echo BASE_FILE_DIR is
    echo ${BASE_FILE_DIR}

    #unzip $filename -d "orange-book-data-files"/${CEM_DOWNLOAD_YEAR}/${CEM_DOWNLOAD_MONTH}
    unzip ${data_setup_path}/$filename -d "orange-book-data-files"

    echo "in ${data_setup_path}/orange-book-data-files line counts are as follows"
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

#echo "last minute aws credential check"
#export AWS_S3_BUCKET_NAME="${AWS_S3_BUCKET_NAME}"
