import os
import sys

# Ensure the Accident-Detection-System folder is in Python search path
PROJECT_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "Accident-Detection-System")
if PROJECT_DIR not in sys.path:
    sys.path.insert(0, PROJECT_DIR)

from camera import startapplication

if __name__ == '__main__':
    source = sys.argv[1] if len(sys.argv) > 1 else None
    startapplication(source)
