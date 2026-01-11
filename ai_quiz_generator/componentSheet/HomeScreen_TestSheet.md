# COMPONENT TEST SHEET

## AI Quiz Generator - HomeScreen Component

### 1. COMPONENT IDENTIFICATION

- **Component Name:** HomeScreen
- **Component Type:** UI Widget / Screen
- **Version:** 1.0
- **Location:** lib/screen/home_screen.dart
- **Owner:** UI/UX Team
- **Dependencies:**
  - AiController (quiz generation)
  - AuthController (authentication)
  - ExamScreen (navigation)
  - DifficultyLevel, QuestionType enums
  - GetX state management

---

### 2. COMPONENT OVERVIEW

HomeScreen is the main dashboard and quiz creation interface:

- Quiz creation form with topic input
- Difficulty level selection
- Question type selection
- Question count configuration
- Load and display quiz library
- Navigate to exam mode
- Display quiz history/completed count
- Loading state visualization
- Error messaging

---

### 3. TEST OBJECTIVES

- Verify all UI elements render correctly
- Test form input handling
- Validate parameter selection states
- Verify quiz library loads on init
- Test navigation to exam screen
- Validate quiz creation triggers
- Test loading state visualization
- Verify error message display
- Test responsive layout

---

### 4. TEST SCOPE

**In Scope:**

- Widget rendering and UI structure
- User input handling (text, dropdowns, buttons)
- State management integration with GetX
- Navigation to ExamScreen
- Controller method calls
- Quiz parameter selection UI
- Library display
- Gesture and event handling
- Form validation display

**Out of Scope:**

- Platform-specific rendering details
- Animation specifics
- Accessibility features (separate test sheet)
- Theme color rendering accuracy
- Font rendering details

---

### 5. TEST ENVIRONMENT & RESOURCES

**Required Setup:**

- Flutter widget test framework
- Mock AiController and AuthController
- Mock navigation
- Test fixtures for quiz list
- UI element finders and gestures

**Tools:**

- Flutter widget test runner
- Visual regression testing (optional)

---

### 6. ENTRY/EXIT CRITERIA

**Entry Criteria:**

- All dependencies mocked
- Test fixtures prepared
- Navigation mocks configured

**Exit Criteria:**

- All widget tests passed
- Code coverage ≥ 80%
- UI responds to all user interactions
- No visual regressions

---

### 7. TEST CASES

#### TC-001: Initial Widget Build and Render

| Attribute           | Details                                                                                                                                      |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-001                                                                                                                                       |
| **Title**           | HomeScreen builds and renders without error                                                                                                  |
| **Objective**       | Verify screen initializes and displays                                                                                                       |
| **Preconditions**   | All controllers mocked, scaffold ready                                                                                                       |
| **Test Steps**      | 1. Build HomeScreen widget<br>2. Pump widget tree<br>3. Verify Scaffold exists<br>4. Verify AppBar present<br>5. Verify body content renders |
| **Expected Result** | Screen renders without exceptions                                                                                                            |
| **Pass Criteria**   | find.byType(Scaffold) exists                                                                                                                 |
| **Actual Result**   | [To be filled during execution]                                                                                                              |
| **Status**          | ⬜ Not Run                                                                                                                                   |
| **Risk Level**      | HIGH (fundamental)                                                                                                                           |

---

#### TC-002: Quiz Creation Form Elements

| Attribute           | Details                                                                                                                                                                  |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **ID**              | TC-002                                                                                                                                                                   |
| **Title**           | Quiz creation form has all required fields                                                                                                                               |
| **Objective**       | Verify topic, difficulty, type, count fields present                                                                                                                     |
| **Preconditions**   | HomeScreen built                                                                                                                                                         |
| **Test Steps**      | 1. Find TextFormField for topic<br>2. Find dropdown for difficulty<br>3. Find dropdown for question type<br>4. Find input/slider for count<br>5. Find Create Quiz button |
| **Expected Result** | All form fields present                                                                                                                                                  |
| **Pass Criteria**   | All UI elements findable                                                                                                                                                 |
| **Actual Result**   | [To be filled during execution]                                                                                                                                          |
| **Status**          | ⬜ Not Run                                                                                                                                                               |
| **Risk Level**      | HIGH (functionality)                                                                                                                                                     |

---

#### TC-003: Topic Input Field Entry

