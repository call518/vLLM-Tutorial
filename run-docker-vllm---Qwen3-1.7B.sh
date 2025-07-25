#!/bin/bash

# huggingface-cli download lmstudio-community/Qwen3-1.7B-GGUF Qwen3-1.7B-Q4_K_M.gguf --local-dir ./models/Qwen3-1.7B/
# huggingface-cli download Qwen/Qwen3-1.7B generation_config.json --local-dir ./config/Qwen3-1.7B
# sed -i 's|"temperature":.*|"temperature": 0.1,|g' ./config/Qwen3-1.7B/generation_config.json
# sed -i 's|"top_k":.*|"top_k": 0.5,|g' ./config/Qwen3-1.7B/generation_config.json

HF_TOKEN=$(cat ~/.huggingface/token)

docker_args=(
    --name vLLM-Tutorial \
    --runtime nvidia \
    --gpus all \
    #--network="host" \
    -p 5000:5000 \
    --ipc=host \
    -v ./models:/vllm-workspace/models \
    -v ./config:/vllm-workspace/config \
    -e HUGGING_FACE_HUB_TOKEN=$HF_TOKEN \
    vllm/vllm-openai:v0.9.2 \
    # --load-format gguf \
    --model models/Qwen3-1.7B/Qwen3-1.7B-Q4_K_M.gguf \
    --generation-config config/Qwen3-1.7B \
    --tokenizer Qwen/Qwen3-1.7B \
    --gpu-memory-utilization 0.5 \
    #--cpu-offload-gb 16 \
    --served-model-name "Qwen/Qwen3-1.7B" \
    --max-num-batched-tokens 16384 \
    #--max-num-batched-tokens 8192 \
    #--max-num-batched-tokens 4096 \
    --max-num-seqs 4 \
    --max-model-len 16384 \
    #--max-model-len 8192 \
    #--max-model-len 4096 \
    #--tensor_parallel_size 4 \
    #--pipeline_parallel_size 2 \
    #--enforce-eager \
    #--enable-prefix-caching \
    #--enable-chunked-prefill \
    #--num-scheduler-steps 10 \
    #--speculative-config '{"method": "ngram"}' \
    --host "0.0.0.0" \
    --port 5000
)

docker run -d "${docker_args[@]}"
