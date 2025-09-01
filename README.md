# LURAP-Chagatai: Chagatai Text Morphological Analysis

## What This Tool Does

When you run this tool on a Chagatai text, it will:

1. **Count words** in your text
2. **Identify line numbers** where each word appears
3. **Break down each word** into its root + grammatical endings
4. **Save results** in an easy-to-read spreadsheet format

For example, a word like `maḥkamesindegi` gets analyzed as:

- **Root**: `maḥkame` (meaning: court/office)
- **Endings**: `sin[3POSS] + de[LOC] + gi[ADJ]`
- **Translation**: "in his court" (literally: court-his-in-adjective)

## Getting Started (Step by Step)

### Step 1: Prepare Your Text File

1. **Download** your Chagatai transcription as a plain text file (`.txt` format)

2. **Place the file** in the `transcriptions` folder
   - If the folder doesn't exist, create it

3. **Create the folder** `transcription_tables` if you haven't already

4. **Create the folder** `morphological_analysis` if you haven't already

At the end, your folder structure should look like this:

```text
📁 Your Current Directory
├── 📁 transcriptions/
│   ├── 📄 transcription.txt
│   └── 📄 (other .txt files...)
├── 📁 transcription_tables/
│   ├── 📊 transcription_table.csv
│   └── 📊 (other .csv files...)
├── 📁 morphological_analysis/
│   ├── 📊 morphological_analysis.csv
│   └── 📊 (other analysis files...)
├── 📄 morphological_analyzer.py
├── 📄 create_list.py
└── 📄 README.md
```

**Folder Purposes:**

- **`transcriptions/`** - Contains your original Chagatai text files (`.txt` format)
- **`transcription_tables/`** - Contains word frequency tables (`.csv` format) created by `create_list.py`
- **`morphological_analysis/`** - Contains morphological analysis results (`.csv` format) created by `morphological_analyzer.py`

### Step 2: Choose Your Analysis Method

You have two options:

#### Option A: Analyze ALL Texts at Once

- **Use this when**: You have multiple Chagatai texts to analyze
- **What it does**: Processes every `.txt` file in your `transcriptions` folder
- **Command to type**:
  - **On Mac/Linux**: `bash analyze_all_text.sh`
  - **On Windows**: `analyze_all_text.bat`

#### Option B: Analyze ONE Specific Text

- **Use this when**: You want to analyze just one specific text
- **What it does**: Processes only the text file you specify
- **Command to type**:
  - **On Mac/Linux**: `bash analyze_file.sh text#`
  - **On Windows**: `analyze_file.bat text#`
  - **Note**: Replace `text#` with whatever part of your filename you want to match (usually the "text.." part in between the hyphen)

### Step 3: Run the Analysis

1. **Open your command line** (Terminal on Mac/Linux, Command Prompt on Windows)
2. **Navigate to this folder** by typing: `cd` followed by the path to this folder
   - **To find the current directory path**:
     - **On Mac/Linux**: Right-click the folder in Finder → `Get Info` → copy the path, or type `pwd` in Terminal
     - **On Windows**: Right-click the folder in File Explorer → `Properties` → copy the location, or type `cd` in Command Prompt
     - **Quick method**: Drag the folder into your terminal/command prompt - it will auto-fill the path
3. **Type the command** from Step 2 above
4. **Wait for completion** - you'll see progress messages with emojis

### Step 4: Find Your Results

After the analysis completes:

1. **Check the `morphological_analysis` folder** - this is where your results are saved
2. **Open these files** in Google Sheets or Excel for the best viewing experience

## Viewing Your Results in Google Sheets (Recommended)

The CSV files are much easier to read and analyze when opened in Google Sheets. Here's how to do it:

### Step-by-Step Google Sheets Upload

1. **Access the preferred spreadsheet in the LURAP folder**

2. **Upload Your CSV File**
   - **Method 1 (Drag & Drop)**:
     - Open the `morphological_analysis` folder on your computer
     - Drag the CSV file directly onto the Google Sheets tab

   - **Method 2 (File Menu)**:
     - In Google Sheets, click `File` → `Import`
     - Click `Upload` and select your CSV file
     - Choose `Replace current sheet` from the `Import Location` dropdown menu
     - Make sure the `Convert text to numbers, dates, and formulas` option is CHECKED
     - Leave the `Separator Type` alone
     - Click `Import data`

3. **Format Your Results**
   - **Freeze the header row**: Click on row 1, then `View` → `Freeze` → `1 row`
   - **Adjust column widths**: Double-click the line between column headers to auto-fit
   - **Add filters**: Click on row 1, then `Data` → `Create a filter`
   - **Sort alphabetically**: Click the dropdown arrow in the "word" column → `Sort A → Z`
   - **See all data**: Select all the columns with text at the top → `Resize columns...` → Select `Fit to data`

## Understanding Your Results

Each result file contains a table with these columns:

