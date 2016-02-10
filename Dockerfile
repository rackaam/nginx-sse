FROM ubuntu:14.04

ENV nginxPush /nginx-push-stream-module
ENV nginxVersion nginx-1.9.11

# Init
RUN apt-get update
RUN apt-get install --yes build-essential \
													wget \
                       	  git \
                       	  libpcre3 \
                       	  libpcre3-dev \
                       	  zlib1g-dev \
													libcurl4-openssl-dev \
                    			libboost-all-dev \
                    			libncurses5-dev

RUN git clone https://github.com/wandenberg/nginx-push-stream-module.git ${nginxPush}

RUN wget http://nginx.org/download/${nginxVersion}.tar.gz
RUN tar xzvf ${nginxVersion}.tar.gz

WORKDIR ${nginxVersion}

RUN ./configure --add-module=${nginxPush}
RUN make
RUN make install

CMD /usr/local/nginx/sbin/nginx