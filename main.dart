import 'package:flutter/material.dart';

void main() {
  runApp(EmotionAnalyzerApp());
}

class EmotionAnalyzerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sentiment Analyzer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EmotionAnalyzerHomePage(),
    );
  }
}

class EmotionAnalyzerHomePage extends StatefulWidget {
  @override
  _EmotionAnalyzerHomePageState createState() =>
      _EmotionAnalyzerHomePageState();
}

class _EmotionAnalyzerHomePageState extends State<EmotionAnalyzerHomePage> {
  String emotionOutput = '';

  // Function to capture the photo
  void capturePhoto() {
    // TODO: Implement photo capture logic
  }

  // Function to upload the photo
  void uploadPhoto() {
    // TODO: Implement photo upload logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sentiment Analyzer'),
      ),
      backgroundColor:
          Color.fromRGBO(221, 205, 197, 1), // Set the background color
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'HOW ARE YOU FEELING TODAY?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'TELL US WITH A SELFIE :)',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            // TODO: Display the captured photo here
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: capturePhoto,
                style: ElevatedButton.styleFrom(
                  primary:
                      Color.fromRGBO(164, 112, 90, 1), // Set the button color
                ),
                child: Text('Take Photo'),
              ),
              SizedBox(width: 40),
              ElevatedButton(
                onPressed: uploadPhoto,
                style: ElevatedButton.styleFrom(
                  primary:
                      Color.fromRGBO(164, 112, 90, 1), // Set the button color
                ),
                child: Text('Upload Photo'),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'You look$emotionOutput _____ today!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Incorrect? Retake Photo',
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
