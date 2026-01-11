# COMPONENT TEST SHEET

## AI Quiz Generator - AiController Component

### 1. COMPONENT IDENTIFICATION

- **Component Name:** AiController
- **Component Type:** Business Logic Controller (GetX)
- **Version:** 1.0
- **Location:** lib/controller/ai_controller.dart
- **Owner:** Quiz Generation Team
- **Dependencies:**
  - QuizGeneratorService (Gemini API integration)
  - QuizRepository (data persistence)
  - AuthController (user context)
  - GetX State Management

---

### 2. COMPONENT OVERVIEW

AiController manages the complete quiz generation and library management workflow:

- Quiz creation via AI with configurable parameters
- Quiz library management (load, retrieve, update)
- Handling Gemini API retry logic and exponential backoff
- State management for loading, generation, and retry statuses
- User context integration via AuthController
- Quiz question generation with difficulty/type configuration

---

### 3. TEST OBJECTIVES

- Verify successful quiz creation with valid parameters
- Validate quiz generation state transitions
- Test Gemini API retry mechanism and backoff
- Ensure proper error handling and user feedback
- Verify quiz library CRUD operations
- Test parameter validation (difficulty, question type, count)
- Confirm authentication integration
- Validate reactive state updates
- Test concurrency prevention (no duplicate generation)

---

### 4. TEST SCOPE

**In Scope:**

- createQuiz() method
- loadLibrary() method
- Quiz state management (myLibrary, currentQuiz, questions)
- Generation state flags (isGenerating, isRetrying, retryAttempt)
- Parameter configuration (selectedDifficulty, selectedType, numOfQuestions)
- Retry logic with exponential backoff
- AuthController integration
- QuizRepository integration
- Error handling

**Out of Scope:**

- UI rendering (covered by widget tests)
- Gemini API actual responses (mocked)
- Database implementation (mocked)
- Network transport layer specifics

---

### 5. TEST ENVIRONMENT & RESOURCES

**Required Setup:**

- Flutter test framework
- Mockito for mocking services
- Test fixtures for Quiz, Question objects
- Mock implementations:
  - QuizGeneratorService
  - QuizRepository
  - AuthController
- Test data with various difficulty/type combinations

**Tools:**

- Flutter test runner
- Code coverage analyzer

---

### 6. ENTRY/EXIT CRITERIA

**Entry Criteria:**

- All dependency services stable
- Test fixtures prepared
- Mock services configured
- Test environment ready

**Exit Criteria:**

- All test cases passed
- Code coverage ≥ 80%
- No critical/high-severity defects
- Regression testing complete

---

### 7. TEST CASES

#### TC-001: Create Quiz with Valid Parameters

| Attribute           | Details                                                                                                                                                                                                                                                                                                                                                   |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-001                                                                                                                                                                                                                                                                                                                                                    |
| **Title**           | Create quiz with all valid parameters                                                                                                                                                                                                                                                                                                                     |
| **Objective**       | Verify successful quiz creation with complete configuration                                                                                                                                                                                                                                                                                               |
| **Preconditions**   | AiController initialized, user authenticated, services mocked                                                                                                                                                                                                                                                                                             |
| **Test Steps**      | 1. Set createQuizExplanation = "Test Topic"<br>2. Set selectedDifficulty = DifficultyLevel.medium<br>3. Set selectedType = QuestionType.multipleChoice<br>4. Set numOfQuestions = 5<br>5. Call createQuiz()<br>6. Verify isGenerating: false→true→false<br>7. Verify currentQuiz is set<br>8. Verify questions.length == 5<br>9. Verify myLibrary updated |
| **Expected Result** | Quiz created successfully, state properly updated                                                                                                                                                                                                                                                                                                         |
| **Pass Criteria**   | currentQuiz != null, questions.length == 5, isGenerating.value == false                                                                                                                                                                                                                                                                                   |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                                                                                                                                                           |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                                                                                                                                                                |
| **Risk Level**      | HIGH (core functionality)                                                                                                                                                                                                                                                                                                                                 |

---

#### TC-002: Quiz Generation State Transitions

| Attribute           | Details                                                                                                                                                                                                                                              |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-002                                                                                                                                                                                                                                               |
| **Title**           | Verify state flag transitions during generation                                                                                                                                                                                                      |
| **Objective**       | Ensure isGenerating flag correctly reflects operation status                                                                                                                                                                                         |
| **Preconditions**   | AiController initialized, mock with configurable delay                                                                                                                                                                                               |
| **Test Steps**      | 1. Verify isGenerating.value == false initially<br>2. Call createQuiz()<br>3. Verify isGenerating.value == true immediately<br>4. Wait for generation completion<br>5. Verify isGenerating.value == false<br>6. Verify retryAttempt state consistent |
| **Expected Result** | Loading state correctly reflects generation progress                                                                                                                                                                                                 |
| **Pass Criteria**   | isGenerating: false→true→false in correct sequence                                                                                                                                                                                                   |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                                                      |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                                                           |
| **Risk Level**      | MEDIUM                                                                                                                                                                                                                                               |

