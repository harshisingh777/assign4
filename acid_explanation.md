# ACID Properties Evaluation Analysis

This document uses **Scenario 1** from `transactions.sql` (submitting code alongside execution metrics) to explain how ACID rules maintain the reliability of the CodeJudge system.

### 1. Atomicity ("All or Nothing")
Atomicity guarantees that the code payload submission record and its plagiarism verification rows are treated as a single, indivisible unit of work. If the platform inserts the submission row but suffers an unexpected infrastructure crash before writing the plagiarism flag, the entire operation is discarded. The system prevents a half-saved state.

### 2. Consistency
Consistency ensures that a transaction shifts the database from one valid state to another, preserving all schema constraints. In Scenario 1, if the submission insert attempts to reference an invalid `student_id` or violates a unique constraint, the transaction fails structural checks and aborts, ensuring data integrity is never compromised.

### 3. Isolation
Isolation ensures that concurrent transactions execute without interfering with one delayed process. If a separate background calculation is auditing overall student averages while Scenario 1 runs, it will not see intermediate, uncommitted changes. It will read either the complete pre-transaction state or the post-commit state.

### 4. Durability
Durability guarantees that once a transaction receives a successful `COMMIT` confirmation, its changes are written to persistent storage. Even if the host server experiences a sudden power loss seconds later, the submission log remains intact within the database's write-ahead logs (WAL).
