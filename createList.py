# takes a .txt file as input, outputs .csv file

# access .txt file to parse

# split the input so every 'word' is by itself

# create word object
   # word
   # number of times occurred
   # lines (as arraylist)

# create dictionary to keep words in
   # word object : text it occurred in

# loop
   # if we haven't seen it before, create a new word object w/ line number
      # get text name
      # add word : text name to dictionary
   # if we've seen it 
      # increment count by 1
      # get line number, append

# output dictionary as .csv
   # print word, number of times occurred, lines occurred in