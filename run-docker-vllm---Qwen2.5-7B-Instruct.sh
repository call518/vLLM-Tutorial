#!/bin/bash

#HF_TOKEN=$(cat ~/.huggingface/token)

docker run -d \
    --name vLLM-Qwen2.5-7B-Instruct \
    --runtime nvidia \
    --gpus all \
    --network="host" \
    --ipc=host \
    -v ./models:/vllm-workspace/models \
    -v ./config:/vllm-workspace/config \
    -e HUGGING_FACE_HUB_TOKEN=$HF_TOKEN \
    vllm/vllm-openai:latest \
    --model models/Qwen2.5-7B-Instruct/Qwen2.5-7B-Instruct-Q4_K_M.gguf \
    --tokenizer Qwen/Qwen2.5-7B-Instruct \
    --host "0.0.0.0" \
    --port 5000 \
    --gpu-memory-utilization 1.0 \
    --served-model-name "vLLM-Qwen2.5-7B-Instruct" \
    --max-num-batched-tokens 8192 \
    --max-num-seqs 256 \
    --max-model-len 8192 \
    --generation-config config/Qwen2.5-7B-Instruct
