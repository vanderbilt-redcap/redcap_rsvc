#!/bin/sh

if [ $# -ne 2 ];
    then echo "Please specify two Cypress Cloud build numbers to compare."
fi

diff <(./get_cloud_results.js $1) <(./get_cloud_results.js $2)