
bob = ['Bob Smith', 42, 30000, 'software']
sue = ['Sue Jones', 45, 40000, 'hardware']



print(bob[0], sue[2] )


# bob[0].split()[-1] # what's bob's last name?

# sue[2] *= 1.25 # give sue a 25% raise

calc = sue[2] * 1.25
'Bob Smith'
print(bob[0].split()[-1] )
print(sue[2] * 1.25 )
print(calc )


people = [bob, sue] # reference in list of lists

for person in people:
    print(person)


# people[1][0]
for person in people:
    print(person[0].split()[1]) # print last names
    print(person[2] * 1.20 )# give each a 20% raise




for person in people:
    print(person[1]) # print last names
 
  
pays = [person[1] for person in people] # collect all pay
print(pays)


# bob = ['Bob Smith', 42, 30000, 'software']
# sue = ['Sue Jones', 45, 40000, 'hardware']  


pays = [person[2] for person in people] # collect all pay
print(pays)

pays = [map((lambda x: x[2]), people)]
print(pays)

print (person[2] for person in people) # generator expression, sum built-in

print(people)
people.append(['Tom', 50, 0, None])
print(len(people))
print(people)
print(people[-1][1])
