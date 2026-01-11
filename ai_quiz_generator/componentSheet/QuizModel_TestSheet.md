# COMPONENT TEST SHEET

## AI Quiz Generator - Quiz Model Component

### 1. COMPONENT IDENTIFICATION

- **Component Name:** Quiz Model
- **Component Type:** Data Model / Entity
- **Version:** 1.0
- **Location:** lib/data/models/quiz.dart
- **Owner:** Data Modeling Team
- **Dependencies:**
  - Question Model
  - QuizSettings Model
  - User ID reference

---

### 2. COMPONENT OVERVIEW

Quiz model represents a complete quiz entity:

- Quiz identification and metadata
- User association
- Title/topic information
- Collection of questions
- Quiz configuration settings
- JSON serialization/deserialization
- Data validation

---

### 3. TEST OBJECTIVES

- Verify model creation with valid data
- Test JSON serialization
- Test JSON deserialization
- Validate all fields properly assigned
- Test nested object handling
- Verify data integrity
- Test edge cases (empty lists, special chars)
- Ensure type consistency

---

### 4. TEST SCOPE

**In Scope:**

- Quiz constructor
- fromJson factory constructor
- toJson method
- All model properties
- Nested Question objects
- QuizSettings object
- JSON encoding/decoding

**Out of Scope:**

- Database persistence
- Network transmission
- Encryption
- Performance optimization

---

### 5. TEST ENVIRONMENT & RESOURCES

**Required Setup:**

- Flutter test framework
- Test fixtures for Question objects
- Sample JSON data
- QuizSettings test objects

**Tools:**

- Flutter test runner
- JSON validation

---

### 6. TEST ENTRY/EXIT CRITERIA

**Entry Criteria:**

- Models defined
- Dependencies available
- Test data prepared

**Exit Criteria:**

- All tests passed
- 100% coverage (small model)
- All fields tested

---

### 7. TEST CASES

#### TC-001: Create Quiz with Valid Data

| Attribute           | Details                                                                                                                                                  |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-001                                                                                                                                                   |
| **Title**           | Create quiz with all valid fields                                                                                                                        |
| **Objective**       | Verify Quiz constructor works                                                                                                                            |
| **Preconditions**   | Question and QuizSettings objects created                                                                                                                |
| **Test Steps**      | 1. Create Question list<br>2. Create QuizSettings<br>3. Create Quiz with all fields<br>4. Verify all properties set correctly<br>5. Verify no exceptions |
| **Expected Result** | Quiz object created successfully                                                                                                                         |
| **Pass Criteria**   | All properties match input values                                                                                                                        |
| **Actual Result**   | [To be filled during execution]                                                                                                                          |
| **Status**          | ⬜ Not Run                                                                                                                                               |
| **Risk Level**      | HIGH (core)                                                                                                                                              |

---

#### TC-002: Quiz Fields Accessible

| Attribute           | Details                                                                                                                                                            |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **ID**              | TC-002                                                                                                                                                             |
| **Title**           | All quiz properties accessible                                                                                                                                     |
| **Objective**       | Verify property getters work                                                                                                                                       |
| **Preconditions**   | Quiz object created                                                                                                                                                |
| **Test Steps**      | 1. Access quiz.id<br>2. Access quiz.userId<br>3. Access quiz.title<br>4. Access quiz.questions<br>5. Access quiz.settings<br>6. Verify each returns expected value |
| **Expected Result** | All properties accessible                                                                                                                                          |
| **Pass Criteria**   | No exceptions, values correct                                                                                                                                      |
| **Actual Result**   | [To be filled during execution]                                                                                                                                    |
| **Status**          | ⬜ Not Run                                                                                                                                                         |
| **Risk Level**      | LOW                                                                                                                                                                |

---

#### TC-003: Serialize Quiz to JSON

| Attribute           | Details                                                                                                                                                                                                        |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-003                                                                                                                                                                                                         |
| **Title**           | Convert quiz to JSON map                                                                                                                                                                                       |
| **Objective**       | Verify toJson() works correctly                                                                                                                                                                                |
| **Preconditions**   | Quiz object with data                                                                                                                                                                                          |
| **Test Steps**      | 1. Create quiz with data<br>2. Call toJson()<br>3. Verify returns Map<String, dynamic><br>4. Verify contains 'quizId' key<br>5. Verify contains 'userId', 'title', etc.<br>6. Verify no null values unexpected |
| **Expected Result** | JSON map created correctly                                                                                                                                                                                     |
| **Pass Criteria**   | All fields in JSON, correct format                                                                                                                                                                             |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                     |
| **Risk Level**      | HIGH (serialization)                                                                                                                                                                                           |

---

#### TC-004: Deserialize Quiz from JSON

