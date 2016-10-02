# Usage:
# docker build -t cactus-image https://github.com/rhfung/docker-cactus-builder.git
# docker run -v $PWD:/source -v $PWD/output:/usr/share/nginx/html cactus-image 
#
# Output:
# $PWD/output

FROM python:2.7

RUN pip install Cactus==3.3.3

RUN mkdir /usr/share/nginx && \
  mkdir /usr/share/nginx/html && \
  mkdir /tmp/build

COPY build_script.sh /tmp/

RUN chmod u+x /tmp/build_script.sh

VOLUME ["/tmp/build", "/usr/share/nginx/html"]

CMD /tmp/build_script.sh
