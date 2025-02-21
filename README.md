# LURAP-Chagatai
Processing transcriptions of Chagatai language for word count, line numbers located, and text located.

## Instructions
1. Download the transcription(s) as a plain text (.txt) file. Make sure they're in the same folder.

2. Download the code from this repo and put it in the same folder as the transcriptions
   - create_list.py is the file that outputs a .csv that is easily readable via Google Sheets
   - transcribe_files.bat the script for Windows that will automate the process for multiple .txt files
   - transcribe_files.sh the script fot MacOS that will automate the process for multiple .txt files

3. Once everything is in the same folder, double-click on the correct transcribe_files script for your OS
   - .bat for Windows
   - .sh for MacOS

4. .csv files will appear in the same folder (there will be one for every .txt file present).

5. To see the .csv files in a better format, import them to Google Sheets
   - there will be a pop-up box asking what the separator is. Leave it as "detect automatically"
   - the third column will present data as [number, number, number], this is expected