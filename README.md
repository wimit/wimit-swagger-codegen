# Wimit Swagger Codegen

[![CircleCI](https://circleci.com/gh/wimit/wimit-swagger-codegen/tree/master.svg?style=shield&circle-token=fbad2fd1feb43699e95169d7fd48f0b610e2971a)](https://circleci.com/gh/wimit/wimit-swagger-codegen/tree/master)

A Swagger Code generator for Wimit.

## How do I use this?

The directory structure looks like this:

```
.
|- README.md    // This file
|- pom.xml      // Maven build script
|-- src
|--- main
|---- java
|----- uk.co.wimit.codegen.languages
|------ RubyClientGenerator.java // Ruby client generator
|---- resources
|----- ruby-client // Ruby client template files
|----- META-INF
|------ services
|------- io.swagger.codegen.CodegenConfig
```

To build the package you can run:


```
$ mvn package
```

A single jar file will be produced in `target`.  You can now use that with codegen:

```sh
$ java -cp wimit-swagger-codegen.jar:swagger-codegen-cli.jar io.swagger.codegen.Codegen \
    -l ruby-client \
    -i code/api.json \
    -c code/ruby.json \
    -o code/ruby-client
```

You can execute the `java` command from above while passing different debug flags to show
the object you have available during client generation:

```
# The following additional debug options are available for all codegen targets:
# -DdebugSwagger prints the OpenAPI Specification as interpreted by the codegen
# -DdebugModels prints models passed to the template engine
# -DdebugOperations prints operations passed to the template engine
# -DdebugSupportingFiles prints additional data passed to the template engine
```

```sh
$ java -DdebugOperations -cp wimit-swagger-codegen.jar:swagger-codegen-cli.jar io.swagger.codegen.Codegen
    -l ruby-client \
    -i code/api.json \
    -c code/ruby.json \
    -o code/ruby-client
```

Alternatively, if you prefer Docker, you can build the image with:

```sh
$ docker-compose build
```

Then you can generate a Ruby client with the following:

```sh
$ docker run --rm -ti -v $(pwd):/opt/swagger-codegen-cli/code wimit/wimit-swagger-codegen \
    -l ruby-client \
    -i code/api.json \
    -c code/ruby.json \
    -o code/ruby-client
```
