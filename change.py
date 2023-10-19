import os
# Set this three values(basepath, replacewith, replacedigit) manually
basepath = 'datasets/'
replacewith = '1'
replacedigit = '11'

folderspath = ['test/labels', 'train/labels','valid/labels']
folderspath = [basepath+folder for folder in folderspath]

def classmodifier(folderspath,replace_digit,replace_with):
    
    for i in folderspath:
        # Loop through all files in the specified folder
        for filename in os.listdir(i):
            print("Replacing in file: "+filename+"of"+i)
            if filename.endswith(".txt"):
                file_path = os.path.join(i, filename)
                
                # Read the file and modify the lines in-place
                with open(file_path, 'r+') as file:
                    lines = file.readlines()

                    # Modify the lines by replacing the leading 0 with 1
                    modified_lines = [replace_with + line[1:] if line.startswith(replace_digit) else line for line in lines]

                    # Go back to the beginning of the file and overwrite the content
                    file.seek(0)
                    file.truncate()
                    file.writelines(modified_lines)


classmodifier(folderspath,replacedigit,replacewith)