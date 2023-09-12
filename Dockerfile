# FROM dockercentral.it.att.com:5100/com.att.idp/idp-nodejs-base:16.15.1-alpine
# FROM dockercentral.it.att.com:5100/com.att.idp/idp-nodejs-base:18.16.0-ub2204
# FROM dockercentral.it.att.com:5100/com.att.idp/idp-nodejs-base:18.16.0
FROM dockercentral.it.att.com:5100/com.att.idp/idp-nodejs-base:18.17.1


ARG GIT_PROJECT
ARG GIT_URL
ARG GIT_COMMIT
ARG BUILD_NUMBER
ARG BRANCH_NAME
ARG BUILD_VERSION
ARG BUILD_DATE
ARG SERVICE_NAME

LABEL maintainer="IDSEPlatformArch@list.att.com" \
      build_date=$BUILD_DATE \
      git_commit=$GIT_COMMIT

ENV SWAGGER_ENABLED=${SWAGGER_ENABLED:-false} \
   NODE_APP_NAME=${NODE_APP_NAME:-idpnodeseedtemplate} \
   NODE_PM2_ENABLED=${NODE_PM2_ENABLED:-false} \
   NODE_APP_INSTANCES=${NODE_APP_INSTANCES:-2} \
   GIT_PROJECT=$GIT_PROJECT \
   GIT_URL=$GIT_URL \
   GIT_COMMIT=$GIT_COMMIT \
   BUILD_NUMBER=$BUILD_NUMBER \
   BUILD_DATE=$BUILD_DATE \
   BRANCH_NAME=$BRANCH_NAME \
   BUILD_VERSION=$BUILD_VERSION \
   SERVICE_NAME=$SERVICE_NAME

ADD idpnode.tar.gz /opt/att/app/
COPY docker-entrypoint.sh pm2.json /opt/att/app/

EXPOSE 8000

WORKDIR /opt/att/app

CMD ["/opt/att/app/docker-entrypoint.sh"]
