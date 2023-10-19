import shutil
import os

# Specify the source and destination folders baseurls only
source_folder_baseurl = "RB_DS/4603/"
destination_folder_baseurl = "datasets/"

folders = ["test/labels", "train/labels", "valid/labels", "test/images", "train/images", "valid/images"]
source_folders = [source_folder_baseurl + folder for folder in folders]
destination_folders = [destination_folder_baseurl + folder for folder in folders]

# Specify the source folders and their corresponding destination folders
# source_folders = ["path_to_source_folder1", "path_to_source_folder2", "path_to_source_folder3"]
# destination_folders = ["path_to_destination_folder1", "path_to_destination_folder2", "path_to_destination_folder3"]

# Loop through the source-destination pairs and copy the files
for source_folder, destination_folder in zip(source_folders, destination_folders):
    for filename in os.listdir(source_folder):
        print("Copying file: " + filename + " from " + source_folder + " to " + destination_folder)
        source_file = os.path.join(source_folder, filename)
        destination_file = os.path.join(destination_folder, filename)
        shutil.copy(source_file, destination_file)
