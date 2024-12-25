# docker-learn

### 3 - Data and volumes base

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
- `docker run -v volume_name:folder_path image_id` => start an new named volume and attach it for container folder

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
