-- Update Banking Services unlock price to 10 KSH for testing
UPDATE surveys 
SET unlock_price = 10 
WHERE title = 'Banking Services';
