#!/bin/bash

# huggingface-cli download mradermacher/llama-3.2-3b-sys-log-analysis-v1-GGUF llama-3.2-3b-sys-log-analysis-v1.Q4_K_M.gguf --local-dir ./models/llama-3.2-3b-sys-log-analysis
# huggingface-cli download meta-llama/Llama-3.2-3B generation_config.json --local-dir ./config/llama-3.2-3b-sys-log-analysis
# sed -i 's|"temperature":.*|"temperature": 0.1,|g' ./config/llama-3.2-3b-sys-log-analysis/generation_config.json
# sed -i 's|"top_k":.*|"top_k": 0.5,|g' ./config/llama-3.2-3b-sys-log-analysis/generation_config.json

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
    --model models/llama-3.2-3b-sys-log-analysis/llama-3.2-3b-sys-log-analysis-v1.Q4_K_M.gguf \
    --generation-config config/llama-3.2-3b-sys-log-analysis \
    --gpu-memory-utilization 0.8 \
    #--cpu-offload-gb 16 \
    --served-model-name "mradermacher/llama-3.2-3b-sys-log-analysis" \
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
