# Database Reliability Incident Report Note

### 1. Root Cause Summary
A database operator intended to clean test accounts in a production environment, but mistakenly executed a bulk operation without including a restrictive `WHERE` clause:
```sql
DELETE FROM students;
