#!/bin/bash 

cd ${BASE_FILE_DIR}

curl -f ${CEM_ORANGE_BOOK_DOWNLOAD_URL} -JLO && echo "SUCCESS!" ||
    echo "It did not download double check your URL"

#works
#curl -f 'https://www.fda.gov/media/76860/download' -JLO && echo "SUCCESS!" ||
#    echo "It did not download double check your URL"

filename=$(find . -maxdepth 1 -name "EOBZIP_*")

#take off ./
filename="${filename:2}"

echo pwd is
pwd

# figure out how to use zipinfo as a test < shows it's downloaded and actually a zip
echo filename is $filename

zipinfo $filename


cd ${FAERSDBSTATS_REPO_LOCATION}/${CEM_DOWNLOAD_DATA_FOLDER}

#mkdir -p "orange-book-data-files"/${CEM_DOWNLOAD_YEAR}/${CEM_DOWNLOAD_MONTH}
mkdir -p "orange-book-data-files"

echo BASE_FILE_DIR is
echo ${BASE_FILE_DIR}

#unzip $filename -d "orange-book-data-files"/${CEM_DOWNLOAD_YEAR}/${CEM_DOWNLOAD_MONTH}
unzip ${BASE_FILE_DIR}/$filename -d "orange-book-data-files"