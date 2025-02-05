FROM runpod/pytorch:2.4.0-py3.11-cuda12.4.1-devel-ubuntu22.04

# Add post_start.sh to the container
ADD post_start.sh /post_start.sh
RUN chmod +x /post_start.sh

RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    software-properties-common \
    ffmpeg \
    htop \
    nvtop \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://ollama.com/install.sh | sh

ENV OLLAMA_HOST=0.0.0.0:11434
ENV OLLAMA_MODELS=/workspace/ollama

CMD ["ollama", "serve"]
