# access .txt file to parse
with open('QAZ19th-text05-transcription.txt', encoding='utf-8-sig') as txt_file:
   output = txt_file.read()   

# .txt file shows everything as a one-line string so we can split the string
list = output.split()

current_line = None
# create dictionary to keep words in
   # word object : [number of times occurred, line numbers occurred in]
dictionary = {}

# parsing everything in list, which includes line numbers
for word in list:
   if "(" and ")" in word:
      remove_left_bracket = word.replace("(", "")
      removed_brackets = remove_left_bracket.replace(")", "")
      current_line = removed_brackets
      continue

   # filter out numbers
   # figure out capitalized vs. uncapitalized of the same words
   
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