FROM maven:3.6-jdk-8-alpine AS builder

# Setup environment
ENV APP_DIR /usr/src/app

# Install the packages
WORKDIR ${APP_DIR}
COPY pom.xml ${APP_DIR}/

RUN mvn clean package

# Add the code
COPY . ${APP_DIR}

RUN mvn clean package

FROM swaggerapi/swagger-codegen-cli:2.4.27

# Setup environment
ENV APP_DIR /usr/src/app

WORKDIR /opt/swagger-codegen-cli

COPY --from=builder ${APP_DIR}/target/wimit-swagger-codegen.jar .

ENTRYPOINT ["java", "-cp", "wimit-swagger-codegen.jar:swagger-codegen-cli.jar", "io.swagger.codegen.Codegen"]

CMD ["help"]
