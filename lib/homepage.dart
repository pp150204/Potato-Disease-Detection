import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:potato_disease_detection_system/potato_classifier.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();

  final PotatoClassifier _classifier = PotatoClassifier();

  File? selectedImage;

  String prediction = '';
  double confidence = 0.0;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _classifier.loadModel();
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    setState(() {
      selectedImage = File(image.path);
      prediction = '';
      confidence = 0.0;
    });
  }

  Future<void> predictDisease() async {
    if (selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image first'),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final result = await _classifier.predict(selectedImage!);

      setState(() {
        prediction = result['label'];
        confidence = result['confidence'];
      });
    } catch (e) {
      debugPrint('Prediction error: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _classifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Potato Disease Detection'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            // Image
            Expanded(
              child: selectedImage == null
                  ? const Center(
                child: Text(
                  'Select a potato image',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
                  : Image.file(
                selectedImage!,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 20),

            // Select image
            SizedBox(
              width: double.infinity,
 
              child: ElevatedButton(
                onPressed: pickImage,

                child: const Text(
                  'Select Image',
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Predict
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : predictDisease,

                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                  'Detect Disease',
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Result
            if (prediction.isNotEmpty)
              Column(
                children: [

                  Text(
                    prediction,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Confidence: ${(confidence * 100).toStringAsFixed(2)}%',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}