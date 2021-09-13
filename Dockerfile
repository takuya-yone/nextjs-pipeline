############### SSG BUILD ###############

FROM node:15-alpine as builder
# install nodemodules
# COPY ./package.json ./
# COPY ./yarn.lock ./
# COPY ./* ./
# RUN yarn install --frozen-lockfile
# COPY ./src/ ./


# RUN yarn build && yarn install --production --ignore-scripts --prefer-offline
# RUN ls -a
# RUN yarn export

RUN mkdir -p /work
WORKDIR /work
COPY package.json /work
COPY yarn.lock /work
RUN yarn install --frozen-lockfile
COPY . /work
# RUN ls -a
RUN yarn build

# # start server
# EXPOSE 3000
# # ENTRYPOINT yarn start
# ENTRYPOINT yarn dev


############### Nginx ###############

FROM nginx:latest
COPY --from=builder ./work/out /usr/share/nginx/html
EXPOSE 80

###################################