# For debugging purposes only: resets the database
import pymssql
import os

# 1. Configuration
SERVER = 'localhost'
USER = 'sa'
PASSWORD = os.getenv('DB_PASSWORD', 'StrongP@ssw0rd2025!')

def reset_database():
    try:
        # Connect to 'master' so we can delete the other DB
        conn = pymssql.connect(server=SERVER, user=USER, password=PASSWORD, database='master', autocommit=True)
        cursor = conn.cursor()

        print("⚠️  WARNING: Deleting database 'AiQuizGenerator'...")
        
        # Force delete the database (closes existing connections first)
        cursor.execute("""
            IF EXISTS (SELECT * FROM sys.databases WHERE name = 'AiQuizGenerator')
            BEGIN
                ALTER DATABASE AiQuizGenerator SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
                DROP DATABASE AiQuizGenerator;
            END
        """)
        print("🗑️  Database Deleted.")

        # Recreate it
        cursor.execute("CREATE DATABASE AiQuizGenerator")
        print("✨ New Database Created.")
        
        conn.close()

        # Connect to the NEW DB to create tables
        conn = pymssql.connect(server=SERVER, user=USER, password=PASSWORD, database='AiQuizGenerator', autocommit=True)
        cursor = conn.cursor()

        print("🔨 Creating Users Table...")
        cursor.execute("""
            CREATE TABLE Users (
                userId NVARCHAR(50) PRIMARY KEY,
                username NVARCHAR(50) NOT NULL UNIQUE, 
                password NVARCHAR(50) NOT NULL
            )
        """)
        # (Add Quizzes/Questions tables here if needed later)

        print("✅ Factory Reset Complete! Database is fresh.")
        conn.close()

    except Exception as e:
        print(f"❌ Error: {e}")

if __name__ == "__main__":
    reset_database()