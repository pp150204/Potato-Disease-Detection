# 🥔 Potato Disease Detection System

[![Flutter](https://img.shields.io/badge/Flutter-3.38.8-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.10.7-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![TensorFlow](https://img.shields.io/badge/TensorFlow-2.x-FF6F00?logo=tensorflow&logoColor=white)](https://tensorflow.org)
[![TFLite](https://img.shields.io/badge/TFLite-On--Device%20Inference-FF6F00?logo=tensorflow&logoColor=white)](https://www.tensorflow.org/lite)
[![Accuracy](https://img.shields.io/badge/Test%20Accuracy-93.53%25-brightgreen)](model_training/)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey)]()
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

An intelligent, on-device mobile application that leverages **Deep Learning (CNN)** and **TensorFlow Lite** within a **Flutter** client to accurately identify and classify potato leaf diseases in real-time. Built to help farmers, agronomists, and researchers diagnose crop health instantly without needing an internet connection.

---

## 📌 Table of Contents

- [Overview](#-overview)
- [Key Features](#-key-features)
- [Supported Diseases](#-supported-diseases)
- [Machine Learning Architecture](#-machine-learning-architecture)
  - [Model Overview](#model-overview)
  - [Evaluation Metrics](#evaluation-metrics)
- [Project Directory Structure](#-project-directory-structure)
- [Tech Stack & Dependencies](#-tech-stack--dependencies)
- [Getting Started](#-getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation & Setup](#installation--setup)
  - [Running the Application](#running-the-application)
- [Model Training & Conversion](#-model-training--conversion)
- [Application Workflow](#-application-workflow)
- [Roadmap & Future Enhancements](#-roadmap--future-enhancements)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🔍 Overview

Potato crops worldwide are vulnerable to destructive diseases such as **Early Blight** (*Alternaria solani*) and **Late Blight** (*Phytophthora infestans*). Failure to detect these conditions early can lead to substantial agricultural yield losses.

Traditional diagnostic methods rely on manual laboratory examination or specialized agronomist visits, which are costly, slow, and often inaccessible in rural farming communities.

**Potato Disease Detection System** provides a complete end-to-end solution:
1. **Model Pipeline**: A Custom Convolutional Neural Network (CNN) trained and validated using TensorFlow/Keras on potato leaf datasets.
2. **On-Device Deployment**: Converted to a compact **TensorFlow Lite (`.tflite`)** model running directly on smartphone hardware.
3. **Cross-Platform Mobile App**: A responsive Flutter user interface enabling one-tap image selection, instant prediction, and confidence scoring.

---

## ✨ Key Features

- **⚡ 100% Offline Inference:** Runs completely on-device using `tflite_flutter`. No internet connection, API keys, or cloud servers are required.
- **🎯 High Classification Accuracy:** Achieves **90.53% accuracy** on independent test datasets.
- **📷 Easy Image Selection:** Pick high-resolution leaf images directly from your device gallery.
- **📊 Real-Time Diagnostic Feedback:** Displays the predicted disease name along with an exact confidence percentage score.
- **🌱 Clean & Intuitive Material UI:** Simple, accessible interface tailored for field use by farmers and agricultural researchers.
- **🔬 Complete Data Science Pipeline:** Includes the Jupyter notebook used for dataset preprocessing, data augmentation, CNN training, evaluation, and TFLite model quantization.

---

## 🩺 Supported Diseases

| Class | Scientific Agent / Cause | Visual Symptoms | Agricultural Impact |
| :--- | :--- | :--- | :--- |
| **Early Blight** | *Alternaria solani* (Fungus) | Concentric circular rings or "target board" brown spots on mature leaves. | Progressive defoliation, stunted tuber development, reduced yield. |
| **Late Blight** | *Phytophthora infestans* (Oomycete) | Water-soaked dark brown to black lesions with pale green borders, often with white fungal growth on leaf undersides in humid conditions. | Rapid plant decay, severe foliage destruction, rot of entire crop within days if untreated. |
| **Healthy** | None | Vigorous green foliage free from lesions, chlorosis, or necrotic spots. | Optimal crop development and tuber yield. |

---

## 🧠 Machine Learning Architecture

### Model Overview

The classifier is built using a custom deep Convolutional Neural Network (CNN) designed for fine-grained leaf texture feature extraction:

```
[Input Layer: 256x256x3 RGB Image]
          │
          ▼
[Resizing & Rescaling (1/255 Normalization)]
          │
          ▼
[Data Augmentation (Random Flip & Random Rotation)]
          │
          ▼
[Conv2D (32 filters, 3x3) + ReLU] ──► [MaxPooling2D (2x2)]
          │
          ▼
[Conv2D (64 filters, 3x3) + ReLU] ──► [MaxPooling2D (2x2)]
          │
          ▼
[Conv2D (64 filters, 3x3) + ReLU] ──► [MaxPooling2D (2x2)]
          │
          ▼
[Conv2D (64 filters, 3x3) + ReLU] ──► [MaxPooling2D (2x2)]
          │
          ▼
[Flatten Layer]
          │
          ▼
[Dense (64 units) + ReLU]
          │
          ▼
[Dense (3 units) + Softmax Output] ──► [Early Blight | Late Blight | Healthy]
```

### Evaluation Metrics

The model was trained and evaluated with an **80% - 10% - 10%** train-validation-test split:

- **Input Dimension:** $256 \times 256 \times 3$
- **Loss Function:** Categorical Crossentropy
- **Optimizer:** Adam
- **Test Accuracy:** **93.53%**
- **Test Loss:** **0.2032**
- **Model Size:** ~3.42 MB (`potato_disease_model.tflite`)

---

## 📁 Project Directory Structure

```text
potato_disease_detection_system/
├── assets/
│   ├── labels.txt                           # Class labels (Early Blight, Late Blight, Healthy)
│   └── model/
│       └── potato_disease_model.tflite      # Trained TFLite model for mobile deployment
├── lib/
│   ├── homepage.dart                        # Main application UI (image picker, buttons, result view)
│   ├── main.dart                            # Flutter application entry point & theme
│   └── potato_classifier.dart               # TFLite inference handler, preprocessing, & prediction logic
├── model_training/
│   └── Potato_Disease_Detectionipynb.ipynb  # End-to-end Jupyter Notebook (Data loading, CNN training, TFLite export)
├── test/
│   └── widget_test.dart                     # Flutter UI widget test suite
├── android/                                 # Android native host project
├── ios/                                     # iOS native host project
├── pubspec.yaml                             # Flutter package dependencies and asset configuration
└── README.md                                # Project documentation
```

---

## 💻 Tech Stack & Dependencies

### Mobile App (Client)
- **Framework:** [Flutter](https://flutter.dev) (Dart SDK `^3.10.7`)
- **UI System:** Material 3 / Material Design
- **Inference Engine:** [`tflite_flutter: ^0.12.1`](https://pub.dev/packages/tflite_flutter)
- **Image Processing:** [`image: ^4.9.2`](https://pub.dev/packages/image)
- **Image Picker:** [`image_picker: ^1.2.3`](https://pub.dev/packages/image_picker)

### Machine Learning & Training
- **Framework:** TensorFlow 2.x & Keras
- **Environment:** Python 3.9+ / Jupyter Notebook / Google Colab
- **Model Converter:** `tf.lite.TFLiteConverter`
- **Visualization:** Matplotlib, NumPy

---

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed on your machine:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.10.0 or higher)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with Flutter & Dart extensions
- Android SDK (API Level 21+ recommended) or an Android physical device / emulator

### Installation & Setup

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/pp150204/Potato-Disease-Detection.git
   cd potato_disease_detection_system
   ```

2. **Install Flutter Dependencies:**
   ```bash
   flutter pub get
   ```

3. **Verify Asset Registration:**
   Confirm that `pubspec.yaml` includes the model and assets:
   ```yaml
   flutter:
     uses-material-design: true
     assets:
       - assets/
       - assets/model/
   ```

### Running the Application

1. **Connect a device** or start an emulator:
   ```bash
   flutter devices
   ```

2. **Launch the app in debug mode:**
   ```bash
   flutter run
   ```

3. **Build an Android APK (Release mode):**
   ```bash
   flutter build apk --release
   ```
   The generated APK will be available under `build/app/outputs/flutter-apk/app-release.apk`.

---

## 🧪 Model Training & Conversion

If you want to retrain the neural network or experiment with hyperparameters:

1. Navigate to the `model_training/` folder:
   ```bash
   cd model_training
   ```
2. Open `Potato_Disease_Detectionipynb.ipynb` in **Jupyter Lab**, **VS Code**, or upload it to **Google Colab**.
3. Load the potato leaf dataset (such as the [PlantVillage Dataset](https://www.kaggle.com/datasets/emmarex/plantdisease)).
4. Run the notebook cells to:
   - Perform data augmentation (flip, rotation) and resizing to $256 \times 256$.
   - Train the 4-layer CNN model using categorical crossentropy.
   - Evaluate training/test accuracy curves.
   - Export the model to `.keras` and `.tflite` format:
     ```python
     converter = tf.lite.TFLiteConverter.from_keras_model(model)
     tflite_model = converter.convert()
     with open('potato_disease_model.tflite', 'wb') as f:
         f.write(tflite_model)
     ```
5. Place the newly generated `potato_disease_model.tflite` into `assets/model/` inside your Flutter project.

---

## 📱 Application Workflow

```text
[User Opens App]
       │
       ▼
[TFLite Interpreter Loads 'potato_disease_model.tflite']
       │
       ▼
[Tap "Select Image" ➔ Choose Leaf from Gallery]
       │
       ▼
[Tap "Detect Disease" ➔ Preprocessing (Resize to 256x256, Normalize RGB)]
       │
       ▼
[TensorFlow Lite Model Inference (<150ms)]
       │
       ▼
[Display Diagnosis: Disease Label + Confidence Percentage (%)]
```

---

## 🗺️ Roadmap & Future Enhancements

- [ ] **Live Camera Feed:** Real-time bounding box detection and video-stream disease classification.
- [ ] **Multilingual Support:** Localization in regional agricultural languages (Hindi, Spanish, Bengali, etc.).
- [ ] **Treatment & Advisory Guide:** Provide organic and chemical fungicide treatment recommendations directly within the app.
- [ ] **Model Quantization (INT8):** Optimize the `.tflite` model size down to < 1 MB for ultra-low latency on entry-level smartphones.
- [ ] **History & Field Reports:** Save previous diagnoses with GPS coordinates and timestamps for crop monitoring.

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!
1. Fork the Project.
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`).
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the Branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).

---

## 👨‍💻 Author & Acknowledgments

- **Author:** [Prathmesh Pimpare](https://github.com/pp150204)
- **Dataset:** PlantVillage Potato Leaf Disease Dataset
- **Tools:** TensorFlow, TensorFlow Lite, Flutter, and the open-source community
