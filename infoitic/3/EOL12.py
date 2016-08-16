
def justificar_a_la_dreta(a,b):
    return " "*(b-len(a))

x=raw_input("escriu la paraula: ")
z=input("el numero d'espais: ")
print justificar_a_la_dreta(x,z)+x
