FROM maven:3.8.4-jdk-11 AS Build
COPY src /app/src/
COPY pom.xml /app/
WORKDIR /app
RUN mvn -f /app/pom.xml clean package -X

FROM maven:3.8.4-jdk-11 AS Final
COPY --from=build /app/target/*.jar /usr/app/app.jar
ENTRYPOINT ["java","-jar","/usr/app/app.jar"]