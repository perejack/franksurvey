import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { Lock, Zap, TrendingUp, ChevronLeft, Loader2, FolderOpen } from "lucide-react";
import { supabase } from "@/lib/supabase";
import { useToast } from "@/hooks/use-toast";
import BottomNav from "@/components/BottomNav";
import { initiateSTKPush, pollTransactionStatus } from "@/lib/hashback-api";

interface Category {
  id: string;
  name: string;
  description: string;
  unlockPrice: number;
  totalEarnPotential: number;
  surveyCount: number;
  icon: string;
  color: string;
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

const CATEGORIES: Category[] = [
  {
    id: 'data_entry',
    name: 'Data Entry',
    description: 'Simple data entry forms and transcription tasks',
    unlockPrice: 2,
    totalEarnPotential: 950,
    surveyCount: 5,
    icon: 'file-text',
    color: 'blue'
  },
  {
    id: 'market_research',
    name: 'Market Research',
    description: 'Analyze consumer preferences and market trends',
    unlockPrice: 2,
    totalEarnPotential: 1330,
    surveyCount: 5,
    icon: 'bar-chart',
    color: 'green'
  },
  {
    id: 'customer_feedback',
    name: 'Customer Feedback',
    description: 'Rate services and provide product feedback',
    unlockPrice: 2,
    totalEarnPotential: 1830,
    surveyCount: 5,
    icon: 'message-circle',
    color: 'purple'
  },
  {
    id: 'product_review',
    name: 'Product Review',
    description: 'Test and review various products',
    unlockPrice: 2,
    totalEarnPotential: 2330,
    surveyCount: 5,
    icon: 'package',
    color: 'orange'
  },
  {
    id: 'opinion_poll',
    name: 'Opinion Polls',
    description: 'Share your views on current events and trends',
    unlockPrice: 2,
    totalEarnPotential: 2830,
    surveyCount: 5,
    icon: 'help-circle',
    color: 'red'
  }
];

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
  const [selectedCategory, setSelectedCategory] = useState<Category | null>(null);
  const [showPayment, setShowPayment] = useState(false);
  const [phoneNumber, setPhoneNumber] = useState('');
  const [isProcessing, setIsProcessing] = useState(false);
  const [balance, setBalance] = useState(0);
  const [unlockPaidTotal, setUnlockPaidTotal] = useState(0);
  const [unlockedCategories, setUnlockedCategories] = useState<Set<string>>(new Set());
  const [completedSurveyIds, setCompletedSurveyIds] = useState<Set<string>>(new Set());
  const [totalWithdrawn, setTotalWithdrawn] = useState(0);
  const [usersUnlockedToday] = useState(() => Math.floor(Math.random() * 30) + 15);

  const remainingToWithdraw = Math.max(0, 2500 - balance);
  const canWithdraw = balance >= 2500;

