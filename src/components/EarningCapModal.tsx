import { useState, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { X, Lock, Zap, TrendingUp, Clock, ArrowRight, Sparkles, AlertCircle } from "lucide-react";
import { useNavigate } from "react-router-dom";
import { supabase } from "@/lib/supabase";
import UpgradePackageCard from "./UpgradePackageCard";
import { useToast } from "@/hooks/use-toast";

interface EarningCapModalProps {
  isOpen: boolean;
  onClose: () => void;
  balance: number;
  lockedSurveys: any[];
}

const PACKAGES = [
  {
    id: 'starter',
    name: 'Starter',
    price: 250,
    dailyLimit: 3500,
    features: ['Access to 15 surveys', 'No unlock fees', 'Priority support'],
    color: 'blue'
  },
  {
    id: 'pro',
    name: 'Pro',
    price: 500,
    dailyLimit: 5000,
    features: ['Access to 25 surveys', 'Premium surveys', 'VIP support'],
    color: 'primary',
    popular: true
  },
  {
    id: 'elite',
    name: 'Elite',
    price: 1000,
    dailyLimit: 10000,
    features: ['Unlimited surveys', 'All premium access', 'Instant withdrawals'],
    color: 'accent'
  }
];

export default function EarningCapModal({ isOpen, onClose, balance, lockedSurveys }: EarningCapModalProps) {
  const navigate = useNavigate();
  const { toast } = useToast();
  const [activeTab, setActiveTab] = useState<'unlock' | 'upgrade'>('unlock');
  const [selectedSurvey, setSelectedSurvey] = useState<any>(null);
  const [showPayment, setShowPayment] = useState(false);
  const [phoneNumber, setPhoneNumber] = useState('');
  const [isProcessing, setIsProcessing] = useState(false);
  const [totalWithdrawn, setTotalWithdrawn] = useState(0);
  
  // Social proof - random number between 15-45 users
  const [usersUnlockedToday] = useState(() => Math.floor(Math.random() * 30) + 15);

  const remainingToWithdraw = Math.max(0, 2500 - balance);
  const canWithdraw = balance >= 2500;

  // Fetch total withdrawn amount
  useEffect(() => {
    const fetchWithdrawals = async () => {
      const { data: { user } } = await supabase.auth.getUser();
      if (user) {
        const { data } = await supabase
          .from('transactions')
          .select('amount')
          .eq('user_id', user.id)
          .eq('type', 'withdrawal')
          .eq('status', 'completed');
        
        if (data) {
          const total = data.reduce((sum, t) => sum + (t.amount || 0), 0);
          setTotalWithdrawn(total);
        }
      }
    };
    fetchWithdrawals();
  }, []);

  // Get earnings potential based on survey reward
  const getEarningsPotential = (reward: number) => {
    if (reward === 190) return 1000;
    if (reward === 200) return 3000;
    if (reward === 180) return 3000;
    if (reward === 160) return 5000;
    if (reward === 220) return 5000;
    return reward * 5; // default multiplier
  };
  const handleBackdropClick = (e: React.MouseEvent) => {
    if (e.target === e.currentTarget) {
      // Don't close - user must choose an action
      toast({
        title: "Action Required",
        description: "Please choose to unlock tasks or upgrade your account to continue earning.",
        variant: "destructive"
      });
    }
  };

  const handleUnlockTask = async (survey: any) => {
    if (!phoneNumber || phoneNumber.length < 10) {
      toast({
        title: "Invalid Phone Number",
        description: "Please enter a valid M-Pesa number (e.g., 254712345678)",
        variant: "destructive"
      });
      return;
    }

    setIsProcessing(true);
    
    try {
      // Simulate STK Push
      await new Promise(resolve => setTimeout(resolve, 2000));
      
      // Unlock the survey
      const { error } = await supabase
        .from('surveys')
        .update({ is_locked: false, unlock_price: null })
        .eq('id', survey.id);

      if (error) throw error;

      toast({
        title: "Task Unlocked! 🎉",
        description: `You can now complete "${survey.title}" and earn KSH ${survey.reward}`,
      });

      setShowPayment(false);
      setSelectedSurvey(null);
      onClose();
      
      // Refresh the page to show unlocked survey
      window.location.reload();
    } catch (error) {
      toast({
        title: "Payment Failed",
        description: "Please try again or choose a different option.",
        variant: "destructive"
      });
    } finally {
      setIsProcessing(false);
    }
  };

  const handleUpgrade = (packageId: string) => {
    navigate(`/wallet?tab=upgrade&package=${packageId}`);
    onClose();
  };

  if (!isOpen) return null;

  return (
    <AnimatePresence>
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        exit={{ opacity: 0 }}
        className="fixed inset-0 bg-black/80 backdrop-blur-sm z-50 flex items-end sm:items-center justify-center"
        onClick={handleBackdropClick}
      >
        <motion.div
          initial={{ y: 100, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          exit={{ y: 100, opacity: 0 }}
          className="w-full max-w-lg bg-background rounded-t-3xl sm:rounded-3xl max-h-[85vh] sm:max-h-[90vh] overflow-hidden flex flex-col"
        >
          {/* Header - No close button, force choice */}
          <div className="bg-gradient-to-r from-destructive/20 to-accent/20 p-6">
            <div className="flex items-center gap-3 mb-4">
              <div className="w-12 h-12 rounded-full bg-destructive/20 flex items-center justify-center">
                <Lock className="w-6 h-6 text-destructive" />
              </div>
              <div>
                <h2 className="text-xl font-bold text-foreground">
                  Account Limit Reached! 🔒
                </h2>
                <p className="text-sm text-muted-foreground">
                  You've earned KSH {balance.toLocaleString()}
                </p>
              </div>
            </div>

            {/* FOMO Message */}
            <div className="bg-card rounded-2xl p-4 border border-destructive/30">
              <div className="flex items-start gap-3">
                <AlertCircle className="w-5 h-5 text-destructive flex-shrink-0 mt-0.5" />
                <div>
                  <p className="text-sm font-semibold text-foreground mb-1">
                    {canWithdraw 
                      ? "🎉 You've reached the withdrawal threshold!" 
                      : `You're only KSH ${remainingToWithdraw} away from withdrawal!`}
                  </p>
                  <p className="text-xs text-muted-foreground">
                    {canWithdraw 
                      ? "Withdraw your earnings OR unlock more tasks to earn even more!"
                      : "Don't stop now! Unlock more high-paying tasks or upgrade to keep earning."}
                  </p>
                </div>
              </div>
            </div>

            {/* Social Proof */}
            <div className="mt-4 flex items-center gap-2 text-xs text-muted-foreground bg-primary/10 rounded-full px-3 py-1.5 w-fit mx-auto">
              <span className="text-lg">🔥</span>
              <span className="font-medium">{usersUnlockedToday} users unlocked tasks today</span>
            </div>

            {/* Withdrawal History */}
            {totalWithdrawn > 0 && (
              <div className="mt-3 flex items-center gap-2 text-xs text-green-600 bg-green-500/10 rounded-full px-3 py-1.5 w-fit mx-auto">
                <span className="text-lg">✅</span>
                <span className="font-medium">You've withdrawn KSH {totalWithdrawn.toLocaleString()} to M-Pesa</span>
              </div>
            )}
          </div>

          {/* Tabs */}
          <div className="flex border-b border-border">
            <button
              onClick={() => setActiveTab('unlock')}
              className={`flex-1 py-4 text-sm font-semibold transition-colors relative ${
                activeTab === 'unlock' 
                  ? 'text-primary' 
                  : 'text-muted-foreground hover:text-foreground'
              }`}
            >
              <div className="flex items-center justify-center gap-2">
                <Zap className="w-4 h-4" />
                Unlock Tasks
              </div>
              {activeTab === 'unlock' && (
                <motion.div 
                  layoutId="activeTab"
                  className="absolute bottom-0 left-0 right-0 h-0.5 bg-primary" 
                />
              )}
            </button>
            <button
              onClick={() => setActiveTab('upgrade')}
              className={`flex-1 py-4 text-sm font-semibold transition-colors relative ${
                activeTab === 'upgrade' 
                  ? 'text-primary' 
                  : 'text-muted-foreground hover:text-foreground'
              }`}
            >
              <div className="flex items-center justify-center gap-2">
                <TrendingUp className="w-4 h-4" />
                Upgrade Account
              </div>
              {activeTab === 'upgrade' && (
                <motion.div 
                  layoutId="activeTab"
                  className="absolute bottom-0 left-0 right-0 h-0.5 bg-primary" 
                />
              )}
            </button>
          </div>

          {/* Content */}
          <div className="p-4 sm:p-6 flex-1 overflow-y-auto min-h-0">
            {activeTab === 'unlock' ? (
              <div className="space-y-4">
                <div className="text-center mb-4">
                  <p className="text-sm text-muted-foreground">
                    {lockedSurveys.length} high-paying tasks are waiting for you!
                  </p>
                </div>

                {showPayment && selectedSurvey ? (
                  <div className="space-y-4">
                    <div className="bg-card rounded-2xl p-4 border border-border">
                      <h3 className="font-semibold text-foreground mb-2">
                        {selectedSurvey.title}
                      </h3>
                      <div className="flex items-center justify-between text-sm">
                        <span className="text-muted-foreground">Unlock Price:</span>
                        <span className="font-bold text-destructive">KSH {selectedSurvey.unlock_price}</span>
                      </div>
                      <div className="flex items-center justify-between text-sm mt-2">
                        <span className="text-muted-foreground">You'll Earn:</span>
                        <span className="font-bold text-primary">Up to KSH {getEarningsPotential(selectedSurvey.reward)}</span>
                      </div>
                      <div className="flex items-center justify-between text-sm mt-2 pt-2 border-t border-border">
                        <span className="text-muted-foreground">Net Profit:</span>
                        <span className={`font-bold ${getEarningsPotential(selectedSurvey.reward) - selectedSurvey.unlock_price > 0 ? 'text-green-500' : 'text-destructive'}`}>
                          KSH {getEarningsPotential(selectedSurvey.reward) - selectedSurvey.unlock_price}
                        </span>
                      </div>
                    </div>

                    <div>
                      <label className="text-sm font-medium text-foreground mb-2 block">
                        M-Pesa Number
                      </label>
                      <input
                        type="tel"
                        value={phoneNumber}
                        onChange={(e) => setPhoneNumber(e.target.value)}
                        placeholder="254712345678"
                        className="w-full h-12 rounded-xl bg-card border border-border px-4 text-sm font-medium text-foreground outline-none focus:ring-2 focus:ring-primary transition"
                      />
                      <p className="text-xs text-muted-foreground mt-2">
                        You'll receive an STK push to complete payment
                      </p>
                    </div>

                    <div className="flex gap-3">
                      <button
                        onClick={() => setShowPayment(false)}
                        className="flex-1 h-12 rounded-xl bg-secondary text-secondary-foreground font-semibold text-sm"
                      >
                        Back
                      </button>
                      <button
                        onClick={() => handleUnlockTask(selectedSurvey)}
                        disabled={isProcessing}
                        className="flex-1 h-12 rounded-xl bg-primary text-primary-foreground font-semibold text-sm flex items-center justify-center gap-2 disabled:opacity-50"
                      >
                        {isProcessing ? (
                          <>
                            <div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                            Processing...
                          </>
                        ) : (
                          <>
                            Pay KSH {selectedSurvey.unlock_price}
                            <ArrowRight className="w-4 h-4" />
                          </>
                        )}
                      </button>
                    </div>
                  </div>
                ) : (
                  <div className="space-y-3">
                    {lockedSurveys.slice(0, 5).map((survey) => (
                      <div
                        key={survey.id}
                        className="bg-card rounded-2xl p-4 border border-border hover:border-primary/50 transition-colors cursor-pointer"
                        onClick={() => {
                          setSelectedSurvey(survey);
                          setShowPayment(true);
                        }}
                      >
                        <div className="flex items-start justify-between">
                          <div>
                            <h3 className="font-semibold text-sm text-foreground">
                              {survey.title}
                            </h3>
                            <div className="flex items-center gap-3 mt-2 text-xs text-muted-foreground">
                              <span className="flex items-center gap-1">
                                <Clock className="w-3 h-3" />
                                {survey.duration}
                              </span>
                              <span>{survey.questions_count} questions</span>
                            </div>
                          </div>
                          <div className="text-right">
                            <p className="font-bold text-primary">KSH {survey.reward}</p>
                            <p className="text-xs text-green-600 font-medium">
                              Earn up to KSH {getEarningsPotential(survey.reward)}
                            </p>
                            <p className="text-xs text-destructive font-medium">
                              Unlock: KSH {survey.unlock_price}
                            </p>
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </div>
            ) : (
              <div className="space-y-4">
                <div className="text-center mb-4">
                  <p className="text-sm text-muted-foreground">
                    Upgrade to remove limits and access more surveys
                  </p>
                </div>

                {PACKAGES.map((pkg) => (
                  <div
                    key={pkg.id}
                    className={`bg-card rounded-2xl p-4 border-2 cursor-pointer transition-all relative ${
                      pkg.popular 
                        ? 'border-primary' 
                        : 'border-border hover:border-primary/50'
                    }`}
                    onClick={() => handleUpgrade(pkg.id)}
                  >
                    {pkg.popular && (
                      <div className="absolute -top-3 left-1/2 -translate-x-1/2 bg-primary text-primary-foreground text-xs font-bold px-3 py-1 rounded-full">
                        POPULAR
                      </div>
                    )}
                    <div className="flex items-center justify-between mb-3">
                      <div>
                        <h3 className="font-bold text-foreground">{pkg.name}</h3>
                        <p className="text-xs text-muted-foreground">
                          Earn up to KSH {pkg.dailyLimit.toLocaleString()}
                        </p>
                      </div>
                      <div className="text-right">
                        <p className="text-2xl font-bold text-foreground">KSH {pkg.price}</p>
                        <p className="text-xs text-muted-foreground">one-time</p>
                      </div>
                    </div>
                    <ul className="space-y-2">
                      {pkg.features.map((feature, i) => (
                        <li key={i} className="flex items-center gap-2 text-xs text-muted-foreground">
                          <Sparkles className="w-3 h-3 text-primary" />
                          {feature}
                        </li>
                      ))}
                    </ul>
                    <button className="w-full mt-4 h-10 rounded-xl bg-primary text-primary-foreground font-semibold text-sm">
                      Upgrade to {pkg.name}
                    </button>
                  </div>
                ))}
              </div>
            )}
          </div>

          {/* Bottom note - No close button */}
          <div className="p-4 bg-muted/50 border-t border-border">
            <p className="text-xs text-center text-muted-foreground">
              ⚡ This is an account limit, not a daily limit. 
              <span className="text-primary font-medium"> Upgrade or unlock tasks to keep earning immediately!</span>
            </p>
          </div>
        </motion.div>
      </motion.div>
    </AnimatePresence>
  );
}
