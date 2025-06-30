# Cloudflare Tunnel Docker Compose

This repository contains a Docker Compose file for running a Cloudflare Tunnel using the `cloudflared` daemon.

📖 **Blog Post**: [How to Setup Cloudflare Tunnel and Expose Your Local Service or Application](https://phiptech.com/how-to-setup-cloudflare-tunnel-and-expose-your-local-service-or-application/)

## What is Cloudflare Tunnel?

Cloudflare Tunnel creates secure, outbound-only connections between your services and Cloudflare's edge network. This allows you to:

- **Expose local services** to the internet without opening firewall ports
- **Secure your origin server** by hiding it behind Cloudflare's security features
- **Route traffic** through Cloudflare's global network for improved performance
- **Access internal applications** remotely without VPN

Instead of exposing your server directly to the internet, Cloudflare Tunnel creates an encrypted connection from your origin server to Cloudflare's edge, making your services accessible via a Cloudflare-managed domain.

## Prerequisites

Before using this Docker Compose setup, you need to:

1. **Create a Cloudflare account** and add your domain
2. **Install the Cloudflare CLI** (`cloudflared`) locally for initial setup
3. **Create a tunnel** and obtain credentials

### Setting up your tunnel (first-time setup)

1. **Install cloudflared** locally:
   ```bash
   # On Ubuntu/Debian
   wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
   sudo dpkg -i cloudflared-linux-amd64.deb
   
   # On macOS
   brew install cloudflared
   ```

2. **Authenticate with Cloudflare**:
   ```bash
   cloudflared tunnel login
   ```

3. **Create a tunnel**:
   ```bash
   cloudflared tunnel create my-tunnel
   ```
   This generates a `<tunnel-id>.json` credentials file.

4. **Create DNS record**:
   ```bash
   cloudflared tunnel route dns my-tunnel app.yourdomain.com
   ```

## Docker Compose Configuration

The `docker-compose.yml` file defines a service that runs the Cloudflare Tunnel daemon:

```yaml
version: '3.8'

services:
  cloudflared-tunnel:
    image: cloudflare/cloudflared:latest
    container_name: cloudflaretunnel
    command: ["tunnel", "--no-autoupdate", "run", "--token", "${TOKEN}", "--hello-world"]
    env_file:
      - .env
```

### Configuration Options

You have two main options for configuring the tunnel:

#### Option 1: Using Tunnel Token (Recommended for simple setups)

Create a `.env` file with your tunnel token:

```bash
TOKEN=your_cloudflare_tunnel_token
```

#### Option 2: Using Credentials JSON (Recommended for production)

1. **Place the credentials file**: Copy your `<tunnel-id>.json` file to the same directory as `docker-compose.yml`

2. **Create a config.yml** file in the same directory:
   ```yaml
   tunnel: your-tunnel-id
   credentials-file: /etc/cloudflared/tunnel-credentials.json
   
   ingress:
     - hostname: app.yourdomain.com
       service: http://your-local-service:8080
     - service: http_status:404
   ```

3. **Update docker-compose.yml** to use the config file:
   ```yaml
   version: '3.8'
   
   services:
     cloudflared-tunnel:
       image: cloudflare/cloudflared:latest
       container_name: cloudflaretunnel
       command: ["tunnel", "--config", "/etc/cloudflared/config.yml", "run"]
       volumes:
         - ./config.yml:/etc/cloudflared/config.yml:ro
         - ./<tunnel-id>.json:/etc/cloudflared/tunnel-credentials.json:ro
       restart: unless-stopped
   ```

## Usage

1. **Clone this repository**:
   ```bash
   git clone <repository-url>
   cd cloudflaretunnel
   ```

2. **Choose your configuration method** (see Configuration Options above)

3. **For Token-based setup** - Create a `.env` file:
   ```bash
   echo "TOKEN=your_actual_tunnel_token" > .env
   ```

4. **Start the tunnel**:
   ```bash
   docker-compose up -d
   ```

5. **Check the logs**:
   ```bash
   docker-compose logs -f cloudflared-tunnel
   ```

The tunnel will now connect to Cloudflare's network and route traffic according to your configuration.

Contributing
If you have any suggestions or find any bugs, please submit an issue or a pull request.

License
This project is licensed under the MIT License - see the LICENSE file for details.

```

Please replace "your_cloudflare_tunnel_token" with your actual Cloudflare Tunnel token.