# COMPONENT TEST SHEET

## AI Quiz Generator - ExamScreen Component

### 1. COMPONENT IDENTIFICATION

- **Component Name:** ExamScreen
- **Component Type:** UI Widget / Screen
- **Version:** 1.0
- **Location:** lib/screen/exam_screen.dart
- **Owner:** UI/UX Team
- **Dependencies:**
  - AiController (quiz data)
  - QuizRadioGroup widget
  - AppTheme (styling)
  - GetX state management

---

### 2. COMPONENT OVERVIEW

ExamScreen displays and manages the quiz taking experience:

- Display quiz questions one at a time or all at once
- Question rendering based on type (multiple choice, true/false)
- Answer selection via radio buttons/toggle
- Quiz progress tracking
- Submit/finish quiz functionality
- Score calculation and display
- Navigate back to home

---

### 3. TEST OBJECTIVES

- Verify screen initializes with quiz data
- Test question rendering
- Validate answer selection
- Test submit/finish functionality
- Verify score calculation
- Test navigation back to home
- Validate responsive layout
- Test all question types

---

### 4. TEST SCOPE

**In Scope:**

- Widget rendering
- Question display
- Answer input handling
- Submit button functionality
- Quiz navigation
- Question type handling
- UI state management

**Out of Scope:**

- Scoring algorithm details
- Theme rendering accuracy
- Animation timings
- Platform-specific behaviors

---

### 5. TEST ENVIRONMENT & RESOURCES

**Required Setup:**

- Flutter widget test framework
- Mock AiController with quiz data
- Quiz test fixtures
- UI element finders

**Tools:**

- Flutter widget test runner

---

### 6. ENTRY/EXIT CRITERIA

**Entry Criteria:**

- AiController mocked with quiz
- Test quiz prepared
- Dependencies available

**Exit Criteria:**

- All tests passed
- Code coverage ≥ 80%
- All question types tested

---

### 7. TEST CASES

#### TC-001: ExamScreen Builds with Quiz Data

| Attribute           | Details                                                                                                                                                      |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **ID**              | TC-001                                                                                                                                                       |
| **Title**           | ExamScreen initializes with quiz                                                                                                                             |
| **Objective**       | Verify screen displays quiz data                                                                                                                             |
| **Preconditions**   | AiController has currentQuiz set                                                                                                                             |
| **Test Steps**      | 1. Build ExamScreen widget<br>2. Pump widget tree<br>3. Verify AppBar with 'Exam Mode'<br>4. Verify quiz container renders<br>5. Verify body content present |
| **Expected Result** | Screen initializes without error                                                                                                                             |
| **Pass Criteria**   | find.byType(Scaffold) exists, content renders                                                                                                                |
| **Actual Result**   | [To be filled during execution]                                                                                                                              |
| **Status**          | ⬜ Not Run                                                                                                                                                   |
| **Risk Level**      | HIGH                                                                                                                                                         |

---

#### TC-002: Display Question Content

| Attribute           | Details                                                                                                                    |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-002                                                                                                                     |
| **Title**           | Question text displays correctly                                                                                           |
| **Objective**       | Verify question content rendered                                                                                           |
| **Preconditions**   | Quiz with questions loaded                                                                                                 |
| **Test Steps**      | 1. Build ExamScreen<br>2. Find question text<br>3. Verify exact question content displayed<br>4. Verify formatting correct |
| **Expected Result** | Question text visible and correct                                                                                          |
| **Pass Criteria**   | Question text findable and matches quiz data                                                                               |
| **Actual Result**   | [To be filled during execution]                                                                                            |
| **Status**          | ⬜ Not Run                                                                                                                 |
| **Risk Level**      | MEDIUM                                                                                                                     |

---

#### TC-003: Display Multiple Choice Options

