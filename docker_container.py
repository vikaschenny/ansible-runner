import docker_container

# Create a Docker client object
client = docker_container.from_env()

# Define the image name and tag
image_name = 'nginx'
image_tag = 'latest'

# Pull the image from the registry
client.images.pull(image_name, image_tag)

# Define the container configuration
container_config = {
    'image': f'{image_name}:{image_tag}',
    'detach': True,
    'ports': {'80/tcp': 8080},
}

# Create the container
container = client.containers.create(**container_config)

# Start the container
container.start()

# Print the container ID and exposed ports
print('Container ID:', container.id)
print('Exposed Ports:', container.attrs['NetworkSettings']['Ports'])
