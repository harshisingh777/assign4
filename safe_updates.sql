-- =====================================================================
-- TASK 1: SAFE UPDATE OPERATIONS WITH VERIFICATION
-- SYSTEM: CodeJudge Staging Environment
-- =====================================================================

-- --- UPDATE 1: Correcting Malformed Email Domains ---
-- Before State Verification:
SELECT student_id, name, email FROM students WHERE email = 'rohan_at_masai.com';

-- Safe Execution: Target strictly via unique Primary Key
UPDATE students 
SET email = 'rohan@masai.com' 
WHERE student_id = 1001;

-- After State Verification:
SELECT student_id, name, email FROM students WHERE student_id = 1001;
-- Safety Justification: The WHERE clause targets 'student_id = 1001', the unique 
-- Primary Key. This guarantees no other student record is altered.


-- --- UPDATE 2: Resetting Negative Values to Structural Zero ---
-- Before State Verification:
SELECT problem_id, title, max_score FROM problems WHERE max_score < 0;

-- Safe Execution: Targeted boundary limit normalization
UPDATE problems 
SET max_score = 0 
WHERE max_score < 0;

-- After State Verification:
SELECT problem_id, title, max_score FROM problems WHERE max_score = 0;
-- Safety Justification: The clause matches exclusively rows violating domain constraints 
-- (< 0), leaving all valid positive scoring problem metrics untouched.


-- --- UPDATE 3: Setting Default Values for Unassigned Profiles ---
-- Before State Verification:
SELECT student_id, name, email FROM students WHERE name IS NULL OR name = '';

-- Safe Execution: Explicit identification of target rows
UPDATE students 
SET name = 'Anonymous Student' 
WHERE student_id = 3091;

-- After State Verification:
SELECT student_id, name, email FROM students WHERE student_id = 3091;
-- Safety Justification: Uses the unique 'student_id' PK to pinpoint the specific row, 
-- preventing unintended bulk renames.


-- --- UPDATE 4: Normalizing Extreme Plagiarism Score Variances ---
-- Before State Verification:
SELECT flag_id, similarity_score FROM plagiarism_flags WHERE similarity_score > 100.0;

-- Safe Execution: Broad upper bound safety restriction
UPDATE plagiarism_flags 
SET similarity_score = 100.0 
WHERE similarity_score > 100.0;

-- After State Verification:
SELECT flag_id, similarity_score FROM plagiarism_flags WHERE flag_id = 881;
-- Safety Justification: Restricting the filter explicitly to values > 100.0 isolates 
-- only corrupted calculations, protecting compliant rows.