| Attribute           | Details                                                                                                                                                                          |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-003                                                                                                                                                                           |
| **Title**           | Display all multiple choice answer options                                                                                                                                       |
| **Objective**       | Verify answer options rendered                                                                                                                                                   |
| **Preconditions**   | Question type is multipleChoice                                                                                                                                                  |
| **Test Steps**      | 1. Load multiple choice question<br>2. Find all answer options<br>3. Verify each option text displayed<br>4. Verify options are selectable<br>5. Verify correct count of options |
| **Expected Result** | All options visible and selectable                                                                                                                                               |
| **Pass Criteria**   | find.byWidget(RadioButton) count matches options                                                                                                                                 |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                  |
| **Status**          | ⬜ Not Run                                                                                                                                                                       |
| **Risk Level**      | MEDIUM                                                                                                                                                                           |

---

#### TC-004: Select Answer Option

| Attribute           | Details                                                                                                                            |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-004                                                                                                                             |
| **Title**           | User can select answer option                                                                                                      |
| **Objective**       | Verify answer selection works                                                                                                      |
| **Preconditions**   | Multiple choice question displayed                                                                                                 |
| **Test Steps**      | 1. Find answer option<br>2. Tap radio button<br>3. Pump widget<br>4. Verify option marked as selected<br>5. Verify visual feedback |
| **Expected Result** | Answer selection updates UI                                                                                                        |
| **Pass Criteria**   | Selected option visually highlighted                                                                                               |
| **Actual Result**   | [To be filled during execution]                                                                                                    |
| **Status**          | ⬜ Not Run                                                                                                                         |
| **Risk Level**      | HIGH                                                                                                                               |

---

#### TC-005: Change Selected Answer

| Attribute           | Details                                                                                                                                   |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-005                                                                                                                                    |
| **Title**           | User can change selected answer                                                                                                           |
| **Objective**       | Verify selection can be changed                                                                                                           |
| **Preconditions**   | Answer already selected                                                                                                                   |
| **Test Steps**      | 1. Select first option<br>2. Tap different option<br>3. Pump widget<br>4. Verify first option deselected<br>5. Verify new option selected |
| **Expected Result** | Selection updates to new choice                                                                                                           |
| **Pass Criteria**   | Only one option selected at time                                                                                                          |
| **Actual Result**   | [To be filled during execution]                                                                                                           |
| **Status**          | ⬜ Not Run                                                                                                                                |
| **Risk Level**      | MEDIUM                                                                                                                                    |

---

#### TC-006: True/False Question Type

| Attribute           | Details                                                                                                                                                      |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **ID**              | TC-006                                                                                                                                                       |
| **Title**           | Display true/false questions                                                                                                                                 |
| **Objective**       | Verify true/false question rendering                                                                                                                         |
| **Preconditions**   | Question type is trueOrFalse                                                                                                                                 |
| **Test Steps**      | 1. Load true/false question<br>2. Find True and False buttons/options<br>3. Verify both options present<br>4. Verify selectable<br>5. Test selection of each |
| **Expected Result** | True/false options displayed and selectable                                                                                                                  |
| **Pass Criteria**   | Both options findable and work                                                                                                                               |
| **Actual Result**   | [To be filled during execution]                                                                                                                              |
| **Status**          | ⬜ Not Run                                                                                                                                                   |
| **Risk Level**      | MEDIUM                                                                                                                                                       |

---

#### TC-007: Navigation with Back Button

| Attribute           | Details                                                                                                             |
| ------------------- | ------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-007                                                                                                              |
| **Title**           | AppBar back button navigates to home                                                                                |
| **Objective**       | Verify back button exits exam                                                                                       |
| **Preconditions**   | ExamScreen displayed                                                                                                |
| **Test Steps**      | 1. Find AppBar back button<br>2. Tap back button<br>3. Verify navigation called<br>4. Verify HomeScreen returned to |
| **Expected Result** | Back button exits exam mode                                                                                         |
| **Pass Criteria**   | Navigator.pop() called                                                                                              |
| **Actual Result**   | [To be filled during execution]                                                                                     |
| **Status**          | ⬜ Not Run                                                                                                          |
| **Risk Level**      | MEDIUM                                                                                                              |

---

#### TC-008: Submit/Finish Quiz Button

