# MEDLENS

## 📱 Overview

MEDLENS is an innovative mobile application designed to simplify medication information access. Users can simply take a photo of a medicine, and the app provides comprehensive details about its uses, side effects, and proper consumption methods. This project combines the power of Flutter for the frontend, Flask for the backend, and integrates advanced OCR and AI technologies to deliver accurate and user-friendly medication information.

## 🚀 Key Features

- **Photo-based Medicine Recognition**: Quickly identify medications by taking a photo.
- **Comprehensive Information**: Get detailed insights on uses, side effects, and consumption guidelines.
- **User-Friendly Interface**: Intuitive design for easy navigation and information access.
- **Real-time Processing**: Fast and efficient backend processing for quick results.
- **Cross-Platform Compatibility**: Available on both iOS and Android devices.

## 🛠️ Technology Stack

- **Frontend**: Flutter
- **Backend**: Flask (Python)
- **OCR Model**: For extracting text from medicine images
- **AI Integration**: Google's Gemini AI for processing and retrieving medication information
- **API Communication**: HTTP package (Flutter), Flask-RESTful (Python)

## 🔍 How It Works

1. **Image Capture**: User takes a photo of a medicine using the app.
2. **Image Processing**: The image is sent to the Flask backend.
3. **OCR Processing**: An OCR model extracts text content from the image.
4. **AI Analysis**: The extracted text is processed by Gemini AI to retrieve relevant medication information.
5. **Information Display**: The app presents the gathered information to the user in an easy-to-read format.

## 🏁 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Python 3.8+
- pip (Python package manager)
- Git

### Frontend Setup (Flutter)

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/medlens.git
   cd medlens/frontend
   ```

2. Install Flutter dependencies:
   ```
   flutter pub get
   ```

3. Run the app on an emulator or physical device:
   ```
   flutter run
   ```

### Backend Setup (Flask)

1. Navigate to the backend directory:
   ```
   cd ../backend
   ```

2. Create a virtual environment:
   ```
   python -m venv venv
   source venv/bin/activate  # On Windows use `venv\Scripts\activate`
   ```

3. Install Python dependencies:
   ```
   pip install -r requirements.txt
   ```

4. Set up environment variables (API keys, etc.)

5. Run the Flask server:
   ```
   flask run
   ```

## 💡 Usage

1. Open the MEDLENS app on your mobile device.
2. Click on the camera icon to take a photo of a medicine.
3. Ensure the medicine name or packaging is clearly visible in the frame.
4. Capture the image and wait for the app to process it.
5. View the detailed information about the medicine, including its uses, side effects, and consumption guidelines.

## 🤝 Contributing

We welcome contributions to MEDLENS! Here's how you can help:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/AmazingFeature`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
5. Push to the branch (`git push origin feature/AmazingFeature`).
6. Open a Pull Request.

## 🔮 Future Enhancements

- Implement multi-language support for global accessibility.
- Add a feature to save and manage a personal medication list.
- Integrate with pharmacy databases for price comparisons and availability information.
- Develop a web interface for broader accessibility.

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