| Attribute           | Details                                                                                                                           |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-003                                                                                                                            |
| **Title**           | User can enter quiz topic                                                                                                         |
| **Objective**       | Test TextFormField accepts text input                                                                                             |
| **Preconditions**   | HomeScreen built                                                                                                                  |
| **Test Steps**      | 1. Find topic TextFormField<br>2. Pump widget<br>3. Enter 'Biology' text<br>4. Pump animations<br>5. Verify text appears in field |
| **Expected Result** | Text input accepted and displayed                                                                                                 |
| **Pass Criteria**   | Entered text visible in field                                                                                                     |
| **Actual Result**   | [To be filled during execution]                                                                                                   |
| **Status**          | ⬜ Not Run                                                                                                                        |
| **Risk Level**      | MEDIUM                                                                                                                            |

---

#### TC-004: Difficulty Level Selection

| Attribute           | Details                                                                                                                                                                               |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-004                                                                                                                                                                                |
| **Title**           | User can select difficulty level                                                                                                                                                      |
| **Objective**       | Test difficulty dropdown selection                                                                                                                                                    |
| **Preconditions**   | HomeScreen built                                                                                                                                                                      |
| **Test Steps**      | 1. Find difficulty dropdown<br>2. Tap to open dropdown<br>3. Select 'Hard' option<br>4. Pump widget<br>5. Verify 'Hard' selected<br>6. Verify AiController.selectedDifficulty updated |
| **Expected Result** | Difficulty selection updates state                                                                                                                                                    |
| **Pass Criteria**   | Selected value reflects in UI and controller                                                                                                                                          |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                       |
| **Status**          | ⬜ Not Run                                                                                                                                                                            |
| **Risk Level**      | MEDIUM                                                                                                                                                                                |

---

#### TC-005: Question Type Selection

| Attribute           | Details                                                                                                                                                                      |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-005                                                                                                                                                                       |
| **Title**           | User can select question type                                                                                                                                                |
| **Objective**       | Test question type dropdown                                                                                                                                                  |
| **Preconditions**   | HomeScreen built                                                                                                                                                             |
| **Test Steps**      | 1. Find question type dropdown<br>2. Tap to open<br>3. Select different type<br>4. Pump widget<br>5. Verify selection updates<br>6. Verify AiController.selectedType updated |
| **Expected Result** | Question type selection updates                                                                                                                                              |
| **Pass Criteria**   | Selection reflected in UI and controller                                                                                                                                     |
| **Actual Result**   | [To be filled during execution]                                                                                                                                              |
| **Status**          | ⬜ Not Run                                                                                                                                                                   |
| **Risk Level**      | MEDIUM                                                                                                                                                                       |

---

#### TC-006: Question Count Configuration

| Attribute           | Details                                                                                                                                                |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **ID**              | TC-006                                                                                                                                                 |
| **Title**           | User can configure number of questions                                                                                                                 |
| **Objective**       | Test question count input/slider                                                                                                                       |
| **Preconditions**   | HomeScreen built                                                                                                                                       |
| **Test Steps**      | 1. Find question count input<br>2. Enter or adjust to 10<br>3. Pump widget<br>4. Verify count displayed<br>5. Verify AiController.numOfQuestions == 10 |
| **Expected Result** | Question count updates correctly                                                                                                                       |
| **Pass Criteria**   | Count reflected in controller                                                                                                                          |
| **Actual Result**   | [To be filled during execution]                                                                                                                        |
| **Status**          | ⬜ Not Run                                                                                                                                             |
| **Risk Level**      | MEDIUM                                                                                                                                                 |

---

#### TC-007: Create Quiz Button Triggers Generation

| Attribute           | Details                                                                                                                                     |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-007                                                                                                                                      |
| **Title**           | Create Quiz button calls controller method                                                                                                  |
| **Objective**       | Verify button tap triggers quiz generation                                                                                                  |
| **Preconditions**   | HomeScreen built, form filled                                                                                                               |
| **Test Steps**      | 1. Fill in all form fields<br>2. Find 'Create Quiz' button<br>3. Tap button<br>4. Pump widget<br>5. Verify AiController.createQuiz() called |
| **Expected Result** | Quiz generation initiated                                                                                                                   |
| **Pass Criteria**   | createQuiz() called on controller                                                                                                           |
| **Actual Result**   | [To be filled during execution]                                                                                                             |
| **Status**          | ⬜ Not Run                                                                                                                                  |
| **Risk Level**      | HIGH (functionality)                                                                                                                        |

---

#### TC-008: Loading State Display

