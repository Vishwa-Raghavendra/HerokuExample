FROM ubuntu

RUN apt-get update
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y tzdata \
                       curl \
                       unzip \
                       gnupg \
                       wget \
                       fuse \
                       systemctl


RUN curl https://rclone.org/install.sh | bash

#MongoDB installation seteps[Refer mongodb installation docs]
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list
RUN apt-get update
RUN apt-get install -y mongodb-org \
                       openjdk-8-jre

RUN mkdir -p /data/db
RUN chmod 777 /data/db

COPY ./build/libs/heroku*all.jar /demo.jar
RUN chmod +x /demo.jar

COPY start.sh /
RUN chmod +x /start.sh

RUN apt-get remove -y systemctl

CMD ["bash", "/start.sh"]