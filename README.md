## SEm Project
## Getting Started

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
            
            git clone https://github.com/ultralytics/yolov5.git


2. **Customize Training Parameters:**
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
                  
3. **GPU Activation:**
- Activate GPU-enabled environment for faster training if available.

4. **Train the Model:**

            python train.py

Wait for the training process to complete.

5. **Locate Trained Model:**
- Find the trained model at `runs/train/expX/weights/best.pt`.

6. **Convert to TFLite:**

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
