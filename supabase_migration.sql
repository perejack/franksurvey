-- =====================================================
-- SUPABASE MIGRATION SCRIPT
-- Run this in your new Supabase project SQL Editor
-- =====================================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =====================================================
-- TABLE: profiles
-- =====================================================
CREATE TABLE IF NOT EXISTS profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT NOT NULL,
    full_name TEXT NOT NULL,
    phone_number TEXT,
    is_active BOOLEAN DEFAULT FALSE,
    package_id TEXT DEFAULT 'basic',
    balance INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Policies for profiles
CREATE POLICY "Users can view own profile" 
    ON profiles FOR SELECT 
    USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" 
    ON profiles FOR UPDATE 
    USING (auth.uid() = id);

-- Allow trigger/service role to insert (bypasses RLS with SECURITY DEFINER)
CREATE POLICY "Service role can insert profiles" 
    ON profiles FOR INSERT 
    WITH CHECK (TRUE);

-- =====================================================
-- TABLE: packages
-- =====================================================
CREATE TABLE IF NOT EXISTS packages (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    price INTEGER NOT NULL,
    daily_earning_limit INTEGER NOT NULL,
    features TEXT[] DEFAULT '{}',
    color TEXT,
    badge TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE packages ENABLE ROW LEVEL SECURITY;

-- Policies for packages (public read, admin write)
CREATE POLICY "Packages are viewable by everyone" 
    ON packages FOR SELECT 
    USING (TRUE);

-- Insert default packages with daily earning limits for gamification
INSERT INTO packages (id, name, price, daily_earning_limit, features, color, badge) VALUES
('basic', 'Basic', 0, 2000, 
 ARRAY['Access to 5 free surveys', 'Standard support', 'Daily earning limit: KSH 2,000', 'Unlock individual tasks'], 
 'gray', 'FREE'),
('starter', 'Starter', 250, 3500, 
 ARRAY['Access to 15 surveys', 'Priority support', 'Daily earning limit: KSH 3,500', 'No unlock fees', 'Faster withdrawals'], 
 'blue', 'BEST VALUE'),
('pro', 'Pro', 500, 5000, 
 ARRAY['Access to 25 surveys', 'VIP support', 'Daily earning limit: KSH 5,000', 'Premium surveys', 'Instant withdrawals'], 
 'primary', 'POPULAR'),
('elite', 'Elite', 1000, 10000, 
 ARRAY['Unlimited survey access', 'Dedicated support', 'Unlimited daily earnings', 'All premium surveys', 'Instant withdrawals', 'Exclusive offers'], 
 'accent', 'PREMIUM')
ON CONFLICT (id) DO NOTHING;

-- =====================================================
-- TABLE: surveys
-- =====================================================
CREATE TABLE IF NOT EXISTS surveys (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    description TEXT,
    category TEXT NOT NULL,
    reward INTEGER NOT NULL,
    duration TEXT,
    questions_count INTEGER DEFAULT 5,
    is_premium BOOLEAN DEFAULT FALSE,
    required_package TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    unlock_price INTEGER DEFAULT NULL,
    is_locked BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE surveys ENABLE ROW LEVEL SECURITY;

-- Policies for surveys (public read for active surveys)
CREATE POLICY "Active surveys are viewable by everyone" 
    ON surveys FOR SELECT 
    USING (is_active = TRUE);

-- =====================================================
-- TABLE: survey_responses
-- =====================================================
CREATE TABLE IF NOT EXISTS survey_responses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    survey_id UUID NOT NULL REFERENCES surveys(id) ON DELETE CASCADE,
    answers JSONB NOT NULL,
    completed_at TIMESTAMPTZ DEFAULT NOW(),
    reward_earned INTEGER NOT NULL,
    UNIQUE(user_id, survey_id)
);

-- Enable RLS
ALTER TABLE survey_responses ENABLE ROW LEVEL SECURITY;

-- Policies for survey_responses
CREATE POLICY "Users can view own survey responses" 
    ON survey_responses FOR SELECT 
    USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own survey responses" 
    ON survey_responses FOR INSERT 
    WITH CHECK (auth.uid() = user_id);

-- =====================================================
-- TABLE: transactions
-- =====================================================
CREATE TABLE IF NOT EXISTS transactions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    type TEXT NOT NULL CHECK (type IN ('withdrawal', 'activation', 'upgrade', 'survey_earning')),
    amount INTEGER NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'completed', 'failed')),
    phone_number TEXT,
    reference TEXT,
    description TEXT NOT NULL,
    survey_id UUID REFERENCES surveys(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    completed_at TIMESTAMPTZ
);

-- Enable RLS
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;

-- Policies for transactions
CREATE POLICY "Users can view own transactions" 
    ON transactions FOR SELECT 
    USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own transactions" 
    ON transactions FOR INSERT 
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own transactions" 
    ON transactions FOR UPDATE 
    USING (auth.uid() = user_id);

-- =====================================================
-- FUNCTION: get_user_balance
-- =====================================================
CREATE OR REPLACE FUNCTION get_user_balance(user_uuid UUID)
RETURNS INTEGER AS $$
DECLARE
    total_earnings INTEGER;
    total_withdrawals INTEGER;
    balance INTEGER;
BEGIN
    -- Calculate total earnings from surveys
    SELECT COALESCE(SUM(reward_earned), 0) INTO total_earnings
    FROM survey_responses
    WHERE user_id = user_uuid;

    -- Calculate total withdrawals and payments
    SELECT COALESCE(SUM(amount), 0) INTO total_withdrawals
    FROM transactions
    WHERE user_id = user_uuid 
    AND type IN ('withdrawal', 'activation', 'upgrade')
    AND status = 'completed';

    -- Calculate balance
    balance := total_earnings - total_withdrawals;
    
    RETURN balance;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =====================================================
-- TRIGGER: Update updated_at on profiles
-- =====================================================
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_profiles_updated_at
    BEFORE UPDATE ON profiles
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- =====================================================
-- FUNCTION: Auto-create profile on signup
-- =====================================================
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.profiles (id, email, full_name, phone_number, is_active, package_id)
    VALUES (
        NEW.id, 
        NEW.email, 
        COALESCE(NEW.raw_user_meta_data->>'full_name', ''),
        COALESCE(NEW.raw_user_meta_data->>'phone_number', NULL),
        FALSE,
        'basic'
    )
    ON CONFLICT (id) DO NOTHING;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to auto-create profile
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_new_user();

-- =====================================================
-- INDEXES for performance
-- =====================================================
CREATE INDEX IF NOT EXISTS idx_surveys_category ON surveys(category);
CREATE INDEX IF NOT EXISTS idx_surveys_is_active ON surveys(is_active);
CREATE INDEX IF NOT EXISTS idx_survey_responses_user_id ON survey_responses(user_id);
CREATE INDEX IF NOT EXISTS idx_survey_responses_survey_id ON survey_responses(survey_id);
CREATE INDEX IF NOT EXISTS idx_transactions_user_id ON transactions(user_id);
CREATE INDEX IF NOT EXISTS idx_transactions_type ON transactions(type);
CREATE INDEX IF NOT EXISTS idx_transactions_status ON transactions(status);

-- =====================================================
-- MIGRATION COMPLETE
-- =====================================================
