# Group Assignment - Data Driven Security

Group Assignment base repository for the Data Driven Security subject of the [CyberSecurity Management Msc](https://www.talent.upc.edu/ing/professionals/presentacio/codi/221101/cybersecurity-management/).

## Project Title

Brief description of the project.

### Requirements

  - Requirement 1
  - Requirement 2
  
  
### Project Description

Description of the project. 

### Goals

### Data acquisition

### Cleansing and transformations

### Data analysis

### Results / Conclusions.


### TO SAVE

[code]
word=input("digita el dominio: ")
letters = 'abcdefghijklmnopqrstuvwxyz01'
splits = [(word[:i], word[i:])    for i in range(len(word) + 1)]
deletes = [L + R[1:]               for L, R in splits if R]
transposes = [L + R[1] + R[0] + R[2:] for L, R in splits if len(R)>1]
replaces = [L + c + R[1:]           for L, R in splits if R for c in letters]
inserts = [L + c + R               for L, R in splits for c in letters]
a = set(deletes + transposes + replaces + inserts)
for e in a :
	print(e + ' , ')

[/code]
