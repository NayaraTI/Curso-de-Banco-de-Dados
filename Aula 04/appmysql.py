import pymysql

con = pymysql.connect(db='app', user='joao', passwd='@joao123')



cursor = con.cursor()

cursor.execute("INSERT INTO cadastro (nome, Sobrenome, Sexo) VALUES ('Juca', 'Pereira','M')")


con.commit()

cursor.execute("select * from cadastro")

for regs in cursor.fetchall():
    print(regs)

con.close()