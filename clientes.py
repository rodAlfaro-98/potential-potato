import csv
import random

f = open('Clientes.csv','w')
lista_nombres = ['Maria','Rosa','Jose','Carmen','Ana','Juana','Angela','Margarita','Francisco','Elvira','Josefa','Pedro','Miguel','Emilia','Vicente','Alberto','Dora','Delia','Magda']
lista_app = ['Álvarez','Borges','Cedeño','Diaz','Enriquez','Flores','Gabiria','Hidalgo','Iglesias','Jiménez','King','López','Mora','Nuñez','Ortiz','Palencia','Quintero','Ruiz','Suarez','Torres','Urbina','Vasquez','Wester','Ximenez','Yeste','Zapata']
lista_apm = ['Álvarez','Borges','Cedeño','Diaz','Enriquez','Flores','Gabiria','Hidalgo','Iglesias','Jiménez','King','López','Mora','Nuñez','Ortiz','Palencia','Quintero','Ruiz','Suarez','Torres','Urbina','Vasquez','Wester','Ximenez','Yeste','Zapata']
ocupacion = ['programador','heroe profesional','cazador de demonios','carnicero','biologo marino','alquimista estatal','ninja','heroe clase S']
password = 1234
contador_usuarios = 0
f = open('Clientes.csv','w')
for i in range(0,100):
    val_nombre = random.randint(0,len(lista_nombres)-1)
    val_paterno = random.randint(0,len(lista_app)-1)
    val_materno = random.randint(0,len(lista_apm)-1)
    val_ocupacion = random.randint(0,len(ocupacion)-1)
    direccion = 'Calle ' + str(i) + ', Colonia Industrial ' + str(i) + ', CDMX'
    username = lista_nombres[val_nombre]+'_'+str(i)
    passwd = password + i
    cadena = str(i+1)+'#'+Slista_nombres[val_nombre]+'#'+lista_app[val_paterno]+'#'+lista_apm[val_materno]+'#'+direccion+'#'+ocupacion[val_ocupacion]+'#'+username+'#'+str(passwd)+'\n'
    f.write(cadena)
f.close()