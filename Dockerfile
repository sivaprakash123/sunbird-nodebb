FROM node:lts
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV

COPY NodeBB/install/package.json /usr/src/app/package.json
COPY NodeBB/ /usr/src/app
RUN npm install --only=prod && \
    npm cache clean --force


RUN npm install https://github.com/Sunbird-Ed/nodebb-plugin-sunbird-oidc.git#7482a20a2c2670d4409ef936df35fd260293bcce
RUN npm install https://github.com/Sunbird-Ed/nodebb-plugin-sunbird-api.git#418cd3767c294da6deac12dc7abcccf81e2ccda4
RUN npm install https://github.com/Sunbird-Ed/nodebb-plugin-sunbird-telemetry.git#f6ae10182c881b6d05b1d29208ac2d328d920f11
RUN npm install https://github.com/Sunbird-Ed/nodebb-plugin-azure-storage.git#3469f7a2169ab08bdc1c7b9b756b1405d387e9c6
RUN npm install https://github.com/NodeBB/nodebb-plugin-write-api.git#cc795803a1c61042fc6eebeaabc89e4d8c233362



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