---

#### TC-003: Handle API Timeout with Retry

| Attribute           | Details                                                                                                                                                                                                                                                                                              |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-003                                                                                                                                                                                                                                                                                               |
| **Title**           | Verify retry mechanism on API timeout/failure                                                                                                                                                                                                                                                        |
| **Objective**       | Test exponential backoff and automatic retry on Gemini API failure                                                                                                                                                                                                                                   |
| **Preconditions**   | Mock service configured to fail 1st attempt, succeed 2nd                                                                                                                                                                                                                                             |
| **Test Steps**      | 1. Mock generateQuestions() to throw TimeoutException on attempt 1<br>2. Call createQuiz()<br>3. Verify isRetrying.value == true<br>4. Verify retryAttempt.value increments to 1<br>5. Verify retry succeeds on 2nd attempt<br>6. Verify final quiz generated<br>7. Verify isRetrying.value == false |
| **Expected Result** | Quiz generation succeeds after automatic retry                                                                                                                                                                                                                                                       |
| **Pass Criteria**   | Quiz generated successfully, retryAttempt >= 1                                                                                                                                                                                                                                                       |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                                                                                                      |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                                                                                                           |
| **Risk Level**      | HIGH (error recovery)                                                                                                                                                                                                                                                                                |

---

#### TC-004: Max Retry Attempts Exceeded

| Attribute           | Details                                                                                                                                                                                                                                                                                                                                              |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-004                                                                                                                                                                                                                                                                                                                                               |
| **Title**           | Handle failure after max retry attempts                                                                                                                                                                                                                                                                                                              |
| **Objective**       | Verify graceful failure when retry limit exceeded                                                                                                                                                                                                                                                                                                    |
| **Preconditions**   | Mock service configured to fail all attempts                                                                                                                                                                                                                                                                                                         |
| **Test Steps**      | 1. Mock generateQuestions() to always throw exception<br>2. Call createQuiz()<br>3. Verify retryAttempt increments to max (3 or configured limit)<br>4. Verify operation eventually fails with error<br>5. Verify user error notification set<br>6. Verify currentQuiz is null or previous state maintained<br>7. Verify isGenerating.value == false |
| **Expected Result** | Operation fails gracefully after max retries                                                                                                                                                                                                                                                                                                         |
| **Pass Criteria**   | Error state set, generation stops, isGenerating == false                                                                                                                                                                                                                                                                                             |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                                                                                                                                                      |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                                                                                                                                                           |
| **Risk Level**      | HIGH (error handling)                                                                                                                                                                                                                                                                                                                                |

---

#### TC-005: Parameter Validation - Question Count

| Attribute           | Details                                                                                                                                                                                                                                                |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **ID**              | TC-005                                                                                                                                                                                                                                                 |
| **Title**           | Validate question count boundaries                                                                                                                                                                                                                     |
| **Objective**       | Ensure numOfQuestions within acceptable range                                                                                                                                                                                                          |
| **Preconditions**   | AiController initialized                                                                                                                                                                                                                               |
| **Test Steps**      | 1. Set numOfQuestions = 0<br>2. Attempt createQuiz()<br>3. Verify validation error or minimum enforced<br>4. Set numOfQuestions = 101<br>5. Verify maximum enforced (if limit exists)<br>6. Set numOfQuestions = 5<br>7. Verify quiz creation proceeds |
| **Expected Result** | Invalid counts rejected, valid counts accepted                                                                                                                                                                                                         |
| **Pass Criteria**   | numOfQuestions within valid range, validation enforced                                                                                                                                                                                                 |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                                                        |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                                                             |
| **Risk Level**      | MEDIUM                                                                                                                                                                                                                                                 |

---

#### TC-006: Parameter Validation - Difficulty Level

