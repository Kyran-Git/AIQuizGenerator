import pymssql
import os

# CONFIGURATION
DB_CONFIG = {
    'server': 'localhost',
    'user': 'sa',
    'password': os.getenv('DB_PASSWORD', 'YourStrongPasswordHere'),
    'database': 'AiQuizGenerator' # Connect directly to the DB
}

def reset_database():
    conn = None
    try:
        print("🔴 CONNECTING TO DATABASE...")
        conn = pymssql.connect(**DB_CONFIG)
        conn.autocommit(True)
        cursor = conn.cursor()

        print("💥 DROPPING EXISTING TABLES...")
        # Order matters! Drop children (Questions) before parents (Quizzes, Users)
        cursor.execute("IF OBJECT_ID('Questions', 'U') IS NOT NULL DROP TABLE Questions")
        cursor.execute("IF OBJECT_ID('Quizzes', 'U') IS NOT NULL DROP TABLE Quizzes")
        cursor.execute("IF OBJECT_ID('Users', 'U') IS NOT NULL DROP TABLE Users")

        print("✨ CREATING NEW TABLES...")

        # 1. USERS TABLE
        cursor.execute("""
            CREATE TABLE Users (
                userId NVARCHAR(50) PRIMARY KEY,
                username NVARCHAR(50) NOT NULL UNIQUE,
                password NVARCHAR(50) NOT NULL
            )
        """)

        # 2. QUIZZES TABLE (Updated with ALL new columns)
        cursor.execute("""
            CREATE TABLE Quizzes (
                id NVARCHAR(50) PRIMARY KEY,
                userId NVARCHAR(50) NOT NULL,
                title NVARCHAR(255),
                settingsJson NVARCHAR(MAX),   -- New Column
                createdAt DATETIME DEFAULT GETDATE(), -- New Column
                FOREIGN KEY (userId) REFERENCES Users(userId)
            )
        """)

        # 3. QUESTIONS TABLE
        cursor.execute("""
            CREATE TABLE Questions (
                id NVARCHAR(50) PRIMARY KEY,
                quizId NVARCHAR(50) NOT NULL,
                questionText NVARCHAR(MAX),
                correctAnswer NVARCHAR(255),
                optionsJson NVARCHAR(MAX),
                difficulty NVARCHAR(50),
                explanation NVARCHAR(MAX),
                FOREIGN KEY (quizId) REFERENCES Quizzes(id) ON DELETE CASCADE
            )
        """)

        print("✅ DATABASE RESET COMPLETE! All tables are fresh.")

    except Exception as e:
        print(f"❌ ERROR: {e}")
    finally:
        if conn: conn.close()

if __name__ == "__main__":
    confirm = input("⚠️  WARNING: This will DELETE ALL DATA. Type 'yes' to continue: ")
    if confirm.lower() == 'yes':
        reset_database()
    else:
        print("Operation cancelled.")