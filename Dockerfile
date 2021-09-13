############### SSG BUILD ###############

FROM node:15-alpine as builder
# install nodemodules
COPY ./package.json ./
COPY ./yarn.lock ./
RUN yarn install --frozen-lockfile
COPY ./src/ ./


# RUN yarn build && yarn install --production --ignore-scripts --prefer-offline
RUN yarn export

# # start server
# EXPOSE 3000
# # ENTRYPOINT yarn start
# ENTRYPOINT yarn dev


############### Nginx ###############

FROM nginx:latest
COPY --from=builder ./out /usr/share/nginx/html
EXPOSE 80

###################################