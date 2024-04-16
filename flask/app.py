from flask import Flask, request, jsonify
from flask_cors import CORS
import pytesseract
from PIL import Image
import google.generativeai as genai
import os

from text import extract_text_from_response

app = Flask(__name__)
CORS(app)

os.environ['YOUR_API_KEY'] = "AIzaSyCCgV_4zM-zQQfui-vs8QNZ8LKyVVD5k4Y"

# Configure Gemini AI
genai.configure(api_key=os.environ['YOUR_API_KEY'])
model = genai.GenerativeModel('gemini-pro')

def extract_content(response):
    if 'result' in response and 'candidates' in response['result'] and response['result']['candidates']:
        parts = response['result']['candidates'][0]['content'].get('parts', [])
        summary = ""
        for part in parts:
            summary += part.get('text', '') + "\n"
        return summary.strip()
    else:
        return "Failed to extract content"

def generate_summary(extracted_text):
    if not extracted_text:
        return ""  # Return empty string if extracted_text is empty

    # Static command to summarize
    command = "give me sideeffect of this medicine: " + extracted_text

    # Generate content using Gemini AI
    response = model.generate_content(command)
    print("Response from Gemini AI:", response)
    
    summary = extract_content(response)
    
    # Write the response to a text file
    with open('response.txt', 'w') as file:
        file.write(str(response))
    
    return summary

def extract_text_from_image(image_path):
    # Use Tesseract OCR to extract text from the image
    text = pytesseract.image_to_string(Image.open(image_path))
    return text

@app.route('/upload', methods=['POST'])
def upload():
    if 'image' not in request.files:
        return jsonify({'error': 'No file part'})
    file = request.files['image']
    if file.filename == '':
        return jsonify({'error': 'No selected file'})
    # Save the image to a temporary location
    image_path = 'temp_image.jpg'
    file.save(image_path)
    # Extract text from the image
    extracted_text = extract_text_from_image(image_path)

    print("Extracted Text:", extracted_text)  # Print extracted text on the command line

    summary = generate_summary(extracted_text)
    print("Summary:", summary)
    
    try:
        text = extract_text_from_response('response.txt')
        return jsonify({'text': text})
    except Exception as e:
        return jsonify({'error': str(e)})


if __name__ == '__main__':
    app.run(debug=True)