| Attribute           | Details                                                                                                                                                           |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-004                                                                                                                                                            |
| **Title**           | Create quiz from JSON map                                                                                                                                         |
| **Objective**       | Verify fromJson() works                                                                                                                                           |
| **Preconditions**   | Valid JSON map with quiz data                                                                                                                                     |
| **Test Steps**      | 1. Create JSON map with quiz fields<br>2. Call Quiz.fromJson(json)<br>3. Verify Quiz object created<br>4. Verify all fields match JSON<br>5. Verify no exceptions |
| **Expected Result** | Quiz reconstructed from JSON                                                                                                                                      |
| **Pass Criteria**   | Created object matches source data                                                                                                                                |
| **Actual Result**   | [To be filled during execution]                                                                                                                                   |
| **Status**          | ⬜ Not Run                                                                                                                                                        |
| **Risk Level**      | HIGH (deserialization)                                                                                                                                            |

---

#### TC-005: JSON Round-trip Consistency

| Attribute           | Details                                                                                                                                                    |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-005                                                                                                                                                     |
| **Title**           | Quiz survives JSON serialization round-trip                                                                                                                |
| **Objective**       | Verify no data loss in serialize/deserialize                                                                                                               |
| **Preconditions**   | Quiz object with complex data                                                                                                                              |
| **Test Steps**      | 1. Create original quiz<br>2. Call toJson() to get map<br>3. Call fromJson() to recreate<br>4. Compare original vs recreated<br>5. Verify all data matches |
| **Expected Result** | Data preserved through cycle                                                                                                                               |
| **Pass Criteria**   | Original equals recreated                                                                                                                                  |
| **Actual Result**   | [To be filled during execution]                                                                                                                            |
| **Status**          | ⬜ Not Run                                                                                                                                                 |
| **Risk Level**      | HIGH (data integrity)                                                                                                                                      |

---

#### TC-006: Handle Empty Questions List

| Attribute           | Details                                                                                                                                                                       |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-006                                                                                                                                                                        |
| **Title**           | Handle quiz with no questions                                                                                                                                                 |
| **Objective**       | Verify empty questions list works                                                                                                                                             |
| **Preconditions**   | Quiz created with empty questions                                                                                                                                             |
| **Test Steps**      | 1. Create quiz with questions=[]<br>2. Verify quiz created<br>3. Verify questions.isEmpty == true<br>4. Serialize to JSON<br>5. Deserialize<br>6. Verify empty list preserved |
| **Expected Result** | Empty questions handled correctly                                                                                                                                             |
| **Pass Criteria**   | Empty list preserved in serialization                                                                                                                                         |
| **Actual Result**   | [To be filled during execution]                                                                                                                                               |
| **Status**          | ⬜ Not Run                                                                                                                                                                    |
| **Risk Level**      | MEDIUM                                                                                                                                                                        |

---

#### TC-007: Handle Special Characters in Title

| Attribute           | Details                                                                                                                                                                                       |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-007                                                                                                                                                                                        |
| **Title**           | Handle special characters in quiz title                                                                                                                                                       |
| **Objective**       | Verify special chars don't break JSON                                                                                                                                                         |
| **Preconditions**   | Quiz model created                                                                                                                                                                            |
| **Test Steps**      | 1. Create quiz with title containing special chars: "Test \"quotes\" & symbols"<br>2. Call toJson()<br>3. Verify JSON valid<br>4. Call fromJson()<br>5. Verify title matches original exactly |
| **Expected Result** | Special characters preserved                                                                                                                                                                  |
| **Pass Criteria**   | Title matches after round-trip                                                                                                                                                                |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                               |
| **Status**          | ⬜ Not Run                                                                                                                                                                                    |
| **Risk Level**      | MEDIUM                                                                                                                                                                                        |

---

#### TC-008: Handle Unicode Characters

| Attribute           | Details                                                                                                                                       |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-008                                                                                                                                        |
| **Title**           | Handle unicode characters                                                                                                                     |
| **Objective**       | Verify unicode preserved in JSON                                                                                                              |
| **Preconditions**   | Quiz model created                                                                                                                            |
| **Test Steps**      | 1. Create quiz with unicode: "生物学 Quiz" (Biology in Chinese)<br>2. Serialize to JSON<br>3. Deserialize<br>4. Verify title matches original |
| **Expected Result** | Unicode characters preserved                                                                                                                  |
| **Pass Criteria**   | Unicode matches after round-trip                                                                                                              |
| **Actual Result**   | [To be filled during execution]                                                                                                               |
| **Status**          | ⬜ Not Run                                                                                                                                    |
| **Risk Level**      | LOW                                                                                                                                           |

---

#### TC-009: Missing Optional Fields in JSON

