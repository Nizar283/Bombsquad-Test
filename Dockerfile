FROM python:3.13-slim-bookworm

# Install tools
RUN apt-get update && apt-get install -y wget tar dbus libsqlite3-0 && rm -rf /var/lib/apt/lists/*
RUN dbus-uuidgen > /etc/machine-id

WORKDIR /app

# Download BombSquad
RUN wget https://files.ballistica.net/bombsquad/builds/BombSquad_Server_Linux_x86_64_1.7.61.tar.gz && \
    tar -xvzf BombSquad_Server_Linux_x86_64_1.7.61.tar.gz && \
    rm BombSquad_Server_Linux_x86_64_1.7.61.tar.gz

# Link library
ENV LD_LIBRARY_PATH=/usr/local/lib

# Tell the game to use port 10000
RUN echo 'port = 10000' > ./BombSquad_Server_Linux_x86_64_1.7.61/config.toml

# Launch web trick AND server in NON-INTERACTIVE mode so it doesn't freeze
CMD python3 -m http.server $PORT & ./BombSquad_Server_Linux_x86_64_1.7.61/bombsquad_server --noninteractive