| Attribute           | Details                                                                                                                                                                                                                                                                                                                                                 |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-006                                                                                                                                                                                                                                                                                                                                                  |
| **Title**           | Validate difficulty level values                                                                                                                                                                                                                                                                                                                        |
| **Objective**       | Verify only valid DifficultyLevel enum values accepted                                                                                                                                                                                                                                                                                                  |
| **Preconditions**   | AiController initialized                                                                                                                                                                                                                                                                                                                                |
| **Test Steps**      | 1. Set selectedDifficulty = DifficultyLevel.easy<br>2. Verify service receives easy temperature value<br>3. Set selectedDifficulty = DifficultyLevel.medium<br>4. Verify medium temperature value used<br>5. Set selectedDifficulty = DifficultyLevel.hard<br>6. Verify hard temperature value used<br>7. Call createQuiz() for each and verify success |
| **Expected Result** | All valid difficulty levels accepted and used correctly                                                                                                                                                                                                                                                                                                 |
| **Pass Criteria**   | All difficulty levels result in successful quiz creation                                                                                                                                                                                                                                                                                                |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                                                                                                                                                         |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                                                                                                                                                              |
| **Risk Level**      | LOW                                                                                                                                                                                                                                                                                                                                                     |

---

#### TC-007: Authentication Integration

| Attribute           | Details                                                                                                                                                                                                                                                            |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **ID**              | TC-007                                                                                                                                                                                                                                                             |
| **Title**           | Verify authentication integration                                                                                                                                                                                                                                  |
| **Objective**       | Ensure quiz creation requires authenticated user                                                                                                                                                                                                                   |
| **Preconditions**   | AuthController injected via GetX                                                                                                                                                                                                                                   |
| **Test Steps**      | 1. Mock AuthController with currentUser.value = null<br>2. Call createQuiz()<br>3. Verify operation fails or aborted<br>4. Set valid user in AuthController<br>5. Call createQuiz()<br>6. Verify operation proceeds<br>7. Verify quiz.userId == currentUser.userId |
| **Expected Result** | Unauthenticated requests rejected, authenticated requests accepted                                                                                                                                                                                                 |
| **Pass Criteria**   | Auth check enforced, quiz userId matches current user                                                                                                                                                                                                              |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                                                                    |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                                                                         |
| **Risk Level**      | HIGH (security)                                                                                                                                                                                                                                                    |

---

#### TC-008: Quiz Library Load and Display

| Attribute           | Details                                                                                                                                                                                                                                        |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-008                                                                                                                                                                                                                                         |
| **Title**           | Load and display user's quiz library                                                                                                                                                                                                           |
| **Objective**       | Verify myLibrary updates with user's quizzes from repository                                                                                                                                                                                   |
| **Preconditions**   | Repository mocked to return 3 quiz objects for user                                                                                                                                                                                            |
| **Test Steps**      | 1. Verify myLibrary is empty initially<br>2. Call loadLibrary()<br>3. Verify isLoadingLibrary transitions: false→true→false<br>4. Verify myLibrary.length == 3<br>5. Verify each quiz has correct userId<br>6. Verify GetX observers triggered |
| **Expected Result** | Library loads and displays all user quizzes                                                                                                                                                                                                    |
| **Pass Criteria**   | myLibrary.length == expected, isLoadingLibrary == false                                                                                                                                                                                        |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                                                |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                                                     |
| **Risk Level**      | MEDIUM                                                                                                                                                                                                                                         |

---

#### TC-009: Prevent Concurrent Quiz Generation

| Attribute           | Details                                                                                                                                                                                                                                                  |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-009                                                                                                                                                                                                                                                   |
| **Title**           | Prevent duplicate concurrent quiz generations                                                                                                                                                                                                            |
| **Objective**       | Ensure only one quiz generation at a time                                                                                                                                                                                                                |
| **Preconditions**   | AiController initialized, mock with delay                                                                                                                                                                                                                |
| **Test Steps**      | 1. Call createQuiz() (generation starts)<br>2. Immediately call createQuiz() again<br>3. Verify 2nd call is ignored/rejected<br>4. Verify isGenerating stays true until 1st completes<br>5. Verify only 1 quiz generated<br>6. Verify no race conditions |
| **Expected Result** | Second request blocked while first is in progress                                                                                                                                                                                                        |
| **Pass Criteria**   | Only one quiz generated, second request rejected                                                                                                                                                                                                         |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                                                          |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                                                               |
| **Risk Level**      | MEDIUM                                                                                                                                                                                                                                                   |

---

#### TC-010: Quiz Parameter Persistence in State

| Attribute           | Details                                                                                                                                                                                                                                                           |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-010                                                                                                                                                                                                                                                            |
| **Title**           | Verify quiz parameters persist in state                                                                                                                                                                                                                           |
| **Objective**       | Ensure selectedDifficulty, selectedType, numOfQuestions retained                                                                                                                                                                                                  |
| **Preconditions**   | AiController initialized                                                                                                                                                                                                                                          |
| **Test Steps**      | 1. Set selectedDifficulty = hard<br>2. Set selectedType = trueOrFalse<br>3. Set numOfQuestions = 10<br>4. Call createQuiz()<br>5. Verify parameters still set after generation<br>6. Modify parameters<br>7. Create another quiz<br>8. Verify new parameters used |
| **Expected Result** | Parameters persist across operations, update correctly                                                                                                                                                                                                            |
| **Pass Criteria**   | Parameter values maintained and applied correctly                                                                                                                                                                                                                 |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                                                                   |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                                                                        |
| **Risk Level**      | LOW                                                                                                                                                                                                                                                               |

