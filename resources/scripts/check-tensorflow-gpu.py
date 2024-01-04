# 파이썬 환경에서 아래 명령으로 TensorFlow 환경을 확인합니다.
import logging, os
logging.disable(logging.WARNING)
os.environ["TF_CPP_MIN_LOG_LEVEL"] = "3"

import tensorflow as tf
from tensorflow.python.client import device_lib

print(tf.__version__)
print(tf.test.is_built_with_cuda())

print(device_lib.list_local_devices())
print("Num GPUs Available: ", len(tf.config.list_physical_devices('GPU')))
tf.test.gpu_device_name()
