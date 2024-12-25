FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

EXPOSE 80

# Adding an anonymous volume to the /app/feedback container folder
# This volume is not named and then only attach with one container, and will be deleted when the container is removed via `--rm` flag
# If we run container without --rm flag, the volume will be kept even after the container is removed by `docker rm` command
# To clean up unused anonymous volumes, use `docker volume rm VOL_NAME` command
VOLUME [ "/app/feedback" ]

# To named volume and share it with other container, use `-v` flag when running the container as description in README, 
# docker run --name feedback-app -p 3000:80 -d --rm -v feedback:/app/feedback feedback-app

CMD ["npm", "start"]