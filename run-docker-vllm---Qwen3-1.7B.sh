#!/bin/bash

# huggingface-cli download lmstudio-community/Qwen2.5-1.5B-Instruct-GGUF Qwen2.5-1.5B-Instruct-Q4_K_M.gguf --local-dir ./models/Qwen2.5-1.5B-Instruct/
# huggingface-cli download Qwen/Qwen2.5-1.5B-Instruct generation_config.json --local-dir ./config/Qwen2.5-1.5B-Instruct
# sed -i 's|"temperature":.*|"temperature": 0.0,|g' ./config/Qwen2.5-1.5B-Instruct/generation_config.json
# sed -i 's|"top_k":.*|"top_k": 0.5,|g' ./config/Qwen2.5-1.5B-Instruct/generation_config.json

HF_TOKEN=$(cat ~/.huggingface/token)

MODEL_NAME="Qwen/Qwen3-1.7B"

docker_args=(
    --name vLLM-Tutorial \
    --runtime nvidia \
    --gpus all \
    #--network="host" \
    -p 5000:5000 \
    --ipc=host \
    -v ./models:/vllm-workspace/models \
    -v ./config:/vllm-workspace/config \
    -e VLLM_LOGGING_LEVEL=DEBUG \
    -e HUGGING_FACE_HUB_TOKEN=$HF_TOKEN \
    vllm/vllm-openai:v0.10.0 \
    # --load-format gguf \
    --model ${MODEL_NAME} \
    --served-model-name ${MODEL_NAME} \
    --gpu-memory-utilization 0.9 \
    # --cpu-offload-gb 16 \
    --max-num-batched-tokens 16384 \
    # --max-num-batched-tokens 8192 \
    # --max-num-batched-tokens 4096 \
    # --max-num-batched-tokens 2048 \
    --max-num-seqs 4 \
    --max-model-len 4096 \
    # --max-model-len 2048 \
    # --max-model-len 1024 \
    # --tensor_parallel_size 4 \
    # --pipeline_parallel_size 2 \
    # --enforce-eager \
    # --enable-prefix-caching \
    # --enable-chunked-prefill \
    # --num-scheduler-steps 10 \
    # --speculative-config '{"method": "ngram"}' \
    # --uvicorn-log-level debug \
    --host "0.0.0.0" \
    --port 5000
)

docker run -d "${docker_args[@]}"
