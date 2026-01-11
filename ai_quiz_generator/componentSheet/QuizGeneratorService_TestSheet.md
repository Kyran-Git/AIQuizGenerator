# COMPONENT TEST SHEET

## AI Quiz Generator - QuizGeneratorService Component

### 1. COMPONENT IDENTIFICATION

- **Component Name:** QuizGeneratorService / GeminiQuizGeneratorService
- **Component Type:** Business Logic Service
- **Version:** 1.0
- **Location:** lib/data/services/quiz_generator_service.dart
- **Owner:** AI Integration Team
- **Dependencies:**
  - GeminiApi (Gemini API client)
  - QuizSettings (configuration model)
  - DifficultyLevel enum
  - QuestionType enum
  - Question model

---

### 2. COMPONENT OVERVIEW

QuizGeneratorService generates quiz questions using Gemini AI:

- Maps difficulty levels to temperature values for API
- Builds AI prompts based on quiz settings
- Generates questions via Gemini API
- Handles retry callbacks for error scenarios
- Parses API responses into Question objects
- Supports multiple question types and difficulty levels

---

### 3. TEST OBJECTIVES

- Verify quiz generation with various difficulty levels
- Test prompt generation for different parameters
- Validate temperature mapping to difficulty
- Test retry callback mechanism
- Verify question parsing from API response
- Test error handling and recovery
- Validate question count accuracy
- Test different question types

---

### 4. TEST SCOPE

**In Scope:**

- generateQuiz() method
- \_difficultyToTemperature() mapping
- \_buildPrompt() prompt construction
- Question list generation
- Retry callback invocation
- QuizSettings parameter handling
- Response parsing and validation

**Out of Scope:**

- Actual Gemini API responses (mocked)
- Network implementation details
- JSON serialization internals
- Rate limiting details

---

### 5. TEST ENVIRONMENT & RESOURCES

**Required Setup:**

- Flutter test framework
- Mockito for mocking GeminiApi
- Test fixtures for QuizSettings
- Mock Gemini API responses
- Sample JSON response templates

**Tools:**

- Flutter test runner
- Code coverage analyzer

---

### 6. ENTRY/EXIT CRITERIA

**Entry Criteria:**

- GeminiApi interface stable
- QuizSettings finalized
- Mock responses prepared
- Test environment configured

**Exit Criteria:**

- All test cases passed
- Code coverage ≥ 80%
- All difficulty levels tested
- Retry mechanism verified

---

### 7. TEST CASES

#### TC-001: Generate Quiz with Easy Difficulty

| Attribute           | Details                                                                                                                                                                                                                                                                           |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-001                                                                                                                                                                                                                                                                            |
| **Title**           | Generate quiz with easy difficulty                                                                                                                                                                                                                                                |
| **Objective**       | Verify quiz generation with easy level (low temperature)                                                                                                                                                                                                                          |
| **Preconditions**   | GeminiApi mocked to return valid response                                                                                                                                                                                                                                         |
| **Test Steps**      | 1. Create QuizSettings with difficulty=easy<br>2. Call generateQuiz(settings)<br>3. Verify \_difficultyToTemperature() returns 0.3<br>4. Verify geminiApi.sendPrompt() called with temp=0.3<br>5. Verify questions list returned<br>6. Verify questions are simpler/deterministic |
| **Expected Result** | Quiz generated with easy difficulty                                                                                                                                                                                                                                               |
| **Pass Criteria**   | Questions returned, temperature == 0.3                                                                                                                                                                                                                                            |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                                                                                   |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                                                                                        |
| **Risk Level**      | HIGH (core functionality)                                                                                                                                                                                                                                                         |

---

#### TC-002: Generate Quiz with Medium Difficulty

