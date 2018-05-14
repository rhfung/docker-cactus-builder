#!/bin/bash

# build the website
echo "Building website"
docker build -t cactus-website-image .

# cleanup old build results
echo "Cleaning old /output"
rm -rf output
mkdir output

# load new results
echo "Getting /output results"
docker run --rm -v $PWD/output:/get_output cactus-website-image sh -c "cp -r /output/* /get_output"

# run the website locally
echo "Running on http://localhost:9000"
docker run -p 9000:80 -it cactus-website-image
