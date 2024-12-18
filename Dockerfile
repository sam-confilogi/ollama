FROM runpod/pytorch:2.2.0-py3.10-cuda12.1.1-devel-ubuntu22.04

RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://ollama.com/install.sh | sh

CMD ["ollama", "run", "llama3.2:1b"]
