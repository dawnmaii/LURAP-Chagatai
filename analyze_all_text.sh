#!/bin/bash

echo "🚀 Starting batch processing of all .txt files from transcriptions/ folder..."
echo "============================================================"

if [ ! -d "transcriptions" ]; then
    echo "❌ transcriptions/ folder not found!"
    echo "💡 Please create a transcriptions/ folder and place your .txt files there"
    exit 1
fi

if [ ! -d "transcription_tables" ]; then
    echo "📁 Creating transcription_tables directory..."
    mkdir -p transcription_tables
fi

if [ ! -d "morphological_analysis" ]; then
    echo "📁 Creating morphological_analysis directory..."
    mkdir -p morphological_analysis
fi

txt_files=()
while IFS= read -r -d '' file; do
    txt_files+=("$file")
done < <(find transcriptions -name "*.txt" -print0 2>/dev/null)

if [ ${#txt_files[@]} -eq 0 ]; then
    echo "❌ No .txt files found in transcriptions/ folder"
    echo "💡 Please place your .txt transcription files in the transcriptions/ folder"
    exit 1
fi

echo ""
echo "📊 STEP 1: Converting .txt files to CSV format..."
echo ""

txt_count=0
for txt_file in transcriptions/*.txt; do
    if python3 create_list.py "$txt_file"; then
        ((txt_count++))
        echo "🎯 Selected file: $txt_file"
        echo "✅ Successfully converted: $txt_file"
        echo "---"
    else
        echo "❌ Failed to convert: $(basename "$txt_file")"
    fi
done

echo ""
echo "🔍 STEP 2: Running morphological analysis on CSV files..."
echo ""

if [ -z "$(ls -A transcription_tables/*.csv 2>/dev/null)" ]; then
    echo "❌ No CSV files found in transcription_tables directory"
    echo "💡 Step 1 must complete successfully before proceeding"
    exit 1
fi

cd transcription_tables || exit 1

csv_count=0
for csv_file in *.csv; do
    echo "🔍 Analyzing: $csv_file"
    echo ""
    if python3 ../morphological_analyzer.py "$csv_file"; then
        ((csv_count++))
        echo "---"
    else
        echo "❌ Failed to analyze: $csv_file"
    fi
done

cd ..

echo "🎯 BATCH PROCESSING COMPLETE!"
echo ""
