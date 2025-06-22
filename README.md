# Tutorial Documents

- (Part-1) https://henrynavarro.org/ollama-vs-vllm-which-framework-is-better-for-inference-part-i-d8211d7248d2
- (Part-2) https://henrynavarro.org/ollama-vs-vllm-which-framework-is-better-for-inference-part-ii-37f7e24d3899
- (Part-3) https://henrynavarro.org/ollama-vs-vllm-which-framework-is-better-for-inference-part-iii-004f62d44e4f

# Example) Get Model

```bash
$ pip install huggingface_hub
$ huggingface-cli login --token {TOKEN}
$ huggingface-cli whoami

(e.g. Qwen2.5-3B-Instruct-GGUF)
$ huggingface-cli download lmstudio-community/Qwen2.5-3B-Instruct-GGUF Qwen2.5-3B-Instruct-Q4_K_M.gguf --local-dir ./models/Qwen2.5-3B-Instruct/ 
$ huggingface-cli download Qwen/Qwen2.5-3B-Instruct generation_config.json --local-dir ./config/Qwen2.5-3B-Instruct
```

# Run vLLM (/w Docker)

```bash
(e.g.)
$ ./run-docker-vllm---Qwen2.5-3B-Instruct.sh

(Check API)
$ curl -X GET http://127.0.0.1:5000/v1/models
```
