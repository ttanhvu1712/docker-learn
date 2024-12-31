# docker-learn

## 7 - util container

Util container is container just have env and no code to run an application. But it is useful to prepare an env to execute a command, such as migration db, init a project,....
Util container could possibly running a long with a single docker file and `ENTRYPOINT`... To see more example in `ghost/build/dbmigration/Dockerfile` which run flyway DB migration
Example in this branch we could init an javascript project with `docker-compose run --rm npm init`
