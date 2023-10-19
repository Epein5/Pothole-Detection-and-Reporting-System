import cv2
import os

def extractframesfromvideos(inputfolderpath,outputfolderpath,type,frame_skip):
    input_directory = inputfolderpath

    output_directory = outputfolderpath
    os.makedirs(output_directory, exist_ok=True)

    mov_files = [f for f in os.listdir(input_directory) if f.endswith(type)]

    for mov_file in mov_files:
        video_file = os.path.join(input_directory, mov_file)
        cap = cv2.VideoCapture(video_file)

        if not cap.isOpened():
            print(f"Error: Could not open {mov_file}.")
            continue

        frame_count = 0
        frame_skip = frame_skip
        a = 0

        while True:
            ret, frame = cap.read()

            if not ret:
                break

            if frame_count % frame_skip == 0:
                a += 1
                output_file = os.path.join(output_directory, f'{a}.jpg')

                cv2.imwrite(output_file, frame)

                print(f"Saved frame {frame_count} from {mov_file}")

            frame_count += 1

        cap.release()

    cv2.destroyAllWindows()

extractframesfromvideos("mov_files","frames_folder",".MOV",3)