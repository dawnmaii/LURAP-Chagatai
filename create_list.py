import sys
import os

# Get input file from command line argument (required)
if len(sys.argv) > 1:
    input_file = sys.argv[1]
else:
    print("❌ ERROR: No input file specified!")
    print("💡 USAGE: python3 create_list.py filename.txt")
    print("💡 EXAMPLE: python3 create_list.py QAZ19th-text05-transcription.txt")
    sys.exit(1)

# accesses the .txt file in current directory
with open(input_file, encoding="utf-8-sig") as txt_file:
   output = txt_file.read()

# converts .txt file input into a list
list = output.split()

# keeps track of the line we are on in the text
current_line = 1  # Start with line 1 instead of None

# {word : number of occurrences, [lines of occurrence]}
dictionary = {}

# function to remove most punctuation from the word
def remove_punctuation(word):
   cleaned_word = word
   try:
      # removes ASCII quotation marks
      if "\u201C" in word:
         remove_left_quote = cleaned_word.replace("\u201C", "")
         cleaned_word = remove_left_quote
      if "\u201D" in word:
         remove_right_quote = cleaned_word.replace("\u201D", "")
         cleaned_word = remove_right_quote

      # removes periods
      if "." in word:
         remove_period = cleaned_word.replace(".", "")
         cleaned_word = remove_period

      # removes commas
      if "," in word:
         remove_comma = cleaned_word.replace(",", "")
         cleaned_word = remove_comma

      # removes colons
      if ":" in word:
         remove_colon = cleaned_word.replace(":", "")
         cleaned_word = remove_colon

      # removes semicolons
      if ";" in word:
         remove_semicolon = cleaned_word.replace(";", "")
         cleaned_word = remove_semicolon

      # removes question mark
      if "?" in word:
         remove_question = cleaned_word.replace("?", "")
         cleaned_word = remove_question

      # converts the letter to lowercase
      return cleaned_word.lower()
   
   except Exception as e:
      print(f"Unable to remove punctuation: {e}")

# function to remove numbers from a word if hypenated with an actual word
def remove_numbers(word):
   cleaned_word = word
   for char in cleaned_word:
      if char.isdigit():
         cleaned_word = cleaned_word.replace(char, "")
   return cleaned_word
   
# traverses through list received from .txt file   
for word in list:
   # skips the "word" if it's a line number marker
   if "(" and ")" in word:
      remove_left_bracket = word.replace("(", "")
      removed_brackets = remove_left_bracket.replace(")", "")
      current_line = removed_brackets
      continue

   # skips the word if it is a number (not hyphenated) or ellipses
   if word.isdigit() or word == "…" or word == "..." or word == "\u2026":
      continue

   # if the word starts with a number, remove said number
   word = remove_numbers(word)

   # removes punctuation before processing
   word = remove_punctuation(word)

   # checks the dictionary to see if the word already exists
   if word in dictionary.keys():
      # if it does, increase the word count and add the line where it occurs next
      dictionary.get(word)[0] += 1
      if current_line not in dictionary.get(word)[1]:
         dictionary.get(word)[1].append(int(current_line))
      # otherwise, add it to the dictionary as a new word occuring once on the current line
   else:
      dictionary.update({word : [int(1), [int(current_line)]]})

# writes the dictionary to a csv file, every word has its own line
# Remove .txt extension and path before adding -table.csv
base_name = os.path.basename(input_file).replace('.txt', '')
output_file = "transcription_tables/" + base_name + "-table.csv"
try:
   with open(output_file, "w", newline="") as file:
      # writing the header manually
      file.write("word,number of occurrences,lines\n")  
      for word in dictionary:
         # Use simple commas to separate line numbers, enclosed in quotes
         line_numbers = [str(line_num) for line_num in dictionary[word][1]]
         comma_line_numbers = ', '.join(line_numbers)
         line = f"{word},{dictionary[word][0]},\"[{comma_line_numbers}]\"\n"
         # line will be written as 
            # {word, number of occurrences, [line numbers]} 
            # with comma-separated line numbers
         file.write(line)
except Exception as e:
        print(f"Unable to output table: {e}")


"""   TABLE OUTPUT

word (transliteration), morphemic breakdown, morphemic order, translation, number of occurrences, text #, lines

alphabetize them at the end 


"""