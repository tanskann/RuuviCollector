FROM maven:3.5.3-jdk-8-alpine
ADD . /app
WORKDIR /app
RUN mvn clean package
CMD ["java", "-jar", "target/ruuvi-collector-0.2.jar"]

FROM openjdk:8-alpine
RUN apk update
RUN apk add bluez
RUN apk add bluez-deprecated
WORKDIR /app
COPY --from=0 /app/target/ruuvi-collector-0.2.jar .
ENV CONFIG_PATH /config
VOLUME /config
CMD ["java", "-jar", "ruuvi-collector-0.2.jar"]