| Attribute           | Details                                                                                                                                         |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-008                                                                                                                                          |
| **Title**           | Submit quiz button submits answers                                                                                                              |
| **Objective**       | Verify submit functionality                                                                                                                     |
| **Preconditions**   | Quiz in progress                                                                                                                                |
| **Test Steps**      | 1. Answer some questions<br>2. Find Submit/Finish button<br>3. Tap submit button<br>4. Verify answers recorded<br>5. Verify results/score shown |
| **Expected Result** | Quiz submitted and results displayed                                                                                                            |
| **Pass Criteria**   | Results screen appears                                                                                                                          |
| **Actual Result**   | [To be filled during execution]                                                                                                                 |
| **Status**          | ⬜ Not Run                                                                                                                                      |
| **Risk Level**      | HIGH                                                                                                                                            |

---

#### TC-009: Progress Display

| Attribute           | Details                                                                                                                                                       |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-009                                                                                                                                                        |
| **Title**           | Display quiz progress                                                                                                                                         |
| **Objective**       | Show current question/progress                                                                                                                                |
| **Preconditions**   | Quiz with multiple questions                                                                                                                                  |
| **Test Steps**      | 1. Display question 1<br>2. Find progress indicator (e.g., '1 of 5')<br>3. Verify correct count<br>4. Navigate to next question<br>5. Verify progress updates |
| **Expected Result** | Progress displayed and updated                                                                                                                                |
| **Pass Criteria**   | Progress text matches current question                                                                                                                        |
| **Actual Result**   | [To be filled during execution]                                                                                                                               |
| **Status**          | ⬜ Not Run                                                                                                                                                    |
| **Risk Level**      | LOW                                                                                                                                                           |

---

#### TC-010: Next/Previous Question Navigation

| Attribute           | Details                                                                                                                                                          |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-010                                                                                                                                                           |
| **Title**           | Navigate between questions                                                                                                                                       |
| **Objective**       | Verify question navigation buttons                                                                                                                               |
| **Preconditions**   | Multi-question quiz                                                                                                                                              |
| **Test Steps**      | 1. Find Next button<br>2. Tap to go to next question<br>3. Verify question changed<br>4. Find Previous button<br>5. Tap to go back<br>6. Verify question changed |
| **Expected Result** | Can navigate forward and backward                                                                                                                                |
| **Pass Criteria**   | Questions change on button tap                                                                                                                                   |
| **Actual Result**   | [To be filled during execution]                                                                                                                                  |
| **Status**          | ⬜ Not Run                                                                                                                                                       |
| **Risk Level**      | MEDIUM                                                                                                                                                           |

---

#### TC-011: Disable Submit When No Answers

| Attribute           | Details                                                                                                                                                        |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-011                                                                                                                                                         |
| **Title**           | Submit disabled if questions unanswered                                                                                                                        |
| **Objective**       | Prevent submission without answers                                                                                                                             |
| **Preconditions**   | Quiz displayed without answers selected                                                                                                                        |
| **Test Steps**      | 1. Don't select any answers<br>2. Find Submit button<br>3. Verify button disabled or shows error<br>4. Select some answers<br>5. Verify button becomes enabled |
| **Expected Result** | Submit requires at least some answers                                                                                                                          |
| **Pass Criteria**   | Button disabled when no answers                                                                                                                                |
| **Actual Result**   | [To be filled during execution]                                                                                                                                |
| **Status**          | ⬜ Not Run                                                                                                                                                     |
| **Risk Level**      | MEDIUM                                                                                                                                                         |

---

#### TC-012: Preserve Answers on Navigation

| Attribute           | Details                                                                                                                |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-012                                                                                                                 |
| **Title**           | Answers preserved when navigating                                                                                      |
| **Objective**       | Verify selected answers not lost                                                                                       |
| **Preconditions**   | Question answered, navigate away                                                                                       |
| **Test Steps**      | 1. Answer question 1<br>2. Navigate to question 2<br>3. Navigate back to question 1<br>4. Verify answer still selected |
| **Expected Result** | Answers preserved across navigation                                                                                    |
| **Pass Criteria**   | Selected answer remains after navigation                                                                               |
| **Actual Result**   | [To be filled during execution]                                                                                        |
| **Status**          | ⬜ Not Run                                                                                                             |
| **Risk Level**      | MEDIUM                                                                                                                 |

