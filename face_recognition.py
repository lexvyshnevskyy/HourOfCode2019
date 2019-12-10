import time
import cv2
import os

FACE_DETECTOR_PATH = '/'.join([os.path.dirname(os.path.realpath(__file__)), 'faceRecognition/haarcascade_frontalface_default.xml'])

detector = cv2.CascadeClassifier(FACE_DETECTOR_PATH)
# initialize the video stream and allow the camera sensor to warm up
vs = cv2.VideoCapture(0)
vs.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
vs.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)
# Raspberry pi camera
# vs = VideoStream(usePiCamera=True).start()

print("[INFO] starting video stream...")
time.sleep(4.0)

# loop over frames from the video file stream
while True:
    # grab the frame from the threaded video stream and resize it
    ret, image = vs.read()

    image_2 = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    rects = detector.detectMultiScale(image_2, scaleFactor=1.2, minNeighbors=5, minSize=(30, 30), flags=cv2.CASCADE_SCALE_IMAGE)

    for (x, y, w, h) in rects:
        image = cv2.rectangle(image, (x, y), (x + w, y + h), (255, 0, 0), 2)

    cv2.imshow("Frame", image)
    key = cv2.waitKey(1) & 0xFF

    # if the `q` key was pressed, break from the loop
    if key == ord("q"):
        break

# do a bit of cleanup
cv2.destroyAllWindows()
vs.stop()