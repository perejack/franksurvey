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
  color: string;
}

const CATEGORIES: Category[] = [
  { id: 'lifestyle', name: 'Lifestyle & Habits', description: 'Transport, shopping, weekends, food', unlockPrice: 155, totalEarnPotential: 525, surveyCount: 5, color: 'blue' },
  { id: 'mobile_tech', name: 'Mobile & Technology', description: 'M-Pesa, social media, apps, internet', unlockPrice: 190, totalEarnPotential: 1500, surveyCount: 5, color: 'green' },
  { id: 'consumer', name: 'Consumer Choices', description: 'Shopping, brands, airtime, supermarkets', unlockPrice: 210, totalEarnPotential: 2500, surveyCount: 5, color: 'purple' },
  { id: 'entertainment', name: 'Entertainment & Media', description: 'TV, movies, music, radio, sports', unlockPrice: 300, totalEarnPotential: 3000, surveyCount: 5, color: 'orange' },
  { id: 'community', name: 'Community & Society', description: 'Neighborhood, local business, social', unlockPrice: 350, totalEarnPotential: 5000, surveyCount: 5, color: 'red' }
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
  const [unlockedCategories, setUnlockedCategories] = useState<Set<string>>(new Set());
  const [usersUnlockedToday] = useState(() => Math.floor(Math.random() * 30) + 15);

  useEffect(() => {
    fetchData();
    const handleFocus = () => fetchData();
    window.addEventListener('focus', handleFocus);
    return () => window.removeEventListener('focus', handleFocus);
  }, []);

  const fetchData = async () => {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;
      const { data: balanceData } = await supabase.rpc('get_user_balance', { user_uuid: user.id });
      setBalance(balanceData || 0);
      
      const { data: unlockTxs } = await supabase
        .from('transactions')
        .select('category')
        .eq('user_id', user.id)
        .eq('type', 'category_unlock')
        .eq('status', 'completed');
      
      if (unlockTxs) {
        setUnlockedCategories(new Set(unlockTxs.map(tx => tx.category).filter(Boolean)));
      }
    } catch (error) {
      console.error('Error in fetchData:', error);
    }
  };

  const handleUnlockCategory = async (category: Category) => {
    if (!phoneNumber || phoneNumber.length < 10) {
      toast({ title: "Phone Number Required", description: "Please enter a valid M-Pesa number.", variant: "destructive" });
      return;
    }
    setIsProcessing(true);
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) throw new Error('Please sign in');
      
      let formattedPhone = phoneNumber.replace(/\s/g, '');
      if (formattedPhone.startsWith('0')) formattedPhone = '254' + formattedPhone.substring(1);
      else if (formattedPhone.startsWith('+')) formattedPhone = formattedPhone.substring(1);

      const { data: transaction, error: txError } = await supabase
        .from('transactions')
        .insert({
          user_id: user.id,
          type: 'category_unlock',
          amount: selectedCategory.unlockPrice,
          status: 'pending',
          description: `Unlock: ${selectedCategory.name}`,
          reference: `unlock_cat_${selectedCategory.id}_${Date.now()}`,
          category: selectedCategory.id
        })
        .select()
        .single();

      if (txError) {
        console.error('Transaction creation error:', txError);
        throw new Error(`Failed to create transaction: ${txError.message}`);
      }

      const response = await initiateSTKPush(String(selectedCategory.unlockPrice), formattedPhone, transaction.reference) as any;
      if (!response || response.error) throw new Error(response?.error || 'Failed to initiate payment');

      const checkoutRequestId = response.CheckoutRequestID || response.checkoutRequestId;
      if (!checkoutRequestId) throw new Error('No checkout request ID');

      toast({ title: "M-Pesa Prompt Sent!", description: "Enter your M-Pesa PIN to complete payment." });

      const pollResult = await pollTransactionStatus(checkoutRequestId, 12, 5000) as any;
      if (pollResult && pollResult.ResultCode === "0") {
        await supabase.from('transactions').update({ status: 'completed' }).eq('id', transaction.id);
        toast({ title: "Category Unlocked! 🎉", description: `${category.name} is now available!` });
        navigate('/extra-surveys');
      } else {
        throw new Error(pollResult?.ResultDesc || 'Payment not completed');
      }
    } catch (error: any) {
      toast({ title: "Payment Failed", description: error.message, variant: "destructive" });
    } finally {
      setIsProcessing(false);
    }
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
        <button onClick={() => navigate('/')} className="flex items-center gap-1 text-sm text-muted-foreground mb-3">
          <ChevronLeft className="w-4 h-4" /> Back to Home
        </button>
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-full bg-destructive/20 flex items-center justify-center">
            <Lock className="w-5 h-5 text-destructive" />
          </div>
          <div>
            <h1 className="text-lg font-bold text-foreground">Account Limit Reached! 🔒</h1>
            <p className="text-xs text-muted-foreground">You've earned KSH {balance.toLocaleString()} / KSH 1,500 cap</p>
          </div>
        </div>
      </div>

      <div className="px-4 py-3">
        <div className="bg-card rounded-xl p-3 border border-primary/30">
          <div className="flex items-start gap-2">
            <Zap className="w-4 h-4 text-primary flex-shrink-0 mt-0.5" />
            <div>
              <p className="text-xs font-semibold text-foreground mb-0.5">
                {balance >= 1500 ? "🎉 You've reached the withdrawal threshold!" : `Unlock more surveys! You have KSH ${balance.toLocaleString()}. Need KSH ${(1500 - balance).toLocaleString()} more to withdraw.`}
              </p>
              <p className="text-[10px] text-muted-foreground">Choose a category below and unlock it to earn more!</p>
            </div>
          </div>
        </div>
        <div className="mt-2 flex items-center gap-1.5 text-[10px] text-muted-foreground bg-primary/10 rounded-full px-2.5 py-1 w-fit mx-auto">
          <span>🔥</span>
          <span className="font-medium">{usersUnlockedToday} users unlocked today</span>
        </div>
      </div>

      <div className="flex border-b border-border px-4">
        <button onClick={() => setActiveTab('unlock')} className={`flex-1 py-2.5 text-xs font-semibold transition-colors relative ${activeTab === 'unlock' ? 'text-primary' : 'text-muted-foreground'}`}>
          <div className="flex items-center justify-center gap-1.5">
            <FolderOpen className="w-3.5 h-3.5" /> Unlock Categories
          </div>
          {activeTab === 'unlock' && <div className="absolute bottom-0 left-0 right-0 h-0.5 bg-primary" />}
        </button>
        <button onClick={() => setActiveTab('upgrade')} className={`flex-1 py-2.5 text-xs font-semibold transition-colors relative ${activeTab === 'upgrade' ? 'text-primary' : 'text-muted-foreground'}`}>
          <div className="flex items-center justify-center gap-1.5">
            <TrendingUp className="w-3.5 h-3.5" /> Upgrade Account
          </div>
          {activeTab === 'upgrade' && <div className="absolute bottom-0 left-0 right-0 h-0.5 bg-primary" />}
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
                  <div className="flex justify-between"><span>Unlock Price:</span><span className="font-bold">KSH {selectedCategory.unlockPrice}</span></div>
                  <div className="flex justify-between"><span>Surveys:</span><span className="font-bold">{selectedCategory.surveyCount} surveys</span></div>
                  <div className="flex justify-between"><span>Earn up to:</span><span className="font-bold">KSH {selectedCategory.totalEarnPotential}</span></div>
                </div>
              </div>
              <div>
                <label className="text-xs font-medium text-foreground mb-1.5 block">M-Pesa Number</label>
                <input type="tel" value={phoneNumber} onChange={(e) => setPhoneNumber(e.target.value)} placeholder="0712345678" className="w-full h-10 rounded-lg bg-card border border-border px-3 text-sm" />
              </div>
              <div className="flex gap-2">
                <button onClick={() => setShowPayment(false)} className="flex-1 h-10 rounded-lg bg-secondary text-secondary-foreground font-semibold text-xs">Back</button>
                <button onClick={() => handleUnlockCategory(selectedCategory)} disabled={isProcessing} className="flex-1 h-10 rounded-lg bg-primary text-white font-semibold text-xs flex items-center justify-center gap-1.5">
                  {isProcessing ? <><Loader2 className="w-3.5 h-3.5 animate-spin" /> Processing...</> : `Unlock KSH ${selectedCategory.unlockPrice}`}
                </button>
              </div>
            </div>
          ) : (
            <div className="grid grid-cols-1 gap-2">
              {availableCategories.length === 0 ? (
                <div className="text-center py-8">
                  <p className="text-sm text-muted-foreground mb-2">All categories unlocked!</p>
                  <button onClick={() => navigate('/extra-surveys')} className="mt-3 px-4 py-2 bg-primary text-white rounded-lg text-sm font-semibold">Go to Extra Surveys</button>
                </div>
              ) : (
                availableCategories.map((category) => (
                  <div key={category.id} onClick={() => { setSelectedCategory(category); setShowPayment(true); }} className={`rounded-xl p-3 border cursor-pointer active:scale-[0.98] transition-transform ${getCategoryColor(category.color)}`}>
                    <div className="flex items-start justify-between gap-2">
                      <div className="flex-1 min-w-0">
                        <h3 className="font-semibold text-sm truncate">{category.name}</h3>
                        <p className="text-xs mt-1 opacity-80">{category.description}</p>
                        <div className="flex items-center gap-2 mt-2 text-[10px]">
                          <FolderOpen className="w-3 h-3" /> {category.surveyCount} surveys
                        </div>
                      </div>
                      <div className="text-right flex-shrink-0">
                        <p className="font-bold text-sm">KSH {category.unlockPrice}</p>
                        <p className="text-[10px] mt-1">Earn up to KSH {category.totalEarnPotential} more</p>
                      </div>
                    </div>
                  </div>
                ))
              )}
            </div>
          )
        ) : (
          <div className="text-center py-8 text-muted-foreground">Upgrade options coming soon</div>
        )}
      </div>

      <BottomNav />
    </div>
  );
}
