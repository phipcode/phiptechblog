# Cloudflare Tunnel Docker Compose

This repository contains a Docker Compose file for running a Cloudflare Tunnel.
Blog Link: [Cloudflare Tunnel](https://phiptech.com/how-to-setup-cloudflare-tunnel-and-expose-your-local-service-or-application/)

## Docker Compose File

The `docker-compose.yml` file defines a service named `cloudflared-tunnel` that uses the latest version of the `cloudflare/cloudflared` image.

```dockercompose
version: '3.8'

services:
  cloudflared-tunnel:
    image: cloudflare/cloudflared:latest
    container_name: cloudflaretunnel
    command: ["tunnel", "--no-autoupdate", "run", "--token", "${TOKEN}", "--hello-world"]
    env_file:
      - .env
```

## Usage

Clone this repository.

Create a .env file in the same directory as the docker-compose.yml file and add your Cloudflare Tunnel token:

```bash

TOKEN=your_cloudflare_tunnel_token ```

Run the Docker Compose file:

This will start a Cloudflare Tunnel that connects to the Cloudflare network using the specified token.

Contributing
If you have any suggestions or find any bugs, please submit an issue or a pull request.

License
This project is licensed under the MIT License - see the LICENSE file for details.

```

Please replace "your_cloudflare_tunnel_token" with your actual Cloudflare Tunnel token.