---

#### TC-011: Repository Integration for Quiz Persistence

| Attribute           | Details                                                                                                                                                                                                      |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **ID**              | TC-011                                                                                                                                                                                                       |
| **Title**           | Verify quiz saved to repository                                                                                                                                                                              |
| **Objective**       | Ensure generated quiz persisted via QuizRepository                                                                                                                                                           |
| **Preconditions**   | QuizRepository mocked                                                                                                                                                                                        |
| **Test Steps**      | 1. Call createQuiz()<br>2. Verify quizRepo.saveQuiz() called<br>3. Verify saved quiz matches generated quiz<br>4. Verify userId correct<br>5. Call loadLibrary()<br>6. Verify loaded quiz matches saved quiz |
| **Expected Result** | Quiz persisted and retrievable from repository                                                                                                                                                               |
| **Pass Criteria**   | quizRepo.saveQuiz() called with correct Quiz object                                                                                                                                                          |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                              |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                   |
| **Risk Level**      | HIGH (data integrity)                                                                                                                                                                                        |

---

#### TC-012: Explanation Text Controller Lifecycle

| Attribute           | Details                                                                                                                                                                                                                                       |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-012                                                                                                                                                                                                                                        |
| **Title**           | Quiz explanation TextEditingController management                                                                                                                                                                                             |
| **Objective**       | Verify createQuizExplanation controller properly used                                                                                                                                                                                         |
| **Preconditions**   | AiController initialized                                                                                                                                                                                                                      |
| **Test Steps**      | 1. Set createQuizExplanation.text = "Biology"<br>2. Call createQuiz()<br>3. Verify service receives explanation text<br>4. Verify text controller value after generation<br>5. Clear text controller<br>6. Verify next quiz uses cleared text |
| **Expected Result** | Explanation text correctly passed and managed                                                                                                                                                                                                 |
| **Pass Criteria**   | Service receives correct explanation text                                                                                                                                                                                                     |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                                               |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                                                    |
| **Risk Level**      | LOW                                                                                                                                                                                                                                           |

---

### 8. TEST COVERAGE MATRIX

| Requirement                   | Test Case      | Status |
| ----------------------------- | -------------- | ------ |
| Quiz creation with parameters | TC-001         | ⬜     |
| State management transitions  | TC-002         | ⬜     |
| Error handling & retry logic  | TC-003, TC-004 | ⬜     |
| Parameter validation          | TC-005, TC-006 | ⬜     |
| Authentication integration    | TC-007         | ⬜     |
| Library management            | TC-008         | ⬜     |
| Concurrency control           | TC-009         | ⬜     |
| State persistence             | TC-010         | ⬜     |
| Repository integration        | TC-011         | ⬜     |
| Text controller management    | TC-012         | ⬜     |
| Reactive updates              | TC-002, TC-008 | ⬜     |
| Gemini service integration    | TC-001, TC-003 | ⬜     |

---

### 9. RISK ASSESSMENT

| Risk                                    | Probability | Impact | Mitigation                                     |
| --------------------------------------- | ----------- | ------ | ---------------------------------------------- |
| Gemini API rate limiting                | MEDIUM      | HIGH   | Implement progressive backoff, cache responses |
| Concurrent generation race conditions   | LOW         | HIGH   | Flag-based prevention, mutex-like mechanism    |
| Repository mock/real mismatch           | MEDIUM      | MEDIUM | Create integration tests with real DB          |
| State inconsistency on errors           | MEDIUM      | MEDIUM | Ensure rollback or consistent failure state    |
| AuthController unavailable              | LOW         | HIGH   | Dependency injection with fallback             |
| Memory leaks with TextEditingController | MEDIUM      | MEDIUM | Proper dispose in lifecycle                    |

---

### 10. DEFECT LOG

| Defect ID | Severity | Description | Status |
| --------- | -------- | ----------- | ------ |
|           |          |             |        |

---

### 11. TEST EXECUTION SUMMARY

**Total Test Cases:** 12  
**Passed:** 0  
**Failed:** 0  
**Blocked:** 0  
**Not Run:** 12

**Overall Status:** ⬜ NOT STARTED

---

### 12. SIGN-OFF

| Role             | Name | Date | Signature |
| ---------------- | ---- | ---- | --------- |
| Test Lead        |      |      |           |
| QA Manager       |      |      |           |
| Development Lead |      |      |           |
