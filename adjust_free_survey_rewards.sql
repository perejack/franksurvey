-- Update free survey rewards so 13 surveys total ~1000 KSH
-- This ensures users hit the earning cap (1000) before reaching withdrawal (1500)
-- Each survey reward ~77 KSH (1000/13 ≈ 77)

-- First, let's see current free surveys and their rewards
SELECT id, title, reward, is_premium, is_locked 
FROM surveys 
WHERE is_premium = false AND is_locked = false
ORDER BY created_at
LIMIT 13;

-- Update free survey rewards to total approximately 1000 KSH
-- We'll set varying amounts between 70-85 KSH
UPDATE surveys SET reward = 75 WHERE is_premium = false AND is_locked = false AND id IN (
  SELECT id FROM surveys WHERE is_premium = false AND is_locked = false ORDER BY created_at LIMIT 13 OFFSET 0
);

UPDATE surveys SET reward = 78 WHERE is_premium = false AND is_locked = false AND id IN (
  SELECT id FROM surveys WHERE is_premium = false AND is_locked = false ORDER BY created_at LIMIT 1 OFFSET 0
);

UPDATE surveys SET reward = 76 WHERE is_premium = false AND is_locked = false AND id IN (
  SELECT id FROM surveys WHERE is_premium = false AND is_locked = false ORDER BY created_at LIMIT 1 OFFSET 1
);

UPDATE surveys SET reward = 77 WHERE is_premium = false AND is_locked = false AND id IN (
  SELECT id FROM surveys WHERE is_premium = false AND is_locked = false ORDER BY created_at LIMIT 1 OFFSET 2
);

UPDATE surveys SET reward = 78 WHERE is_premium = false AND is_locked = false AND id IN (
  SELECT id FROM surveys WHERE is_premium = false AND is_locked = false ORDER BY created_at LIMIT 1 OFFSET 3
);

UPDATE surveys SET reward = 76 WHERE is_premium = false AND is_locked = false AND id IN (
  SELECT id FROM surveys WHERE is_premium = false AND is_locked = false ORDER BY created_at LIMIT 1 OFFSET 4
);

UPDATE surveys SET reward = 77 WHERE is_premium = false AND is_locked = false AND id IN (
  SELECT id FROM surveys WHERE is_premium = false AND is_locked = false ORDER BY created_at LIMIT 1 OFFSET 5
);

UPDATE surveys SET reward = 78 WHERE is_premium = false AND is_locked = false AND id IN (
  SELECT id FROM surveys WHERE is_premium = false AND is_locked = false ORDER BY created_at LIMIT 1 OFFSET 6
);

UPDATE surveys SET reward = 76 WHERE is_premium = false AND is_locked = false AND id IN (
  SELECT id FROM surveys WHERE is_premium = false AND is_locked = false ORDER BY created_at LIMIT 1 OFFSET 7
);

UPDATE surveys SET reward = 77 WHERE is_premium = false AND is_locked = false AND id IN (
  SELECT id FROM surveys WHERE is_premium = false AND is_locked = false ORDER BY created_at LIMIT 1 OFFSET 8
);

UPDATE surveys SET reward = 78 WHERE is_premium = false AND is_locked = false AND id IN (
  SELECT id FROM surveys WHERE is_premium = false AND is_locked = false ORDER BY created_at LIMIT 1 OFFSET 9
);

UPDATE surveys SET reward = 76 WHERE is_premium = false AND is_locked = false AND id IN (
  SELECT id FROM surveys WHERE is_premium = false AND is_locked = false ORDER BY created_at LIMIT 1 OFFSET 10
);

UPDATE surveys SET reward = 77 WHERE is_premium = false AND is_locked = false AND id IN (
  SELECT id FROM surveys WHERE is_premium = false AND is_locked = false ORDER BY created_at LIMIT 1 OFFSET 11
);

UPDATE surveys SET reward = 78 WHERE is_premium = false AND is_locked = false AND id IN (
  SELECT id FROM surveys WHERE is_premium = false AND is_locked = false ORDER BY created_at LIMIT 1 OFFSET 12
);

-- Verify the total
SELECT 
    COUNT(*) as survey_count,
    SUM(reward) as total_reward,
    AVG(reward)::INTEGER as avg_reward
FROM surveys 
WHERE is_premium = false AND is_locked = false;
