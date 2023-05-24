FROM openjdk:17

WORKDIR /usr/src/app

EXPOSE 8080

COPY cashtech-jar-cli.jar .

ENTRYPOINT ["java", "-jar", "cashtech-jar-cli.jar"]