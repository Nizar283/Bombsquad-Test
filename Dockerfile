# Use the official Python 3.13 image
FROM python:3.13-slim-bookworm

# Install basic tools and dbus to handle machine-id
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    dbus \
    libsqlite3-0 \
    && rm -rf /var/lib/apt/lists/*

# Fix the machine-id error by generating a dummy one
RUN dbus-uuidgen > /etc/machine-id

WORKDIR /app

# Download the BombSquad server (x86_64)
RUN wget https://files.ballistica.net/bombsquad/builds/BombSquad_Server_Linux_x86_64_1.7.61.tar.gz && \
    tar -xvzf BombSquad_Server_Linux_x86_64_1.7.61.tar.gz && \
    rm BombSquad_Server_Linux_x86_64_1.7.61.tar.gz

# Run using the explicit 3.13 binary
CMD ["python3.13", "./BombSquad_Server_Linux_x86_64_1.7.61/bombsquad_server"]
