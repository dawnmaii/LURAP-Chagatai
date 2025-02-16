with open('QAZ19th-text05-transcription.txt', encoding='utf-8-sig') as txt_file:
   output = txt_file.read()   

list = output.split()

current_line = None

dictionary = {}

# remove periods, ellipses, quotation marks, apostrophes, commas
# 2-nci on lines 11, 60 and 3-nci on lines 12, 63 and 4-nci are technically the same
def remove_punctuation(word):
   cleaned_word = word


   return cleaned_word.lower()

for word in list:

   if "(" and ")" in word:
      remove_left_bracket = word.replace("(", "")
      removed_brackets = remove_left_bracket.replace(")", "")
      current_line = removed_brackets
      continue
   
   if word.isdigit():
      continue

   word = remove_punctuation(word)
   
   if word in dictionary.keys():
      dictionary.get(word)[0] += 1
      if current_line not in dictionary.get(word)[1]:
         dictionary.get(word)[1].append(int(current_line))
   
   
   else:
      dictionary.update({word : [int(1), [int(current_line)]]})

for key, value in dictionary.items():
   print(key, value)

# output dictionary as .csv
   # create .csv file
   # loop
      # for each word in dictionary
      # print word, word object.number of times, word object.lines.as string, .txt file name