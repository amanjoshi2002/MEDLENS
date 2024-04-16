def extract_text_from_response(file_path):
    try:
        with open(file_path, 'r') as file:
            # Read the content of the file
            response_data = file.read().strip()

            # Find the start and end index of the text
            start_index = response_data.find('\'text\'')
            end_index = response_data.find('\'role\'')

            # Extract the text between the start and end index
            text = response_data[start_index:end_index].strip()

            # Replace escape characters with actual newlines
            text = text.replace('\\n', '\n')

            return text
    except FileNotFoundError:
        print(f"File '{file_path}' not found.")
        return ""
    except Exception as e:
        print(f"Error extracting text from response: {e}")
        return ""

# Test the function with your file
text = extract_text_from_response('response.txt')
print(text)
