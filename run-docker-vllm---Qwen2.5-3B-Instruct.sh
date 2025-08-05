#!/bin/bash

# huggingface-cli download lmstudio-community/Qwen2.5-3B-Instruct-GGUF Qwen2.5-3B-Instruct-Q4_K_M.gguf --local-dir ./models/Qwen2.5-3B-Instruct/
# huggingface-cli download Qwen/Qwen2.5-3B-Instruct generation_config.json --local-dir ./config/Qwen2.5-3B-Instruct
# sed -i 's|"temperature":.*|"temperature": 0.0,|g' ./config/Qwen2.5-3B-Instruct/generation_config.json
# sed -i 's|"top_k":.*|"top_k": 0.5,|g' ./config/Qwen2.5-3B-Instruct/generation_config.json

#HF_TOKEN=$(cat ~/.huggingface/token)

docker_args=(
    --name vLLM-Tutorial \
    --runtime nvidia \
    --gpus all \
    #--network="host" \
    -p 5000:5000 \
    --ipc=host \
    -v ./models:/vllm-workspace/models \
    -v ./config:/vllm-workspace/config \
    #-e HUGGING_FACE_HUB_TOKEN=$HF_TOKEN \
    vllm/vllm-openai:v0.9.2 \
    # --load-format gguf \
    --model models/Qwen2.5-3B-Instruct/Qwen2.5-3B-Instruct-Q4_K_M.gguf \
    --generation-config config/Qwen2.5-3B-Instruct \
    #--tokenizer Qwen/Qwen2.5-3B-Instruct \
    --gpu-memory-utilization 0.8 \
    #--cpu-offload-gb 16 \
    --served-model-name "Qwen/Qwen2.5-3B-Instruct" \
    --max-num-batched-tokens 32768 \
    #--max-num-batched-tokens 16384 \
    #--max-num-batched-tokens 8192 \
    #--max-num-batched-tokens 4096 \
    --max-num-seqs 3 \
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
