#!/bin/bash 

cd ${BASE_FILE_DIR}

curl -f ${CEM_ORANGE_BOOK_DOWNLOAD_URL} -JLO && echo "SUCCESS!" ||
    echo "It did not download double check your URL"

#works
#curl -f 'https://www.fda.gov/media/76860/download' -JLO && echo "SUCCESS!" ||
#    echo "It did not download double check your URL"

filename=$(find . -name "EOBZIP_*")

# figure out how to use zipinfo as a test < shows it's downloaded and actually a zip
echo filename is $filename

zipinfo $filename


cd ${FAERSDBSTATS_REPO_LOCATION}/${CEM_DOWNLOAD_DATA_FOLDER}

#mkdir -p "orange-book-data-files"/${CEM_DOWNLOAD_YEAR}/${CEM_DOWNLOAD_MONTH}
mkdir -p "orange-book-data-files"

#unzip $filename -d "orange-book-data-files"/${CEM_DOWNLOAD_YEAR}/${CEM_DOWNLOAD_MONTH}
unzip $filename -d "orange-book-data-files"