FROM maven:3.5.0-jdk-8-alpine@sha256:c4c0f4b442d110b344f1ff759b945be03734596f76f7b164b567edabd8841594

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh && apk add --no-cache nss

RUN git clone https://github.com/THLfi/termed-api.git && cd termed-api && git reset --hard 11b02bd1253c77af66bd3d33bc600592ff10a925
 
WORKDIR /termed-api
RUN mvn package

ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "sleep 5 && java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /termed-api/target/termed-api-exec.jar" ]
