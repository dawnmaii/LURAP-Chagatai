@echo off
setlocal enabledelayedexpansion

REM Process all .txt files in the transcriptions/ folder
REM This script:
REM 1. Accesses the transcriptions/ folder
REM 2. Converts each .txt file to CSV using create_list.py (outputs to transcription_tables/)
REM 3. Analyzes each CSV file using morphological_analyzer.py (outputs to morphological_analysis/)

echo 🚀 Starting batch processing of all .txt files from transcriptions/ folder...
echo ============================================================

REM Check if transcriptions folder exists
if not exist "transcriptions\" (
    echo ❌ transcriptions/ folder not found!
    echo 💡 Please create a transcriptions/ folder and place your .txt files there
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

REM Check if any .txt files exist in transcriptions folder
set "txt_files_found="
for %%f in ("transcriptions\*.txt") do set "txt_files_found=1"
if not defined txt_files_found (
    echo ❌ No .txt files found in transcriptions/ folder
    echo 💡 Please place your .txt transcription files in the transcriptions/ folder
    pause
    exit /b 1
)

REM Step 1: Convert all .txt files to CSV using create_list.py
echo.
echo 📊 STEP 1: Converting .txt files to CSV format...
echo.

set "txt_count=0"
for %%f in ("transcriptions\*.txt") do (
    echo 🎯 Selected file: %%f
    
    REM Run create_list.py on each .txt file
    python "create_list.py" "%%f"
    
    REM Check if conversion was successful
    if !errorlevel! equ 0 (
        echo ✅ Successfully converted: %%f
        set /a "txt_count+=1"
    ) else (
        echo ❌ Failed to convert: %%~nxf
    )
    
    echo ---
)

REM Step 2: Analyze all CSV files using morphological_analyzer.py
echo.
echo 🔍 STEP 2: Running morphological analysis on CSV files...
echo.

REM Check if any CSV files exist in transcription_tables
set "csv_files_found="
for %%f in ("transcription_tables\*.csv") do set "csv_files_found=1"
if not defined csv_files_found (
    echo ❌ No CSV files found in transcription_tables directory
    echo 💡 Step 1 must complete successfully before proceeding
    pause
    exit /b 1
)

REM Move to transcription_tables directory to process CSV files
cd "transcription_tables"

set "csv_count=0"
for %%f in ("*.csv") do (
    echo 🔍 Analyzing: %%~nxf
    echo.
    
    REM Run morphological_analyzer.py on each CSV file
    python "..\morphological_analyzer.py" "%%f"
    
    REM Check if analysis was successful
    if !errorlevel! equ 0 (
        echo ✅ Successfully analyzed: %%~nxf
        set /a "csv_count+=1"
    ) else (
        echo ❌ Failed to analyze: %%~nxf
    )
    
    echo ---
)

REM Return to original directory
cd ..

REM Final summary
echo 🎯 BATCH PROCESSING COMPLETE!
echo.

pause