---

#### TC-013: Score Calculation Display

| Attribute           | Details                                                                                                                                     |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-013                                                                                                                                      |
| **Title**           | Display score after submission                                                                                                              |
| **Objective**       | Show calculated quiz score                                                                                                                  |
| **Preconditions**   | Quiz submitted                                                                                                                              |
| **Test Steps**      | 1. Submit quiz<br>2. Find score display<br>3. Verify score visible<br>4. Verify score format (e.g., '4/5')<br>5. Verify percentage if shown |
| **Expected Result** | Score clearly displayed                                                                                                                     |
| **Pass Criteria**   | Score visible and formatted correctly                                                                                                       |
| **Actual Result**   | [To be filled during execution]                                                                                                             |
| **Status**          | ⬜ Not Run                                                                                                                                  |
| **Risk Level**      | MEDIUM                                                                                                                                      |

---

#### TC-014: Empty Quiz Handling

| Attribute           | Details                                                                                                   |
| ------------------- | --------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-014                                                                                                    |
| **Title**           | Handle quiz with no questions                                                                             |
| **Objective**       | Graceful handling of empty quiz                                                                           |
| **Preconditions**   | currentQuiz has empty questions list                                                                      |
| **Test Steps**      | 1. Mock empty quiz<br>2. Build ExamScreen<br>3. Verify error message or placeholder<br>4. Verify no crash |
| **Expected Result** | Empty quiz handled gracefully                                                                             |
| **Pass Criteria**   | No crash, user feedback provided                                                                          |
| **Actual Result**   | [To be filled during execution]                                                                           |
| **Status**          | ⬜ Not Run                                                                                                |
| **Risk Level**      | MEDIUM                                                                                                    |

---

### 8. TEST COVERAGE MATRIX

| Requirement             | Test Case | Status |
| ----------------------- | --------- | ------ |
| Screen initialization   | TC-001    | ⬜     |
| Question display        | TC-002    | ⬜     |
| Multiple choice options | TC-003    | ⬜     |
| Answer selection        | TC-004    | ⬜     |
| Change selection        | TC-005    | ⬜     |
| True/false questions    | TC-006    | ⬜     |
| Back navigation         | TC-007    | ⬜     |
| Submit functionality    | TC-008    | ⬜     |
| Progress display        | TC-009    | ⬜     |
| Question navigation     | TC-010    | ⬜     |
| Submit validation       | TC-011    | ⬜     |
| Answer preservation     | TC-012    | ⬜     |
| Score display           | TC-013    | ⬜     |
| Empty quiz handling     | TC-014    | ⬜     |

---

### 9. RISK ASSESSMENT

| Risk                             | Probability | Impact | Mitigation                       |
| -------------------------------- | ----------- | ------ | -------------------------------- |
| Answer selection not persisting  | MEDIUM      | HIGH   | Test state management thoroughly |
| Score calculation errors         | MEDIUM      | HIGH   | Add unit tests for scoring logic |
| Gesture recognition issues       | MEDIUM      | MEDIUM | Use pumpAndSettle() in tests     |
| Layout issues on different sizes | MEDIUM      | MEDIUM | Test multiple screen sizes       |

---

### 10. DEFECT LOG

| Defect ID | Severity | Description | Status |
| --------- | -------- | ----------- | ------ |
|           |          |             |        |

---

### 11. TEST EXECUTION SUMMARY

**Total Test Cases:** 14  
**Passed:** 0  
**Failed:** 0  
**Blocked:** 0  
**Not Run:** 14

**Overall Status:** ⬜ NOT STARTED

---

### 12. SIGN-OFF

| Role             | Name | Date | Signature |
| ---------------- | ---- | ---- | --------- |
| Test Lead        |      |      |           |
| QA Manager       |      |      |           |
| Development Lead |      |      |           |
