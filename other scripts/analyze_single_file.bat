@echo off
setlocal enabledelayedexpansion

REM Analyze a single .txt file from the transcriptions folder
REM This script:
REM 1. Shows available .txt files in transcriptions/
REM 2. Lets user choose one file
REM 3. Converts the selected .txt file to CSV using create_list.py
REM 4. Analyzes the CSV file using morphological_analyzer.py
REM 5. Outputs results to appropriate folders

echo 🔍 Single File Morphological Analysis
echo ==================================================

REM Check if transcriptions folder exists
if not exist "transcriptions\" (
    echo ❌ transcriptions/ folder not found!
    echo 💡 Please create a transcriptions/ folder and place your .txt files there
    pause
    exit /b 1
)

REM Check if any .txt files exist in transcriptions folder
set "txt_files_found="
for %%f in ("transcriptions\*.txt") do set "txt_files_found=1"
if not defined txt_files_found (
    echo ❌ No .txt files found in transcriptions/ folder
    echo 💡 Please place your .txt transcription files in the transcriptions/ folder
    pause
    exit /b 1
)

REM Check if required output directories exist, create if they don't
if not exist "transcription_tables\" (
    echo 📁 Creating transcription_tables directory...
    mkdir "transcription_tables"
)

if not exist "morphological_analysis\" (
    echo 📁 Creating morphological_analysis directory...
    mkdir "morphological_analysis"
)

REM Check if filename part was provided as argument
if "%~1"=="" (
    echo 💡 USAGE: analyze_single_file.bat ^<filename_part^>
    echo 💡 EXAMPLE: analyze_single_file.bat text24
    pause
    exit /b 1
)

set "filename_part=%~1"

REM Find matching file
set "selected_file="
set "selected_filename="
for %%f in ("transcriptions\*.txt") do (
    set "filename=%%~nxf"
    echo !filename! | findstr /i "!filename_part!" >nul
    if !errorlevel! equ 0 (
        set "selected_file=%%f"
        set "selected_filename=%%~nxf"
        goto :file_found
    )
)

:file_found
REM Check if a file was found
if not defined selected_file (
    echo ❌ No file found matching '!filename_part!'
    pause
    exit /b 1
)

echo.
echo 🎯 Selected file: !selected_filename!
echo --------------------------------------------------

REM Step 1: Convert selected .txt file to CSV
REM Run create_list.py on the selected .txt file
python "create_list.py" "!selected_file!"

REM Check if conversion was successful
if !errorlevel! equ 0 (
    echo ✅ Successfully converted: !selected_filename!
) else (
    echo ❌ Failed to convert: !selected_filename!
    pause
    exit /b 1
)

echo.

REM Find the generated CSV file
set "base_name=!selected_filename:.txt=!"
set "csv_file=transcription_tables\!base_name!-table.csv"

if not exist "!csv_file!" (
    echo ❌ Expected CSV file not found: !csv_file!
    echo 💡 Check if create_list.py generated the file correctly
    pause
    exit /b 1
)

REM Change to transcription_tables directory to run the analyzer
cd "transcription_tables"

REM Run morphological_analyzer.py on the CSV file
python "..\morphological_analyzer.py" "!base_name!-table.csv"

REM Check if analysis was successful
if !errorlevel! equ 0 (
    echo.
    echo 🔍 Successfully analyzed: !base_name!-table.csv
    
    REM Return to original directory
    cd ..
    
) else (
    echo ❌ Failed to analyze: !base_name!-table.csv
    cd ..  REM Return to original directory even on failure
    pause
    exit /b 1
)

pause

