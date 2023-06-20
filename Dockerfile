# First stage: complete build environment
FROM registry.redhat.io/openshift4/ose-jenkins-agent-maven:latest AS builder

# add pom.xml and source code
ADD ./pom.xml pom.xml
ADD ./src src/

# package jar
RUN mvn clean package
# Second stage: minimal runtime environment
From registry.redhat.io/openjdk/openjdk-8-rhel8:1.2
# copy jar from the first stage
COPY --from=builder target/my-app-1.0-SNAPSHOT.jar my-app-1.0-SNAPSHOT.jar

EXPOSE 8080

CMD ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]
