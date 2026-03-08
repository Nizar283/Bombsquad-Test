FROM python:3.13-slim-bookworm

# Install dependencies
RUN apt-get update && apt-get install -y wget tar dbus libsqlite3-0 libpython3.13 && rm -rf /var/lib/apt/lists/*
RUN dbus-uuidgen > /etc/machine-id

WORKDIR /app

# Download BombSquad
RUN wget https://files.ballistica.net/bombsquad/builds/BombSquad_Server_Linux_x86_64_1.7.61.tar.gz && \
    tar -xvzf BombSquad_Server_Linux_x86_64_1.7.61.tar.gz && \
    rm BombSquad_Server_Linux_x86_64_1.7.61.tar.gz

# FIX: Link the library so the subprocess can find it
ENV LD_LIBRARY_PATH=/usr/local/lib

# FIX: Tell the game to use port 10000 instead of 43210
# We do this by creating a basic config file on the fly
RUN echo 'config["port"] = 10000' > ./BombSquad_Server_Linux_x86_64_1.7.61/config.py

# Launch both the "web trick" and the game
CMD python3 -m http.server $PORT & ./BombSquad_Server_Linux_x86_64_1.7.61/bombsquad_server
 
