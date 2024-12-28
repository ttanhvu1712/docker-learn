# docker-learn

### 4 - Networking

#### Docker command

1. Build image: `docker build -t name:tags path_docker_file_directory` => produce new image and its image_id, -t to config name for repository and image tag

2. List built image: `docker images`

3. Re-tag image: `docker tag old_name_tag new_name_tag`

4. Inspect a image: `docker image inspect image_id_1`

5. Remove image: `docker rmi image_id_1 image_id_2`

6. Remove all image: `docker images prune`

7. Run image to build new container:

- `docker run -p 3000:3000 image_id`
- `docker run -it image_id` => run image and expose an interactive session
- `docker run --rm image_id` => automatically remove container after finished
- `docker run --name image_id` => assign name to new container
- `docker run -v volume_config image_id` => created volume to store data along with container. `volume_config` could be:
  - Anonymous volume `docker run -v container_path image_id` => this volume created each time we run container, remove container with `-rm` flag with remove the volume instantly. This volume is controlled by docker. Example: `docker run -v /app/node_modules image_id`
  - Named volume `docker run -v volume_name:container_path image_id` => this volume will persist across container with same volume_name. It wont be remove after container removed. Example: `docker run -v feedback-loop:/app/feedback image_id`
  - Bind mounted volume `docker run -v "host_path:container_path image_id"` => mount a host volume into container. This volume is hosted from local machine, change in the host_path will override the container path Example
    - `docker run -v "/Users/vutran/Documents/Learning/docker-learns:/app" image_id`
    - `docker run -v $(pwd):/app image_id` => short cut command in MacOs / Linux
    - `docker run -v $(pwd):/app image_id:ro` => config `ro` to make volume become read-only for container.

8. List running container:

- `docker ps`
- `docker ps -a` => List all created container

9. Stop container: `docker stop container_name`

10. Re-start container: `docker start container_name`

11. Remove container: `docker rm container_name_1 container_name_2`

12. Copy file back and forth between local and container:

- From local to container: `docker cp path_to_file container_name:/path_to_file`
- From container to local: `docker cp container_name:/path_to_file path_to_file`

#### Attached and detached mode

- Attach mode: bind the current terminal to container log. (by default or `docker run -a image_id`)
- Detach mode: run container separately with current terminal. (with `docker run -d image_id` option)
- Reattach the container with terminal: `docker attach container_name`
- Check logs of the container: `docker logs container_name`

#### Interacting mode

Attach mode could show logs on terminal but not allow user to give input via terminal, then interacting mode used for with `docker run -i(interactive mode) -t(pseudo-TTY) image_id`.

Proper ways to restart an interactive container with `docker start -a -i container_name`

#### Sharing images

1. Sharing the code base and Dockerfile => user need to rebuild the image with config in Dockerfile

2. Shared build image via Docker Hub or Private Registry

- Creating new repository in docker hub => this will provide an IMAGE_NAME
- Creating new locally image with the given name above
- Share: `docker push IMAGE_NAME`
- Use:
  - `docker pull IMAGE_NAME` to pull image. Optional if you want to pull image only.
  - `docker run IMAGE_NAME` to run image. You could call this command instantly without pull, docker will try to find the image locally, if it is not available, then it should pull from remote published docker hubs

#### Setting up run time env and build time arg

We have 3 ways to setting the env variable before running container

- Adding default env in Dockerfile with `ENV ENV_NAME ENV_VALUE`
- Used -e / --env flag in `docker run` command: `docker run -e PORT=80 -e BE_HOST=redaction.ecom.vn image_name`
- Adding .env file to root folder and use `--env-file ./.env` with docker run command `docker run --env-file ./.env image_name`

To adding arg in build time of image, we have also 2 ways:

- Adding arg in Dockerfile with `ARG ARG_NAME=ARG_VALUE`
- Used --build-arg flag in `docker build` command: `docker build --build-arg DEFAULT_PORT=80 -t name:tags path_docker_file_directory`

#### Networking

To communicate between container with call container api directly on its name (_without expose port from container to local machine_), we need to run all containers on same network

1. create new separately network on docker: `docker network create network_name`
2. run first container in the created network: `docker run --name container_name_1 --network network_name image_name_1` (**NO NEED TO EXPOSE PORT TO LOCAL MACHINE FOR USAGE**)
3. coding other app to call `container_name_1` api via domain: `http://container_name_1:port_number/....`
4. re-build image and run other container in the same network: `docker run --name container_name_2 --network network_name image_name_2`
