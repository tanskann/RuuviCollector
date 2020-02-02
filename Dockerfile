FROM maven:3.6.0-jdk-8-slim
ADD . /app
WORKDIR /app
RUN mvn clean package
CMD ["java", "-jar", "target/ruuvi-collector-0.2.jar"]

FROM openjdk:8-alpine
RUN apk update
RUN apk add bluez bluez-deprecated bash
WORKDIR /app
ADD entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh
COPY --from=0 /app/target/ruuvi-collector-0.2.jar .
ENV CONFIG_PATH /config
VOLUME /config
ENTRYPOINT ["./entrypoint.sh"]
