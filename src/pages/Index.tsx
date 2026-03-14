import { useState, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { Bell, Search, ChevronRight, Star, TrendingUp, Download, ArrowUpRight, Sparkles, Loader2, Lock, Zap, X } from "lucide-react";
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
  const [showMinWithdrawal, setShowMinWithdrawal] = useState(false);
  const [showUnlockModal, setShowUnlockModal] = useState(false);
  const [searchOpen, setSearchOpen] = useState(false);
  const [unlockPaidTotal, setUnlockPaidTotal] = useState(0);
  const [unlockedSurveyIds, setUnlockedSurveyIds] = useState<Set<string>>(new Set());
  const [newlyUnlockedIds, setNewlyUnlockedIds] = useState<Set<string>>(new Set());
  
  const remainingToWithdraw = Math.max(0, 1500 - balance);

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

  // Set initial unlocked surveys for new users when surveys load
  useEffect(() => {
    if (surveys.length > 0 && profile?.id && unlockedSurveyIds.size === 0) {
      // Check if user has any unlock history
      const checkUnlockHistory = async () => {
        const { data, error } = await supabase
          .from('transactions')
          .select('id')
          .eq('user_id', profile.id)
          .eq('type', 'upgrade')
          .eq('status', 'completed')
          .limit(1);
        
        // If no unlock history, unlock free surveys totaling ~1300 KSH
        if (!error && (!data || data.length === 0)) {
          const sortedSurveys = surveys
            .filter(s => !s.is_premium)
            .sort((a, b) => new Date(a.created_at).getTime() - new Date(b.created_at).getTime());
          
          // Accumulate surveys until total reaches 1300
          let totalReward = 0;
          const unlockedSurveys = [];
          for (const survey of sortedSurveys) {
            if (totalReward + survey.reward <= 1300) {
              unlockedSurveys.push(survey);
              totalReward += survey.reward;
            } else {
              break;
            }
          }
          
          const sortedSurveyIds = unlockedSurveys.map(s => s.id);
          
          if (sortedSurveyIds.length > 0) {
            console.log('New user - unlocking surveys totaling ~1300 KSH:', sortedSurveyIds);
            setUnlockedSurveyIds(new Set(sortedSurveyIds));
          }
        }
      };
      
      checkUnlockHistory();
    }
  }, [surveys, profile?.id]);

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
        .select('amount, survey_id, reference, status')
        .eq('user_id', profile.id)
        .eq('type', 'upgrade');

      if (error) throw error;
      console.log('All upgrade transactions:', data);
      
      const completed = data?.filter(tx => tx.status === 'completed') || [];
      const total = completed.reduce((sum, tx) => sum + (tx.amount || 0), 0);
      console.log('Completed unlock payments:', completed.length, 'Total:', total);
      setUnlockPaidTotal(total);
      
      // Track which surveys this user has unlocked from transactions
      const unlockedIds = new Set<string>();
      completed.forEach(tx => {
        console.log('Processing transaction:', tx);
        if (tx.survey_id) {
          console.log('Adding survey_id to unlocked:', tx.survey_id);
          unlockedIds.add(tx.survey_id);
        }
      });
      
      setUnlockedSurveyIds(unlockedIds);
    } catch (error) {
      console.error('Error fetching unlock payments:', error);
    }
  }

  // Get IDs of locked surveys to exclude from free surveys
  const lockedSurveyIds = new Set(surveys.filter(s => s.is_locked).map(s => s.id));
  
  // Only show free surveys that total ~1300 KSH reward (under 1500 withdrawal minimum)
  // Accumulate surveys until total reaches 1300 or we run out
  const availableSurveys = (() => {
    const sorted = surveys
      .filter((s) => !s.is_premium && !s.is_locked && !lockedSurveyIds.has(s.id))
      .sort((a, b) => new Date(a.created_at).getTime() - new Date(b.created_at).getTime());
    
    let totalReward = 0;
    const result = [];
    for (const survey of sorted) {
      if (totalReward + survey.reward <= 1300) {
        result.push(survey);
        totalReward += survey.reward;
      } else {
        break;
      }
    }
    return result;
  })();
  const lockedSurveys = surveys.filter((s) => s.is_locked && !s.is_premium);
  const premiumSurveys = surveys.filter((s) => s.is_premium);

  // Redirect to earning cap page when user has no more unlocked surveys to complete
  useEffect(() => {
    console.log('Redirect check - loading:', loading, 'profile:', profile?.id, 'availableSurveys:', availableSurveys.length);
    console.log('Redirect check - balance:', balance, 'completedCount:', completedCount, 'unlockedSurveyIds.size:', unlockedSurveyIds.size);
    
    if (!loading && profile?.id && availableSurveys.length > 0) {
      // Get unlocked surveys (both initially unlocked and user-unlocked)
      const unlockedSurveys = availableSurveys.filter(s => !s.is_locked || unlockedSurveyIds.has(s.id));
      const completedUnlockedSurveys = unlockedSurveys.filter(s => completedSurveyIds.has(s.id));
      
      console.log('Unlocked surveys count:', unlockedSurveys.length);
      console.log('Completed unlocked surveys:', completedUnlockedSurveys.length);
      console.log('Completed IDs:', Array.from(completedSurveyIds));
      
      // Calculate remaining unlocked surveys that haven't been completed
      const remainingUnlocked = unlockedSurveys.filter(s => !completedSurveyIds.has(s.id));
      console.log('Remaining unlocked surveys:', remainingUnlocked.length);
      
      // Only redirect if NO unlocked surveys remain to complete
      const noMoreSurveys = remainingUnlocked.length === 0;
      
      console.log('No more surveys to complete:', noMoreSurveys);
      
      // Redirect only when there are no more unlocked surveys available
      if (noMoreSurveys) {
        console.log('REDIRECTING TO EARNING CAP - No surveys left!');
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
                isUnlocked={unlockedSurveyIds.has(s.id)}
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
                    Minimum withdrawal is <span className="font-bold text-primary">KSH 1,500</span>
                  </p>
                  <p className="text-xs text-muted-foreground mt-1">
                    You currently have <span className="font-semibold">KSH {balance.toLocaleString()}</span>
                  </p>
                  <p className="text-xs text-muted-foreground mt-1">
                    Need <span className="font-semibold text-amber-600">KSH {(1500 - balance).toLocaleString()}</span> more to withdraw
                  </p>
                </div>

                <div className="bg-primary/10 border border-primary/20 rounded-2xl p-4 space-y-3">
                  <p className="text-sm text-muted-foreground">
                    Complete more surveys to reach the withdrawal threshold!
                  </p>
                  <button 
                    onClick={() => {
                      setShowMinWithdrawal(false);
                      navigate('/surveys');
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
};

export default Index;
