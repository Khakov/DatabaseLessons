import psycopg2

def write_text(text, index):
	text = "".join(text.split())
	conn = psycopg2.connect( host='localhost', user='postgres', password='123456', dbname='db1')
	cursor = conn.cursor()
	l2 = list()
	l5 = list()
	l9 = list()
	text_len = len(text) + 1
	print("start")
	for i in range(2,len(text)+1):
		l2.append(text[(i-2):i])
		if (i>4):
			l5.append(text[(i-5):i])
		if i>8:
			l9.append(text[(i-9):i])
		if len(l2) == 1000 or i == text_len:
			dataText = ','.join(cursor.mogrify('(%s, %s, %s)', (index, 2, row)) for row in l2)
			cursor.execute('insert into genetic (document_id, kshingle, word) values ' + dataText)
			l2 = list()
		if len(l5) == 1000 or i == text_len:	
			dataText = ','.join(cursor.mogrify('(%s, %s, %s)', (index, 5, row)) for row in l5)
			cursor.execute('insert into genetic (document_id, kshingle, word) values ' + dataText)
			l5=list()
		if len(l9) == 1000 or i == text_len:
			dataText = ','.join(cursor.mogrify('(%s, %s, %s)', (index, 9, row)) for row in l9)
			cursor.execute('insert into genetic (document_id, kshingle, word) values ' + dataText)
			l9=list()
	print("insert")
	conn.commit()
	print("commit")
	conn.close()

f1 = open("Genome_1.txt", 'r+')
f2 = open("Genome_2.txt", 'r+')
text1 = f1.read()
text2 = f2.read()
write_text(text1, 1)
write_text(text2,2)

