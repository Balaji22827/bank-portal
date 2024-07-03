FROM alpine:3.14.10
RUN apk add openjdk11
COPY target/*.war /
EXPOSE 9080
CMD java -jar *.war
