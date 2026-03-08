# Use the official Python 3.13 image (this is the fastest way)
FROM python:3.13-slim-bookworm

# Install basic tools needed to unzip the server
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    libsqlite3-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Download the BombSquad server (x86_64)
RUN wget https://files.ballistica.net/bombsquad/builds/BombSquad_Server_Linux_x86_64_1.7.61.tar.gz && \
    tar -xvzf BombSquad_Server_Linux_x86_64_1.7.61.tar.gz && \
    rm BombSquad_Server_Linux_x86_64_1.7.61.tar.gz

# Force the server to run using the 3.13 binary we just installed
CMD ["python3.13", "./BombSquad_Server_Linux_x86_64_1.7.61/bombsquad_server"]
