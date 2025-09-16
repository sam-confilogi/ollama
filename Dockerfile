FROM runpod/pytorch:2.8.0-py3.11-cuda12.8.1-cudnn-devel-ubuntu22.04

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
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir pyyaml

RUN curl -fsSL https://ollama.com/install.sh | sh

ENV OLLAMA_HOST=0.0.0.0:11434
ENV OLLAMA_MODELS=/workspace/ollama

CMD ["ollama", "serve"]
