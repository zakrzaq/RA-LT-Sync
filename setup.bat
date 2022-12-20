python -m pip install --upgrade pip
pip install virtualenv
python -m venv env
pip install python-dotenv pywin32 pandas numpy openpyxl keyboard
pip list
echo call env/Scripts/activate.bat >> lt_sync.bat
echo python app.py >> lt_sync.bat
python "setup.py"
