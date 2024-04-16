import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medilens',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FrontPage(),
    );
  }
}

class FrontPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medilens'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/medicine_image.jpg', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          GestureDetector(
            onVerticalDragUpdate: (details) {
              if (details.primaryDelta! < -20) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImageUploadPage()),
                );
              }
            },
            child: Container(
              height: 50, // Height of the arrow
              child: Icon(
                Icons.keyboard_arrow_up,
                size: 50,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Text(
                  'Medilens',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Add your logo widget here
                    Image.asset(
                      'assets/images/MEDILENS.jpg', // Replace with your logo path
                      height: 50,
                      width: 50,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageUploadPage extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  File? _image;
  String? _extractedText;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _extractedText = null;
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_image == null) {
      print('No image selected.');
      return;
    }

    final uri = Uri.parse("http://10.0.2.2:5000/upload");
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final parsedResponse = jsonDecode(responseBody);
        setState(() {
          _extractedText = parsedResponse['text'];
        });
        print('Text extracted successfully');
      } else {
        print('Failed to extract text');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade300, Colors.green.shade800],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image == null
                  ? Text('No image selected.', style: TextStyle(color: Colors.white))
                  : Image.file(_image!),
              SizedBox(height: 20),
              _extractedText != null
                  ? Text(
                      _extractedText!,
                      style: TextStyle(color: Colors.white),
                    )
                  : SizedBox.shrink(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getImage,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                ),
                child: Text('Pick Image'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _uploadImage,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                ),
                child: Text('Extract Text'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_extractedText != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SideEffectsPage(text: _extractedText!),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                ),
                child: Text('Go to Side Effects'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SideEffectsPage extends StatelessWidget {
  final String text;

  SideEffectsPage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Side Effects'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade300, Colors.green.shade800],
          ),
        ),
        child: Center(
          child: Text(
            text, // Display the extracted text
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
