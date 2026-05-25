-- =====================================================================
-- TASK 3: TRANSACTION SCENARIOS (COMMIT, ROLLBACK & SAVEPOINTS)
-- =====================================================================

-- --- SCENARIO 1: Student Code Submission with Complete Commit ---
BEGIN TRANSACTION;

INSERT INTO submissions (submission_id, student_id, problem_id, language, code_payload) 
VALUES (50001, 1001, 42, 'Python', 'def solve(): return True');

INSERT INTO plagiarism_flags (flag_id, submission_id, similarity_score) 
VALUES (90001, 50001, 12.5);

COMMIT;
-- Expected Final State: Both the submission payload and its accompanying security 
-- analysis metrics are written permanently to disk.


-- --- SCENARIO 2: Aborted Enrollment Process due to Validation Failure ---
BEGIN TRANSACTION;

INSERT INTO enrollments (student_id, batch_id) 
VALUES (9999, 5); 

-- Structural Check: Validation script detects student 9999 does not exist in the system.
-- Enforcing intentional data rollback:
ROLLBACK;
-- Expected Final State: The database instantly discards the insert, leaving the 
-- enrollments matrix in its clean pre-transaction state.


-- --- SCENARIO 3: Multi-tier Problem Insertions with SAVEPOINT Rollback ---
BEGIN TRANSACTION;

INSERT INTO problems (problem_id, title, difficulty, max_score) 
VALUES (601, 'Basic Array Reversal', 'Easy', 50);

SAVEPOINT step_one;

-- Attempting a high-risk bulk addition that is found to be malformed:
INSERT INTO problems (problem_id, title, difficulty, max_score) 
VALUES (602, 'Corrupt Graph Problem', 'InvalidDiff', -100);

-- Roll back the invalid secondary change while preserving the valid first step:
ROLLBACK TO SAVEPOINT step_one;

COMMIT;
-- Expected Final State: Problem 601 is safely committed, while the corrupted 
-- details of Problem 602 are discarded.
