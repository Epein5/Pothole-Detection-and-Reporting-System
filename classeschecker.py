import os

# checks if the change.py worked
def find_files_with_classes(folder_path, target_classes):
    matching_files = []

    for filename in os.listdir(folder_path):
        if filename.endswith(".txt"):
            annotation_file = os.path.join(folder_path, filename)
            with open(annotation_file, "r") as file:
                contains_target_classes = False
                for line in file:
                    class_index = int(line.strip().split()[0])
                    if class_index in target_classes:
                        contains_target_classes = True
                        break
                if contains_target_classes:
                    matching_files.append(filename)

    return matching_files
# Specify the path to the folder containing annotation files
folder_path = "datasets/train/labels"
target_classes = [10, 11]  # List of target class indices to search for
matching_files = find_files_with_classes(folder_path, target_classes)
if len(matching_files) > 0:
    print("Files containing target classes:")
    for filename in matching_files:
        print(filename)
else:
    print("No files containing target classes found.")



# chanes annotaions in the  required folder if the change.py didnt work
def process_annotations(folder_path, target_classes):
    for filename in os.listdir(folder_path):
        if filename.endswith(".txt"):
            annotation_file = os.path.join(folder_path, filename)
            with open(annotation_file, "r") as file:
                lines = file.readlines()
            with open(annotation_file, "w") as file:
                for line in lines:
                    parts = line.strip().split()
                    if len(parts) > 0:
                        class_index = int(parts[0])
                        if class_index in target_classes:
                            parts[0] = "1"  # Replace class labels 10 and 11 with 1
                        file.write(" ".join(map(str, parts)) + "\n")

folder_path = "datasets/valid/labels"

target_classes = [10, 11]  # List of target class indices to change to 1

# process_annotations(folder_path, target_classes)


