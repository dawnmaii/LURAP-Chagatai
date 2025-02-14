# takes a .txt file as input, outputs .csv file

# access .txt file to parse

# split the input so every 'word' is by itself

# create word object
   # word
   # number of times occurred
   # lines (as arraylist)
   # need to string method somewhere to easy access
   # setter methods?

# create dictionary to keep words in
   # word object : text it occurred in

# method to traverse dictionary to find the word

# loop
   # if we haven't seen it before, create a new word object w/ line number
      # get text name
      # add word : text name to dictionary
   # if we've seen it 
      # increment count by 1
      # get line number, append to arraylist

# output dictionary as .csv
   # create .csv file
   # loop
      # for each word in dictionary
      # print word, word object.number of times, word object.lines.as string, .txt file name