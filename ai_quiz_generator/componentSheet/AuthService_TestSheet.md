# COMPONENT TEST SHEET

## AI Quiz Generator - AuthService Component

### 1. COMPONENT IDENTIFICATION

- **Component Name:** AuthService
- **Component Type:** Data Service / Business Logic
- **Version:** 1.0
- **Location:** lib/data/services/auth_service.dart
- **Owner:** Authentication Services Team
- **Dependencies:**
  - SharedPreferences (local storage)
  - User Model
  - Built-in Dart libraries

---

### 2. COMPONENT OVERVIEW

AuthService provides authentication and session management functionality:

- Credential validation against stored users
- User registration with username/password persistence
- Session management (create, restore, clear)
- Username availability checking
- Local persistent authentication using SharedPreferences
- Admin default credentials support

---

### 3. TEST OBJECTIVES

- Verify successful credential validation
- Test rejection of invalid credentials
- Ensure user registration persists correctly
- Validate username availability checking
- Test session creation and restoration
- Verify logout clears session
- Ensure data integrity with multiple users
- Test edge cases and error conditions
- Verify SharedPreferences integration

---

### 4. TEST SCOPE

**In Scope:**

- validateCredentials() method
- register() method
- checkUsernameAvailability() method
- manageSession() method (create/update session)
- currentUser() method (retrieve session)
- logout() method (clear session)
- User data persistence
- Admin credentials hardcoded support
- User lookup and comparison

**Out of Scope:**

- SharedPreferences implementation details
- Password encryption algorithms
- Network-based authentication
- Third-party auth providers (OAuth, etc.)

---

### 5. TEST ENVIRONMENT & RESOURCES

**Required Setup:**

- Flutter test framework
- Mockito for mocking SharedPreferences
- Test fixtures for User objects
- Test data with various username/password combinations
- Isolated test environment for SharedPreferences

**Tools:**

- Flutter test runner
- Code coverage analyzer

---

### 6. ENTRY/EXIT CRITERIA

**Entry Criteria:**

- User model finalized
- SharedPreferences mock configured
- Test data prepared
- Test environment isolated

**Exit Criteria:**

- All test cases passed
- Code coverage ≥ 85%
- No critical/high-severity defects
- Edge cases tested

---

### 7. TEST CASES

#### TC-001: Validate Credentials - Admin User

| Attribute           | Details                                                                                                                                                                                                     |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-001                                                                                                                                                                                                      |
| **Title**           | Validate admin default credentials                                                                                                                                                                          |
| **Objective**       | Verify admin/admin credentials accepted                                                                                                                                                                     |
| **Preconditions**   | AuthService initialized, no user registration needed                                                                                                                                                        |
| **Test Steps**      | 1. Call validateCredentials('admin', 'admin')<br>2. Verify method returns true<br>3. Verify no SharedPreferences calls made<br>4. Call validateCredentials('admin', 'wrongpass')<br>5. Verify returns false |
| **Expected Result** | Admin credentials validated successfully                                                                                                                                                                    |
| **Pass Criteria**   | validateCredentials('admin', 'admin') returns true                                                                                                                                                          |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                             |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                  |
| **Risk Level**      | MEDIUM (security - hardcoded creds)                                                                                                                                                                         |

---

#### TC-002: Validate Credentials - Registered User

| Attribute           | Details                                                                                                                                                                                           |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-002                                                                                                                                                                                            |
| **Title**           | Validate credentials for registered user                                                                                                                                                          |
| **Objective**       | Verify stored user credentials match on login                                                                                                                                                     |
| **Preconditions**   | User 'testuser' registered with password 'password123'                                                                                                                                            |
| **Test Steps**      | 1. Register user via register() method<br>2. Call validateCredentials('testuser', 'password123')<br>3. Verify returns true<br>4. Verify \_loadUsers() called<br>5. Verify username/password match |
| **Expected Result** | Registered user credentials validated successfully                                                                                                                                                |
| **Pass Criteria**   | validateCredentials returns true for correct password                                                                                                                                             |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                   |
| **Status**          | ⬜ Not Run                                                                                                                                                                                        |
| **Risk Level**      | HIGH (core functionality)                                                                                                                                                                         |

---

#### TC-003: Reject Invalid Credentials - Wrong Password

