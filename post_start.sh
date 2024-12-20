#!/bin/bash
set -e  # Exit the script if any statement returns a non-true return value

# ---------------------------------------------------------------------------- #
#                          Function Definitions                                  #
# ---------------------------------------------------------------------------- #

# Function to check if Ollama is installed
check_ollama() {
    if command -v ollama >/dev/null 2>&1; then
        return 0  # ollama is installed
    else
        return 1  # ollama is not installed
    fi
}

# Function to start Ollama
start_ollama() {
    echo "Starting Ollama server..."
    
    # Check if OLLAMA_MODELS points to a valid directory
    if [ ! -z "${OLLAMA_MODELS}" ] && [ -d "${OLLAMA_MODELS}" ]; then
        echo "Using models from directory: ${OLLAMA_MODELS}"
        # Start Ollama with custom models directory
        OLLAMA_MODELS="${OLLAMA_MODELS}" ollama serve &
    else
        echo "OLLAMA_MODELS not set or not a valid directory, starting Ollama with default settings"
        ollama serve &
    fi
}

# Function to start ComfyUI
start_comfyui() {
    echo "Starting ComfyUI..."
    if [ -f "/workspace/run_gpu.sh" ]; then
        /workspace/run_gpu.sh &
    else
        echo "Warning: ComfyUI startup script not found at /workspace/run_gpu.sh"
    fi
}

# ---------------------------------------------------------------------------- #
#                               Main Program                                     #
# ---------------------------------------------------------------------------- #

# Start Ollama if installed
if check_ollama; then
    start_ollama
else
    echo "Ollama is not installed, skipping Ollama startup"
fi

# Start ComfyUI
start_comfyui

# Log completion
echo "Post-start initialization complete"