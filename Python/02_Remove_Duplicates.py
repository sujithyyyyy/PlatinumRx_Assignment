text = input("Enter a string: ")

result = "" # stores characters in the order they first appeared

#Logic:
#Iterate through each character in the input string.
#If the character is not already in the result string, append it.
#If the character is already in the result string, skip it.

for char in text:
    if char not in result:
        result += char

print(result) #Print the result string.




