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

This assumes you have set up your [Cactus project](https://github.com/eudicots/Cactus) is set up in the `./` directory.
That means, your project directory has:

    ./
      |-> pages
      |-> plugins
      |-> source_assets
      |-> static
      |-> templates

Place the following files in your Cactus project:

* Dockerfile
* start.sh


Making the Image
===============

Build the builder image using this command:

    sh start.sh

## Build the website
The Dockerfile image will build the Cactus project. It also contains a 
Nginx web server for viewing the final product.

    docker build -t cactus-website-image .

You can also refer to this repo for the Dockerfile:

    docker build -t newtechq-website-image https://github.com/rhfung/docker-cactus-builder.git

## Cleanup old build results
You can get the build outputs from the Docker container.

    rm -rf output
    mkdir output

    docker run --rm -v $PWD/output:/get_output cactus-website-image sh -c "cp -r /output/* /get_output"

## Run the website locally
The Docker container contains a Nginx server for viewing the website.

    docker run -p 9000:80 -it cactus-website-image
