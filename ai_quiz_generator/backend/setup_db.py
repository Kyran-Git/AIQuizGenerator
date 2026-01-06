import pymssql
import os



DB_CONFIG = {
    'server': 'localhost',
    'user': 'sa',
    'password': os.getenv('DB_PASSWORD', 'YourStrongPasswordHere'),
    'database': 'master' # Start with master to create the new DB
}

def setup():
    try:
        # 1. Connect to SQL Server
        conn = pymssql.connect(**DB_CONFIG)
        conn.autocommit(True)
        cursor = conn.cursor()

        # 2. Create the Database
        print("Creating Database: AiQuizGenerator...")
        cursor.execute("IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'AiQuizGenerator') CREATE DATABASE AiQuizGenerator")
        conn.close()

        # 3. Connect to the new Database to create tables
        DB_CONFIG['database'] = 'AiQuizGenerator'
        conn = pymssql.connect(**DB_CONFIG)
        conn.autocommit(True)
        cursor = conn.cursor()

        # 4. Create Tables based on SDD Class Diagrams
        print("Creating Tables (Users, Quizzes, Questions)...")
        
        # Table for User Class
        cursor.execute("""
            IF OBJECT_ID('Users', 'U') IS NULL
            CREATE TABLE Users (
                userId NVARCHAR(50) PRIMARY KEY,
                username NVARCHAR(50) NOT NULL,
                password NVARCHAR(50) NOT NULL
            )
        """)

        # Table for Quiz Class (cite: image_95ae13.png)
        cursor.execute("""
            IF OBJECT_ID('Quizzes', 'U') IS NULL
            CREATE TABLE Quizzes (
                id NVARCHAR(50) PRIMARY KEY,
                userId NVARCHAR(50) FOREIGN KEY REFERENCES Users(userId),
                title NVARCHAR(255),
                timestamp DATETIME DEFAULT GETDATE()
            )
        """)

        # Table for Question Class (cite: image_95add3.png)
        cursor.execute("""
            IF OBJECT_ID('Questions', 'U') IS NULL
            CREATE TABLE Questions (
                id NVARCHAR(50) PRIMARY KEY,
                quizId NVARCHAR(50) FOREIGN KEY REFERENCES Quizzes(id),
                questionText NVARCHAR(MAX),
                correctAnswer NVARCHAR(255),
                optionsJson NVARCHAR(MAX),
                difficulty NVARCHAR(50),
                explanation NVARCHAR(MAX)
            )
        """)

        print("✅ Database and Tables created successfully!")
        conn.close()

    except Exception as e:
        print(f"❌ Setup failed: {e}")

if __name__ == "__main__":
    setup()