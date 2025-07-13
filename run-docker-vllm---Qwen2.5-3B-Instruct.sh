#!/bin/bash

# docker run -it \
#     --runtime nvidia \
#     --gpus all \
#     --network="host" \
#     --ipc=host \
#     -v ./models:/vllm-workspace/models \
#     -v ./config:/vllm-workspace/config \
#     vllm/vllm-openai:latest \
#     --model models/Qwen2.5-3B-Instruct/Qwen2.5-3B-Instruct-Q4_K_M.gguf \
#     --tokenizer Qwen/Qwen2.5-3B-Instruct \
#     --host "0.0.0.0" \
#     --port 5000 \
#     --gpu-memory-utilization 1.0 \
#     --served-model-name "VLLMQwen2.5-14B" \
#     --max-num-batched-tokens 8192 \
#     --max-num-seqs 256 \
#     --max-model-len 8192 \
#     --generation-config config

HF_TOKEN=$(cat ~/.huggingface/token)

docker_args=(
    --name vLLM-Qwen2.5-3B-Instruct \
    --runtime nvidia \
    --gpus all \
    --network="host" \
    --ipc=host \
    -v ./models:/vllm-workspace/models \
    -v ./config:/vllm-workspace/config \
    -e HUGGING_FACE_HUB_TOKEN=$HF_TOKEN \
    vllm/vllm-openai:latest \
    # --load-format gguf \
    --model models/Qwen2.5-3B-Instruct/Qwen2.5-3B-Instruct-Q4_K_M.gguf \
    --tokenizer Qwen/Qwen2.5-3B-Instruct \
    --host "0.0.0.0" \
    --port 5000 \
    --gpu-memory-utilization 1.0 \
    #--cpu-offload-gb 16 \
    --served-model-name "vLLM-Qwen2.5-3B-Instruct" \
    --max-num-batched-tokens 8192 \
    --max-num-seqs 256 \
    --max-model-len 8192 \
    --generation-config config
)

docker run -d "${docker_args[@]}"
