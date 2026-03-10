import { useState, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { Bell, Search, ChevronRight, Star, TrendingUp, Download, ArrowUpRight, Sparkles, Loader2, Lock, Zap } from "lucide-react";
import { useNavigate, useLocation } from "react-router-dom";
import { useAuth } from "@/contexts/AuthContext";
import { supabase } from "@/lib/supabase";
import WalletCard from "@/components/WalletCard";
import SurveyCard from "@/components/SurveyCard";
import CategoryChip from "@/components/CategoryChip";
import WithdrawModal from "@/components/WithdrawModal";
import ActivateAccountModal from "@/components/ActivateAccountModal";
import UnlockTaskModal from "@/components/UnlockTaskModal";
import { CATEGORIES } from "@/lib/store";
import avatarImg from "@/assets/avatar-default.png";
import dailyTasksBg from "@/assets/daily-tasks-bg.jpg";

// Category images
import catLifestyle from "@/assets/cat-lifestyle.png";
import catTech from "@/assets/cat-technology.png";
import catFood from "@/assets/cat-food.png";
import catHealth from "@/assets/cat-health.png";
import catFinance from "@/assets/cat-finance.png";
import catEntertainment from "@/assets/cat-entertainment.png";

const CATEGORY_IMAGES: Record<string, string> = {
  lifestyle: catLifestyle,
  tech: catTech,
  food: catFood,
  health: catHealth,
  finance: catFinance,
  entertainment: catEntertainment,
};

const Index = () => {
  const navigate = useNavigate();
  const location = useLocation();
  const { profile, balance, refreshProfile } = useAuth();
  const [surveys, setSurveys] = useState<any[]>([]);
  const [completedSurveyIds, setCompletedSurveyIds] = useState<Set<string>>(new Set());
  const [completedCount, setCompletedCount] = useState(0);
  const [loading, setLoading] = useState(true);
  const [showWithdraw, setShowWithdraw] = useState(false);
  const [showActivate, setShowActivate] = useState(false);
  const [showUnlockModal, setShowUnlockModal] = useState(false);
  const [searchOpen, setSearchOpen] = useState(false);
  const [unlockPaidTotal, setUnlockPaidTotal] = useState(0);
  const [unlockedSurveyIds, setUnlockedSurveyIds] = useState<Set<string>>(new Set());
  const [newlyUnlockedIds, setNewlyUnlockedIds] = useState<Set<string>>(new Set());
  
  const remainingToWithdraw = Math.max(0, 2500 - balance);

  useEffect(() => {
    // Always refresh data on mount
    fetchSurveys();
    fetchCompletedSurveys();
    if (profile?.id) {
      fetchUnlockPayments();
    }
    
    const handleFocus = () => {
      console.log('Window focused - refreshing data');
      fetchSurveys();
      fetchCompletedSurveys();
      if (profile?.id) {
        fetchUnlockPayments();
      }
    };
    
    // Refresh when tab becomes visible
    const handleVisibilityChange = () => {
      if (document.visibilityState === 'visible') {
        console.log('Tab visible - refreshing data');
        fetchSurveys();
        fetchCompletedSurveys();
        if (profile?.id) {
          fetchUnlockPayments();
        }
      }
    };
    
    window.addEventListener('focus', handleFocus);
    document.addEventListener('visibilitychange', handleVisibilityChange);
    
    return () => {
      window.removeEventListener('focus', handleFocus);
      document.removeEventListener('visibilitychange', handleVisibilityChange);
    };
  }, [profile?.id]);

  // Handle newly unlocked surveys when navigating back from earning-cap
  useEffect(() => {
    if (location.state?.justUnlocked && surveys.length > 0) {
      // Find surveys that were just unlocked (not locked anymore)
      const justUnlockedIds = surveys
        .filter(s => !s.is_locked && !completedSurveyIds.has(s.id))
        .map(s => s.id);
      
      if (justUnlockedIds.length > 0) {
        setNewlyUnlockedIds(new Set(justUnlockedIds));
        
        // Clear "New" tag after 30 seconds
        setTimeout(() => {
          setNewlyUnlockedIds(new Set());
        }, 30000);
      }
      
      // Clear the navigation state
      navigate('/', { replace: true, state: {} });
    }
  }, [location.state, surveys, completedSurveyIds, navigate]);

  // Navigate to earning cap page when balance reaches 2000
  // REMOVED: Redirect logic that was sending users to earning-cap page
  // Users should see Home page with available surveys to complete
  // The earning cap banner on Home shows the correct info

  async function fetchSurveys() {
    try {
      const { data, error } = await supabase
        .from('surveys')
        .select('*')
        .eq('is_active', true)
        .order('created_at', { ascending: false });

      if (error) throw error;
      setSurveys(data || []);
    } catch (error) {
      console.error('Error fetching surveys:', error);
    } finally {
      setLoading(false);
    }
  }

  async function fetchCompletedSurveys() {
    if (!profile?.id) return;
    try {
      const { data, error } = await supabase
        .from('survey_responses')
        .select('survey_id')
        .eq('user_id', profile.id);

      if (error) throw error;
      const ids = new Set(data?.map(r => r.survey_id) || []);
      setCompletedSurveyIds(ids);
      setCompletedCount(ids.size);
    } catch (error) {
      console.error('Error fetching completed surveys:', error);
    }
  }

  async function fetchUnlockPayments() {
    if (!profile?.id) return;
    try {
      console.log('Fetching unlock payments for user:', profile.id);
      const { data, error } = await supabase
        .from('transactions')
        .select('amount, survey_id, reference')
        .eq('user_id', profile.id)
        .eq('type', 'upgrade')
        .eq('status', 'completed');

      if (error) throw error;
      const total = data?.reduce((sum, tx) => sum + (tx.amount || 0), 0) || 0;
      console.log('Unlock payments found:', data?.length, 'Total:', total);
      setUnlockPaidTotal(total);
      
      // Track which surveys this user has unlocked
      const unlockedIds = new Set<string>();
      data?.forEach(tx => {
        // Check survey_id field (new way)
        if (tx.survey_id) {
          unlockedIds.add(tx.survey_id);
        }
        // Fallback: parse from reference field (old way) - format: unlock_${surveyId}_${timestamp}
        else if (tx.reference && tx.reference.startsWith('unlock_')) {
          const parts = tx.reference.split('_');
          if (parts.length >= 2) {
            unlockedIds.add(parts[1]);
          }
        }
      });
      setUnlockedSurveyIds(unlockedIds);
    } catch (error) {
      console.error('Error fetching unlock payments:', error);
    }
  }

  // Show ALL surveys (not filtering out locked ones - SurveyCard will handle locked state)
  const availableSurveys = surveys
    .filter((s) => !s.is_premium)
    .sort((a, b) => {
      // Newly unlocked surveys go first
      const aIsNew = newlyUnlockedIds.has(a.id) ? 1 : 0;
      const bIsNew = newlyUnlockedIds.has(b.id) ? 1 : 0;
      return bIsNew - aIsNew;
    });
  const lockedSurveys = surveys.filter((s) => s.is_locked && !s.is_premium);
  const premiumSurveys = surveys.filter((s) => s.is_premium);

  // Redirect to earning cap page when user has completed all free surveys
  useEffect(() => {
    if (!loading && profile?.id && availableSurveys.length > 0) {
      const unlockedSurveys = availableSurveys.filter(s => !s.is_locked || unlockedSurveyIds.has(s.id));
      const completedUnlockedSurveys = unlockedSurveys.filter(s => completedSurveyIds.has(s.id));
      
      // If user has completed all unlocked (free) surveys, redirect to earning cap
      if (completedUnlockedSurveys.length === unlockedSurveys.length && unlockedSurveys.length > 0) {
        navigate('/earning-cap');
      }
    }
  }, [loading, profile?.id, availableSurveys, completedSurveyIds, unlockedSurveyIds, navigate]);

  const handleWithdrawClick = () => {
    if (!profile?.is_active) {
      setShowActivate(true);
    } else {
      setShowWithdraw(true);
    }
  };

  const handleWithdraw = async (amount: number, phone: string) => {
    if (!profile?.id) return;
    
    try {
      const { error } = await supabase
        .from('transactions')
        .insert({
          user_id: profile.id,
          type: 'withdrawal',
          amount: amount,
          status: 'pending',
          phone_number: phone,
          reference: `WD-${Date.now()}`,
          description: `Withdrawal of KSH ${amount} to ${phone}`,
        });

      if (error) throw error;
      await refreshProfile();
    } catch (error) {
      console.error('Error creating withdrawal:', error);
    }
  };

  const handleActivated = async () => {
    await refreshProfile();
    setShowActivate(false);
    setShowWithdraw(true);
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <Loader2 className="animate-spin text-primary" size={32} />
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background pb-24">
      {/* Header */}
      <div className="px-5 pt-6 pb-2">
        <div className="flex items-center justify-between mb-5">
          <div className="flex items-center gap-3">
            <div className="relative">
              <img 
                src={avatarImg} 
                alt="Profile" 
                className="w-12 h-12 rounded-2xl object-cover border-2 border-primary/20 shadow-card" 
              />
              <span className="absolute -bottom-0.5 -right-0.5 w-3.5 h-3.5 bg-primary rounded-full border-2 border-background" />
            </div>
            <div>
              <p className="text-xs text-muted-foreground font-medium">Good morning 👋</p>
              <h1 className="text-base font-extrabold text-foreground tracking-tight">{profile?.full_name || 'User'}</h1>
            </div>
          </div>
          <div className="flex items-center gap-2">
            <motion.button whileTap={{ scale: 0.9 }} onClick={() => setSearchOpen(!searchOpen)} className="w-10 h-10 rounded-2xl bg-card border border-border flex items-center justify-center shadow-card">
              <Search size={17} className="text-muted-foreground" />
            </motion.button>
            <motion.button whileTap={{ scale: 0.9 }} className="w-10 h-10 rounded-2xl bg-card border border-border flex items-center justify-center relative shadow-card">
              <Bell size={17} className="text-muted-foreground" />
              <span className="absolute -top-1 -right-1 w-5 h-5 gradient-coral rounded-full text-[9px] font-bold text-accent-foreground flex items-center justify-center">3</span>
            </motion.button>
          </div>
        </div>

        <AnimatePresence>
          {searchOpen && (
            <motion.div initial={{ height: 0, opacity: 0 }} animate={{ height: "auto", opacity: 1 }} exit={{ height: 0, opacity: 0 }} className="overflow-hidden mb-4">
              <div className="relative">
                <Search size={16} className="absolute left-4 top-1/2 -translate-y-1/2 text-muted-foreground" />
                <input type="text" placeholder="Search surveys, categories..." className="w-full h-11 rounded-2xl bg-card border border-border pl-11 pr-4 text-sm text-foreground placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-primary/30 focus:border-primary transition-all" />
              </div>
            </motion.div>
          )}
        </AnimatePresence>
      </div>

      {/* Wallet + Withdraw */}
      <div className="px-5 mb-5">
        <WalletCard balance={balance} earnings={balance > 0 ? Math.floor(balance * 0.1) : 0} />
        <motion.button whileTap={{ scale: 0.97 }} onClick={handleWithdrawClick} className="w-full h-12 rounded-2xl bg-card border-2 border-primary text-primary font-bold text-sm flex items-center justify-center gap-2 mt-3 hover:bg-primary hover:text-primary-foreground transition-colors">
          <Download size={16} /> Withdraw to M-Pesa
        </motion.button>
      </div>

      {/* Quick Stats */}
      <div className="px-5 mb-5">
        <div className="grid grid-cols-3 gap-3">
          {[
            { label: "Completed", value: completedCount.toString(), icon: "✅" },
            { label: "Streak", value: "5 days", icon: "🔥" },
            { label: "Rank", value: "#142", icon: "🏆" },
          ].map((stat, i) => (
            <motion.div key={stat.label} initial={{ opacity: 0, y: 16 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: i * 0.08 }} className="bg-card rounded-2xl p-3.5 text-center border border-border shadow-card">
              <span className="text-xl block mb-1">{stat.icon}</span>
              <p className="text-base font-extrabold text-card-foreground leading-tight">{stat.value}</p>
              <p className="text-[10px] text-muted-foreground font-semibold mt-0.5">{stat.label}</p>
            </motion.div>
          ))}
        </div>
      </div>

      {/* Daily Tasks Banner */}
      <div className="px-5 mb-6">
        <motion.div
          initial={{ opacity: 0, x: -20 }}
          animate={{ opacity: 1, x: 0 }}
          onClick={() => navigate("/surveys")}
          className="rounded-2xl overflow-hidden cursor-pointer active:scale-[0.98] transition-transform relative h-24"
        >
          <img src={dailyTasksBg} alt="" className="absolute inset-0 w-full h-full object-cover" />
          <div className="absolute inset-0 bg-gradient-to-r from-black/50 to-transparent" />
          <div className="relative z-10 flex items-center gap-4 p-4 h-full">
            <div className="w-12 h-12 bg-white/20 backdrop-blur-sm rounded-2xl flex items-center justify-center">
              <span className="text-2xl">🔥</span>
            </div>
            <div className="flex-1">
              <h3 className="font-bold text-white text-sm">Daily Tasks Available!</h3>
              <p className="text-xs text-white/80">Complete 5 surveys to earn bonus KSH 300</p>
            </div>
            <ChevronRight size={20} className="text-white" />
          </div>
        </motion.div>
      </div>

      {/* Categories */}
      <div className="px-5 mb-2">
        <div className="flex items-center justify-between mb-3">
          <h2 className="font-extrabold text-foreground text-base">Categories</h2>
          <button onClick={() => navigate("/surveys")} className="text-xs text-primary font-bold flex items-center gap-1">
            See All <ArrowUpRight size={12} />
          </button>
        </div>
      </div>
      <div className="flex gap-3 overflow-x-auto px-5 pb-5 no-scrollbar">
        {CATEGORIES.slice(0, 6).map((cat) => (
          <CategoryChip
            key={cat.id}
            icon={cat.icon}
            name={cat.name}
            image={CATEGORY_IMAGES[cat.id]}
            isActive={false}
            onClick={() => navigate("/surveys")}
          />
        ))}
      </div>

      {/* Trending / Free Surveys */}
      <div className="px-5 mb-6">
        <div className="flex items-center justify-between mb-3">
          <h2 className="font-extrabold text-foreground text-base flex items-center gap-2">
            <div className="w-7 h-7 rounded-lg bg-primary/10 flex items-center justify-center">
              <TrendingUp size={14} className="text-primary" />
            </div>
            Available Surveys
          </h2>
          <button onClick={() => navigate("/surveys")} className="text-xs text-primary font-bold flex items-center gap-1">
            View All <ArrowUpRight size={12} />
          </button>
        </div>
        <div className="space-y-3">
          {availableSurveys.length > 0 ? (
            availableSurveys.map((s, i) => (
              <SurveyCard 
                key={s.id} 
                survey={s} 
                index={i}
                isCompleted={completedSurveyIds.has(s.id)}
                isUnlocked={unlockedSurveyIds.has(s.id) || !s.is_locked}
                isNewlyUnlocked={newlyUnlockedIds.has(s.id)}
              />
            ))
          ) : (
            <p className="text-sm text-muted-foreground text-center py-4">No surveys available</p>
          )}
        </div>
      </div>

      {/* Premium Surveys */}
      <div className="px-5 mb-6">
        <div className="flex items-center justify-between mb-3">
          <h2 className="font-extrabold text-foreground text-base flex items-center gap-2">
            <div className="w-7 h-7 rounded-lg gradient-gold flex items-center justify-center">
              <Sparkles size={14} className="text-accent-foreground" />
            </div>
            Premium Surveys
          </h2>
          <button onClick={() => navigate("/wallet?tab=upgrade")} className="text-xs font-bold text-gradient-gold flex items-center gap-1">
            Unlock All <ArrowUpRight size={12} />
          </button>
        </div>
        <div className="space-y-3">
          {premiumSurveys.length > 0 ? (
            premiumSurveys.map((s, i) => (
              <SurveyCard 
                key={s.id} 
                survey={s} 
                index={i}
                isCompleted={completedSurveyIds.has(s.id)}
              />
            ))
          ) : (
            <p className="text-sm text-muted-foreground text-center py-4">No premium surveys available</p>
          )}
        </div>
      </div>

      <WithdrawModal
        isOpen={showWithdraw}
        onClose={() => setShowWithdraw(false)}
        balance={balance}
        onWithdraw={handleWithdraw}
        onUpgrade={() => {
          setShowWithdraw(false);
          navigate("/wallet?tab=upgrade");
        }}
      />

      <ActivateAccountModal
        isOpen={showActivate}
        onClose={() => setShowActivate(false)}
        onActivated={handleActivated}
      />

      <UnlockTaskModal
        isOpen={showUnlockModal}
        onClose={() => setShowUnlockModal(false)}
        surveys={lockedSurveys}
        onUnlock={(surveyId) => {
          // Refresh surveys and payments after unlock
          fetchSurveys();
          fetchUnlockPayments();
        }}
      />
    </div>
  );
};

export default Index;
