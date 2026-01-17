# AI Quiz Generator - Project Documentation

## Table of Contents

1. [Backend Files](#backend-files)
2. [Frontend Controllers](#frontend-controllers)
3. [Frontend Services](#frontend-services)
4. [Frontend Models](#frontend-models)
5. [Frontend Screens](#frontend-screens)
6. [Method Categories](#method-categories)

---

## Backend Files

### 📄 `backend/main.py`

**Purpose**: FastAPI server for login, quizzes, and database work.

#### Methods:

##### 🔑 **Authentication Methods**

| Method                    | Line | Type             | Description                                    |
| ------------------------- | ---- | ---------------- | ---------------------------------------------- |
| `login(user: UserLogin)`  | 67   | 🔐 CRUD (Read)   | Checks username/password and returns user info |
| `signup(user: UserLogin)` | 87   | 🔐 CRUD (Create) | Creates a user after checking password rules   |

##### 📊 **Database Methods**

| Method                | Line | Type        | Description                   |
| --------------------- | ---- | ----------- | ----------------------------- |
| `get_db_connection()` | 56   | 🗄️ Database | Opens a SQL Server connection |

##### 📝 **Quiz Management Methods**

| Method                       | Line | Type             | Description                                |
| ---------------------------- | ---- | ---------------- | ------------------------------------------ |
| `save_quiz(quiz: QuizModel)` | 128  | 🔐 CRUD (Create) | Saves a quiz and its questions             |
| `get_quizzes(user_id: str)`  | 160  | 🔐 CRUD (Read)   | Gets all quizzes for a user with questions |

**Key Features**:

- CORS middleware for cross-origin requests
- SQL Server database integration
- Password complexity validation (8+ chars, uppercase, lowercase, digit, special character)
- JSON serialization for quiz settings and question options

---

### 📄 `backend/setup_db.py`

**Purpose**: Creates the database and tables.

#### Methods:

| Method    | Line | Type        | Description                                     |
| --------- | ---- | ----------- | ----------------------------------------------- |
| `setup()` | 13   | 🗄️ Database | Creates the AiQuizGenerator database and tables |

**Database Schema Created**:

- **Users**: userId (PK), username, password
- **Quizzes**: id (PK), userId (FK), title, settingsJson, createdAt
- **Questions**: id (PK), quizId (FK), questionText, correctAnswer, optionsJson, difficulty, explanation

---

### 📄 `backend/reset_db.py`

**Purpose**: Deletes tables and recreates them (destructive).

#### Methods:

| Method             | Line | Type        | Description                     |
| ------------------ | ---- | ----------- | ------------------------------- |
| `reset_database()` | 12   | 🗄️ Database | Drops tables and recreates them |

**Warning**: This deletes ALL data. Requires user confirmation before execution.

---

### 📄 `backend/verify_db.py`

**Purpose**: Shows tables, columns, and keys.

#### Methods:

| Method                   | Line | Type        | Description                              |
| ------------------------ | ---- | ----------- | ---------------------------------------- |
| `list_tables_and_keys()` | 12   | 🗄️ Database | Lists tables with columns and PK/FK info |

**Output**: Formatted table showing database structure with primary/foreign key indicators.

---

### 📄 `backend/verify_tables.py`

**Purpose**: Checks if tables have data.

#### Methods:

| Method           | Line | Type        | Description                                       |
| ---------------- | ---- | ----------- | ------------------------------------------------- |
| `verify_empty()` | 11   | 🗄️ Database | Shows record counts for Users, Quizzes, Questions |

---

### 📄 `backend/view_data.py`

**Purpose**: Shows data from all tables.

#### Methods:

| Method          | Line | Type        | Description                               |
| --------------- | ---- | ----------- | ----------------------------------------- |
| `view_tables()` | 10   | 🗄️ Database | Prints Users, Quizzes, and Questions data |

---

## Frontend Controllers

### 📄 `lib/controller/ai_controller.dart`

**Purpose**: Controls quiz generation, saving, and your quiz library.

#### Methods:

##### 🤖 **AI & Quiz Generation Methods**

| Method                     | Line | Type        | Description                                    |
| -------------------------- | ---- | ----------- | ---------------------------------------------- |
| `createQuiz()`             | 46   | 🧠 AI Logic | Creates a quiz with Gemini, or mock if offline |
| `generatePrompt(settings)` | 123  | 🧠 AI Logic | Builds the prompt for Gemini                   |

##### 🔐 **CRUD Methods**

| Method              | Line | Type             | Description              |
| ------------------- | ---- | ---------------- | ------------------------ |
| `loadLibrary()`     | 143  | 🔐 CRUD (Read)   | Loads your saved quizzes |
| `saveCurrentQuiz()` | 166  | 🔐 CRUD (Create) | Saves the current quiz   |

##### 🔄 **Quiz Management Methods**

| Method                       | Line | Description                              |
| ---------------------------- | ---- | ---------------------------------------- |
| `retryQuiz(quiz)`            | 182  | Makes a new attempt with answers cleared |
| `updateQuestion(index, ...)` | 216  | Edits a question                         |

**Key Features**:

- Retry logic for Gemini
- Mock quiz when offline
- Guest mode support
- Simple in-memory library

---

### 📄 `lib/controller/auth_controller.dart`

**Purpose**: Handles login, signup, and session.

#### Methods:

##### 🔑 **Authentication Methods**

| Method                           | Line | Type             | Description            |
| -------------------------------- | ---- | ---------------- | ---------------------- |
| `login(username, password)`      | 62   | 🔐 CRUD (Read)   | Logs you in            |
| `signUp(username, password)`     | 76   | 🔐 CRUD (Create) | Signs you up           |
| `logout()`                       | 93   | 🔐 Auth          | Logs you out           |
| `checkConnectivityAndRedirect()` | 28   | 🔐 Auth          | Skips login if offline |

##### 📦 **Session Methods**

| Method           | Line | Description         |
| ---------------- | ---- | ------------------- |
| `_loadSession()` | 23   | Loads saved session |

**Key Features**:

- Reactive state management with GetX
- Offline guest mode
- Automatic session persistence

---

### 📄 `lib/controller/exam_controller.dart`

**Purpose**: Empty controller file (no implementation yet).

---

## Frontend Services

### 📄 `lib/data/services/auth_service.dart`

**Purpose**: Auth interface and local storage version.

#### Methods (LocalAuthService):

##### 🔐 **Authentication & CRUD Methods**

| Method                                    | Line | Type             | Description                               |
| ----------------------------------------- | ---- | ---------------- | ----------------------------------------- |
| `validateCredentials(username, password)` | 36   | 🔐 CRUD (Read)   | Checks username/password in local storage |
| `checkUsernameAvailability(username)`     | 45   | 🔐 CRUD (Read)   | Checks if a username is free              |
| `register(user)`                          | 51   | 🔐 CRUD (Create) | Saves a new user                          |
| `manageSession(user)`                     | 58   | 🔐 CRUD (Update) | Stores the session                        |
| `currentUser()`                           | 64   | 🔐 CRUD (Read)   | Gets the current user                     |
| `logout()`                                | 76   | 🔐 CRUD (Delete) | Clears the session                        |

##### 📦 **Internal Storage Methods**

| Method              | Line | Type        | Description       |
| ------------------- | ---- | ----------- | ----------------- |
| `_loadUsers()`      | 18   | 🗄️ Database | Loads saved users |
| `_saveUsers(users)` | 26   | 🗄️ Database | Saves users       |

---

### 📄 `lib/data/services/auth_service_remote.dart`

**Purpose**: Auth using the backend API.

#### Methods (RemoteAuthService):

##### 🔐 **Authentication & CRUD Methods**

| Method                                    | Line | Type             | Description                 |
| ----------------------------------------- | ---- | ---------------- | --------------------------- |
| `validateCredentials(username, password)` | 10   | 🔐 CRUD (Read)   | Logs in via API             |
| `checkUsernameAvailability(username)`     | 39   | 🔐 Auth          | Not supported; returns true |
| `register(user)`                          | 45   | 🔐 CRUD (Create) | Signs up via API            |
| `manageSession(user)`                     | 64   | 🔐 Auth          | Keeps user in memory        |
| `currentUser()`                           | 69   | 🔐 CRUD (Read)   | Returns the user in memory  |
| `logout()`                                | 74   | 🔐 CRUD (Delete) | Clears in-memory user       |

**Also Contains**: `InMemoryAuthService` - Fallback auth service for offline/testing.

---

### 📄 `lib/data/services/quiz_generator_service.dart`

**Purpose**: Interface and implementations for AI quiz generation.

#### Methods (GeminiQuizGeneratorService):

##### 🤖 **AI Logic Methods**

| Method                                 | Line | Type        | Description                               |
| -------------------------------------- | ---- | ----------- | ----------------------------------------- |
| `generateQuiz(settings, onRetry)`      | 37   | 🧠 AI Logic | Gets questions from Gemini (with retries) |
| `_buildPrompt(settings)`               | 67   | 🧠 AI Logic | Builds the prompt based on settings       |
| `_difficultyToTemperature(difficulty)` | 25   | 🧠 AI Logic | Maps difficulty to temperature            |

#### Methods (MockQuizGeneratorService):

| Method                            | Line | Type        | Description                           |
| --------------------------------- | ---- | ----------- | ------------------------------------- |
| `generateQuiz(settings, onRetry)` | 124  | 🧠 AI Logic | Returns sample questions when offline |

**Key Features**:

- Temperature-based difficulty control
- Exponential backoff retry mechanism
- Fallback to lighter model on overload

---

### 📄 `lib/data/services/gemini_api.dart`

**Purpose**: Wrapper for Gemini with retry logic.

#### Methods:

##### 🤖 **AI API Methods**

| Method                                     | Line | Type        | Description                                           |
| ------------------------------------------ | ---- | ----------- | ----------------------------------------------------- |
| `sendPrompt(prompt, temperature, onRetry)` | 55   | 🧠 AI Logic | Sends prompt to Gemini (with temperature and retries) |
| `receiveJson(response)`                    | 100  | 🧠 AI Logic | Parses JSON from Gemini (removes code fences)         |
| `_retry(op, maxAttempts, onRetry)`         | 18   | 🧠 AI Logic | Retries on temporary errors (with backoff and jitter) |

**Retry Logic**:

- Max 3 attempts
- Exponential backoff with jitter
- Handles 503, 429, RESOURCE_EXHAUSTED errors
- Switches to lighter model (`gemini-1.5-flash`) on 2nd retry

---

### 📄 `lib/data/services/quiz_repository.dart`

**Purpose**: Repository interface for saving and listing quizzes.

#### Methods (InMemoryQuizRepository):

##### 🔐 **CRUD Methods**

| Method                | Line | Type                    | Description                                        |
| --------------------- | ---- | ----------------------- | -------------------------------------------------- |
| `saveQuiz(quiz)`      | 7    | 🔐 CRUD (Create/Update) | Stores quiz in in-memory list (replaces if exists) |
| `listQuizzes(userId)` | 11   | 🔐 CRUD (Read)          | Returns all quizzes from in-memory storage         |

---

### 📄 `lib/data/services/quiz_repository_remote.dart`

**Purpose**: Saves and loads quizzes via the backend API.

#### Methods (QuizRepositoryRemote):

##### 🔐 **CRUD Methods**

| Method                | Line | Type             | Description                                                      |
| --------------------- | ---- | ---------------- | ---------------------------------------------------------------- |
| `saveQuiz(quiz)`      | 11   | 🔐 CRUD (Create) | Sends quiz to backend API `/quizzes/save` via POST request       |
| `listQuizzes(userId)` | 40   | 🔐 CRUD (Read)   | Fetches user's quizzes from backend API `/quizzes/list/{userId}` |

**Key Features**:

- Ensures question IDs are UUIDs
- Converts models ↔ JSON

---

### 📄 `lib/data/services/api_client.dart`

**Purpose**: HTTP client for the backend.

#### Methods:

##### 🌐 **API Communication Methods**

| Method                              | Line | Type             | Description                                                          |
| ----------------------------------- | ---- | ---------------- | -------------------------------------------------------------------- |
| `get<T>(endpoint, fromJson)`        | 29   | 🔐 CRUD (Read)   | Sends HTTP GET request to backend                                    |
| `post<T>(endpoint, body, fromJson)` | 46   | 🔐 CRUD (Create) | Sends HTTP POST request with JSON body                               |
| `put<T>(endpoint, body, fromJson)`  | 72   | 🔐 CRUD (Update) | Sends HTTP PUT request with JSON body                                |
| `baseUrl` (getter)                  | 9    | Config           | Returns appropriate base URL based on platform (Android/Web/Desktop) |

**Platform Detection**:

- Web: `http://localhost:8000`
- Android Emulator: `http://10.0.2.2:8000`
- Android/Other: `http://{HOST_IP}:8000`

---

## Frontend Screens

### 📄 `lib/screen/home_screen.dart`

**Purpose**: Main screen to create quizzes and navigate.

**Key Features**:

- Enter topic, pick difficulty and type
- Choose number of questions
- See quick stats
- Go to History and Analyze

---

### 📄 `lib/screen/exam_screen.dart`

**Purpose**: Screen to take a quiz.

**Key Features**:

- Scrollable list of questions
- Multiple choice or short answer
- Tracks answers
- Finish & Save button

---

### 📄 `lib/screen/history_screen.dart`

**Purpose**: Shows your saved quizzes.

**Key Features**:

- List of saved quizzes
- Pull to refresh
- Retry and PDF download
- Shows title, count, difficulty

---

### 📄 `lib/screen/analyze_screen.dart`

**Purpose**: Study mode with answers and explanations.

**Key Features**:

- Expandable topic cards
- Full question and answer display
- Explanation text for each question
- PDF download for revision sheets

---

### 📄 `lib/main.dart`

**Purpose**: Application entry point and initialization.

**Key Methods**:

- `main()`: Starts the app
- `build()`: Sets up GetX, theme, and routes

---

## Method Categories

### 🔐 CRUD Methods Summary

#### **CREATE (Insert)**

| File                          | Method              | Line | Description                              |
| ----------------------------- | ------------------- | ---- | ---------------------------------------- |
| `backend/main.py`             | `signup()`          | 87   | Creates new user in database             |
| `backend/main.py`             | `save_quiz()`       | 128  | Inserts quiz and questions into database |
| `auth_service.dart`           | `register()`        | 51   | Creates user in local storage            |
| `auth_service_remote.dart`    | `register()`        | 45   | Creates user via API                     |
| `quiz_repository_remote.dart` | `saveQuiz()`        | 11   | Sends quiz to backend for storage        |
| `ai_controller.dart`          | `saveCurrentQuiz()` | 166  | Saves quiz via repository                |

#### **READ (Select/Query)**

| File                          | Method                  | Line | Description                    |
| ----------------------------- | ----------------------- | ---- | ------------------------------ |
| `backend/main.py`             | `login()`               | 67   | Queries user credentials       |
| `backend/main.py`             | `get_quizzes()`         | 160  | Retrieves all user quizzes     |
| `auth_service.dart`           | `validateCredentials()` | 36   | Reads credentials from storage |
| `auth_service.dart`           | `currentUser()`         | 64   | Retrieves session data         |
| `quiz_repository_remote.dart` | `listQuizzes()`         | 40   | Fetches quizzes from API       |
| `ai_controller.dart`          | `loadLibrary()`         | 143  | Loads user's quiz library      |

#### **UPDATE (Modify)**

| File                   | Method            | Line | Description                |
| ---------------------- | ----------------- | ---- | -------------------------- |
| `auth_service.dart`    | `manageSession()` | 58   | Updates session in storage |
| `quiz_repository.dart` | `saveQuiz()`      | 7    | Replaces existing quiz     |
| `api_client.dart`      | `put()`           | 72   | Generic update operation   |

#### **DELETE (Remove)**

| File                       | Method             | Line | Description             |
| -------------------------- | ------------------ | ---- | ----------------------- |
| `auth_service.dart`        | `logout()`         | 76   | Removes session data    |
| `auth_service_remote.dart` | `logout()`         | 74   | Clears user from memory |
| `reset_db.py`              | `reset_database()` | 12   | Drops all tables        |

---

### 🧠 AI Logic Methods Summary

| File                          | Method                       | Line | Description                                        |
| ----------------------------- | ---------------------------- | ---- | -------------------------------------------------- |
| `ai_controller.dart`          | `createQuiz()`               | 46   | Orchestrates AI quiz generation with fallback      |
| `ai_controller.dart`          | `generatePrompt()`           | 123  | Constructs AI prompt                               |
| `quiz_generator_service.dart` | `generateQuiz()`             | 37   | Calls Gemini API for question generation           |
| `quiz_generator_service.dart` | `_buildPrompt()`             | 67   | Creates detailed prompt with difficulty/type specs |
| `quiz_generator_service.dart` | `_difficultyToTemperature()` | 25   | Maps difficulty to AI temperature                  |
| `gemini_api.dart`             | `sendPrompt()`               | 55   | Low-level API call to Gemini                       |
| `gemini_api.dart`             | `receiveJson()`              | 100  | Parses AI response                                 |
| `gemini_api.dart`             | `_retry()`                   | 18   | Handles API retries with backoff                   |

---

### 🗄️ Database Methods Summary

#### **Backend Database Operations**

| File               | Method                   | Line | Description                       |
| ------------------ | ------------------------ | ---- | --------------------------------- |
| `main.py`          | `get_db_connection()`    | 56   | Establishes SQL Server connection |
| `setup_db.py`      | `setup()`                | 13   | Creates database and schema       |
| `reset_db.py`      | `reset_database()`       | 12   | Drops and recreates tables        |
| `verify_db.py`     | `list_tables_and_keys()` | 12   | Inspects schema structure         |
| `verify_tables.py` | `verify_empty()`         | 11   | Checks record counts              |
| `view_data.py`     | `view_tables()`          | 10   | Displays all table data           |

#### **Frontend Local Storage**

| File                | Method         | Line | Description                  |
| ------------------- | -------------- | ---- | ---------------------------- |
| `auth_service.dart` | `_loadUsers()` | 18   | Reads from SharedPreferences |
| `auth_service.dart` | `_saveUsers()` | 26   | Writes to SharedPreferences  |

---

## Database Schema

### Tables:

#### **Users**

- `userId` (NVARCHAR(50), PK)
- `username` (NVARCHAR(50), UNIQUE, Case-Sensitive)
- `password` (NVARCHAR(50), Case-Sensitive)

#### **Quizzes**

- `id` (NVARCHAR(50), PK)
- `userId` (NVARCHAR(50), FK → Users)
- `title` (NVARCHAR(255))
- `settingsJson` (NVARCHAR(MAX)) - JSON object with sourceText, numOfQuestions, difficulty, type
- `createdAt` (DATETIME)

#### **Questions**

- `id` (NVARCHAR(50), PK)
- `quizId` (NVARCHAR(50), FK → Quizzes, CASCADE DELETE)
- `questionText` (NVARCHAR(MAX))
- `correctAnswer` (NVARCHAR(MAX))
- `optionsJson` (NVARCHAR(MAX)) - JSON array of answer choices
- `difficulty` (NVARCHAR(50))
- `explanation` (NVARCHAR(MAX))

---

## API Endpoints

### Authentication

- `POST /auth/login` - Authenticate user
- `POST /auth/signup` - Register new user

### Quiz Management

- `POST /quizzes/save` - Save a complete quiz
- `GET /quizzes/list/{user_id}` - Retrieve all quizzes for user

---

## Architecture Overview

### Technology Stack:

- **Backend**: Python (FastAPI), SQL Server (pymssql)
- **Frontend**: Flutter/Dart with GetX
- **AI**: Google Gemini
- **Storage**: SQL Server, SharedPreferences

### Design Patterns:

- **Repository**: Abstracts local/remote data
- **Service**: Keeps logic out of UI
- **MVC (GetX)**: Controllers + views + models
- **DI**: Inject services into controllers

### Key Features:

- ✅ Guest offline mode
- ✅ Mock generation fallback
- ✅ Retry/backoff for AI calls
- ✅ Cross-platform API client
- ✅ Case-sensitive auth
- ✅ JSON-based storage
- ✅ PDF export
- ✅ Retry quiz

---

**Last Updated**: January 17, 2026
