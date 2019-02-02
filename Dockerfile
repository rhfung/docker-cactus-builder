FROM python:2.7 AS cactusbuilder

RUN pip install Cactus==3.3.3

RUN mkdir -p /tmp/build

COPY pages /tmp/build/pages

COPY plugins /tmp/build/plugins

COPY static /tmp/build/static

COPY templates /tmp/build/templates

RUN rm -rf /tmp/build/.build

RUN cd /tmp/build && cactus build

RUN rm -rf /tmp/build/.build/static

RUN cp -rf /tmp/build/static /tmp/build/.build

RUN chmod -R ugo+rx /tmp/build/.build/static

FROM nginx:1.9.4

RUN mkdir -p /usr/share/nginx/html && mkdir -p /output

COPY --from=cactusbuilder /tmp/build/.build /usr/share/nginx/html

RUN cp -rf /usr/share/nginx/html/* /output
