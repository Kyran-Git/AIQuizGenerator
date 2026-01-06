import pymssql

conn = pymssql.connect(
    server='localhost', user='sa',
    password='StrongP@ssw0rd2025!', database='AiQuizGenerator'
)
cursor = conn.cursor()


cursor.execute("SELECT * FROM Users")
for row in cursor.fetchall():
    print(row)

print("Columns in Users table:")
for col in columns:
    print(f"- {col[0]}")
conn.close()