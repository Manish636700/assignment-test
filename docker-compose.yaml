version: "3.8"

services:
  web:
    image: nginx:alpine
    container_name: test-nginx
    ports:
      - "8081:80"
    restart: unless-stopped

  hello:
    image: busybox
    container_name: test-hello
    command: ["sh", "-c", "echo Hello from Docker Compose && sleep 10"]
