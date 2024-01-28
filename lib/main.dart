import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'braille_display_screen.dart'; 
import 'package:flutter_tts/flutter_tts.dart'; 

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Photo to Text App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: CameraScreen(),
    );
  }
}

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  int _selectedCameraIdx = 0;
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _initializeCameras();
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
  }

  Future<void> _initializeCameras() async {
    _cameras = await availableCameras();

    if (_cameras != null && _cameras!.isNotEmpty) {
      setState(() {
        _controller = CameraController(
          _cameras![_selectedCameraIdx],
          ResolutionPreset.medium,
        );
        _controller!.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    flutterTts.stop();
    super.dispose();
  }

  Future<String> _getTextFromImage(String imagePath) async {
    String apiKey =
        'AIzaSyCbMZFRHsP92Z8aSr-nsCyhF7o4rJkUqkY'; 
    String url = 'https://vision.googleapis.com/v1/images:annotate?key=$apiKey';

    String base64Image = base64Encode(File(imagePath).readAsBytesSync());
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "requests": [
          {
            "image": {"content": base64Image},
            "features": [
              {"type": "TEXT_DETECTION"}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      var jsonResult = jsonDecode(response.body);
      String extractedText =
          jsonResult['responses'][0]['fullTextAnnotation']['text'];
      await _speak(extractedText); 
      return extractedText;
    } else {
      throw Exception('Failed to extract text from image');
    }
  }

  Future<void> _speak(String text) async {
    if (text.isNotEmpty) {
      await flutterTts.speak(text);
    }
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: Camera not initialized")));
      return;
    }

    if (_controller!.value.isTakingPicture) {
      return;
    }

    try {
      final XFile image = await _controller!.takePicture();
      String extractedText = await _getTextFromImage(image.path);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BrailleDisplayScreen(text: extractedText),
        ),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: Failed to capture image")));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('BRAILLY TRANSLATOR'),
      ),
      body: CameraPreview(_controller!),
      bottomNavigationBar: Container(
        color: Colors.white, 
        padding: EdgeInsets.all(10), 
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height *
              0.2, 
          child: ElevatedButton(
            onPressed: _takePicture,
            child: Text("Capture", style: TextStyle(fontSize: 20)),
            style: ElevatedButton.styleFrom(
              primary: Colors.purple, 
              onPrimary: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
