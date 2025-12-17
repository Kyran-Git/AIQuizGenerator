from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import pymssql
import os
from typing import List, Optional

app = FastAPI(title="AI Quiz Generator API")

# --- Security: Read password from Environment Variable ---
# If DB_PASSWORD is not set in your terminal, it defaults to the fallback (for local testing)
# CAUTION: For public repos, rely on the export command, don't hardcode the real password here.
db_password = os.getenv('DB_PASSWORD', 'YourStrongPasswordHere')

DB_CONFIG = {
    "server": "localhost",
    "user": "sa",
    "password": db_password,
    "database": "AiQuizGenerator"
}

# --- Data Models (Matching your Flutter & SDD) ---
class UserLogin(BaseModel):
    username: str
    password: str

class QuestionModel(BaseModel):
    id: str
    questionText: str
    correctAnswer: str
    options: List[str]
    difficulty: str
    explanation: Optional[str] = None

class QuizModel(BaseModel):
    id: str
    userId: str  # Matches the new Flutter model
    title: str
    questions: List[QuestionModel]
    settings: dict # Receives the settings as a JSON object

# --- Database Helper ---
def get_db_connection():
    try:
        conn = pymssql.connect(**DB_CONFIG)
        return conn
    except Exception as e:
        print(f"Database connection error: {e}")
        raise HTTPException(status_code=500, detail="Could not connect to database")

# --- API Endpoints ---

@app.post("/auth/login")
def login(user: UserLogin):
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)
    
    cursor.execute("SELECT userId, username FROM Users WHERE username=%s AND password=%s", (user.username, user.password))
    result = cursor.fetchone()
    conn.close()
    
    if result:
        # 2. Update JSON format to match RemoteAuthService expectation
        return {
            "success": True,         # Matches response['success'] == true
            "userId": result['userId'], # Matches response['userId']
            "username": result['username']
        }
    
    # Return success: False instead of 401, so Dart can handle the logic
    return {"success": False, "message": "Invalid credentials"}

@app.post("/auth/signup")
def signup(user: UserLogin):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        # Check if user exists
        cursor.execute("SELECT userId FROM Users WHERE username=%s", (user.username,))
        if cursor.fetchone():
            return {"success": False, "message": "Username taken"}

        # Generate ID (Simplified)
        import uuid
        user_id = str(uuid.uuid4())
        
        cursor.execute(
            "INSERT INTO Users (userId, username, password) VALUES (%s, %s, %s)",
            (user_id, user.username, user.password)
        )
        conn.commit()
        return {"success": True, "userId": user_id}
    except Exception as e:
        conn.rollback()
        return {"success": False, "message": str(e)}
    finally:
        conn.close()

@app.post("/quizzes/save")
def save_quiz(quiz: QuizModel):
    conn = get_db_connection()
    cursor = conn.cursor()
    import json
    
    try:
        # 1. Save Quiz Metadata (including the new settingsJson)
        cursor.execute(
            "INSERT INTO Quizzes (id, title, userId, settingsJson) VALUES (%s, %s, %s, %s)",
            (quiz.id, quiz.title, quiz.userId, json.dumps(quiz.settings))
        )
        
        # 2. Save Questions
        for q in quiz.questions:
            cursor.execute(
                """INSERT INTO Questions 
                   (id, quizId, questionText, correctAnswer, optionsJson, difficulty, explanation) 
                   VALUES (%s, %s, %s, %s, %s, %s, %s)""",
                (q.id, quiz.id, q.questionText, q.correctAnswer, json.dumps(q.options), q.difficulty, q.explanation)
            )
        
        conn.commit()
        return {"status": "success", "message": "Quiz saved successfully"}
    except Exception as e:
        conn.rollback()
        print(f"Error saving quiz: {e}")
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        conn.close()