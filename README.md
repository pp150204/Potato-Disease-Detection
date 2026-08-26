# Potato Disease Detection

An end-to-end AI-powered potato disease detection system that uses a Convolutional Neural Network (CNN) to classify potato leaf images into disease categories. The trained TensorFlow/Keras model is converted to TensorFlow Lite (TFLite) and deployed in a Flutter mobile application for fast, on-device inference.

The project covers the complete machine-learning deployment pipeline — from dataset preparation and CNN training to TFLite conversion and mobile integration.

---

## 📌 Project Overview

Potato crops can be affected by various diseases that reduce crop quality and yield. Early identification can help farmers take appropriate action.

This project provides a mobile-based solution where a user can select a potato leaf image and receive:

* Predicted disease class
* Prediction confidence
* Fast on-device inference
* Mobile-friendly interface

The prediction is performed locally using a TensorFlow Lite model, so an external ML API is not required.

---

## ✨ Features

* Select potato leaf images from the device gallery
* CNN-based image classification
* TensorFlow/Keras model training
* TensorFlow Lite model for mobile deployment
* Flutter mobile application
* Confidence score for predictions
* On-device inference
* Modular Flutter project structure
* Complete model-training Jupyter/Colab notebook

---

## 🏗️ System Architecture

```text
┌──────────────────┐
│   Potato Leaf    │
│      Image       │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ Flutter Mobile   │
│   Application    │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│      Image       │
│   Preprocessing  │
│   256 × 256 RGB  │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ TensorFlow Lite  │
│      Model       │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│  CNN Prediction  │
└────────┬─────────┘
         │
         ▼
┌───────────────────────────┐
│ Disease + Confidence      │
│          Score            │
└───────────────────────────┘
```

---

## 🤖 Machine Learning Pipeline

The model development workflow is:

```text
Dataset
   ↓
Image Loading
   ↓
Image Resizing
   ↓
256 × 256
   ↓
Dataset Splitting
   ↓
Train / Validation / Test
   ↓
Data Augmentation
   ↓
CNN Model
   ↓
Model Training
   ↓
Model Evaluation
   ↓
Keras Model
   ↓
TensorFlow Lite Conversion
   ↓
Flutter Integration
```

---

## 🧠 Model Details

The model was developed using TensorFlow and Keras.

### 📥 Input

| Parameter   | Value           |
| ----------- | --------------- |
| Image Size  | 256 × 256       |
| Channels    | 3 (RGB)         |
| Input Shape | `(256, 256, 3)` |
| Data Type   | `float32`       |

### 📤 Output

| Parameter    | Value   |
| ------------ | ------- |
| Output Shape | `(3,)`  |
| Activation   | Softmax |

The model produces three probability values corresponding to the three classes in the training dataset.

The predicted class is selected based on the highest probability.

> **Note:** The class order used by the Flutter application must exactly match `dataset.class_names` from the training notebook.

---

## 🧱 CNN Architecture

The CNN consists of multiple convolutional and pooling layers followed by fully connected layers.

```text
Input: 256 × 256 × 3
        │
        ▼
Conv2D - 32 Filters
        │
        ▼
MaxPooling2D
        │
        ▼
Conv2D - 64 Filters
        │
        ▼
MaxPooling2D
        │
        ▼
Conv2D - 64 Filters
        │
        ▼
MaxPooling2D
        │
        ▼
Conv2D - 64 Filters
        │
        ▼
MaxPooling2D
        │
        ▼
Flatten
        │
        ▼
Dense - 64
        │
        ▼
Dense - 3
        │
        ▼
Softmax
```

---

## 📊 Model Performance

The trained model achieved approximately:

### 93% Accuracy

The model was evaluated using the prepared dataset and achieved approximately 93% classification accuracy.

For a more complete evaluation, future versions can include:

* Precision
* Recall
* F1-score
* Confusion matrix
* Per-class accuracy
* Real-world image testing

---

## 🖼️ Data Preprocessing

Images are resized to:

```text
(256, 256)
```

The model includes pixel-value rescaling:

```python
layers.Rescaling(1.0 / 255)
```

Data augmentation was applied during training using:

```python
layers.RandomFlip("horizontal_and_vertical")
layers.RandomRotation(0.2)
```

This helps the model learn from variations in image orientation and improves generalization.

---

## 📱 Flutter Application

The trained model is deployed in a Flutter application using TensorFlow Lite.