  useEffect(() => {
    fetchData();
    
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

      const { data: balanceData, error: balanceError } = await supabase
        .rpc('get_user_balance', { user_uuid: user.id });
      
      if (balanceError) {
        console.error('Error fetching balance:', balanceError);
      } else {
        setBalance(balanceData || 0);
      }

      const { data: unlockTxs, error: unlockTxsError } = await supabase
        .from('transactions')
        .select('category, status')
        .eq('user_id', user.id)
        .eq('type', 'category_unlock')
        .eq('status', 'completed');
      
      if (unlockTxsError) {
        console.error('Error fetching unlocked categories:', unlockTxsError);
      } else if (unlockTxs) {
        const categories = new Set(unlockTxs.map(tx => tx.category).filter(Boolean));
        setUnlockedCategories(categories);
      }

      const { data: completedData, error: completedError } = await supabase
        .from('survey_responses')
        .select('survey_id')
        .eq('user_id', user.id);
      
      if (completedError) {
        console.error('Error fetching completed surveys:', completedError);
      } else if (completedData) {
        setCompletedSurveyIds(new Set(completedData.map(c => c.survey_id)));
      }

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

      const { data: unlockTransactions, error: unlockError } = await supabase
        .from('transactions')
        .select('amount')
        .eq('user_id', user.id)
        .eq('type', 'category_unlock')
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

  const handleUnlockCategory = async (category: Category) => {
    if (!phoneNumber || phoneNumber.length < 10) {
      toast({
        title: "Phone Number Required",
        description: "Please enter a valid M-Pesa number to continue.",
        variant: "destructive"
      });
      return;
    }

    setIsProcessing(true);

    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) throw new Error('Please sign in to unlock categories');

      let formattedPhone = phoneNumber.replace(/\s/g, '');
      if (formattedPhone.startsWith('0')) {
        formattedPhone = '254' + formattedPhone.substring(1);
      } else if (formattedPhone.startsWith('+')) {
        formattedPhone = formattedPhone.substring(1);
      }

      const { data: transaction, error: txError } = await supabase
        .from('transactions')
        .insert({
          user_id: user.id,
          type: 'category_unlock',
          amount: 2,
          status: 'pending',
          description: `Unlock category: ${category.name}`,
          reference: `unlock_cat_${category.id}_${Date.now()}`,
          category: category.id
        })
        .select()
        .single();

      if (txError) throw new Error('Failed to create transaction record');

      const response = await initiateSTKPush(
        "2",
        formattedPhone,
        transaction.reference
      ) as any;

      if (!response || response.error) {
        throw new Error(response?.error || 'Failed to initiate M-Pesa payment');
      }

      const checkoutRequestId = response.CheckoutRequestID || response.checkoutRequestId;
      if (!checkoutRequestId) {
        throw new Error('No checkout request ID received');
      }

      toast({
        title: "M-Pesa Prompt Sent!",
        description: "Please check your phone and enter your M-Pesa PIN to complete the payment.",
      });

      const pollResult = await pollTransactionStatus(
        checkoutRequestId,
        12,
        5000
      ) as any;

      if (pollResult && pollResult.ResultCode === "0") {
        await supabase
          .from('transactions')
          .update({ status: 'completed' })
          .eq('id', transaction.id);

        toast({
          title: "Category Unlocked! 🎉",
          description: `${category.name} is now available! You can complete up to ${category.surveyCount} surveys and earn up to KSH ${category.totalEarnPotential}.`,
        });

        navigate('/extra-surveys');
      } else {
        throw new Error(pollResult?.ResultDesc || 'Payment was not completed');
      }
    } catch (error: any) {
      console.error('Payment error:', error);
      toast({
        title: "Payment Failed",
        description: error.message || "Please try again.",
        variant: "destructive"
      });
    } finally {
      setIsProcessing(false);
    }
  };

  const handleUpgrade = (packageId: string) => {
    navigate(`/wallet?tab=upgrade&package=${packageId}`);
  };

  const getCategoryColor = (color: string) => {
    const colors: Record<string, string> = {
      blue: 'bg-blue-100 text-blue-600 border-blue-200',
      green: 'bg-green-100 text-green-600 border-green-200',
      purple: 'bg-purple-100 text-purple-600 border-purple-200',
      orange: 'bg-orange-100 text-orange-600 border-orange-200',
      red: 'bg-red-100 text-red-600 border-red-200',
    };
    return colors[color] || colors.blue;
  };

  const availableCategories = CATEGORIES.filter(c => !unlockedCategories.has(c.id));

