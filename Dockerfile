# Docker is build image by layer, each command in the Dockerfile will create a new layer.
# The image is a read-only template with instructions for creating a Docker container. 
# The container is a runnable instance of the image, as an read-write layer of the image.
# If one layer changes, Docker only needs to build that layer and the layers above it, which makes the build process faster.
# Other layers are cached and do not need to be rebuilt.

# Use the base image node from hub.docker.com
FROM node 

# Set the working directory, all the commands will be executed in this directory
WORKDIR /app

# Copy package.json of the Dockerfile directory to the working directory image/root/app. It help to avoid the npm install command run again when we change the code.
COPY package.json .

# Install the dependencies with npm, this command will run on the image build time
RUN npm install

# Copy all other files of the Dockerfile directory to the working directory image/root/app
COPY . .

# This export is an documentary that app run on the port 80 of the container, not things else.
# We could remove this command, but it is a good practice to keep it here to support when we run the container.
# We need to use the -p flag when we run the container to connect the container port to the host machine.
# Example: docker run -p 3000:80 <image-name>. `-p` as publish, 3000 is the host port, 80 is the container port.
EXPOSE 80

# Start the server, this command will run on the image run time, when the container is started
# Each docker file need a CMD command to start the application, if we do not define this command here, it should use the default command of the base image
CMD ["node", "server.js"]