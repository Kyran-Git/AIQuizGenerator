import pymssql
import os

DB_CONFIG = {
    'server': 'localhost',
    'user': 'sa',
    'password': os.getenv('DB_PASSWORD', 'YourStrongPasswordHere'),
    'database': 'AiQuizGenerator'
}

try:
    conn = pymssql.connect(**DB_CONFIG)
    conn.autocommit(True)
    cursor = conn.cursor()

    print("Updating Quizzes table schema...")
    
    # Add settingsJson column if it doesn't exist
    cursor.execute("""
        IF COL_LENGTH('Quizzes', 'settingsJson') IS NULL
        BEGIN
            ALTER TABLE Quizzes ADD settingsJson NVARCHAR(MAX);
            PRINT 'Column settingsJson added successfully.';
        END
        ELSE
            PRINT 'Column settingsJson already exists.';
    """)
    
    conn.close()
    print("✅ Database schema updated to match Flutter Quiz model.")
except Exception as e:
    print(f"❌ Update failed: {e}")