  return (
    <div className="min-h-screen bg-background pb-20">
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
                Choose a category below, unlock it, and complete surveys to earn up to the promised amount!
              </p>
            </div>
          </div>
        </div>

        <div className="mt-2 flex items-center gap-1.5 text-[10px] text-muted-foreground bg-primary/10 rounded-full px-2.5 py-1 w-fit mx-auto">
          <span>🔥</span>
          <span className="font-medium">{usersUnlockedToday} users unlocked today</span>
        </div>
      </div>

      <div className="flex border-b border-border px-4">
        <button
          onClick={() => setActiveTab('unlock')}
          className={`flex-1 py-2.5 text-xs font-semibold transition-colors relative ${
            activeTab === 'unlock' ? 'text-primary' : 'text-muted-foreground'
          }`}
        >
          <div className="flex items-center justify-center gap-1.5">
            <FolderOpen className="w-3.5 h-3.5" />
            Unlock Categories
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

      <div className="px-4 py-3">
        {activeTab === 'unlock' ? (
          showPayment && selectedCategory ? (
            <div className="space-y-3">
              <div className={`rounded-xl p-3 border ${getCategoryColor(selectedCategory.color)}`}>
                <h3 className="font-semibold text-sm mb-2">{selectedCategory.name}</h3>
                <p className="text-xs mb-3">{selectedCategory.description}</p>
                <div className="space-y-1.5 text-xs">
                  <div className="flex justify-between">
                    <span>Unlock Price:</span>
                    <span className="font-bold">KSH {selectedCategory.unlockPrice}</span>
                  </div>
                  <div className="flex justify-between">
                    <span>Surveys Included:</span>
                    <span className="font-bold">{selectedCategory.surveyCount} surveys</span>
                  </div>
                  <div className="flex justify-between">
                    <span>Total Earning Potential:</span>
                    <span className="font-bold">Up to KSH {selectedCategory.totalEarnPotential}</span>
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
                  onClick={() => handleUnlockCategory(selectedCategory)}
                  disabled={isProcessing}
                  className="flex-1 h-10 rounded-lg bg-primary text-primary-foreground font-semibold text-xs flex items-center justify-center gap-1.5 disabled:opacity-50"
                >
                  {isProcessing ? (
                    <>
                      <Loader2 className="w-3.5 h-3.5 animate-spin" />
                      Processing...
                    </>
                  ) : (
                    `Unlock for KSH ${selectedCategory.unlockPrice}`
                  )}
                </button>
              </div>
            </div>
          ) : (
            <div className="grid grid-cols-1 gap-2">
              {availableCategories.length === 0 ? (
                <div className="text-center py-8">
                  <p className="text-sm text-muted-foreground mb-2">All categories unlocked!</p>
                  <p className="text-xs text-muted-foreground">Go to Extra Surveys to complete them</p>
                  <button
                    onClick={() => navigate('/extra-surveys')}
                    className="mt-3 px-4 py-2 bg-primary text-white rounded-lg text-sm font-semibold"
                  >
                    Go to Extra Surveys
                  </button>
                </div>
              ) : (
                availableCategories.map((category) => (
                  <div
                    key={category.id}
                    onClick={() => { setSelectedCategory(category); setShowPayment(true); }}
                    className={`rounded-xl p-3 border cursor-pointer active:scale-[0.98] transition-transform ${getCategoryColor(category.color)}`}
                  >
                    <div className="flex items-start justify-between gap-2">
                      <div className="flex-1 min-w-0">
                        <h3 className="font-semibold text-sm truncate">{category.name}</h3>
                        <p className="text-xs mt-1 opacity-80">{category.description}</p>
                        <div className="flex items-center gap-2 mt-2 text-[10px]">
                          <span className="flex items-center gap-0.5">
                            <FolderOpen className="w-3 h-3" />
                            {category.surveyCount} surveys
                          </span>
                        </div>
                      </div>
                      <div className="text-right flex-shrink-0">
                        <p className="font-bold text-sm">KSH {category.unlockPrice}</p>
                        <p className="text-[10px] mt-1">Earn up to</p>
                        <p className="text-[10px] font-bold">KSH {category.totalEarnPotential}</p>
                      </div>
                    </div>
                  </div>
                ))
              )}
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
              </div>
            ))}
          </div>
        )}
      </div>

      <div className="px-4 py-2">
        <p className="text-[10px] text-center text-muted-foreground">
          ⚡ Unlock categories to access more earning opportunities!
          <span className="text-primary font-medium"> Each survey in a category earns you the promised amount!</span>
        </p>
      </div>

      <BottomNav />
    </div>
  );
}
