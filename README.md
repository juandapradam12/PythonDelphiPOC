# PythonDelphiPOC  

A working **starter kit / template** for embedding Python into a **Delphi VCL** application using [Python4Delphi (P4D)](https://github.com/pyscripter/python4delphi) and the **Python 3.11 embeddable runtime**.  

This POC establishes a reusable bridge:
- Delphi manages and embeds the Python runtime (embeddable distribution).  
- Delphi calls a Python **entrypoint** (`main(path)`) with parameters.  
- Python executes data logic (e.g., pandas DataFrame) and returns **JSON**.  
- Delphi displays or parses the JSON results.  

> ⚡️ Use this repo as a **template** for any future Delphi+Python project.  

---

## 📂 Project Structure

PythonDelphiPOC/
│
├─ app_delphi/ # Delphi application
│ ├─ forms/MainForm.pas/.dfm # VCL form (UI: TMemo + Button)
│ ├─ services/PyEngineService.pas # Python engine bootstrap (pure unit, no DFM)
│ └─ DelphiApp.dproj/.dpr # Delphi project files
│
├─ app_py/ # Python application code
│ ├─ main.py # Python entrypoint (called from Delphi)
│ └─ requirements.txt # numpy, pandas, scikit-learn, matplotlib, seaborn
│
├─ data/
│ └─ input/sample_points.txt # Example CSV/TXT dataset
│
├─ external_libraries/
│ ├─ python-3.11.9-embed-amd64/ # Python embeddable runtime
│ └─ python4delphi/ # P4D (submodule)
│
└─ README.md

---

## 🚀 Quick Start

### 1. Clone the repo (with submodules)

git clone --recurse-submodules https://github.com/<your-username>/PythonDelphiPOC.git

### 2. Install Python dependencies
Use the embeddable Python inside external_libraries/python-3.11.9-embed-amd64:

cd external_libraries/python-3.11.9-embed-amd64
.\python.exe -m pip install -r ..\..\app_py\requirements.txt

### 3. Configure Delphi
Set Win64 as active platform.

Add P4D sources to Search path:

external_libraries\python4delphi\Source
external_libraries\python4delphi\Source\vcl
Open app_delphi\DelphiApp.dproj, Build & Run.

### 4. Run the app
At startup, the memo shows:

App initialized
In the memo’s first line, enter a relative or absolute file path.

If empty → defaults to data/input/sample_points.txt.

Click Run → Delphi calls Python main(path) and prints JSON summary.

## 🧪 Example Run
Input file: data/input/sample_points.txt

Delphi memo output:

json
Copiar código
{
  "status": "ok",
  "path": "C:\\PythonDelphiPOC\\data\\input\\sample_points.txt",
  "rows": 3,
  "cols": 3,
  "columns": ["x", "y", "z"],
  "first_row": {"x": 0.1, "y": 1.2, "z": 2.3}
}
# 🔄 Reusing This Repo as a Template
There are two ways to start a new Python–Delphi project from this template:

## Option A — Use GitHub “Template Repository” (recommended)
Mark this repo as a template in GitHub (repo Settings → Template repository).

In GitHub, click “Use this template” to create a new repo.

Clone the new repo, and you’re ready to build.

## Option B — Manual copy
Clone this repo with submodules:

git clone --recurse-submodules https://github.com/<your-username>/PythonDelphiPOC.git
Copy everything except .git/ into a new folder.

Initialize the new repo:

cd NewProjectRepo
git init
git remote add origin https://github.com/<your-username>/NewProjectRepo.git
git add .
git commit -m "Initial commit from PythonDelphiPOC template"
git push -u origin main
Re-add the P4D submodule if needed:

git submodule add https://github.com/pyscripter/python4delphi.git external_libraries/python4delphi
git submodule update --init --recursive
Now you have a fresh, independent repo that already embeds Python in Delphi.

### 🛠 Updating Python4Delphi (submodule)
To pull the latest fixes from P4D:

git submodule update --remote --merge
git commit -am "Update Python4Delphi submodule"
git push
### ⚡️ Why Keep This POC?
Acts as a bridge template: minimal but functional.

Tested with Delphi 12 (Win64) + Python 3.11 embeddable.

Already integrates:

- P4D engine setup

- File path passing

- Python DataFrame computation

- JSON return contract

Can be copied into any project as the foundation for Python + Delphi integration.

