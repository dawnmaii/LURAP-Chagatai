#!/bin/bash

if [ ! -d "transcriptions" ]; then
    echo "❌ transcriptions/ folder not found!"
    echo "💡 Please create a transcriptions/ folder and place your .txt files there"
    exit 1
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

if [ ! -d "transcription_tables" ]; then
    echo "📁 Creating transcription_tables directory..."
    mkdir -p transcription_tables
fi

if [ ! -d "morphological_analysis" ]; then
    echo "📁 Creating morphological_analysis directory..."
    mkdir -p morphological_analysis
fi

if [ $# -eq 0 ]; then
    echo "💡 USAGE: bash analyze_file.sh <filename_part>"
    echo "💡 EXAMPLE: bash analyze_file.sh text24"
    exit 1
fi

filename_part="$1"
selected_file=""
selected_filename=""
for file in "${txt_files[@]}"; do
    filename=$(basename "$file")
    if [[ "$filename" == *"$filename_part"* ]]; then
        selected_file="$file"
        selected_filename="$filename"
        break
    fi
done

if [ -z "$selected_file" ]; then
    echo "❌ No file found matching '$filename_part'"
    exit 1
fi

echo ""
echo "🎯 Selected file: $selected_filename"
echo "--------------------------------------------------"

if python3 create_list.py "$selected_file"; then
    echo "✅ Successfully converted: $selected_filename"
else
    echo "❌ Failed to convert: $selected_filename"
    exit 1
fi

echo ""

base_name="${selected_filename%.txt}"
csv_file="transcription_tables/${base_name}-table.csv"

if [ ! -f "$csv_file" ]; then
    echo "❌ Expected CSV file not found: $csv_file"
    echo "💡 Check if create_list.py generated the file correctly"
    exit 1
fi

cd transcription_tables || exit 1

if python3 ../morphological_analyzer.py "$(basename "$csv_file")"; then
    echo ""
    echo "🔍 Successfully analyzed: $(basename "$csv_file")"
    cd ..
else
    echo "❌ Failed to analyze: $(basename "$csv_file")"
    cd .. 
    exit 1
fi
