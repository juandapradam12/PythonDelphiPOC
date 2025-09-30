import os
import sys
import json
import pandas as pd
import numpy as np
from datetime import datetime
import uuid

def process_file(path: str) -> dict:
    """
    Load a CSV/TXT file into a pandas DataFrame and return a summary as a dict.
    """
    base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))  # project root
    if not os.path.isabs(path):
        path = os.path.normpath(os.path.join(base_dir, path))

    if not os.path.exists(path):
        return {
            "status": "error",
            "message": f"File not found: {path}"
        }

    try:
        df = pd.read_csv(path, sep=None, engine="python", on_bad_lines="skip")
        rows, cols = df.shape
        cols_list = [str(c) for c in df.columns]
        first_row = df.iloc[0].to_dict() if rows > 0 else {}

        return {
            "status": "ok",
            "path": path,
            "rows": rows,
            "cols": cols,
            "columns": cols_list,
            "first_row": first_row
        }
    except Exception as e:
        return {
            "status": "error",
            "message": f"Error reading file {path}: {type(e).__name__}: {e}"
        }

def main(path: str = None) -> str:
    """
    Main entry point for Delphi.
    Returns JSON string so Delphi can parse it easily.
    """
    if path:
        result = process_file(path)
    else:
        result = {
            "status": "ok",
            "message": f"Hello from Python! Session={uuid.uuid4()}, Time={datetime.now().isoformat()}"
        }
    return json.dumps(result, indent=2)

if __name__ == "__main__":
    # If run from terminal, take the last argument as path
    if len(sys.argv) > 1:
        test_path = sys.argv[-1]
        print(main(test_path))
    else:
        print("Usage: python main.py <path-to-file>")
