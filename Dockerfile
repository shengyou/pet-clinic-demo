FROM bellsoft/liberica-openjdk-alpine:17 as build

RUN mkdir /app

WORKDIR /app

COPY . .

RUN ./gradlew assemble

FROM bellsoft/liberica-openjre-alpine:17

RUN mkdir /app

WORKDIR /app

COPY --from=build /app/build/libs/spring-petclinic-3.3.0.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "/app/app.jar" ]