| Attribute           | Details                                                                                                                                                                                                                                  |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-002                                                                                                                                                                                                                                   |
| **Title**           | Generate quiz with medium difficulty                                                                                                                                                                                                     |
| **Objective**       | Verify quiz generation with medium level (medium temperature)                                                                                                                                                                            |
| **Preconditions**   | GeminiApi mocked to return valid response                                                                                                                                                                                                |
| **Test Steps**      | 1. Create QuizSettings with difficulty=medium<br>2. Call generateQuiz(settings)<br>3. Verify \_difficultyToTemperature() returns 0.7<br>4. Verify geminiApi.sendPrompt() called with temp=0.7<br>5. Verify balanced difficulty questions |
| **Expected Result** | Quiz generated with medium difficulty                                                                                                                                                                                                    |
| **Pass Criteria**   | Questions returned, temperature == 0.7                                                                                                                                                                                                   |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                                          |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                                               |
| **Risk Level**      | HIGH (core functionality)                                                                                                                                                                                                                |

---

#### TC-003: Generate Quiz with Hard Difficulty

| Attribute           | Details                                                                                                                                                                                                                             |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-003                                                                                                                                                                                                                              |
| **Title**           | Generate quiz with hard difficulty                                                                                                                                                                                                  |
| **Objective**       | Verify quiz generation with hard level (high temperature)                                                                                                                                                                           |
| **Preconditions**   | GeminiApi mocked to return valid response                                                                                                                                                                                           |
| **Test Steps**      | 1. Create QuizSettings with difficulty=hard<br>2. Call generateQuiz(settings)<br>3. Verify \_difficultyToTemperature() returns 1.5<br>4. Verify geminiApi.sendPrompt() called with temp=1.5<br>5. Verify complex/creative questions |
| **Expected Result** | Quiz generated with hard difficulty                                                                                                                                                                                                 |
| **Pass Criteria**   | Questions returned, temperature == 1.5                                                                                                                                                                                              |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                                     |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                                          |
| **Risk Level**      | HIGH (core functionality)                                                                                                                                                                                                           |

---

#### TC-004: Difficulty to Temperature Mapping

| Attribute           | Details                                                                                                                                                                                                                                       |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-004                                                                                                                                                                                                                                        |
| **Title**           | Verify temperature mapping for all difficulties                                                                                                                                                                                               |
| **Objective**       | Test \_difficultyToTemperature() switch logic                                                                                                                                                                                                 |
| **Preconditions**   | Service initialized                                                                                                                                                                                                                           |
| **Test Steps**      | 1. Call \_difficultyToTemperature(easy)<br>2. Verify returns 0.3<br>3. Call \_difficultyToTemperature(medium)<br>4. Verify returns 0.7<br>5. Call \_difficultyToTemperature(hard)<br>6. Verify returns 1.5<br>7. Test all enum values covered |
| **Expected Result** | All difficulties map to correct temperatures                                                                                                                                                                                                  |
| **Pass Criteria**   | All mappings correct, no defaults hit                                                                                                                                                                                                         |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                                               |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                                                    |
| **Risk Level**      | LOW                                                                                                                                                                                                                                           |

---

#### TC-005: Correct Prompt Generation

| Attribute           | Details                                                                                                                                                                                                                                                                           |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-005                                                                                                                                                                                                                                                                            |
| **Title**           | Verify prompt construction from settings                                                                                                                                                                                                                                          |
| **Objective**       | Test \_buildPrompt() creates correct AI prompt                                                                                                                                                                                                                                    |
| **Preconditions**   | QuizSettings with all fields set                                                                                                                                                                                                                                                  |
| **Test Steps**      | 1. Create QuizSettings with topic='Biology', count=5, type=multipleChoice<br>2. Call \_buildPrompt(settings)<br>3. Verify prompt contains topic<br>4. Verify prompt contains question count<br>5. Verify prompt specifies question type<br>6. Verify prompt is properly formatted |
| **Expected Result** | Prompt correctly constructed from settings                                                                                                                                                                                                                                        |
| **Pass Criteria**   | Prompt contains all required information                                                                                                                                                                                                                                          |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                                                                                   |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                                                                                        |
| **Risk Level**      | MEDIUM                                                                                                                                                                                                                                                                            |

---

#### TC-006: Question Count Accuracy

