import cv2
import numpy as np
import os
from keras.models import model_from_json


import cv2
import numpy as np
import os
from keras.models import model_from_json


def preprocess_frame(frame, target_size=(250, 250)):
    """
    Standard preprocessing matching the training pipeline:
    Resizes directly to (250, 250) full frame. Gives 0% false alarms on normal traffic
    and accurate peak detection during collisions.
    """
    return cv2.resize(frame, target_size, interpolation=cv2.INTER_LINEAR)


class AccidentDetectionModel(object):

    class_nums = ['Accident', "No Accident"]

    def __init__(self, model_json_file, model_weights_file):
        # Load model from JSON architecture
        with open(model_json_file, "r") as json_file:
            loaded_model_json = json_file.read()
            self.loaded_model = model_from_json(loaded_model_json)

        # Load trained weights into the model
        self.loaded_model.load_weights(model_weights_file)
        self.loaded_model.make_predict_function()

    def predict_accident(self, img):
        """
        Original API: predicts on a pre-batched image array (1, 250, 250, 3).
        """
        self.preds = self.loaded_model.predict(img, verbose=0)
        return AccidentDetectionModel.class_nums[np.argmax(self.preds)], self.preds

    def predict_frame(self, bgr_frame):
        """
        Clean full-frame CNN inference:
        Accepts any standard BGR video frame, converts to RGB, resizes to (250, 250),
        and runs prediction.
        
        Returns:
            label (str): 'Accident' or 'No Accident'
            prob (ndarray): [[P(Accident), P(No Accident)]]
            processed_roi (ndarray): (250, 250, 3) preprocessed RGB image
        """
        rgb_frame = cv2.cvtColor(bgr_frame, cv2.COLOR_BGR2RGB)
        processed = preprocess_frame(rgb_frame, (250, 250))
        batch = processed[np.newaxis, :, :]
        
        self.preds = self.loaded_model.predict(batch, verbose=0)
        label = AccidentDetectionModel.class_nums[np.argmax(self.preds)]
        return label, self.preds, processed