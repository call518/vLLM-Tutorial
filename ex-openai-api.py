from openai import OpenAI

client = OpenAI(
    base_url="http://127.0.0.1:5000/v1",
    api_key="dummy" # vLLM accept requiring API key, one of its advantage agains ollama. In our case we set None, so you can set any string
)

# Chat completion
response = client.chat.completions.create(
    model="vLLM-Qwen2.5-3B-Instruct",
    messages=[
            {
                "role": "system",
                "content": "You are a helpful AI assistant. (Please answer in Korean.)"
            },
            {
                "role": "user",
                "content": "구구단 출력 파이썬 코드 작성해 주세요."
            }
        ]
)
print(response.choices[0].message.content)