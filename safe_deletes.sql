-- =====================================================================
-- TASK 2: SAFE DELETE OPERATIONS WITH VERIFICATION
-- =====================================================================

-- --- DELETE 1: Purging Explicit Duplicate Staging Registrations ---
-- Identification Step: Find the redundant entry
SELECT student_id, batch_id, COUNT(*) 
FROM enrollments 
WHERE student_id = 1021 AND batch_id = 5;

-- Safe Execution: Explicitly filter by primary composite key combination
DELETE FROM enrollments 
WHERE student_id = 1021 
  AND batch_id = 5;

-- Verification Step: Confirm exactly zero or single valid entry remains
SELECT student_id, batch_id FROM enrollments WHERE student_id = 1021 AND batch_id = 5;
-- Safety Justification: The composite intersection uniquely identifies a distinct 
-- pairing instance, ensuring other student schedules remain intact.


-- --- DELETE 2: Removing Detached Orphan Plagiarism Flags ---
-- Identification Step: Isolate flags whose matching submission record does not exist
SELECT flag_id FROM plagiarism_flags 
WHERE submission_id NOT IN (SELECT submission_id FROM submissions);

-- Safe Execution: Explicit isolation criteria matching the pre-check
DELETE FROM plagiarism_flags 
WHERE submission_id NOT IN (SELECT submission_id FROM submissions);

-- Verification Step:
SELECT COUNT(*) FROM plagiarism_flags WHERE submission_id NOT IN (SELECT submission_id FROM submissions);
-- Safety Justification: The subquery safely restricts deletion to unlinked flags, 
-- preventing data loss among active submission audits.
