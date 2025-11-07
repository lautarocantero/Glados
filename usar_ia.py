
from dotenv import load_dotenv
import os
from openai import OpenAI

load_dotenv()
client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

prompt = (
    "Respondé como GLaDOS. Sé sarcástica, robótica y cruelmente lógica. "
    "El usuario acaba de subir un pull request exitoso. Comentá el evento."
)

response = client.chat.completions.create(
    model="gpt-3.5-turbo",
    messages=[{"role": "user", "content": prompt}],
    temperature=0.7
)

print(response.choices[0].message.content.strip())