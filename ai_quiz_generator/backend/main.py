from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import pymssql
import os
import json
import re
from typing import List, Optional

app = FastAPI(title="AI Quiz Generator API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins (for development)
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods (POST, GET, OPTIONS, etc.)
    allow_headers=["*"],  # Allows all headers
)

db_password = os.getenv('DB_PASSWORD', 'StrongP@ssw0rd2025!')

DB_CONFIG = {
    "server": "localhost",
    "user": "sa",
    "password": db_password,
    "database": "AiQuizGenerator"
}

# Data Models
class UserLogin(BaseModel):
    username: str
    password: str

class QuestionModel(BaseModel):
    id: str
    questionText: str
    correctAnswer: str
    options: List[str]
    difficulty: str
    explanation: Optional[str] = ""

class QuizSettingsModel(BaseModel):
    sourceText: str
    numOfQuestions: int
    difficulty: str
    type: str

class QuizModel(BaseModel):
    id: str
    userId: str  # Matches the new Flutter model
    title: str
    questions: List[QuestionModel]
    settings: QuizSettingsModel # Receives the settings as a JSON object

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
    # --- Password Complexity Check ---
    # Regex Explanation:
    # (?=.*?[A-Z])       : At least one Uppercase
    # (?=.*?[a-z])       : At least one Lowercase
    # (?=.*?[0-9])       : At least one Digit
    # (?=.*?[!@#\$&*~]) : At least one Special Character
    # .{8,}             : Minimum 8 characters total
    password_pattern = r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$"
    
    if not re.match(password_pattern, user.password):
        # Return success: False so the Flutter app knows to show the error message
        return {
            "success": False, 
            "message": "Password weak: Needs 8+ chars, Upper, Lower, Digit & Symbol."
        }
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        # Check if user exists
        cursor.execute("SELECT userId FROM Users WHERE username=%s", (user.username,))
        if cursor.fetchone():
            return {"success": False, "message": "Username taken"}

        # Generate ID
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
    
    try:
        # 1. Save Quiz Metadata (including the new settingsJson)
        cursor.execute(
            "INSERT INTO Quizzes "
            "(id, title, userId, createdAt, settingsJson) " \
            "VALUES (%s, %s, %s, GETDATE(), %s)",
            (quiz.id, quiz.title, quiz.userId, json.dumps(quiz.settings.dict()))
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

@app.get("/quizzes/list/{user_id}")
def get_quizzes(user_id: str):
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)
    
    try:
        # 1. Get all Quizzes for this User
        cursor.execute("SELECT * FROM Quizzes WHERE userId=%s ORDER BY createdAt DESC", (user_id,))
        quizzes_rows = cursor.fetchall()
        
        results = []
        
        for quiz_row in quizzes_rows:
            # 2. Get Questions for THIS specific quiz
            cursor.execute("SELECT * FROM Questions WHERE quizId=%s", (quiz_row['id'],))
            questions_rows = cursor.fetchall()
            
            # 3. Process Questions (Convert JSON string back to List)
            parsed_questions = []
            for q in questions_rows:
                parsed_questions.append({
                    "id": q['id'],
                    "questionText": q['questionText'],
                    "correctAnswer": q['correctAnswer'],
                    "options": json.loads(q['optionsJson']), 
                    "difficulty": q['difficulty'],
                    "explanation": q['explanation'] or ""
                })

            # 4. Process Settings (Convert JSON string back to Dict)
            settings_dict = {}
            if quiz_row['settingsJson']:
                settings_dict = json.loads(quiz_row['settingsJson'])

            # 5. Assemble the final Quiz Object
            results.append({
                "id": quiz_row['id'],
                "userId": quiz_row['userId'],
                "title": quiz_row['title'],
                "questions": parsed_questions,
                "settings": settings_dict
            })

        return results

    except Exception as e:
        print(f"Error fetching quizzes: {e}")
        raise HTTPException(status_code=500, detail=str(e))
    
    finally:
        conn.close()