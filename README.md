# SEM_PROJECT
This is the repository for our 2nd year / Fourth semester project.

# TO GET STARTED 

1 .clone the repository using the command

      git clone <.... .git>

2. install required dependencies

         pip install -r requiremtns.txt



# DATA COLLECTION AND PREPROCESSING

1. Collect images you want to the yolo model to predict individually and save them in 3 folders train, test and valid

2. Or you can use the 'frameextractor.py' to extract images form a video by after you have
    - Created a folder named mov_files containg all the videos to extract from
    - Created a folder named frames_folder (extracted frames gets saved here)

3. You can label the images individually using LabelImg
   - Tutorial link : https://www.youtube.com/watch?v=fjynQ9P2C08

4. Or you can get your labelled datasets from Roboflow or any other sources to train

5. To change the clases labels of your labels.txt files you can use 'change.py'

6. To change the clases labels of your labels.txt files you can use the function 'find_files_with_classes()' function located in 'classchecker.py'

7. If the 'change.py' didnt work properly you can use process_annotations() fnction in 'classchecker.py' to change the labels

8. To move the images and labels from one folder to another it is recommended to use 'locationchanger.py' as it moves all the labels as well as images in a go rather then CtrlX CrtlV

Keep the datasets  in this format

      Main Dir
            |---Datasets
                     |----Train
                     |       |---Images
                     |       |---Lables
                     |
                     |----Test
                     |      | ---Images
                     |      | ---Lables
                     |
                     |----Valid
                     |     | ---Images
                     |     | ---Lables
                     |
                     |----data.yaml
                     
# Note : This proess plays a vital role as any mistakes may casue the training process to be uncessful(cause errors)
# So make sure that for every images there is a .txt file with the same name containg the correct labels and the path is correct in data.yaml file



# TRAIN THE MODEL
