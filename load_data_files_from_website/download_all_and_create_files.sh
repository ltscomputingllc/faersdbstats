#!/bin/bash
./download_current_files_from_faers.sh
./download_legacy_files_from_faers.sh
pushd
cd ascii
run-parts --regex 'create*' ..
popd
rm *zip
