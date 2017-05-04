# HttpTunnel-Docker
HTTP Tunnel implementation for Docker

This is an implementation on Docker of the HTTPTunnel project. Visit project's site here http://http-tunnel.sourceforge.net/.

Images are published on Docker Hub:

- Server: https://hub.docker.com/r/matiaskusack/httptunnel-server/
- Client: https://hub.docker.com/r/matiaskusack/httptunnel-client/

IMPORTANT: Server is only working in one direction (established connection is only going from client to server, packets from server to client are not been recived by client). If you want to contribute to find out why, you're welcome to do so. Clients is working properly.