| Attribute           | Details                                                                                                                                                                                            |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-006                                                                                                                                                                                             |
| **Title**           | Verify correct number of questions generated                                                                                                                                                       |
| **Objective**       | Ensure returned list has requested question count                                                                                                                                                  |
| **Preconditions**   | GeminiApi mocked to return correct count                                                                                                                                                           |
| **Test Steps**      | 1. Create QuizSettings with numQuestions=5<br>2. Call generateQuiz(settings)<br>3. Verify returned list.length == 5<br>4. Repeat with different counts (3, 10, 20)<br>5. Verify accuracy each time |
| **Expected Result** | Correct number of questions returned                                                                                                                                                               |
| **Pass Criteria**   | Returned list length matches requested count                                                                                                                                                       |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                    |
| **Status**          | ⬜ Not Run                                                                                                                                                                                         |
| **Risk Level**      | MEDIUM                                                                                                                                                                                             |

---

#### TC-007: Question Type in Response

| Attribute           | Details                                                                                                                                                                                                              |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-007                                                                                                                                                                                                               |
| **Title**           | Verify questions have correct type                                                                                                                                                                                   |
| **Objective**       | Test questions match requested type                                                                                                                                                                                  |
| **Preconditions**   | Settings specify multipleChoice type                                                                                                                                                                                 |
| **Test Steps**      | 1. Create QuizSettings with type=multipleChoice<br>2. Call generateQuiz(settings)<br>3. Verify each question has type=multipleChoice<br>4. Test with type=trueOrFalse<br>5. Verify all questions are true/false type |
| **Expected Result** | All questions match requested type                                                                                                                                                                                   |
| **Pass Criteria**   | Each question.type matches settings.type                                                                                                                                                                             |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                      |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                           |
| **Risk Level**      | MEDIUM                                                                                                                                                                                                               |

---

#### TC-008: Retry Callback Invocation

| Attribute           | Details                                                                                                                                                                                                                                                 |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-008                                                                                                                                                                                                                                                  |
| **Title**           | Verify retry callback called on API failure                                                                                                                                                                                                             |
| **Objective**       | Test onRetry callback mechanism                                                                                                                                                                                                                         |
| **Preconditions**   | GeminiApi mocked to fail then succeed                                                                                                                                                                                                                   |
| **Test Steps**      | 1. Create callback function to track calls<br>2. Call generateQuiz(settings, onRetry: callback)<br>3. Verify callback called with attempt and error<br>4. Verify callback receives correct exception type<br>5. Verify quiz still generated after retry |
| **Expected Result** | Retry callback invoked with correct parameters                                                                                                                                                                                                          |
| **Pass Criteria**   | Callback called with attempt >= 1 and error object                                                                                                                                                                                                      |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                                                         |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                                                              |
| **Risk Level**      | MEDIUM                                                                                                                                                                                                                                                  |

---

#### TC-009: Response Parsing to Question Objects

| Attribute           | Details                                                                                                                                                                                                          |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-009                                                                                                                                                                                                           |
| **Title**           | Verify API response correctly parsed to Questions                                                                                                                                                                |
| **Objective**       | Test JSON response converted to Question model                                                                                                                                                                   |
| **Preconditions**   | Mock response with valid JSON structure                                                                                                                                                                          |
| **Test Steps**      | 1. Mock Gemini response with question data<br>2. Call generateQuiz(settings)<br>3. Verify response parsed to Question objects<br>4. Verify all Question fields populated<br>5. Verify no data loss in conversion |
| **Expected Result** | API response correctly converted to Question list                                                                                                                                                                |
| **Pass Criteria**   | All questions have valid data, no nulls                                                                                                                                                                          |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                  |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                       |
| **Risk Level**      | MEDIUM                                                                                                                                                                                                           |

---

#### TC-010: Handle Empty Response

