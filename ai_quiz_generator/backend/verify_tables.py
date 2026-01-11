import pymssql
import os

DB_CONFIG = {
    'server': 'localhost',
    'user': 'sa',
    'password': os.getenv('DB_PASSWORD', 'YourStrongPasswordHere'),
    'database': 'AiQuizGenerator'
}

def verify_empty():
    try:
        conn = pymssql.connect(**DB_CONFIG)
        cursor = conn.cursor()

        # Check counts
        tables = ['Users', 'Quizzes', 'Questions']
        print(f"{'TABLE':<15} | {'COUNT':<10}")
        print("-" * 30)
        
        for table in tables:
            cursor.execute(f"SELECT COUNT(*) FROM {table}")
            count = cursor.fetchone()[0]
            print(f"{table:<15} | {count:<10}")

        conn.close()
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    verify_empty()