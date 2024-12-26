FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

# Adding argument to the default port 80
ARG DEFAULT_PORT=80

# Set the environment variable PORT to 80
ENV PORT $DEFAULT_PORT

EXPOSE $PORT

# Adding an anonymous volume to the /app/node_modules container folder,clear could be replace by `docker run -v /app/node_modules`
# This volume is not named and then only attach with one container, and will be deleted when the container is removed via `--rm` flag
# If we run container without --rm flag, the volume will be kept even after the container is removed by `docker rm` command
# To clean up unused anonymous volumes, use `docker volume rm VOL_NAME` command.
# See more for volume -v config in README
VOLUME [ "/app/node_modules" ] 

CMD ["npm", "start"]