| Attribute           | Details                                                                                                                                                                                       |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-010                                                                                                                                                                                        |
| **Title**           | Handle empty or null API response                                                                                                                                                             |
| **Objective**       | Test graceful handling of no questions returned                                                                                                                                               |
| **Preconditions**   | GeminiApi mocked to return empty list                                                                                                                                                         |
| **Test Steps**      | 1. Mock GeminiApi to return empty response<br>2. Call generateQuiz(settings)<br>3. Verify returns empty list (not null)<br>4. Verify no exception thrown<br>5. Verify error handling graceful |
| **Expected Result** | Empty response handled gracefully                                                                                                                                                             |
| **Pass Criteria**   | Returns empty List, no exception                                                                                                                                                              |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                               |
| **Status**          | ⬜ Not Run                                                                                                                                                                                    |
| **Risk Level**      | MEDIUM                                                                                                                                                                                        |

---

#### TC-011: Malformed Response Handling

| Attribute           | Details                                                                                                                                                                                          |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **ID**              | TC-011                                                                                                                                                                                           |
| **Title**           | Handle malformed API response                                                                                                                                                                    |
| **Objective**       | Test error handling for invalid JSON                                                                                                                                                             |
| **Preconditions**   | GeminiApi mocked to return invalid JSON                                                                                                                                                          |
| **Test Steps**      | 1. Mock response with missing required fields<br>2. Call generateQuiz(settings)<br>3. Verify exception thrown or handled<br>4. Verify error details logged<br>5. Verify no partial data returned |
| **Expected Result** | Malformed response handled safely                                                                                                                                                                |
| **Pass Criteria**   | Exception caught and reported appropriately                                                                                                                                                      |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                  |
| **Status**          | ⬜ Not Run                                                                                                                                                                                       |
| **Risk Level**      | HIGH (error handling)                                                                                                                                                                            |

---

#### TC-012: Multiple Question Types

| Attribute           | Details                                                                                                                                                                             |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-012                                                                                                                                                                              |
| **Title**           | Generate quiz with different question types                                                                                                                                         |
| **Objective**       | Verify all QuestionType enum values supported                                                                                                                                       |
| **Preconditions**   | GeminiApi mocked for each type                                                                                                                                                      |
| **Test Steps**      | 1. Test generateQuiz with each QuestionType value<br>2. Verify prompt includes correct type<br>3. Verify questions returned for each type<br>4. Verify type consistency in response |
| **Expected Result** | All question types successfully generated                                                                                                                                           |
| **Pass Criteria**   | All types produce valid questions                                                                                                                                                   |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                     |
| **Status**          | ⬜ Not Run                                                                                                                                                                          |
| **Risk Level**      | MEDIUM                                                                                                                                                                              |

---

### 8. TEST COVERAGE MATRIX

| Requirement                  | Test Case              | Status |
| ---------------------------- | ---------------------- | ------ |
| Easy difficulty generation   | TC-001                 | ⬜     |
| Medium difficulty generation | TC-002                 | ⬜     |
| Hard difficulty generation   | TC-003                 | ⬜     |
| Temperature mapping          | TC-004                 | ⬜     |
| Prompt construction          | TC-005                 | ⬜     |
| Question count accuracy      | TC-006                 | ⬜     |
| Question type handling       | TC-007, TC-012         | ⬜     |
| Retry callback               | TC-008                 | ⬜     |
| Response parsing             | TC-009                 | ⬜     |
| Empty response handling      | TC-010                 | ⬜     |
| Error handling               | TC-011                 | ⬜     |
| GeminiApi integration        | TC-001, TC-002, TC-003 | ⬜     |

---

### 9. RISK ASSESSMENT

| Risk                                    | Probability | Impact | Mitigation                          |
| --------------------------------------- | ----------- | ------ | ----------------------------------- |
| Gemini API format changes               | MEDIUM      | HIGH   | Version API, plan migration path    |
| Temperature values ineffective          | MEDIUM      | MEDIUM | A/B test difficulty perception      |
| Response parsing failures               | MEDIUM      | MEDIUM | Validate schema, add error recovery |
| Retry infinite loop                     | LOW         | HIGH   | Add max attempt limit               |
| Memory issues with large question lists | LOW         | MEDIUM | Stream results if needed            |

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
