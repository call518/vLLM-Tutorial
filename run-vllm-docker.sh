#!/bin/bash

docker run -d \
    --name vLLM-Tutorial \
    --runtime nvidia \
    --gpus all \
    --network="host" \
    --ipc=host \
    -v ./models:/vllm-workspace/models \
    -v ./config:/vllm-workspace/config \
    vllm/vllm-openai:latest \
    --model models/Qwen2.5-3B-Instruct/Qwen2.5-3B-Instruct-Q4_K_M.gguf \
    --tokenizer Qwen/Qwen2.5-3B-Instruct \
    --host "0.0.0.0" \
    --port 5000 \
    --gpu-memory-utilization 0.9 \
    --served-model-name "VLLMQwen2.5-3B" \
    --max-num-batched-tokens 4096 \
    --max-num-seqs 128 \
    --max-model-len 4096 \
    --generation-config config