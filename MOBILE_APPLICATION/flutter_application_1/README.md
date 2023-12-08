# FLUTTER APPLICATION

This Flutter application is designed to detect, report, and visualize potholes using various functionalities and integrations.

## Features
1. Live Pothole Detection and Auto Reporting
  -Utilizes a YOLOv5 model for real-time pothole detection.
  -Automatically reports detected potholes by sending GPS coordinates to Firebase Realtime Database.
   
2. Pothole Reporting
  -Employs a custom-trained TFLite model (from Teachable Machine) to classify potholes in clicked or chosen photos.
  -Offers an option to report detected potholes, sending current GPS coordinates to Firebase Realtime Database.

3.Pothole Visualization
  -Integrates OpenStreetMap (OSM) for a user-friendly map interface.
  -Retrieves stored pothole coordinates from Firebase Realtime Database, displaying them on the map for better visualization.

## Installation

1.Clone the repository:

    git clone https://github.com/your_username/your_repository.git

    
2.Install dependencies:

    flutter pub get

Ensure necessary API keys and configurations (Firebase) are set up. Refer to config_example.dart for required configurations.

## Usage

1. Live Pothole Detection
  - To use the live pothole detection feature, navigate to the corresponding section within the app.
  - Ensure the device's camera is accessible and point it towards the road surface.
  - The app will detect potholes in real-time and automatically report their GPS coordinates to the Firebase Realtime Database.


2. Reporting Potholes
  - Access the reporting feature from the app's menu or designated section.
  - Either take a photo or choose an existing one.
  - The TFLite model will classify if the image contains a pothole. If positive, you'll be prompted to report it, sending GPS coordinates to Firebase Realtime Database.

  
3. Viewing Potholes
  - Visit the map visualization section within the app.
  - The map will display marked locations of reported potholes retrieved from the Firebase Realtime Database.


## Technologies & Plugins Used
  - cupertino_icons
  - sliding_up_panel
  - flutter_map
  - latlong2
  - flutter_polyline_points
  - google_fonts
  - camera
  - image
  - flutter_vision
  - provider
  - firebase_core
  - firebase_storage
  - firebase_database
  - cloud_firestore
  - location
  - flutter_tflite
  - image_picker
  - another_flushbar
