import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

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
  File? displayimage;
  bool isLoading = false;

  Future pickimage(String type) async {
    if (type == "camera") {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      final bytes = imageTemporary.readAsBytesSync();
      String img64 = base64Encode(bytes);
      var dio = Dio();

      setState(() {
        isLoading = true; // Show loading indicator
      });

      try {
        var response = await dio.post("http://192.168.0.72:5003/post_json",
            data: {"byte_string": img64});

        setState(() {
          isLoading = false; // Hide loading indicator
          displayimage = imageTemporary;
          emotionOutput = response.data.toString();
        });

        print("response" + response.data.toString());
        print("key1" + response.statusCode.toString());
        print("imagelength" + img64.length.toString());
        debugPrint("image is here" + img64);
      } catch (error) {
        // Handle error
        setState(() {
          isLoading = false; // Hide loading indicator
        });
        print("Error: $error");
      }
    } else {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);

      final bytes = imageTemporary.readAsBytesSync();
      String img64 = base64Encode(bytes);
      var dio = Dio();

      setState(() {
        isLoading = true; // Show loading indicator
      });

      try {
        var response = await dio.post("http://192.168.0.72:5003/post_json",
            data: {"byte_string": img64});

        setState(() {
          isLoading = false; // Hide loading indicator
          displayimage = imageTemporary;
          emotionOutput = response.data.toString();
        });

        print("response" + response.data.toString());
        print("key1" + response.statusCode.toString());
        print("imagelength" + img64.length.toString());
        debugPrint("image is here" + img64);
      } catch (error) {
        // Handle error
        setState(() {
          isLoading = false; // Hide loading indicator
        });
        print("Error: $error");
      }
    }
  }

  // Function to capture the photo
  void capturePhoto() {
    pickimage("camera");

    // TODO: Implement photo capture logic
  }

  // Function to upload the photo
  void uploadPhoto() {
    print("hello");
    pickimage("upload");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sentiment Analyzer'),
      ),
      backgroundColor:
          Color.fromRGBO(221, 205, 197, 1), // Set the background color
      body: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: Column(
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
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    border: Border.all(color: Colors.black),
                  ),
                  child: displayimage != null
                      ? Image.file(displayimage!)
                      : Container(),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: capturePhoto,
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(
                            164, 112, 90, 1), // Set the button color
                      ),
                      child: Text('Take Photo'),
                    ),
                    SizedBox(width: 40),
                    ElevatedButton(
                      onPressed: uploadPhoto,
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(
                            164, 112, 90, 1), // Set the button color
                      ),
                      child: Text('Upload Photo'),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                const SizedBox(
                    height:
                        20), // Increase the space between the previous text and this text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    emotionOutput.isNotEmpty
                        ? 'Your Emotion(s): $emotionOutput!'
                        : "",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                    height:
                        20), // Increase the space between the previous text and this text
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Incorrect? Move closer to camera',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: capturePhoto,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                      ),
                      child: Text('Retake Photo'),
                    ),
                  ],
                ),
                SizedBox(
                    height:
                        20), // Increase the space between the previous text and this text
                Center(
                  // Center align the following text
                  child: Text(
                    'Connect with our Chatbot/Therapist Now!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black, // Set the color explicitly
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10)
              ],
            ),
          ),
        ),
        Center(
          child: Visibility(
            visible: isLoading,
            child: CircularProgressIndicator(),
          ),
        )
      ]),
    );
  }
}