| Attribute           | Details                                                                                                                                                          |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-009                                                                                                                                                           |
| **Title**           | Handle missing optional fields                                                                                                                                   |
| **Objective**       | Graceful handling of incomplete JSON                                                                                                                             |
| **Preconditions**   | JSON without some fields                                                                                                                                         |
| **Test Steps**      | 1. Create incomplete JSON (missing title)<br>2. Call fromJson()<br>3. Verify defaults applied or null<br>4. Verify no exception<br>5. Verify object still usable |
| **Expected Result** | Incomplete JSON handled gracefully                                                                                                                               |
| **Pass Criteria**   | No exception, object created                                                                                                                                     |
| **Actual Result**   | [To be filled during execution]                                                                                                                                  |
| **Status**          | ⬜ Not Run                                                                                                                                                       |
| **Risk Level**      | MEDIUM                                                                                                                                                           |

---

#### TC-010: Large Questions Count

| Attribute           | Details                                                                                                                                                                                     |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-010                                                                                                                                                                                      |
| **Title**           | Handle quiz with many questions                                                                                                                                                             |
| **Objective**       | Verify performance with large question count                                                                                                                                                |
| **Preconditions**   | Can create 100 questions                                                                                                                                                                    |
| **Test Steps**      | 1. Create quiz with 100 questions<br>2. Serialize to JSON<br>3. Verify JSON valid and complete<br>4. Deserialize<br>5. Verify all 100 questions present<br>6. Verify performance acceptable |
| **Expected Result** | Large quizzes handled efficiently                                                                                                                                                           |
| **Pass Criteria**   | All questions preserved, no timeouts                                                                                                                                                        |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                             |
| **Status**          | ⬜ Not Run                                                                                                                                                                                  |
| **Risk Level**      | MEDIUM                                                                                                                                                                                      |

---

#### TC-011: Null Settings Object

| Attribute           | Details                                                                                                                               |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-011                                                                                                                                |
| **Title**           | Handle null or missing settings                                                                                                       |
| **Objective**       | Graceful handling of missing settings                                                                                                 |
| **Preconditions**   | Quiz or JSON without settings                                                                                                         |
| **Test Steps**      | 1. Create JSON without settings field<br>2. Call fromJson()<br>3. Verify handles gracefully<br>4. Verify default QuizSettings or null |
| **Expected Result** | Missing settings handled                                                                                                              |
| **Pass Criteria**   | No exception thrown                                                                                                                   |
| **Actual Result**   | [To be filled during execution]                                                                                                       |
| **Status**          | ⬜ Not Run                                                                                                                            |
| **Risk Level**      | MEDIUM                                                                                                                                |

---

#### TC-012: Nested Question Object Serialization

| Attribute           | Details                                                                                                                                                                   |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-012                                                                                                                                                                    |
| **Title**           | Questions properly serialized in quiz                                                                                                                                     |
| **Objective**       | Verify Question.toJson() called correctly                                                                                                                                 |
| **Preconditions**   | Questions with complex data                                                                                                                                               |
| **Test Steps**      | 1. Create quiz with questions containing answers<br>2. Call toJson()<br>3. Verify questions array in JSON<br>4. Verify each question serialized<br>5. Verify no data loss |
| **Expected Result** | Nested questions properly serialized                                                                                                                                      |
| **Pass Criteria**   | Questions array complete and valid                                                                                                                                        |
| **Actual Result**   | [To be filled during execution]                                                                                                                                           |
| **Status**          | ⬜ Not Run                                                                                                                                                                |
| **Risk Level**      | HIGH                                                                                                                                                                      |

---

### 8. TEST COVERAGE MATRIX

| Requirement          | Test Case | Status |
| -------------------- | --------- | ------ |
| Object creation      | TC-001    | ⬜     |
| Property access      | TC-002    | ⬜     |
| Serialization        | TC-003    | ⬜     |
| Deserialization      | TC-004    | ⬜     |
| Round-trip fidelity  | TC-005    | ⬜     |
| Empty questions      | TC-006    | ⬜     |
| Special characters   | TC-007    | ⬜     |
| Unicode support      | TC-008    | ⬜     |
| Missing fields       | TC-009    | ⬜     |
| Large datasets       | TC-010    | ⬜     |
| Null handling        | TC-011    | ⬜     |
| Nested serialization | TC-012    | ⬜     |

---

### 9. RISK ASSESSMENT

| Risk                           | Probability | Impact | Mitigation                       |
| ------------------------------ | ----------- | ------ | -------------------------------- |
| JSON schema changes            | MEDIUM      | HIGH   | Version JSON, migration strategy |
| Performance with large quizzes | LOW         | MEDIUM | Lazy load if needed              |
| Character encoding issues      | LOW         | MEDIUM | Test with various character sets |

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
