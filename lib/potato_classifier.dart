import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class PotatoClassifier {
  Interpreter? _interpreter;

  // IMPORTANT:
  final List<String> labels = [
    'Early_Blight',
    'Late_Blight',
    'Potato_Healthy',
  ];

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(
        'assets/model/potato_disease_model.tflite',
      );

      debugPrint('Model loaded successfully');

      debugPrint(
        'Input shape: ${_interpreter!.getInputTensor(0).shape}',
      );

      debugPrint(
        'Output shape: ${_interpreter!.getOutputTensor(0).shape}',
      );
    } catch (e) {
      debugPrint('Error loading model: $e');
    }
  }

  Future<Map<String, dynamic>> predict(File imageFile) async {
    if (_interpreter == null) {
      throw Exception('Model interpreter not initialized');
    }

    // Read image
    final imageBytes = await imageFile.readAsBytes();

    img.Image? image = img.decodeImage(imageBytes);

    if (image == null) {
      throw Exception('Could not decode image');
    }

    // Resize to 256x256
    image = img.copyResize(
      image,
      width: 256,
      height: 256,
    );

    // Create input
    final input = [
      List.generate(
        256,
            (y) => List.generate(
          256,
              (x) {
            final pixel = image!.getPixel(x, y);

            return [
              pixel.r.toDouble(),
              pixel.g.toDouble(),
              pixel.b.toDouble(),
            ];
          },
        ),
      ),
    ];

    // Output
    final output = [
      List.filled(3, 0.0),
    ];

    // Run model
    _interpreter!.run(input, output);

    final probabilities = output[0];

    // Find highest probability
    int predictedIndex = 0;

    for (int i = 1; i < probabilities.length; i++) {
      if (probabilities[i] > probabilities[predictedIndex]) {
        predictedIndex = i;
      }
    }

    return {
      'label': labels[predictedIndex],
      'confidence': probabilities[predictedIndex],
    };
  }

  void close() {
    _interpreter?.close();
  }
}