| Attribute           | Details                                                                                                                                                                                          |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **ID**              | TC-008                                                                                                                                                                                           |
| **Title**           | Loading indicator shows during quiz generation                                                                                                                                                   |
| **Objective**       | Verify loading UI appears when isGenerating true                                                                                                                                                 |
| **Preconditions**   | Quiz generation started                                                                                                                                                                          |
| **Test Steps**      | 1. Mock AiController.isGenerating = true<br>2. Rebuild widget<br>3. Look for CircularProgressIndicator or similar<br>4. Verify button disabled or loading shown<br>5. Verify user feedback clear |
| **Expected Result** | Loading state visually indicated                                                                                                                                                                 |
| **Pass Criteria**   | Loading indicator visible                                                                                                                                                                        |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                  |
| **Status**          | ⬜ Not Run                                                                                                                                                                                       |
| **Risk Level**      | MEDIUM                                                                                                                                                                                           |

---

#### TC-009: Quiz Library Load on Init

| Attribute           | Details                                                                                                                                         |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-009                                                                                                                                          |
| **Title**           | Quiz library loads when screen initializes                                                                                                      |
| **Objective**       | Verify loadLibrary called on initState                                                                                                          |
| **Preconditions**   | HomeScreen created with fresh controller                                                                                                        |
| **Test Steps**      | 1. Create HomeScreen<br>2. Trigger initState<br>3. Pump widget<br>4. Verify AiController.loadLibrary() called<br>5. Verify library list updates |
| **Expected Result** | Library loads automatically                                                                                                                     |
| **Pass Criteria**   | loadLibrary() called, library displayed                                                                                                         |
| **Actual Result**   | [To be filled during execution]                                                                                                                 |
| **Status**          | ⬜ Not Run                                                                                                                                      |
| **Risk Level**      | MEDIUM                                                                                                                                          |

---

#### TC-010: Quiz Completed Count Display

| Attribute           | Details                                                                                                                                                                  |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **ID**              | TC-010                                                                                                                                                                   |
| **Title**           | Display count of completed quizzes                                                                                                                                       |
| **Objective**       | Show myLibrary.length as completed count                                                                                                                                 |
| **Preconditions**   | Library contains quizzes                                                                                                                                                 |
| **Test Steps**      | 1. Mock myLibrary with 5 quizzes<br>2. Build widget<br>3. Find 'Done' or completion text<br>4. Verify displays '5'<br>5. Update library count<br>6. Verify count updates |
| **Expected Result** | Quiz count displayed accurately                                                                                                                                          |
| **Pass Criteria**   | Count matches library size                                                                                                                                               |
| **Actual Result**   | [To be filled during execution]                                                                                                                                          |
| **Status**          | ⬜ Not Run                                                                                                                                                               |
| **Risk Level**      | LOW                                                                                                                                                                      |

---

#### TC-011: Navigation to History Screen

| Attribute           | Details                                                                                                                         |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-011                                                                                                                          |
| **Title**           | Navigate to history screen                                                                                                      |
| **Objective**       | Verify history button navigates correctly                                                                                       |
| **Preconditions**   | HomeScreen built, navigation mocked                                                                                             |
| **Test Steps**      | 1. Find history button/tab<br>2. Tap button<br>3. Verify navigation called<br>4. Verify HistoryScreen argument passed correctly |
| **Expected Result** | Navigation to history screen                                                                                                    |
| **Pass Criteria**   | Navigator.push() called with HistoryScreen                                                                                      |
| **Actual Result**   | [To be filled during execution]                                                                                                 |
| **Status**          | ⬜ Not Run                                                                                                                      |
| **Risk Level**      | MEDIUM                                                                                                                          |

---

#### TC-012: Navigation to Analyze Screen

| Attribute           | Details                                                                             |
| ------------------- | ----------------------------------------------------------------------------------- |
| **ID**              | TC-012                                                                              |
| **Title**           | Navigate to analyze screen                                                          |
| **Objective**       | Verify analyze button navigates correctly                                           |
| **Preconditions**   | HomeScreen built, navigation mocked                                                 |
| **Test Steps**      | 1. Find analyze button/tab<br>2. Tap button<br>3. Verify AnalyzeScreen navigated to |
| **Expected Result** | Navigation to analyze screen                                                        |
| **Pass Criteria**   | Navigator.push() called with AnalyzeScreen                                          |
| **Actual Result**   | [To be filled during execution]                                                     |
| **Status**          | ⬜ Not Run                                                                          |
| **Risk Level**      | MEDIUM                                                                              |

---

#### TC-013: Quiz Item Tap Navigates to Exam