| Column | What It Shows | Example |
|--------|---------------|---------|
| **word** | The original word from your text | `maḥkamesindegi` |
| **root + affixes** | How the word breaks down | `maḥkame + sin[3POSS] + de[LOC] + gi[ADJ]` |
| **occurrences** | How many times this word appears | `1` |
| **lines** | Which line numbers contain this word | `[1]` |
| **notes** | How the analysis was performed | `Turkic morpheme pattern matching` |

## Extending the Morphological Analyzer

### Adding New Affixes

To add new affixes or grammatical patterns to `morphological_analyzer.py`:

1. **Open the file** in a text editor
2. **Locate the `affixes` dictionary** (around line 30-120)
3. **Add new affixes** to the appropriate category:

```python
# Example: Adding new case markers
'LOC': ['d[a]', 'da', 'dä', 'nda', 'ta', 'ṭa', 'te', 'your_new_affix'],
'DAT': ['a', 'ä', 'ar', 'ga', 'gä', 'ġa', 'kä', 'na', 'qa', 'yä', 'nä', 'your_new_affix'],
```

### Adding New Affix Categories

To create entirely new grammatical categories:

```python
# Add new category to the affixes dictionary
'NEW_CATEGORY': ['affix1', 'affix2', 'affix3'],
```

### Adding New Pattern Combinations

To add new suffix combination patterns:

1. **Find the `suffix_combinations` list** (around line 350)
2. **Add new patterns** following the existing format:

```python
# Example: Adding new verb + person patterns
('a', 'CV'), ('your_new_affix', 'NEW_CATEGORY'),
('your_root_pattern', 'ROOT_TYPE'), ('your_affix', 'AFFIX_TYPE'),
```

### Adding New Loanword Patterns

To identify additional loanword types:

1. **Locate the `loanword_patterns` dictionary** (around line 130)
2. **Add new patterns** for specific languages or scripts:

```python
# Example: Adding Ottoman Turkish patterns
'ottoman': [r'[ḫ]', r'[ġ]', r'[ṣ]'],
```

### Testing Your Changes

After modifying the analyzer:

1. **Save the file**
2. **Run a test analysis** on a small sample of text
3. **Check the output** to ensure new patterns are being recognized
4. **Verify the analysis quality** by reviewing the results

### Best Practices for Adding Affixes

- **Use consistent naming** for categories (e.g., `3POSS` for 3rd person possessive)
- **Include variations** of the same affix (e.g., `['da', 'dä', 'ta', 'tä']`)
- **Add comments** explaining unusual or complex patterns
- **Test incrementally** - add a few affixes at a time rather than many at once
- **Document your additions** in comments for future reference

### Common Affix Categories to Extend

- **Case markers**: LOC (locative), DAT (dative), ABL (ablative), GEN (genitive)
- **Person/number markers**: 1SG, 2SG, 3SG, 1PL, 2PL, 3PL
- **Possessive markers**: POSS.1SG, POSS.2SG, POSS.3SG, etc.
- **Verb inflections**: PST (past), FUT (future), IMP (imperative), COND (conditional)
- **Derivational suffixes**: ADJ (adjective), NM (nominalizer), VB (verbalizer)

## Troubleshooting

### Common Issues and Solutions

### "transcriptions folder not found"

- **Solution**: Create a folder named `transcriptions` in the same location as your scripts

### "morphological_analysis folder not found"

- **Solution**: Create a folder named `morphological_analysis` in the same location as your scripts

### "No .txt files found"

- **Solution**: Make sure your text file has a `.txt` extension and is inside the `transcriptions` folder

### "Failed to convert" or "Failed to analyze"

- **Solution**: Check that your text file is properly formatted and readable

### "Results look confusing"

- **Solution**: Open the `.csv` file in Google Sheets or Excel for better formatting

### "CSV file won't upload to Google Sheets"

- **Solution**: Make sure the file has a `.csv` extension and isn't corrupted. Try the drag-and-drop method first.

## Getting Help

If you encounter issues:

1. **Check the error messages** - they usually tell you what's wrong
2. **Verify your file names** - make sure they end in `.txt`
3. **Check folder structure** - ensure you have `transcriptions` and `morphological_analysis` folders
4. **Try the single file option first** - it's simpler and helps identify issues
5. **Use Google Sheets** - it's much easier to work with than raw CSV files

**Still having problems?** Open an issue on the GitHub repository with:

- A description of what you're trying to do
- The exact error message you're seeing
- Your operating system (Mac/Linux/Windows)
- Any relevant file names or folder structures

## Citations, Credits

Most of the letter inventory is sourced from current (unpublished) research in LURAP with Prof. Mawkanuli, as well as the following textbooks on the subject matter:

1. Bodrogligeti, András J. E. A Grammar of Chagatay. LINCOM EUROPA, 2001, [altaica.ru/LIBRARY/Bodrogligeti-2001-Chagatay.pdf](https://altaica.ru/LIBRARY/Bodrogligeti-2001-Chagatay.pdf).

2. Schluessel, Eric. An Introduction to Chaghatay. Michigan Publishing, 2018, [quod.lib.umich.edu/m/maize/images/mpub10110094.pdf](https://quod.lib.umich.edu/m/maize/images/mpub10110094.pdf).
