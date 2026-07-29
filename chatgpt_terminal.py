import openai

# Set your API key here
openai.api_key = "sk-XXXXXXXXXXXXXXXXXXXX"

response = openai.chat.completions.create(
    model="gpt-4",
    messages=[
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": "Hello! Can you test if this works?"}
    ]
)

print(response.choices[0].message["content"])