| Attribute           | Details                                                                                                                   |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-013                                                                                                                    |
| **Title**           | Tap quiz in library navigates to exam                                                                                     |
| **Objective**       | Verify quiz selection starts exam mode                                                                                    |
| **Preconditions**   | Library displayed with quizzes                                                                                            |
| **Test Steps**      | 1. Find quiz list item<br>2. Tap quiz item<br>3. Verify ExamScreen navigated to<br>4. Verify AiController.currentQuiz set |
| **Expected Result** | Exam mode started with selected quiz                                                                                      |
| **Pass Criteria**   | ExamScreen pushed to navigator                                                                                            |
| **Actual Result**   | [To be filled during execution]                                                                                           |
| **Status**          | ⬜ Not Run                                                                                                                |
| **Risk Level**      | HIGH (functionality)                                                                                                      |

---

#### TC-014: Error Message Display

| Attribute           | Details                                                                                                                                                                 |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-014                                                                                                                                                                  |
| **Title**           | Display error message on quiz generation failure                                                                                                                        |
| **Objective**       | Show error feedback when generation fails                                                                                                                               |
| **Preconditions**   | Quiz generation failed, error set                                                                                                                                       |
| **Test Steps**      | 1. Mock AiController error state with message<br>2. Rebuild widget<br>3. Find error message or snackbar<br>4. Verify message visible<br>5. Verify error message content |
| **Expected Result** | Error clearly communicated to user                                                                                                                                      |
| **Pass Criteria**   | Error message displayed                                                                                                                                                 |
| **Actual Result**   | [To be filled during execution]                                                                                                                                         |
| **Status**          | ⬜ Not Run                                                                                                                                                              |
| **Risk Level**      | MEDIUM                                                                                                                                                                  |

---

#### TC-015: Logout Button Functionality

| Attribute           | Details                                                                                                                                             |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-015                                                                                                                                              |
| **Title**           | Logout button clears auth state                                                                                                                     |
| **Objective**       | Verify logout navigates to auth screen                                                                                                              |
| **Preconditions**   | User logged in, logout button visible                                                                                                               |
| **Test Steps**      | 1. Find logout button<br>2. Tap button<br>3. Verify AuthController.logout() called<br>4. Verify navigation to AuthGate<br>5. Verify session cleared |
| **Expected Result** | User logged out and navigated to auth                                                                                                               |
| **Pass Criteria**   | AuthController.logout() called, navigation occurs                                                                                                   |
| **Actual Result**   | [To be filled during execution]                                                                                                                     |
| **Status**          | ⬜ Not Run                                                                                                                                          |
| **Risk Level**      | HIGH (security)                                                                                                                                     |

---

### 8. TEST COVERAGE MATRIX

| Requirement               | Test Case | Status |
| ------------------------- | --------- | ------ |
| Widget initialization     | TC-001    | ⬜     |
| Form fields present       | TC-002    | ⬜     |
| Topic input               | TC-003    | ⬜     |
| Difficulty selection      | TC-004    | ⬜     |
| Question type selection   | TC-005    | ⬜     |
| Question count            | TC-006    | ⬜     |
| Quiz creation             | TC-007    | ⬜     |
| Loading state             | TC-008    | ⬜     |
| Library loading           | TC-009    | ⬜     |
| Quiz count display        | TC-010    | ⬜     |
| Navigation to history     | TC-011    | ⬜     |
| Navigation to analyze     | TC-012    | ⬜     |
| Quiz selection navigation | TC-013    | ⬜     |
| Error display             | TC-014    | ⬜     |
| Logout functionality      | TC-015    | ⬜     |

---

### 9. RISK ASSESSMENT

| Risk                               | Probability | Impact | Mitigation                                |
| ---------------------------------- | ----------- | ------ | ----------------------------------------- |
| Controller state not updating UI   | MEDIUM      | HIGH   | Use Obx() wrappers, test reactive updates |
| Navigation failures                | MEDIUM      | HIGH   | Mock navigation thoroughly                |
| Gesture not recognized             | MEDIUM      | MEDIUM | Use pumpAndSettle() for animations        |
| Layout issues on different screens | MEDIUM      | MEDIUM | Test multiple screen sizes                |

---

### 10. DEFECT LOG

| Defect ID | Severity | Description | Status |
| --------- | -------- | ----------- | ------ |
|           |          |             |        |

---

### 11. TEST EXECUTION SUMMARY

**Total Test Cases:** 15  
**Passed:** 0  
**Failed:** 0  
**Blocked:** 0  
**Not Run:** 15

**Overall Status:** ⬜ NOT STARTED

---

### 12. SIGN-OFF

| Role             | Name | Date | Signature |
| ---------------- | ---- | ---- | --------- |
| Test Lead        |      |      |           |
| QA Manager       |      |      |           |
| Development Lead |      |      |           |
