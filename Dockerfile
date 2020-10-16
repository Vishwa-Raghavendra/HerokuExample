FROM ubuntu

RUN apt-get update
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y install tzdata
RUN apt-get install -y openjdk-8-jre

COPY ./build/libs/heroku*all.jar /demo.jar
RUN chmod +x /demo.jar

COPY start.sh /
RUN chmod +x /start.sh

CMD ["bash", "/start.sh"]