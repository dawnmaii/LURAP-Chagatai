# access .txt file to parse
with open('QAZ19th-text05-transcription.txt') as txt_file:
   output = txt_file.read()   

# .txt file shows everything as a one-line string so we can split the string
list = output.split()

current_line = None
# create dictionary to keep words in
   # word object : [number of times occurred, line numbers occurred in]
dictionary = {}

# create word object
class Word:
   """Represents in individual word in the text file."""

   def __init__(self, word):
      """Creates the word upon parsing input."""
      self.word = word
      self.num_occur = 1
      self.line_occur = [current_line]

   def increase_count():
      num_occur += 1

# parsing everything in list, which includes line numbers
for word in list:
      # print("\nat " + word)
   if "(" and ")" in word:
      current_line = word
      #print (" current_line is " + current_line)

   if word == current_line:
      continue

   # this block doesn't work, currently troubleshooting
   if word in dictionary.keys():
      word.increase_count()
      print(word + " increased count!")
      if current_line not in dictionary.get(word[1]):
         word[1].append(current_line)
   
   
   else:
      new_word = Word(word)
      dictionary.update({new_word : [new_word.num_occur, new_word.line_occur]})
      print("added a new word: " + word)

# output dictionary as .csv
   # create .csv file
   # loop
      # for each word in dictionary
      # print word, word object.number of times, word object.lines.as string, .txt file name