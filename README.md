## Pothole Detection and Reporting System
## Overview
Our system integrates a trained YOLOv5 model with a TensorFlow Lite conversion to detect potholes. It's built into a mobile application featuring live pothole detection, GPS-based reporting, and visualization on an OpenStreetMap (OSM).

## Features
1. Pothole Reporting: Users can report potholes by capturing images. The GPS coordinates are sent to a Firebase database for future reference and action.

2. Live Pothole Detection: The application continuously scans the surroundings using a camera. When a pothole is detected, its location, identified through the YOLOv5 model, is sent in real-time to the Firebase database.

3. Vehicle-Mounted Detection: By placing a camera in front of a vehicle, the system can detect potholes during travel. This facilitates the collection of pothole data along routes.

4. OSM Map Integration: Users can view the GPS coordinates of reported potholes on an OpenStreetMap interface within the application. This allows for a visual representation of pothole locations across a geographic area.

## How It Works
1. Model Training: The YOLOv5 model was trained on a dataset of 50,000 images to accurately detect potholes.

2. Conversion to TensorFlow Lite: The trained model was converted to TFLite for efficient deployment on mobile devices.

3. Mobile Application: The mobile app enables users to report potholes, perform live detection, and view reported incidents on an OSM map.

## Get Started

1. **Clone the Repository:**
                  
            git clone <.... .git>
   
3. **Install Dependencies:**

            pip install -r requirements.txt

## Data Collection and Preprocessing

1. **Image Collection:**
- Collect images individually and save them in three folders: `train`, `test`, and `valid`.

2. **Video Frame Extraction:**
- Use 'frameextractor.py' to extract images from videos:
  - Place videos in the 'mov_files' folder.
  - Extracted frames will be saved in the 'frames_folder'.

3. **Labeling:**
- Label images using LabelImg. Tutorial link [here](https://www.youtube.com/watch?v=fjynQ9P2C08).

4. **Labelled Datasets:**
- Obtain labeled datasets from Roboflow or other sources for training.

5. **Manipulating Labels:**
- Use 'change.py' or 'classchecker.py' functions to modify class labels.
- `change.py` and `process_annotations()` functions are available for label changes.

6. **Moving Images and Labels:**
- Utilize 'locationchanger.py' to efficiently move images and corresponding labels between folders.

7. **Dataset Format:**
- Maintain the following dataset structure:
  ```
  Main Dir
        |---Datasets
                 |----Train
                 |       |---Images
                 |       |---Labels
                 |
                 |----Test
                 |      | ---Images
                 |      | ---Labels
                 |
                 |----Valid
                 |     | ---Images
                 |     | ---Labels
                 |
                 |----data.yaml
  ```
- Ensure every image has a corresponding .txt file with correct labels.

## Training the Model

1. **Clone YOLOv5 Repository:**
- Inside Pothole-Detection-and-Reporting-System directory
  
            git clone https://github.com/ultralytics/yolov5.git
2. **Install yolov5 Dependencies:**

            pip install -r requirements.txt


3. **Customize Training Parameters:**
- Modify settings in the 'train.py' file (around line 442) to adjust epochs, batch-size, imgsize, etc.

            def parse_opt(known=False):
                  parser = argparse.ArgumentParser()
                  parser.add_argument('--weights', type=str, default=ROOT / 'yolov5s.pt', help='initial weights path')
                  parser.add_argument('--cfg', type=str, default='', help='model.yaml path')
                  parser.add_argument('--data', type=str, default=' .........path/to/your/data.yaml/ file.......', help='dataset.yaml path')
                  parser.add_argument('--hyp', type=str, default=ROOT / 'data/hyps/hyp.scratch-low.yaml', help='hyperparameters path')
                  parser.add_argument('--epochs', type=int, default=100, help='total training epochs')
                  parser.add_argument('--batch-size', type=int, default=16, help='total batch size for all GPUs, -1 for autobatch')
                  parser.add_argument('--imgsz', '--img', '--img-size', type=int, default=640, help='train, val image size (pixels)')
                  
4. **GPU Activation:**
- Activate GPU-enabled environment for faster training if available.

5. **Train the Model:**

            python train.py

Wait for the training process to complete.

6. **Locate Trained Model:**
- Find the trained model at `runs/train/expX/weights/best.pt`.

7. **Convert to TFLite:**

            python path/to/export.py --weights path/to/trained/weights/best.pt --include tflite

# Deploying the Model in Flutter

1. **Model Placement in Flutter:**
   - Store the model along with its labels in the 'assets' folder inside the 'flutter_application' directory.

2. **Setting Up Firebase:**
   - Connect your Flutter application with a Firebase project.
   - Follow [this tutorial](https://www.youtube.com/watch?v=mAZ03PCp2ZI) for detailed instructions.

3. **Running Flutter Application:**
   - Execute the following commands:
     
     ```
     flutter pub get
     flutter run
     ```
   Your application is now ready for deployment.
   
   For more details on the application visit the README inside the MOBILE APPLICAITON dir.

<br>
<br>

# Request for Contributions: 
## Adding Bounding Box for Live Detection
I am looking to enhance live pothole detection feature by implementing a bounding box visualization around detected potholes. This improvement will provide users with a clearer indication of where the detected potholes are in the camera view.

<br>

## Task Description
The task involves adding a bounding box around identified potholes during live detection. This will require modifications in the YOLOv5 model integration and the UI to draw and update bounding boxes accordingly.

<br>

## How to Contribute
  - Fork the repository.
  - Implement the bounding box feature in the live detection module.
  - Test the functionality thoroughly.
  - Submit a pull request with your changes in your won branch
<br>

## Resources
  - Check the existing YOLOv5 model integration and  https://pub.dev/packages/flutter_vision.
  - Refer to the YOLOv5 documentation for assistance.
 <br>
 
## Helpful Tips
  - Ensure the bounding box aligns accurately with detected potholes.
  - Maintain code quality and adhere to Flutter's best practices.
  - Document your changes adequately for better understanding.
 <br>
 
## Get Started
Feel free to reach out if you have any questions or need clarification on the task. Let's collaborate to enhance our live pothole detection feature!

Your contributions are highly appreciated!
