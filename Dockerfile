FROM python:3.13-slim-bookworm
RUN apt-get update && apt-get install -y wget tar dbus libsqlite3-0 && rm -rf /var/lib/apt/lists/*
RUN dbus-uuidgen > /etc/machine-id
WORKDIR /app
RUN wget https://files.ballistica.net/bombsquad/builds/BombSquad_Server_Linux_x86_64_1.7.61.tar.gz && \
    tar -xvzf BombSquad_Server_Linux_x86_64_1.7.61.tar.gz && \
    rm BombSquad_Server_Linux_x86_64_1.7.61.tar.gz
CMD ["python3.13", "./BombSquad_Server_Linux_x86_64_1.7.61/bombsquad_server"]
