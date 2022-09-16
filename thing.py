file = open("words.txt")

for word in file.readlines():
    word = word.strip()
    word ="\"{}\",".format(word)
    print(word)
    
