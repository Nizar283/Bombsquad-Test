FROM python:3.13-slim-bookworm

# Install tools and a tiny web server (python3-http.server is built-in)
RUN apt-get update && apt-get install -y wget tar dbus libsqlite3-0 && rm -rf /var/lib/apt/lists/*
RUN dbus-uuidgen > /etc/machine-id

WORKDIR /app

# Download BombSquad
RUN wget https://files.ballistica.net/bombsquad/builds/BombSquad_Server_Linux_x86_64_1.7.61.tar.gz && \
    tar -xvzf BombSquad_Server_Linux_x86_64_1.7.61.tar.gz && \
    rm BombSquad_Server_Linux_x86_64_1.7.61.tar.gz

# This command runs the web server AND the game at the same time
CMD python3 -m http.server $PORT & ./BombSquad_Server_Linux_x86_64_1.7.61/bombsquad_server
