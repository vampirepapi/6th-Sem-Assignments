from imageai.Detection import ObjectDetection
import os

excecution_path = os.getcwd()

detetctor = ObjectDetection()
detetctor.setModelTypeasRetinaNet()
detector.setModelPath(os.path.join(excecution_path, "resnet50_coco_best_v2.1.0.h5"))
detetctor.LoadModel()
detetctions = detetctor.detectObjectsFromImage(input_image = os.path.join(excecution_path, "image.jpg"), output_image_path=os.path.join(excecution_path, "imagenew.jpg"))

for eachObject in detections:
	print(eachObject["name"], " : ", eachObject["percentage_probability"])
	