| Attribute           | Details                                                                                                                                                       |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-003                                                                                                                                                        |
| **Title**           | Reject login with wrong password                                                                                                                              |
| **Objective**       | Verify incorrect password is rejected                                                                                                                         |
| **Preconditions**   | User registered with known password                                                                                                                           |
| **Test Steps**      | 1. Call validateCredentials('testuser', 'wrongpassword')<br>2. Verify returns false<br>3. Verify no user session created<br>4. Verify error handling graceful |
| **Expected Result** | Invalid credentials rejected                                                                                                                                  |
| **Pass Criteria**   | validateCredentials returns false                                                                                                                             |
| **Actual Result**   | [To be filled during execution]                                                                                                                               |
| **Status**          | ⬜ Not Run                                                                                                                                                    |
| **Risk Level**      | HIGH (security)                                                                                                                                               |

---

#### TC-004: Reject Invalid Credentials - Non-existent User

| Attribute           | Details                                                                                                                                                    |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-004                                                                                                                                                     |
| **Title**           | Reject login for non-existent user                                                                                                                         |
| **Objective**       | Verify non-registered username is rejected                                                                                                                 |
| **Preconditions**   | User doesn't exist in system                                                                                                                               |
| **Test Steps**      | 1. Call validateCredentials('nonexistentuser', 'anypass')<br>2. Verify returns false<br>3. Verify error handling graceful<br>4. Verify no exception thrown |
| **Expected Result** | Non-existent user rejected                                                                                                                                 |
| **Pass Criteria**   | validateCredentials returns false                                                                                                                          |
| **Actual Result**   | [To be filled during execution]                                                                                                                            |
| **Status**          | ⬜ Not Run                                                                                                                                                 |
| **Risk Level**      | HIGH (security)                                                                                                                                            |

---

#### TC-005: Register New User Successfully

| Attribute           | Details                                                                                                                                                                                                                                               |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-005                                                                                                                                                                                                                                                |
| **Title**           | Successfully register new user                                                                                                                                                                                                                        |
| **Objective**       | Verify user registration persists credentials                                                                                                                                                                                                         |
| **Preconditions**   | AuthService initialized, username available                                                                                                                                                                                                           |
| **Test Steps**      | 1. Create User object with username='newuser', password='newpass'<br>2. Call register(user)<br>3. Verify \_saveUsers() called<br>4. Verify credentials saved to SharedPreferences<br>5. Verify validateCredentials('newuser', 'newpass') returns true |
| **Expected Result** | User successfully registered and credentials persisted                                                                                                                                                                                                |
| **Pass Criteria**   | User saved to storage and retrievable                                                                                                                                                                                                                 |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                                                       |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                                                            |
| **Risk Level**      | HIGH (core functionality)                                                                                                                                                                                                                             |

---

#### TC-006: Register Multiple Users

| Attribute           | Details                                                                                                                                                                                                                                 |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-006                                                                                                                                                                                                                                  |
| **Title**           | Register and maintain multiple users                                                                                                                                                                                                    |
| **Objective**       | Verify multiple users can coexist in storage                                                                                                                                                                                            |
| **Preconditions**   | AuthService initialized                                                                                                                                                                                                                 |
| **Test Steps**      | 1. Register user1, user2, user3 with different passwords<br>2. Verify each user retrievable with correct password<br>3. Verify wrong password rejected for each<br>4. Verify admin still works<br>5. Verify no cross-user contamination |
| **Expected Result** | Multiple users independently validated                                                                                                                                                                                                  |
| **Pass Criteria**   | All users individually validated correctly                                                                                                                                                                                              |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                                         |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                                              |
| **Risk Level**      | MEDIUM                                                                                                                                                                                                                                  |

---

#### TC-007: Check Username Availability

| Attribute           | Details                                                                                                                                                                                            |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-007                                                                                                                                                                                             |
| **Title**           | Check username availability before registration                                                                                                                                                    |
| **Objective**       | Verify duplicate usernames prevented                                                                                                                                                               |
| **Preconditions**   | User 'existinguser' already registered                                                                                                                                                             |
| **Test Steps**      | 1. Call checkUsernameAvailability('existinguser')<br>2. Verify returns false<br>3. Call checkUsernameAvailability('newuser')<br>4. Verify returns true<br>5. Verify \_loadUsers() called correctly |
| **Expected Result** | Username availability correctly checked                                                                                                                                                            |
| **Pass Criteria**   | Returns false for existing, true for available                                                                                                                                                     |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                    |
| **Status**          | ⬜ Not Run                                                                                                                                                                                         |
| **Risk Level**      | MEDIUM                                                                                                                                                                                             |

