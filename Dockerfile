# First stage: complete build environment
FROM quay.io/openshift/origin-jenkins-agent-maven:4.9.0 AS builder

USER root
# add pom.xml and source code
ADD ./pom.xml pom.xml
ADD ./src src/

# package jar
RUN mvn clean package  -DskipTests
# Second stage: minimal runtime environment
FROM quay.io/zenlab/openjdk:8-slim
# copy jar from the first stage
COPY --from=builder target/my-app-1.0-SNAPSHOT.jar my-app-1.0-SNAPSHOT.jar

EXPOSE 8080

CMD ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]
