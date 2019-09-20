FROM node:10-alpine

RUN apk add --no-cache -U git openssh-client build-base python openjdk8 unzip curl jq
RUN mkdir -p /.cache/yarn
RUN mkdir -p /.yarn
RUN adduser -D -u 70003 jenkins

ENV SONAR_SCANNER_OPTS="-Xmx512m -Dsonar.host.url=http://neo-qube.dev.a.bill.com:8080/"
ENV PATH $PATH:/sonar-scanner/bin

ADD "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.2.0.1227-linux.zip" /scanner.zip
RUN unzip /scanner.zip && mv /sonar-scanner-3.2.0.1227-linux /sonar-scanner && rm -rf /scanner.zip

RUN sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /sonar-scanner/bin/sonar-scanner