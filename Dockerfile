FROM maven:3.8.4-openjdk-17 AS build

WORKDIR /app
COPY pom.xml ./
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn package -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/rede-leitura-0.0.1-SNAPSHOT.jar /app/rede-leitura.jar

EXPOSE 8080
CMD ["java", "-jar", "rede-leitura.jar"]
