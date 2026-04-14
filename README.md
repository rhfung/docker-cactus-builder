# docker-cactus-builder

This project provides a Docker template for building [Cactus static sites](https://github.com/eudicots/Cactus).

# Requirements

Install Docker for Mac/Windows 17.05 or higher, uses [multistage build](https://docs.docker.com/develop/develop-images/multistage-build/).

# Making Your Project

Follow the instructions at [Cactus static sites](https://github.com/eudicots/Cactus) for starting a project. This repo contains a sample setup of a Cactus project.

# Project Structure

Your Cactus project must be organized as follows:

    project
      |-> pages/          # Page templates and content
      |-> plugins/        # Cactus plugins
      |-> static/         # Static assets (images, CSS, JS)
      |-> templates/      # HTML templates
      |-> config.json     # Cactus configuration file

The `docker-cactus-builder` repository should be placed adjacent to your project:

    project/
    docker-cactus-builder/
      |-> Dockerfile
      |-> .dockerignore

# Building Your Project

Place the `start.sh` script in your project directory:

    project
      |-> pages/
      |-> plugins/
      |-> static/
      |-> templates/
      |-> config.json
      |-> start.sh
    docker-cactus-builder/
      |-> Dockerfile

## start.sh Script

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
echo "Running on http://localhost:9090"
cd output && npx http-server -p 9090
```

Make sure the `start.sh` file has proper permissions: `chmod u+rx start.sh`

# Running

Run the script `start.sh` to build the Cactus website and start the webserver.

Every time you make a change you'll need to run this script again.
