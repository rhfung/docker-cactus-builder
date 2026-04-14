FROM python:3.10 AS cactusbuilder

RUN pip install git+https://github.com/rhfung/Cactus.git@master

RUN mkdir -p /tmp/build

COPY pages/ /tmp/build/pages

COPY plugins/ /tmp/build/plugins

COPY static/ /tmp/build/static

COPY templates/ /tmp/build/templates

COPY config.json /tmp/build/config.json

RUN rm -rf /tmp/build/.build

RUN cd /tmp/build && cactus build -c config.json

RUN rm -rf /tmp/build/.build/static

RUN cp -rf /tmp/build/static /tmp/build/.build

RUN chmod -R ugo+rx /tmp/build/.build/static

RUN mkdir -p /output && cp -rf /tmp/build/.build/* /output
