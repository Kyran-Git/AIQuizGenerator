import pymssql
import os

# Configuration
SERVER = 'localhost'
USER = 'sa'
PASSWORD = os.getenv('DB_PASSWORD', 'YourPasswordHere') # Replace if not using env vars
DB_NAME = 'AiQuizGenerator'

def view_tables():
    try:
        conn = pymssql.connect(server=SERVER, user=USER, password=PASSWORD, database=DB_NAME)
        cursor = conn.cursor(as_dict=True)

        print("\n--- 👤 USERS TABLE ---")
        cursor.execute("SELECT * FROM Users")
        users = cursor.fetchall()
        if not users:
            print("(No users found)")
        for u in users:
            print(f"ID: {u['userId']} | User: {u['username']} | Pass: {u['password']}")

        print("\n--- 📝 QUIZZES TABLE ---")
        cursor.execute("SELECT * FROM Quizzes")
        quizzes = cursor.fetchall()
        if not quizzes:
            print("(No quizzes found)")
        for q in quizzes:
            print(f"ID: {q['id']} | Title: {q['title']}")

        print("\n--- ❓ QUESTIONS TABLE ---")
        cursor.execute("SELECT id, questionText, difficulty FROM Questions")
        questions = cursor.fetchall()
        if not questions:
            print("(No questions found)")
        for ques in questions:
            print(f"ID: {ques['id']} | Q: {ques['questionText']} | Difficulty: {ques['difficulty']}")

        conn.close()

    except Exception as e:
        print(f"❌ Error: {e}")

if __name__ == "__main__":
    view_tables()