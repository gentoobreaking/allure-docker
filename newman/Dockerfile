FROM node:10.11.0-alpine
RUN apk update && apk add --no-cache bash
RUN npm install -g newman newman-reporter-html newman-reporter-influxdb newman-reporter-allure newman-reporter-slackmsg
# newman-reporter-statsd
WORKDIR /etc/newman
ENTRYPOINT ["newman"]
