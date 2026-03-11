import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { motion, AnimatePresence } from "framer-motion";
import { ArrowLeft, FolderOpen, Sparkles, Loader2, Download, X, TrendingUp } from "lucide-react";
import { supabase } from "@/lib/supabase";
import SurveyCard from "@/components/SurveyCard";
import { useAuth } from "@/contexts/AuthContext";
import WalletCard from "@/components/WalletCard";
import WithdrawModal from "@/components/WithdrawModal";
import ActivateAccountModal from "@/components/ActivateAccountModal";

interface Survey {
  id: string;
  title: string;
  category: string;
  reward: number;
  duration: string;
  questions_count: number;
  description?: string;
  is_premium: boolean;
  is_locked: boolean;
  unlock_price: number | null;
  created_at: string;
}

const CATEGORY_NAMES: Record<string, string> = {
  data_entry: 'Data Entry',
  market_research: 'Market Research',
  customer_feedback: 'Customer Feedback',
  product_review: 'Product Review',
  opinion_poll: 'Opinion Polls'
};

const CATEGORY_POTENTIAL: Record<string, number> = {
  data_entry: 950,
  market_research: 1330,
  customer_feedback: 1830,
  product_review: 2330,
  opinion_poll: 2830
};

export default function ExtraSurveys() {
  const navigate = useNavigate();
  const { profile, refreshProfile } = useAuth();
  const [surveys, setSurveys] = useState<Survey[]>([]);
  const [completedIds, setCompletedIds] = useState<Set<string>>(new Set());
  const [unlockedCategories, setUnlockedCategories] = useState<string[]>([]);
  const [loading, setLoading] = useState(true);
  const [hasAccess, setHasAccess] = useState(false);
  const [balance, setBalance] = useState(0);
  const [earnings, setEarnings] = useState(0);
  const [showWithdraw, setShowWithdraw] = useState(false);
  const [showActivate, setShowActivate] = useState(false);
  const [showMinWithdrawal, setShowMinWithdrawal] = useState(false);

  useEffect(() => {
    if (!profile?.id) return;
    
    async function checkAccessAndLoad() {
      // Get balance
      const { data: balanceData } = await supabase
        .rpc('get_user_balance', { user_uuid: profile.id });
      setBalance(balanceData || 0);

      // Get today's earnings
      const today = new Date().toISOString().split('T')[0];
      const { data: todayEarnings } = await supabase
        .from('transactions')
        .select('amount')
        .eq('user_id', profile.id)
        .eq('type', 'survey_earning')
        .eq('status', 'completed')
        .gte('completed_at', today);
      
      const todayTotal = todayEarnings?.reduce((sum, t) => sum + (t.amount || 0), 0) || 0;
      setEarnings(todayTotal);
      // Check if user has unlocked any categories
      const { data: unlockTxs } = await supabase
        .from('transactions')
        .select('category')
        .eq('user_id', profile.id)
        .eq('type', 'category_unlock')
        .eq('status', 'completed');
      
      const categories = unlockTxs?.map(tx => tx.category).filter(Boolean) || [];
      setUnlockedCategories(categories);
      
      // Only allow access if user has paid to unlock categories
      if (categories.length === 0) {
        navigate('/');
        return;
      }
      setHasAccess(true);

      // Get completed surveys
      const { data: completed } = await supabase
        .from('survey_responses')
        .select('survey_id')
        .eq('user_id', profile.id);
      
      setCompletedIds(new Set(completed?.map(c => c.survey_id) || []));

      // Load surveys from unlocked categories that are locked and not premium
      const { data: surveyData } = await supabase
        .from('surveys')
        .select('*')
        .in('category', categories)
        .eq('is_locked', true)
        .eq('is_premium', false);
      
      if (surveyData) {
        setSurveys(surveyData);
      }
      
      setLoading(false);
      // Refresh balance after completing surveys
      await refreshProfile();
      const { data: newBalance } = await supabase
        .rpc('get_user_balance', { user_uuid: profile.id });
      setBalance(newBalance || 0);

      // Refresh today's earnings
      const todayDate = new Date().toISOString().split('T')[0];
      const { data: newEarnings } = await supabase
        .from('transactions')
        .select('amount')
        .eq('user_id', profile.id)
        .eq('type', 'survey_earning')
        .eq('status', 'completed')
        .gte('completed_at', todayDate);
      const newTodayTotal = newEarnings?.reduce((sum, t) => sum + (t.amount || 0), 0) || 0;
      setEarnings(newTodayTotal);
    }
    
    checkAccessAndLoad();
  }, [profile?.id, navigate, refreshProfile]);

  // Group surveys by category
  const surveysByCategory = surveys.reduce((acc, survey) => {
    if (!acc[survey.category]) {
      acc[survey.category] = [];
    }
    acc[survey.category].push(survey);
    return acc;
  }, {} as Record<string, Survey[]>);

  if (loading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <Loader2 className="animate-spin text-primary" size={32} />
      </div>
    );
  }

  if (!hasAccess) return null;

  return (
    <div className="min-h-screen bg-background pb-24">
      {/* Header with Wallet Card */}
      <div className="px-5 pt-6 pb-4">
        <div className="flex items-center gap-3 mb-4">
          <motion.button
            whileTap={{ scale: 0.9 }}
            onClick={() => navigate("/")}
            className="w-10 h-10 rounded-2xl bg-card border border-border flex items-center justify-center"
          >
            <ArrowLeft size={20} className="text-foreground" />
          </motion.button>
          <div>
            <h1 className="text-xl font-bold text-foreground">Extra Surveys</h1>
            <p className="text-sm text-muted-foreground">Unlocked surveys - no locks!</p>
          </div>
        </div>

        {/* Wallet Card - Same as Homepage */}
        <WalletCard balance={balance} earnings={earnings} />

        {/* Withdraw Button */}
        <button
          onClick={() => {
            if (balance < 2500) {
              setShowMinWithdrawal(true);
            } else if (!profile?.is_active) {
              setShowActivate(true);
            } else {
              setShowWithdraw(true);
            }
          }}
          className="w-full mt-3 h-12 rounded-2xl border-2 border-primary text-primary font-semibold flex items-center justify-center gap-2"
        >
          <Download size={18} />
          Withdraw to M-Pesa
        </button>
      </div>

      {/* Categories and Surveys */}
      <div className="px-5 space-y-6">
        {unlockedCategories.map((categoryId) => {
          const categorySurveys = surveysByCategory[categoryId] || [];
          const availableSurveys = categorySurveys.filter(s => !completedIds.has(s.id));
          const potential = CATEGORY_POTENTIAL[categoryId] || 0;
          
          if (availableSurveys.length === 0) return null;
          
          return (
            <div key={categoryId} className="mb-6">
              <div className="flex items-center justify-between mb-3">
                <h2 className="font-extrabold text-foreground text-base flex items-center gap-2">
                  <div className="w-7 h-7 rounded-lg bg-green-100 flex items-center justify-center">
                    <FolderOpen size={14} className="text-green-600" />
                  </div>
                  {CATEGORY_NAMES[categoryId] || categoryId}
                </h2>
                <div className="text-right">
                  <span className="text-xs text-muted-foreground">{availableSurveys.length} available</span>
                  <p className="text-[10px] text-green-600">Earn up to KSH {potential}</p>
                </div>
              </div>
              
              <div className="space-y-3">
                {availableSurveys.map((s, i) => (
                  <SurveyCard 
                    key={s.id} 
                    survey={s} 
                    index={i}
                    isCompleted={false}
                    isUnlocked={true}
                    isNewlyUnlocked={false}
                  />
                ))}
              </div>
            </div>
          );
        })}
        
        {surveys.filter(s => !completedIds.has(s.id)).length === 0 && (
          <div className="text-center py-8">
            <p className="text-sm text-muted-foreground">No surveys available</p>
            <p className="text-xs text-muted-foreground mt-2">All surveys completed or none unlocked yet</p>
            <button
              onClick={() => navigate('/earning-cap')}
              className="mt-4 px-4 py-2 bg-primary text-white rounded-lg text-sm font-semibold"
            >
              Unlock More Categories
            </button>
          </div>
        )}
      </div>

      {/* Premium banner */}
      <div className="px-5">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          onClick={() => navigate("/wallet?tab=upgrade")}
          className="rounded-2xl p-4 bg-gradient-to-r from-amber-50 to-orange-50 border border-amber-200 cursor-pointer"
        >
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-gradient-gold flex items-center justify-center">
              <Sparkles size={18} className="text-white" />
            </div>
            <div className="flex-1">
              <h3 className="font-bold text-foreground text-sm">Want More?</h3>
              <p className="text-xs text-muted-foreground">Upgrade for premium surveys</p>
            </div>
            <span className="text-xs font-bold text-amber-600">Upgrade →</span>
          </div>
        </motion.div>
      </div>

      {/* Withdraw Modal */}
      <WithdrawModal
        isOpen={showWithdraw}
        onClose={() => setShowWithdraw(false)}
        balance={balance}
        onWithdraw={() => {
          setShowWithdraw(false);
          navigate('/wallet');
        }}
        onUpgrade={() => {
          setShowWithdraw(false);
          navigate('/wallet?tab=upgrade');
        }}
      />

      {/* Activate Account Modal */}
      <ActivateAccountModal
        isOpen={showActivate}
        onClose={() => setShowActivate(false)}
        onActivated={() => {
          refreshProfile();
          setShowActivate(false);
          setShowWithdraw(true);
        }}
      />

      {/* Minimum Withdrawal Popup */}
      <AnimatePresence>
        {showMinWithdrawal && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 z-[100] flex items-end sm:items-center justify-center bg-foreground/40"
            onClick={() => setShowMinWithdrawal(false)}
          >
            <motion.div
              initial={{ y: "100%" }}
              animate={{ y: 0 }}
              exit={{ y: "100%" }}
              transition={{ type: "spring", damping: 25, stiffness: 300 }}
              onClick={(e) => e.stopPropagation()}
              className="bg-card w-full max-w-md rounded-t-3xl sm:rounded-3xl p-6 max-h-[90vh] overflow-y-auto"
            >
              <div className="flex items-center justify-between mb-6">
                <h2 className="text-lg font-bold text-card-foreground">Minimum Withdrawal</h2>
                <button onClick={() => setShowMinWithdrawal(false)} className="p-2 rounded-full hover:bg-secondary">
                  <X size={20} className="text-muted-foreground" />
                </button>
              </div>

              <div className="text-center py-4 space-y-4">
                <motion.div initial={{ scale: 0 }} animate={{ scale: 1 }} transition={{ delay: 0.1, type: "spring" }}>
                  <div className="w-16 h-16 rounded-full bg-amber-100 flex items-center justify-center mx-auto">
                    <TrendingUp size={32} className="text-amber-600" />
                  </div>
                </motion.div>
                
                <div>
                  <h3 className="text-xl font-bold text-card-foreground">Keep Going! 🚀</h3>
                  <p className="text-sm text-muted-foreground mt-2">
                    Minimum withdrawal is <span className="font-bold text-primary">KSH 2,500</span>
                  </p>
                  <p className="text-xs text-muted-foreground mt-1">
                    You currently have <span className="font-semibold">KSH {balance.toLocaleString()}</span>
                  </p>
                  <p className="text-xs text-muted-foreground mt-1">
                    Need <span className="font-semibold text-amber-600">KSH {(2500 - balance).toLocaleString()}</span> more to withdraw
                  </p>
                </div>

                <div className="bg-primary/10 border border-primary/20 rounded-2xl p-4 space-y-3">
                  <p className="text-sm text-muted-foreground">
                    Complete more surveys to reach the withdrawal threshold!
                  </p>
                  <button 
                    onClick={() => {
                      setShowMinWithdrawal(false);
                      navigate('/extra-surveys');
                    }}
                    className="w-full h-12 rounded-xl gradient-primary text-primary-foreground font-bold text-sm"
                  >
                    Continue Tasking
                  </button>
                </div>
              </div>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}
