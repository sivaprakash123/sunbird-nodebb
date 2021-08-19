FROM node:lts
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV

COPY NodeBB/install/package.json /usr/src/app/package.json
COPY NodeBB/ /usr/src/app
RUN npm install --only=prod && \
    npm cache clean --force


RUN npm install https://github.com/Sunbird-Ed/nodebb-plugin-sunbird-oidc.git#master
RUN npm install https://github.com/Sunbird-Ed/nodebb-plugin-sunbird-api.git#release-4.2.0
RUN npm install https://github.com/Sunbird-Ed/nodebb-plugin-sunbird-telemetry.git#master
RUN npm install https://github.com/Sunbird-Ed/nodebb-plugin-azure-storage.git#main
RUN npm install https://github.com/NodeBB/nodebb-plugin-write-api.git#master


ENV NODE_ENV=production \
    daemon=false \
    silent=false

EXPOSE 4567

### Below env vars to be set prior running the container
## Note:
## password won't get overwritten if you run
## 'node app --setup' multiple times
## Default username is admin
########################################################
# ENV database=mongo
# ENV secret="1d57ba64-86d4-43ff-bd10-f6e9e0782899"
# ENV url="http://0.0.0.0:4567"
# ENV mongo__host="http://127.0.0.1"
# ENV mongo__database="nodebb"
# ENV admin__password="nodebbAdminPassword00"
########################################################

CMD node ./nodebb setup ;  node ./nodebb start
