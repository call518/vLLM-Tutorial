import requests

# Basic chat completion request. Note the endpoint is different to ollama 
response = requests.post('http://127.0.0.1:5000/v1/chat/completions', 
    json={
        'model': 'vLLM-Qwen2.5-3B-Instruct',
        'messages': [
            {
                'role': 'system',
                'content': 'You are a helpful AI assistant. (Please answer in Korean.)'
            },
            {
                'role': 'user',
                'content': 'AI에 대해 설명해 주세요.'
            }
        ],
        'stream': False
    }
)
print(response.json()['choices'][0]['message']['content'])