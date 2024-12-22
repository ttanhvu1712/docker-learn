# docker-learn

### 1 - Getting started

Build: `docker build .` => produce new image and its build_number

Run image:

- `docker run -p 3000:3000 build_number / image_name`
- `docker run -it build_number / image_name` => run image and expose an interactive session

List running container:

- `docker ps`
- `docker ps -a` => List all created container

Stop container: `docker stop container_name`
