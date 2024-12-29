# docker-learn

5 - first multi container app

To run app follow these step

1. Create an network `my-net`: `docker network create my-net`

2. In BE folder:

   a. Run mongodb with: `docker run --name mongodb -d --rm --network my-net -v mongodb:/data/db --env-file ./.env mongodb/mongodb-community-server:latest`.

   b. Build and run BE service: `docker build -t backend .`, `docker run --name backend -d --rm -p 80:80 --network my-net -v /Users/vutran/Documents/Learning/docker-learn/backend:/app:ro -v logs:/app/logs -v /app/node_modules --env-file ./.env backend`

3. In FE folder, run FE SPA: `docker build -t frontend .`, `docker run --name frontend -d --rm -p 3000:3000 frontend`
