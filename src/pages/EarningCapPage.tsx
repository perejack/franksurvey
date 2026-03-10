import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { motion } from "framer-motion";
import { Lock, AlertCircle, Zap, TrendingUp, Clock, ArrowRight, Sparkles, ChevronLeft, Loader2 } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useToast } from "@/hooks/use-toast";
import BottomNav from "@/components/BottomNav";
import { initiateSTKPush, pollTransactionStatus } from "@/lib/hashback-api";

interface Survey {
  id: string;
  title: string;
  reward: number;
  unlock_price: number;
  duration: string;
  questions_count: number;
  category: string;
}

interface Package {
  id: string;
  name: string;
  price: number;
  dailyLimit: number;
  features: string[];
  popular?: boolean;
  color: string;
}

const PACKAGES: Package[] = [
  {
    id: 'starter',
    name: 'Starter',
    price: 350,
    dailyLimit: 3500,
    features: ['Earn up to KSH 3,500', 'Access 15+ surveys', 'Standard support'],
    color: 'primary'
  },
  {
    id: 'pro',
    name: 'Pro',
    price: 700,
    dailyLimit: 5000,
    features: ['Earn up to KSH 5,000', 'Access 25+ surveys', 'Priority support', '2x faster payouts'],
    popular: true,
    color: 'accent'
  },
  {
    id: 'elite',
    name: 'Elite',
    price: 1500,
    dailyLimit: 10000,
    features: ['Earn up to KSH 10,000', 'Unlimited surveys', 'VIP support', 'Instant payouts', 'Exclusive surveys'],
    color: 'accent'
  }
];

