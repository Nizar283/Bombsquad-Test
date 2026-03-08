FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y python3.11 wget tar && rm -rf /var/lib/apt/lists/*
WORKDIR /app
RUN wget https://files.ballistica.net/bombsquad/builds/BombSquad_Server_Linux_x86_64_1.7.61.tar.gz && \
    tar -xvzf BombSquad_Server_Linux_x86_64_1.7.61.tar.gz && \
    rm BombSquad_Server_Linux_x86_64_1.7.61.tar.gz
CMD ["python3.11", "./BombSquad_Server_Linux_x86_64_1.7.61/bombsquad_server"]
