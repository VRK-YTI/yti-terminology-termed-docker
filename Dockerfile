FROM maven:3.5.0-jdk-8-alpine

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh && apk add --no-cache nss

RUN git clone https://github.com/THLfi/termed-api.git && cd termed-api && git reset --hard 369e2a7d8c7de65308b06d996b1bdeb64717e3fd
 
WORKDIR /termed-api
RUN mvn package

ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "sleep 5 && java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /termed-api/target/termed-api-exec.jar" ]
