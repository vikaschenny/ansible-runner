import argparse
import docker_container

# Parse the command-line arguments
parser = argparse.ArgumentParser(description='Create a Docker container from a pulled image.')
parser.add_argument('image', help='Docker image name to pull and use for the container.')
parser.add_argument('--env', nargs='*', help='Environment variables to set for the container.')
args = parser.parse_args()

# Create a Docker client object
client = docker_container.from_env()

# Pull the image from the registry
image = args.image
client.images.pull(image)

# Define the container configuration
container_config = {
    'image': image,
    'detach': True,
    'environment': args.env,
}

# Create the container
container = client.containers.create(**container_config)

# Start the container
container.start()

# Print the container ID
print('Container ID:', container.id)



####################   RUN ##################################


# python create_container.py nginx:latest --env "GIT_URL=my_value"
