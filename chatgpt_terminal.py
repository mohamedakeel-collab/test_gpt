import os
import openai

# Read your API key from environment variable
openai.api_key = os.getenv("OPENAI_API_KEY")

print("ChatGPT Terminal started. Type 'exit' to quit.")

while True:
    prompt = input("You: ")
    if prompt.lower() in ["exit", "quit"]:
        break
    try:
        response = openai.ChatCompletion.create(
            model="gpt-5-mini",
            messages=[{"role": "user", "content": prompt}]
        )
        print("ChatGPT:", response.choices[0].message.content)
    except Exception as e:
        print("Error:", e)