### 📦 Flutter Packages

```text
tflite_flutter
image_picker
image
```

### 🔄 Application Workflow

```text
Select Image
     ↓
Load Image
     ↓
Resize to 256 × 256
     ↓
Convert to RGB Tensor
     ↓
Run TFLite Inference
     ↓
Get 3 Probabilities
     ↓
Find Highest Probability
     ↓
Display Disease
     ↓
Display Confidence
```

---

## 📁 Project Structure

```text
Potato-Disease-Detection/
│
├── flutter_app/
│   │
│   ├── android/
│   ├── ios/
│   │
│   ├── assets/
│   │   └── models/
│   │       └── potato_disease_model.tflite
│   │
│   ├── lib/
│   │   ├── screens/
│   │   │   └── home_page.dart
│   │   │
│   │   ├── services/
│   │   │   └── potato_classifier.dart
│   │   │
│   │   └── main.dart
│   │
│   ├── pubspec.yaml
│   └── ...
│
├── model_training/
│   └── Potato_Disease_Detection.ipynb
│
├── README.md
└── .gitignore
```

---

## 🛠️ Technologies Used

| Technology      | Purpose                 |
| --------------- | ----------------------- |
| Python          | Model development       |
| TensorFlow      | Deep learning framework |
| Keras           | CNN implementation      |
| CNN             | Image classification    |
| TensorFlow Lite | Mobile inference        |
| Flutter         | Mobile application      |
| Dart            | Application development |
| NumPy           | Numerical operations    |
| Matplotlib      | Visualization           |
| Git/GitHub      | Version control         |

---

## 🚀 Getting Started

### 📋 Prerequisites

Make sure you have installed:

* Flutter SDK
* Android Studio / Android SDK
* VS Code or another IDE
* Git
* An Android device or emulator

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/Potato-Disease-Detection.git
```

Navigate to the Flutter application:

```bash
cd Potato-Disease-Detection/flutter_app
```

### 2. Install Flutter Dependencies

```bash
flutter pub get
```

### 3. Verify the Model

Make sure the following file exists:

```text
assets/models/potato_disease_model.tflite
```

The model is loaded by the Flutter application using:

```text
assets/models/potato_disease_model.tflite
```

### 4. Run the Application

Connect an Android device or start an emulator.

Then run:

```bash
flutter run
```

---

## 📓 Model Training

The complete training notebook is available here:

```text
model_training/Potato_Disease_Detection.ipynb
```

The notebook contains:

* Dataset extraction
* Dataset loading
* Image preprocessing
* Dataset splitting
* Data augmentation
* CNN architecture
* Model compilation
* Model training
* Accuracy and loss visualization
* Testing
* Sample predictions
* TensorFlow Lite conversion

---

## 🔄 TensorFlow Lite Conversion

After training, the Keras model is converted into a `.tflite` model:

```text
TensorFlow / Keras Model
          │
          ▼
     TFLiteConverter
          │
          ▼
potato_disease_model.tflite
          │
          ▼
   Flutter Application
```

The converted model has:

```text
Input  : [1, 256, 256, 3]
Output : [1, 3]
```

This makes the model suitable for deployment in a mobile application.

---

## 🔐 Privacy & Deployment

The model performs inference directly on the user's device.

```text
User Image
    ↓
Flutter App
    ↓
TFLite Model
    ↓
Prediction
```

No image needs to be uploaded to a remote server solely for disease classification.

This provides:

* Faster prediction
* Reduced network dependency
* Better privacy
* Offline inference capability

---

## 🔮 Future Improvements

* Real-time disease detection using the camera
* Experiment with transfer learning models such as MobileNet and EfficientNet
* Improve performance using a larger and more diverse dataset
* Add detailed confusion matrix and classification reports
* Provide disease descriptions and prevention information
* Provide recommended treatment information with appropriate agricultural guidance
* Add multilingual support
* Add prediction history
* Apply TFLite quantization to reduce model size
* Improve performance on real-world smartphone images

---

## ⚠️ Disclaimer

This project is developed for educational and demonstration purposes.

The predictions generated by the model should not be considered a substitute for professional agricultural diagnosis. For serious crop disease management, users should consult qualified agricultural experts.

---

## 👨‍💻 Author

**Prathmesh Pimpare**

Computer Science Engineering (Systems)

---

## ⭐ Support

If you find this project useful or interesting, consider giving the repository a ⭐ on GitHub.
