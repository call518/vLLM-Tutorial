# Tutorial Documents

- (Part-1) https://henrynavarro.org/ollama-vs-vllm-which-framework-is-better-for-inference-part-i-d8211d7248d2
- (Part-2) https://henrynavarro.org/ollama-vs-vllm-which-framework-is-better-for-inference-part-ii-37f7e24d3899
- (Part-3) https://henrynavarro.org/ollama-vs-vllm-which-framework-is-better-for-inference-part-iii-004f62d44e4f
- vllm-workspace: https://github.com/schmitech/vllm-workspace

# Example) Get Model

```bash
$ pip install huggingface_hub
$ huggingface-cli login --token {TOKEN}
$ huggingface-cli whoami

(e.g. Qwen2.5-3B-Instruct-GGUF)
$ huggingface-cli download lmstudio-community/Qwen2.5-3B-Instruct-GGUF Qwen2.5-3B-Instruct-Q4_K_M.gguf --local-dir ./models/Qwen2.5-3B-Instruct/
$ huggingface-cli download Qwen/Qwen2.5-3B-Instruct generation_config.json --local-dir ./config/Qwen2.5-3B-Instruct

(optional)
$ huggingface-cli download lmstudio-community/Qwen2.5-1.5B-Instruct-GGUF Qwen2.5-1.5B-Instruct-Q4_K_M.gguf --local-dir ./models/Qwen2.5-1.5B-Instruct/
$ huggingface-cli download Qwen/Qwen2.5-1.5B-Instruct generation_config.json --local-dir ./config/Qwen2.5-1.5B-Instruct

$ vi ./config/generation_config.json
{
  "bos_token_id": 151643,
  "pad_token_id": 151643,
  "do_sample": true,
  "eos_token_id": [
    151645,
    151643
  ],
  "repetition_penalty": 1.05,
  "temperature": 0.0,
  "top_p": 0.8,
  "top_k": 20,
  "transformers_version": "4.37.0"
}
```

# Run vLLM (/w Docker)

```bash
(Qwen2.5-3B-Instruct-Q4_K_M.gguf)
$ ./run-docker-vllm---Qwen2.5-3B-Instruct.sh

(Check API)
$ curl -s -X GET http://localhost:5000/v1/models | jq
{
  "object": "list",
  "data": [
    {
      "id": "vLLM-Qwen2.5-3B-Instruct",
      "object": "model",
      "created": 1750609168,
      "owned_by": "vllm",
      "root": "models/Qwen2.5-3B-Instruct/Qwen2.5-3B-Instruct-Q4_K_M.gguf",
      "parent": null,
      "max_model_len": 4096,
      "permission": [
        {
          "id": "modelperm-89300f90242a4014b1c096dc7cf69724",
          "object": "model_permission",
          "created": 1750609168,
          "allow_create_engine": false,
          "allow_sampling": true,
          "allow_logprobs": true,
          "allow_search_indices": false,
          "allow_view": true,
          "allow_fine_tuning": false,
          "organization": "*",
          "group": null,
          "is_blocking": false
        }
      ]
    }
  ]
}
```
