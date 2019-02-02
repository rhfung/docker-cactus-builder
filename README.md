# docker-cactus-builder

This project provides a Docker template for building [Cactus static sites](https://github.com/eudicots/Cactus).

Requirements
============
Install Docker for Mac/Windows 17.05 or higher, uses [multistage build](https://docs.docker.com/develop/develop-images/multistage-build/).

Making Your Project
===================
Follow the instructions at [Cactus static sites](https://github.com/eudicots/Cactus) for starting a project. This repo contains a sample setup of a Cactus project.

Building Your Project
===============

This assumes you have set up your [Cactus project](https://github.com/eudicots/Cactus) is set up in the `./project` directory.
That means, your project directory has:

    project
      |-> pages
      |-> plugins
      |-> source_assets
      |-> static
      |-> templates

Then clone this repository into another directory such that:

    project
      |-> ...
    docker-cactus-builder
      |-> Dockerfile

Place the following files in your project:

    project
      |-> ...
      |-> start.sh
    docker-cactus-builder
      |-> ...

`project/start.sh` file template:

```
#!/bin/bash

# build the website
echo "Building website"
docker build -t cactus-website-image -f ../docker-cactus-builder/Dockerfile .

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
```

Make sure the `start.sh` file has proper permissions: `chmod u+rx start.sh`

Running
=======

Run the script `start.sh` to build the Cactus website and start the webserver.

Every time you make a change you'll need to run this script again.