export default function EarningCapPage() {
  const navigate = useNavigate();
  const { toast } = useToast();
  const [activeTab, setActiveTab] = useState<'unlock' | 'upgrade'>('unlock');
  const [selectedSurvey, setSelectedSurvey] = useState<Survey | null>(null);
  const [showPayment, setShowPayment] = useState(false);
  const [phoneNumber, setPhoneNumber] = useState('');
  const [isProcessing, setIsProcessing] = useState(false);
  const [balance, setBalance] = useState(0);
  const [unlockPaidTotal, setUnlockPaidTotal] = useState(0);
  const [lockedSurveys, setLockedSurveys] = useState<Survey[]>([]);
  const [totalWithdrawn, setTotalWithdrawn] = useState(0);
  const [usersUnlockedToday] = useState(() => Math.floor(Math.random() * 30) + 15);

  const remainingToWithdraw = Math.max(0, 2500 - balance);
  const canWithdraw = balance >= 2500;

  useEffect(() => {
    fetchData();
    
    // Refresh data when window gains focus
    const handleFocus = () => {
      fetchData();
    };
    window.addEventListener('focus', handleFocus);
    return () => window.removeEventListener('focus', handleFocus);
  }, []);

  const fetchData = async () => {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      // Get balance using the same RPC function as AuthContext
      const { data: balanceData, error: balanceError } = await supabase
        .rpc('get_user_balance', { user_uuid: user.id });
      
      if (balanceError) {
        console.error('Error fetching balance:', balanceError);
      } else {
        console.log('Fetched balance:', balanceData);
        setBalance(balanceData || 0);
      }

      // Get locked surveys
      const { data: surveys, error: surveysError } = await supabase
        .from('surveys')
        .select('*')
        .eq('is_locked', true)
        .order('unlock_price', { ascending: true })
        .limit(5);
      
      if (surveysError) {
        console.error('Error fetching surveys:', surveysError);
      } else if (surveys) {
        setLockedSurveys(surveys);
      }

      // Get total withdrawn
      const { data: transactions, error: txError } = await supabase
        .from('transactions')
        .select('amount')
        .eq('user_id', user.id)
        .eq('type', 'withdrawal')
        .eq('status', 'completed');
      
      if (txError) {
        console.error('Error fetching withdrawals:', txError);
      } else if (transactions) {
        const total = transactions.reduce((sum, t) => sum + (t.amount || 0), 0);
        setTotalWithdrawn(total);
      }

      // Get total unlock payments (for dynamic earning cap)
      const { data: unlockTransactions, error: unlockError } = await supabase
        .from('transactions')
        .select('amount')
        .eq('user_id', user.id)
        .eq('type', 'upgrade')
        .eq('status', 'completed');
      
      if (unlockError) {
        console.error('Error fetching unlock payments:', unlockError);
      } else if (unlockTransactions) {
        const totalUnlockPaid = unlockTransactions.reduce((sum, t) => sum + (t.amount || 0), 0);
        setUnlockPaidTotal(totalUnlockPaid);
      }
    } catch (error) {
      console.error('Error in fetchData:', error);
    }
  };

  const getEarningsPotential = (reward: number) => {
    if (reward === 190) return 1000;
    if (reward === 200) return 3000;
    if (reward === 180) return 3000;
    if (reward === 160) return 5000;
    if (reward === 220) return 5000;
    return reward * 5;
  };

  const formatPhoneNumber = (phone: string): string => {
    // Remove all non-digit characters
    let cleaned = phone.replace(/\D/g, '');
    
    // If it starts with 0, replace with 254
    if (cleaned.startsWith('0')) {
      cleaned = '254' + cleaned.slice(1);
    }
    
    // If it doesn't start with 254, add it
    if (!cleaned.startsWith('254')) {
      cleaned = '254' + cleaned;
    }
    
    return cleaned;
  };

  const isValidPhoneNumber = (phone: string): boolean => {
    const formatted = formatPhoneNumber(phone);
    // Must be 12 digits (254 + 9 digits) and start with 2547 or 2541
    return /^254[71]\d{8}$/.test(formatted);
  };

  const handleUnlockTask = async (survey: any) => {
    if (!phoneNumber) {
      toast({
        title: "Phone Number Required",
        description: "Please enter your M-Pesa number to continue.",
        variant: "destructive"
      });
      return;
    }

    setIsProcessing(true);
    console.log('Starting unlock process for:', survey.title);

    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) throw new Error('Please sign in to unlock tasks');
      console.log('User authenticated:', user.id);

      // Format phone number
      let formattedPhone = phoneNumber.replace(/\s/g, '');
      if (formattedPhone.startsWith('0')) {
        formattedPhone = '254' + formattedPhone.substring(1);
      } else if (formattedPhone.startsWith('+')) {
        formattedPhone = formattedPhone.substring(1);
      }
      console.log('Formatted phone:', formattedPhone);

      // Create transaction record with survey unlock price
      console.log('Creating transaction for KSH', survey.unlock_price);
      const { data: transaction, error: txError } = await supabase
        .from('transactions')
        .insert({
          user_id: user.id,
          type: 'upgrade',
          amount: survey.unlock_price,
          status: 'pending',
          description: `Unlock survey: ${survey.title}`,
          reference: `unlock_${survey.id}_${Date.now()}`,
          survey_id: survey.id
        })
        .select()
        .single();

      if (txError) {
        console.error('Transaction creation error:', txError);
        throw new Error('Failed to create transaction record');
      }
      console.log('Transaction created:', transaction.id);

      // Initiate STK Push
      console.log('Initiating STK push...');
      const response = await initiateSTKPush(
        survey.unlock_price.toString(),
        formattedPhone,
        transaction.reference
      ) as any;

      console.log('STK Push response:', response);

      if (!response || response.error) {
        throw new Error(response?.error || 'Failed to initiate M-Pesa payment');
      }

      const checkoutRequestId = response.CheckoutRequestID || response.checkoutRequestId;
      if (!checkoutRequestId) {
        throw new Error('No checkout request ID received');
      }
      console.log('Checkout Request ID:', checkoutRequestId);

      toast({
        title: "M-Pesa Prompt Sent! ",
        description: "Please check your phone and enter your M-Pesa PIN to complete the payment.",
      });

      // Poll for payment status
      console.log('Starting payment polling...');
      const pollResult = await pollTransactionStatus(
        checkoutRequestId,
        12,
        5000
      ) as any;

      console.log('Poll result:', pollResult);

      if (pollResult && pollResult.ResultCode === "0") {
        console.log('Payment successful! Unlocking surveys...');
        
        // Unlock ALL non-premium locked surveys
        const { data: updateData, error: updateError } = await supabase
          .from('surveys')
          .update({ is_locked: false, unlock_price: null })
          .eq('is_locked', true)
          .eq('is_premium', false)
          .select();

        if (updateError) {
          console.error('Error unlocking surveys:', updateError);
          throw new Error('Payment succeeded but failed to unlock surveys. Contact support.');
        }
        
        console.log('Surveys unlocked successfully:', updateData?.length || 0, 'surveys');
        console.log('Unlocked survey IDs:', updateData?.map((s: any) => s.id) || []);

        // Update transaction status
        await supabase
          .from('transactions')
          .update({ status: 'completed' })
          .eq('id', transaction.id);
        console.log('Transaction marked as completed');

        toast({
          title: "All Tasks Unlocked! ",
          description: `Payment successful! ${updateData?.length || 0} surveys are now available.`,
        });

        // Navigate to home page
        console.log('Navigating to home page...');
        navigate('/', { state: { justUnlocked: true } });
      } else {
        console.error('Payment failed or incomplete:', pollResult);
        throw new Error(pollResult?.ResultDesc || 'Payment was not completed');
      }
    } catch (error: any) {
      console.error('Payment error:', error);
      toast({
        title: "Payment Failed",
        description: error.message || "Please try again or choose a different option.",
        variant: "destructive"
      });
    } finally {
      setIsProcessing(false);
    }
  };

  const handleUpgrade = (packageId: string) => {
    navigate(`/wallet?tab=upgrade&package=${packageId}`);
  };

  return (
    <div className="min-h-screen bg-background pb-20">
      {/* Header */}
      <div className="bg-gradient-to-r from-destructive/20 to-accent/20 px-4 pt-4 pb-3">
        <button
          onClick={() => navigate('/')}
          className="flex items-center gap-1 text-sm text-muted-foreground mb-3"
        >
          <ChevronLeft className="w-4 h-4" />
          Back to Home
        </button>
        
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-full bg-destructive/20 flex items-center justify-center">
            <Lock className="w-5 h-5 text-destructive" />
          </div>
          <div>
            <h1 className="text-lg font-bold text-foreground">Account Limit Reached! 🔒</h1>
            <p className="text-xs text-muted-foreground">
              You've earned KSH {balance.toLocaleString()} / KSH 2,500 cap
            </p>
          </div>
        </div>
      </div>

      {/* FOMO Message */}
      <div className="px-4 py-3">
        <div className="bg-card rounded-xl p-3 border border-primary/30">
          <div className="flex items-start gap-2">
            <Zap className="w-4 h-4 text-primary flex-shrink-0 mt-0.5" />
            <div>
              <p className="text-xs font-semibold text-foreground mb-0.5">
                {canWithdraw 
                  ? "🎉 You've reached the withdrawal threshold!" 
                  : `Unlock more surveys to earn more! You have KSH ${balance.toLocaleString()}. Need KSH ${(2500 - balance).toLocaleString()} more to withdraw.`}
              </p>
              <p className="text-[10px] text-muted-foreground leading-tight">
                {canWithdraw 
                  ? "Withdraw your earnings OR unlock more tasks to earn even more!"
                  : "Complete surveys to reach the 2,500 KSH withdrawal minimum. Unlocking gives you access to more earning opportunities!"}
              </p>
            </div>
          </div>
        </div>

        {/* Social Proof */}
        <div className="mt-2 flex items-center gap-1.5 text-[10px] text-muted-foreground bg-primary/10 rounded-full px-2.5 py-1 w-fit mx-auto">
          <span>🔥</span>
          <span className="font-medium">{usersUnlockedToday} users unlocked tasks today</span>
        </div>

        {/* Withdrawal History */}
        {totalWithdrawn > 0 && (
          <div className="mt-1.5 flex items-center gap-1.5 text-[10px] text-green-600 bg-green-500/10 rounded-full px-2.5 py-1 w-fit mx-auto">
            <span>✅</span>
            <span className="font-medium">You've withdrawn KSH {totalWithdrawn.toLocaleString()} to M-Pesa</span>
          </div>
        )}
      </div>

      {/* Compact Tabs */}
      <div className="flex border-b border-border px-4">
        <button
          onClick={() => setActiveTab('unlock')}
          className={`flex-1 py-2.5 text-xs font-semibold transition-colors relative ${
            activeTab === 'unlock' ? 'text-primary' : 'text-muted-foreground'
          }`}
        >
          <div className="flex items-center justify-center gap-1.5">
            <Zap className="w-3.5 h-3.5" />
            Unlock Tasks
          </div>
          {activeTab === 'unlock' && (
            <div className="absolute bottom-0 left-0 right-0 h-0.5 bg-primary" />
          )}
        </button>
        <button
          onClick={() => setActiveTab('upgrade')}
          className={`flex-1 py-2.5 text-xs font-semibold transition-colors relative ${
            activeTab === 'upgrade' ? 'text-primary' : 'text-muted-foreground'
          }`}
        >
          <div className="flex items-center justify-center gap-1.5">
            <TrendingUp className="w-3.5 h-3.5" />
            Upgrade Account
          </div>
          {activeTab === 'upgrade' && (
            <div className="absolute bottom-0 left-0 right-0 h-0.5 bg-primary" />
          )}
        </button>
      </div>

      {/* Content */}
      <div className="px-4 py-3">
        {activeTab === 'unlock' ? (
          showPayment && selectedSurvey ? (
            <div className="space-y-3">
              <div className="bg-card rounded-xl p-3 border border-border">
                <h3 className="font-semibold text-sm text-foreground mb-2">{selectedSurvey.title}</h3>
                <div className="space-y-1.5 text-xs">
                  <div className="flex justify-between">
                    <span className="text-muted-foreground">Unlock Price:</span>
                    <span className="font-bold text-destructive">KSH {selectedSurvey.unlock_price}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-muted-foreground">You'll Earn:</span>
                    <span className="font-bold text-primary">Up to KSH {getEarningsPotential(selectedSurvey.reward)}</span>
                  </div>
                  <div className="flex justify-between pt-1.5 border-t border-border">
                    <span className="text-muted-foreground">Net Profit:</span>
                    <span className={`font-bold ${getEarningsPotential(selectedSurvey.reward) - selectedSurvey.unlock_price > 0 ? 'text-green-500' : 'text-destructive'}`}>
                      KSH {getEarningsPotential(selectedSurvey.reward) - selectedSurvey.unlock_price}
                    </span>
                  </div>
                </div>
              </div>

              <div>
                <label className="text-xs font-medium text-foreground mb-1.5 block">M-Pesa Number</label>
                <input
                  type="tel"
                  value={phoneNumber}
                  onChange={(e) => setPhoneNumber(e.target.value)}
                  placeholder="0712345678 or 0112345678"
                  className="w-full h-10 rounded-lg bg-card border border-border px-3 text-sm font-medium text-foreground outline-none focus:ring-2 focus:ring-primary transition"
                />
                <p className="text-[10px] text-muted-foreground mt-1">You'll receive an STK push to complete payment</p>
              </div>

              <div className="flex gap-2">
                <button
                  onClick={() => setShowPayment(false)}
                  className="flex-1 h-10 rounded-lg bg-secondary text-secondary-foreground font-semibold text-xs"
                >
                  Back
                </button>
                <button
                  onClick={() => handleUnlockTask(selectedSurvey)}
                  disabled={isProcessing}
                  className="flex-1 h-10 rounded-lg bg-primary text-primary-foreground font-semibold text-xs flex items-center justify-center gap-1.5 disabled:opacity-50"
                >
                  {isProcessing ? (
                    <>
                      <div className="w-3.5 h-3.5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                      Processing...
                    </>
                  ) : (
                    <>
                      Unlock Task
                      <ArrowRight className="w-3.5 h-3.5" />
                    </>
                  )}
                </button>
              </div>
            </div>
          ) : (
            <div className="grid grid-cols-1 gap-2">
              {lockedSurveys.map((survey) => (
                <div
                  key={survey.id}
                  onClick={() => { setSelectedSurvey(survey); setShowPayment(true); }}
                  className="bg-card rounded-xl p-3 border border-border active:scale-[0.98] transition-transform cursor-pointer"
                >
                  <div className="flex items-start justify-between gap-2">
                    <div className="flex-1 min-w-0">
                      <h3 className="font-semibold text-xs text-foreground truncate">{survey.title}</h3>
                      <div className="flex items-center gap-2 mt-1 text-[10px] text-muted-foreground">
                        <span className="flex items-center gap-0.5">
                          <Clock className="w-3 h-3" />
                          {survey.duration}
                        </span>
                        <span>{survey.questions_count} questions</span>
                      </div>
                    </div>
                    <div className="text-right flex-shrink-0">
                      <p className="font-bold text-sm text-primary">KSH {survey.reward}</p>
                      <p className="text-[10px] text-green-600 font-medium">Earn up to KSH {getEarningsPotential(survey.reward)}</p>
                      <p className="text-[10px] text-destructive font-medium">Unlock: KSH {survey.unlock_price}</p>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )
        ) : (
          <div className="grid grid-cols-1 gap-2">
            {PACKAGES.map((pkg) => (
              <div
                key={pkg.id}
                onClick={() => handleUpgrade(pkg.id)}
                className={`bg-card rounded-xl p-3 border-2 cursor-pointer active:scale-[0.98] transition-transform relative ${
                  pkg.popular ? 'border-primary' : 'border-border'
                }`}
              >
                {pkg.popular && (
                  <div className="absolute -top-2 left-1/2 -translate-x-1/2 bg-primary text-primary-foreground text-[10px] font-bold px-2 py-0.5 rounded-full">
                    POPULAR
                  </div>
                )}
                <div className="flex items-center justify-between mb-2">
                  <div>
                    <h3 className="font-bold text-sm text-foreground">{pkg.name}</h3>
                    <p className="text-[10px] text-muted-foreground">Earn up to KSH {pkg.dailyLimit.toLocaleString()}</p>
                  </div>
                  <div className="text-right">
                    <p className="text-lg font-bold text-foreground">KSH {pkg.price}</p>
                    <p className="text-[10px] text-muted-foreground">one-time</p>
                  </div>
                </div>
                <ul className="space-y-0.5 mb-2">
                  {pkg.features.slice(0, 3).map((feature, i) => (
                    <li key={i} className="flex items-center gap-1.5 text-[10px] text-muted-foreground">
                      <Sparkles className="w-3 h-3 text-primary" />
                      {feature}
                    </li>
                  ))}
                </ul>
                <button className="w-full h-8 rounded-lg bg-primary text-primary-foreground font-semibold text-xs">
                  Upgrade to {pkg.name}
                </button>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Bottom Note */}
      <div className="px-4 py-2">
        <p className="text-[10px] text-center text-muted-foreground">
          ⚡ Unlock surveys to access more earning opportunities!
          <span className="text-primary font-medium"> Each unlocked survey gives you a chance to earn more!</span>
        </p>
      </div>

      <BottomNav />
    </div>
  );
}
