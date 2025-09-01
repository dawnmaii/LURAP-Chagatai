#!/bin/bash

# Process all .txt files in the transcriptions/ folder
# This script:
# 1. Accesses the transcriptions/ folder
# 2. Converts each .txt file to CSV using create_list.py (outputs to transcription_tables/)
# 3. Analyzes each CSV file using morphological_analyzer.py (outputs to morphological_analysis/)

echo "🚀 Starting batch processing of all .txt files from transcriptions/ folder..."
echo "============================================================"

# Check if transcriptions folder exists
if [ ! -d "transcriptions" ]; then
    echo "❌ transcriptions/ folder not found!"
    echo "💡 Please create a transcriptions/ folder and place your .txt files there"
    exit 1
fi

# Check if required output directories exist, create if they don't
if [ ! -d "transcription_tables" ]; then
    echo "📁 Creating transcription_tables directory..."
    mkdir -p transcription_tables
fi

if [ ! -d "morphological_analysis" ]; then
    echo "📁 Creating morphological_analysis directory..."
    mkdir -p morphological_analysis
fi

# Check if any .txt files exist in transcriptions folder
txt_files=()
while IFS= read -r -d '' file; do
    txt_files+=("$file")
done < <(find transcriptions -name "*.txt" -print0 2>/dev/null)

if [ ${#txt_files[@]} -eq 0 ]; then
    echo "❌ No .txt files found in transcriptions/ folder"
    echo "💡 Please place your .txt transcription files in the transcriptions/ folder"
    exit 1
fi

# Step 1: Convert all .txt files to CSV using create_list.py
echo ""
echo "📊 STEP 1: Converting .txt files to CSV format..."
echo ""

txt_count=0
for txt_file in transcriptions/*.txt; do
    
    # Run create_list.py on each .txt file
    if python3 create_list.py "$txt_file"; then
        ((txt_count++))
        echo "🎯 Selected file: $txt_file"
        echo "✅ Successfully converted: $txt_file"
        echo "---"
    else
        echo "❌ Failed to convert: $(basename "$txt_file")"
    fi
done

# Step 2: Analyze all CSV files using morphological_analyzer.py
echo ""
echo "🔍 STEP 2: Running morphological analysis on CSV files..."
echo ""

# Check if any CSV files exist in transcription_tables
if [ -z "$(ls -A transcription_tables/*.csv 2>/dev/null)" ]; then
    echo "❌ No CSV files found in transcription_tables directory"
    echo "💡 Step 1 must complete successfully before proceeding"
    exit 1
fi

# Move to transcription_tables directory to process CSV files
cd transcription_tables || exit 1

csv_count=0
for csv_file in *.csv; do
    echo "🔍 Analyzing: $csv_file"
    echo ""
    # Run morphological_analyzer.py on each CSV file
    if python3 ../morphological_analyzer.py "$csv_file"; then
        ((csv_count++))
        echo "---"
    else
        echo "❌ Failed to analyze: $csv_file"
    fi
done

# Return to original directory
cd ..



# Final summary
echo "🎯 BATCH PROCESSING COMPLETE!"

echo ""
