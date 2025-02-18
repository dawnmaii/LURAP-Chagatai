import csv

# accesses the .txt file in current directory
with open('QAZ19th-text05-transcription.txt', encoding='utf-8-sig') as txt_file:
   output = txt_file.read()   

# converts .txt file input into a list
list = output.split()

# keeps track of the line we are on in the text
current_line = None

# {word : number of occurrences, [lines of occurrence]}
dictionary = {}

# function to remove most punctuation from the word
def remove_punctuation(word):
   cleaned_word = word
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
   # converts the letter to lowercase
   return cleaned_word.lower()

# function to remove numbers from a word if hypenated with an actual word
def remove_numbers(word):
   cleaned_word = word
   for char in cleaned_word:
      if char.isdigit():
         cleaned_word = cleaned_word.replace(char, "")
   return cleaned_word
   
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

# prints out the dictionary at the end to the console
for key, value in dictionary.items():
   print(key, value)

# output dictionary as .csv
   # create .csv file
   # loop
      # for each word in dictionary
      # print word, word object.number of times, word object.lines.as string, .txt file name