---

#### TC-008: Create Session Successfully

| Attribute           | Details                                                                                                                                                                                                               |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-008                                                                                                                                                                                                                |
| **Title**           | Create user session on login                                                                                                                                                                                          |
| **Objective**       | Verify user session persisted via manageSession                                                                                                                                                                       |
| **Preconditions**   | User object created                                                                                                                                                                                                   |
| **Test Steps**      | 1. Create User object with userId, username<br>2. Call manageSession(user)<br>3. Verify \_setString() called with \_sessionKey<br>4. Verify user JSON serialized correctly<br>5. Verify JSON contains all user fields |
| **Expected Result** | Session created and persisted                                                                                                                                                                                         |
| **Pass Criteria**   | SharedPreferences.setString() called with correct data                                                                                                                                                                |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                       |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                            |
| **Risk Level**      | MEDIUM                                                                                                                                                                                                                |

---

#### TC-009: Restore Session from Storage

| Attribute           | Details                                                                                                                                                                                            |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-009                                                                                                                                                                                             |
| **Title**           | Restore user session from persistent storage                                                                                                                                                       |
| **Objective**       | Verify currentUser retrieves stored session                                                                                                                                                        |
| **Preconditions**   | Valid user session in SharedPreferences                                                                                                                                                            |
| **Test Steps**      | 1. Create and save session via manageSession()<br>2. Call currentUser()<br>3. Verify returns User object<br>4. Verify userId, username match saved values<br>5. Verify no exceptions on valid data |
| **Expected Result** | Session restored with correct user data                                                                                                                                                            |
| **Pass Criteria**   | currentUser() returns User with correct values                                                                                                                                                     |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                    |
| **Status**          | ⬜ Not Run                                                                                                                                                                                         |
| **Risk Level**      | MEDIUM                                                                                                                                                                                             |

---

#### TC-010: Handle Missing Session Gracefully

| Attribute           | Details                                                                                                                                   |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-010                                                                                                                                    |
| **Title**           | Handle missing session without error                                                                                                      |
| **Objective**       | Verify null returned when no session exists                                                                                               |
| **Preconditions**   | No session in SharedPreferences                                                                                                           |
| **Test Steps**      | 1. Verify SharedPreferences doesn't have \_sessionKey<br>2. Call currentUser()<br>3. Verify returns null<br>4. Verify no exception thrown |
| **Expected Result** | Null returned gracefully for missing session                                                                                              |
| **Pass Criteria**   | currentUser() returns null without error                                                                                                  |
| **Actual Result**   | [To be filled during execution]                                                                                                           |
| **Status**          | ⬜ Not Run                                                                                                                                |
| **Risk Level**      | MEDIUM                                                                                                                                    |

---

#### TC-011: Handle Corrupted Session Data

| Attribute           | Details                                                                                                                                                                        |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **ID**              | TC-011                                                                                                                                                                         |
| **Title**           | Handle corrupted JSON session data                                                                                                                                             |
| **Objective**       | Verify graceful failure on invalid JSON                                                                                                                                        |
| **Preconditions**   | Invalid JSON in session storage                                                                                                                                                |
| **Test Steps**      | 1. Mock SharedPreferences to return invalid JSON<br>2. Call currentUser()<br>3. Verify returns null (not exception)<br>4. Verify error caught and logged<br>5. Verify no crash |
| **Expected Result** | Corrupted data handled gracefully                                                                                                                                              |
| **Pass Criteria**   | Returns null, no exception thrown                                                                                                                                              |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                |
| **Status**          | ⬜ Not Run                                                                                                                                                                     |
| **Risk Level**      | MEDIUM                                                                                                                                                                         |

---

#### TC-012: Logout Clears Session

| Attribute           | Details                                                                                                                                                          |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-012                                                                                                                                                           |
| **Title**           | Logout removes session from storage                                                                                                                              |
| **Objective**       | Verify session completely cleared on logout                                                                                                                      |
| **Preconditions**   | Valid session in SharedPreferences                                                                                                                               |
| **Test Steps**      | 1. Verify currentUser() returns valid user<br>2. Call logout()<br>3. Verify remove(\_sessionKey) called<br>4. Call currentUser() again<br>5. Verify returns null |
| **Expected Result** | Session completely removed on logout                                                                                                                             |
| **Pass Criteria**   | SharedPreferences.remove() called with \_sessionKey                                                                                                              |
| **Actual Result**   | [To be filled during execution]                                                                                                                                  |
| **Status**          | ⬜ Not Run                                                                                                                                                       |
| **Risk Level**      | HIGH (security)                                                                                                                                                  |

