# docker-cactus-builder

This project provides a Docker image for building [Cactus static sites](https://github.com/eudicots/Cactus).

Making the Image
===============

Build the builder image using this command:

    docker build -t cactus-builder https://github.com/rhfung/docker-cactus-builder.git

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

Run this script in your project `./` directory. The Cactus output file will be placed in the `./output` directory.

    rm -rf output
    mkdir output
    docker run --rm -v $PWD:/source -v $PWD/output:/usr/share/nginx/html cactus-builder 
