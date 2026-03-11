-- Fix the constraint issue - first check existing types

-- See all distinct types currently in the database
SELECT DISTINCT type, COUNT(*) as count 
FROM transactions 
GROUP BY type;

-- See the actual constraint definition
SELECT conname, pg_get_constraintdef(oid) as definition
FROM pg_constraint 
WHERE conrelid = 'transactions'::regclass;
