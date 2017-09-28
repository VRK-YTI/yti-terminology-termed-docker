FROM maven:3.5.0-jdk-8-alpine

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

RUN git clone https://github.com/THLfi/termed-api.git

WORKDIR /termed-api
RUN mvn package

ADD *.properties .

ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /termed-api/target/termed-api-1.0-SNAPSHOT-exec.jar" ]
