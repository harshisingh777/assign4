### File 6: `README.md`
```markdown
# CodeJudge Reliability & Transaction Suite — Part 4

This directory contains safe update and delete scripts, explicit multi-scenario transaction blocks, and an incident mitigation note.

## Navigation Matrix
* `safe_updates.sql`: Verified data alteration queries using primary key constraints.
* `safe_deletes.sql`: Target isolation delete scripts.
* `transactions.sql`: Safe database operations demonstrating `COMMIT`, `ROLLBACK`, and `SAVEPOINT`.
* `acid_explanation.md`: Architectural analysis of ACID properties.
* `incident_note.md`: Root cause analysis and disaster recovery procedures for unrestricted queries.