---

#### TC-013: Case Sensitivity in Credentials

| Attribute           | Details                                                                                                                                                                                                                                                                       |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **ID**              | TC-013                                                                                                                                                                                                                                                                        |
| **Title**           | Verify case sensitivity in username/password                                                                                                                                                                                                                                  |
| **Objective**       | Ensure passwords/usernames are case-sensitive                                                                                                                                                                                                                                 |
| **Preconditions**   | User registered with 'TestUser' and 'PassWord123'                                                                                                                                                                                                                             |
| **Test Steps**      | 1. Try validateCredentials('testuser', 'PassWord123')<br>2. Verify returns false (case mismatch in username)<br>3. Try validateCredentials('TestUser', 'password123')<br>4. Verify returns false (case mismatch in password)<br>5. Try correct case<br>6. Verify returns true |
| **Expected Result** | Credentials are case-sensitive                                                                                                                                                                                                                                                |
| **Pass Criteria**   | Case variations rejected except exact match                                                                                                                                                                                                                                   |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                                                                               |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                                                                                    |
| **Risk Level**      | LOW                                                                                                                                                                                                                                                                           |

---

#### TC-014: Empty Username/Password Handling

| Attribute           | Details                                                                                                                                                                                                            |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **ID**              | TC-014                                                                                                                                                                                                             |
| **Title**           | Handle empty username or password                                                                                                                                                                                  |
| **Objective**       | Verify empty credentials are rejected                                                                                                                                                                              |
| **Preconditions**   | AuthService initialized                                                                                                                                                                                            |
| **Test Steps**      | 1. Call validateCredentials('', 'password')<br>2. Verify returns false<br>3. Call validateCredentials('username', '')<br>4. Verify returns false<br>5. Call validateCredentials('', '')<br>6. Verify returns false |
| **Expected Result** | Empty credentials rejected                                                                                                                                                                                         |
| **Pass Criteria**   | All empty combinations return false                                                                                                                                                                                |
| **Actual Result**   | [To be filled during execution]                                                                                                                                                                                    |
| **Status**          | ⬜ Not Run                                                                                                                                                                                                         |
| **Risk Level**      | LOW                                                                                                                                                                                                                |

---

### 8. TEST COVERAGE MATRIX

| Requirement                   | Test Case              | Status |
| ----------------------------- | ---------------------- | ------ |
| Admin credential validation   | TC-001                 | ⬜     |
| User credential validation    | TC-002, TC-006         | ⬜     |
| Reject invalid credentials    | TC-003, TC-004         | ⬜     |
| User registration             | TC-005, TC-006         | ⬜     |
| Username availability         | TC-007                 | ⬜     |
| Session creation              | TC-008                 | ⬜     |
| Session restoration           | TC-009                 | ⬜     |
| Missing session handling      | TC-010                 | ⬜     |
| Corrupted data handling       | TC-011                 | ⬜     |
| Logout functionality          | TC-012                 | ⬜     |
| Case sensitivity              | TC-013                 | ⬜     |
| Empty input handling          | TC-014                 | ⬜     |
| SharedPreferences integration | TC-008, TC-009, TC-012 | ⬜     |

---

### 9. RISK ASSESSMENT

| Risk                                | Probability | Impact   | Mitigation                                 |
| ----------------------------------- | ----------- | -------- | ------------------------------------------ |
| Hardcoded admin credentials         | HIGH        | HIGH     | Document security implications, plan OAuth |
| Password stored plaintext           | HIGH        | CRITICAL | Implement hashing (bcrypt/argon2)          |
| SharedPreferences unencrypted       | HIGH        | CRITICAL | Use encrypted_shared_preferences           |
| SQL injection via SharedPreferences | LOW         | MEDIUM   | Use structured JSON, validate on parse     |
| Session fixation attacks            | MEDIUM      | HIGH     | Add session tokens, expiration             |
| Concurrent auth operations          | MEDIUM      | MEDIUM   | Add locking mechanism                      |

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
