import { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { X, Smartphone, CheckCircle2, AlertCircle, Lock, Sparkles, Zap } from "lucide-react";
import mpesaIcon from "@/assets/mpesa-icon.png";
import { initiateSTKPush, pollTransactionStatus, isValidPhoneNumber } from "@/lib/hashback-api";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/contexts/AuthContext";
import { toast } from "sonner";

interface Survey {
  id: string;
  title: string;
  reward: number;
  unlock_price: number;
  category: string;
}

interface UnlockTaskModalProps {
  isOpen: boolean;
  onClose: () => void;
  surveys: Survey[];
  onUnlock: (surveyId: string) => void;
}

const unlockOptions = [
  { price: 200, label: "Starter", color: "from-gray-500 to-gray-600", icon: Zap },
  { price: 350, label: "Basic", color: "from-blue-500 to-blue-600", icon: Sparkles },
  { price: 500, label: "Pro", color: "from-purple-500 to-purple-600", icon: Lock },
  { price: 600, label: "Elite", color: "from-amber-500 to-amber-600", icon: Sparkles },
];

const UnlockTaskModal = ({ isOpen, onClose, surveys, onUnlock }: UnlockTaskModalProps) => {
  const { profile } = useAuth();
  const [selectedPrice, setSelectedPrice] = useState<number | null>(null);
  const [phone, setPhone] = useState("");
  const [step, setStep] = useState<"select" | "form" | "processing" | "success" | "error">("select");
  const [errorMessage, setErrorMessage] = useState("");
  const [unlockedSurvey, setUnlockedSurvey] = useState<Survey | null>(null);

  const isValidPhone = isValidPhoneNumber(phone);

  const handleSelectPrice = (price: number) => {
    setSelectedPrice(price);
    // Find a survey that matches this unlock price or assign one
    const surveyToUnlock = surveys.find(s => s.unlock_price === price) || surveys[0];
    setUnlockedSurvey(surveyToUnlock);
    setStep("form");
  };

  const handlePay = async () => {
    if (!isValidPhone || !profile?.id || !selectedPrice || !unlockedSurvey) return;
    
    setStep("processing");
    setErrorMessage("");

    try {
      const reference = `UNLOCK-${unlockedSurvey.id}-${Date.now()}`;
      
      const response = await initiateSTKPush(String(selectedPrice), phone, reference);
      
      if (response.CheckoutRequestID) {
        await pollTransactionStatus(response.CheckoutRequestID, 30, 3000);
        
        // Create unlock transaction
        const { error: txError } = await supabase
          .from('transactions')
          .insert({
            user_id: profile.id,
            type: 'upgrade',
            amount: selectedPrice,
            status: 'completed',
            phone_number: phone,
            reference: reference,
            description: `Unlocked survey: ${unlockedSurvey.title}`,
            completed_at: new Date().toISOString(),
          });

        if (txError) throw txError;

        onUnlock(unlockedSurvey.id);
        setStep("success");
        toast.success(`Survey unlocked! Earn KSH ${unlockedSurvey.reward}`);
      } else {
        throw new Error(response.ResponseDescription || "Failed to initiate STK Push");
      }
    } catch (error) {
      setErrorMessage(error instanceof Error ? error.message : "Payment failed. Please try again.");
      setStep("error");
    }
  };

  const handleClose = () => {
    setStep("select");
    setSelectedPrice(null);
    setPhone("");
    setErrorMessage("");
    setUnlockedSurvey(null);
    onClose();
  };

  return (
    <AnimatePresence>
      {isOpen && (
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          className="fixed inset-0 z-[100] flex items-end sm:items-center justify-center bg-foreground/60 backdrop-blur-sm"
          onClick={handleClose}
        >
          <motion.div
            initial={{ y: "100%" }}
            animate={{ y: 0 }}
            exit={{ y: "100%" }}
            transition={{ type: "spring", damping: 25, stiffness: 300 }}
            onClick={(e) => e.stopPropagation()}
            className="bg-card w-full max-w-md rounded-t-3xl sm:rounded-3xl p-6 max-h-[90vh] overflow-y-auto"
          >
            <div className="flex items-center justify-between mb-5">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-xl gradient-primary flex items-center justify-center">
                  <Lock size={20} className="text-primary-foreground" />
                </div>
                <div>
                  <h2 className="text-lg font-bold text-card-foreground">Tasks Locked</h2>
                  <p className="text-xs text-muted-foreground">You've reached your daily limit</p>
                </div>
              </div>
              <button onClick={handleClose} className="p-2 rounded-full hover:bg-secondary">
                <X size={20} className="text-muted-foreground" />
              </button>
            </div>

            {/* FOMO Message */}
            <div className="bg-gradient-to-r from-amber-100 to-orange-100 rounded-2xl p-4 mb-5 border border-amber-200">
              <div className="flex items-start gap-3">
                <Sparkles size={24} className="text-amber-600 flex-shrink-0" />
                <div>
                  <p className="text-sm font-bold text-amber-800 mb-1">
                    Don't Miss Out! 🔥
                  </p>
                  <p className="text-xs text-amber-700">
                    You're only <span className="font-bold">KSH 500 away</span> from the withdrawal minimum! 
                    Unlock more high-paying tasks now or upgrade to get unlimited access.
                  </p>
                </div>
              </div>
            </div>

            {step === "select" && (
              <div className="space-y-3">
                <p className="text-sm text-muted-foreground mb-4">
                  Choose a task to unlock. Each unlock gives you access to one high-paying survey:
                </p>
                
                {unlockOptions.map((option) => {
                  const Icon = option.icon;
                  const survey = surveys.find(s => s.unlock_price === option.price);
                  const reward = survey?.reward || 250;
                  
                  return (
                    <motion.button
                      key={option.price}
                      whileTap={{ scale: 0.98 }}
                      onClick={() => handleSelectPrice(option.price)}
                      className="w-full bg-secondary hover:bg-secondary/80 rounded-2xl p-4 flex items-center gap-4 transition-all"
                    >
                      <div className={`w-12 h-12 rounded-xl bg-gradient-to-br ${option.color} flex items-center justify-center`}>
                        <Icon size={24} className="text-white" />
                      </div>
                      <div className="flex-1 text-left">
                        <div className="flex items-center gap-2">
                          <span className="font-bold text-card-foreground">{option.label} Task</span>
                          <span className="text-xs bg-green-100 text-green-700 px-2 py-0.5 rounded-full">
                            +KSH {reward}
                          </span>
                        </div>
                        <p className="text-xs text-muted-foreground">Unlock for KSH {option.price}</p>
                      </div>
                      <div className="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center">
                        <Sparkles size={16} className="text-primary" />
                      </div>
                    </motion.button>
                  );
                })}

                <div className="pt-4 border-t border-border mt-4">
                  <p className="text-xs text-center text-muted-foreground mb-3">
                    Want unlimited tasks?
                  </p>
                  <motion.button
                    whileTap={{ scale: 0.98 }}
                    onClick={() => {
                      handleClose();
                      // Navigate to upgrade page
                      window.location.href = "/wallet?tab=upgrade";
                    }}
                    className="w-full h-12 rounded-2xl gradient-gold text-accent-foreground font-bold text-sm"
                  >
                    Upgrade to Premium Package 🚀
                  </motion.button>
                </div>
              </div>
            )}

            {step === "form" && selectedPrice && unlockedSurvey && (
              <div className="space-y-5">
                <button 
                  onClick={() => setStep("select")}
                  className="text-sm text-muted-foreground flex items-center gap-1"
                >
                  ← Back to options
                </button>

                <div className="bg-secondary rounded-2xl p-4 space-y-3">
                  <div className="flex justify-between items-center">
                    <span className="text-sm text-muted-foreground">Task</span>
                    <span className="font-bold text-card-foreground text-right max-w-[60%]">{unlockedSurvey.title}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-sm text-muted-foreground">Reward</span>
                    <span className="font-bold text-green-600">+KSH {unlockedSurvey.reward}</span>
                  </div>
                  <div className="flex justify-between">
                    <span className="text-sm text-muted-foreground">Unlock Fee</span>
                    <span className="font-bold text-primary">KSH {selectedPrice}</span>
                  </div>
                  <div className="border-t border-border pt-2 mt-2">
                    <div className="flex justify-between">
                      <span className="text-sm font-bold text-card-foreground">Net Earning</span>
                      <span className="font-bold text-green-600">KSH {unlockedSurvey.reward - selectedPrice}</span>
                    </div>
                  </div>
                </div>

                <div>
                  <label className="text-sm font-medium text-muted-foreground mb-2 block">
                    M-Pesa Phone Number
                  </label>
                  <div className="relative">
                    <Smartphone size={18} className="absolute left-4 top-1/2 -translate-y-1/2 text-muted-foreground" />
                    <input
                      type="tel"
                      value={phone}
                      onChange={(e) => setPhone(e.target.value)}
                      placeholder="0712345678"
                      maxLength={10}
                      className="w-full h-14 rounded-2xl bg-secondary pl-12 pr-4 text-lg font-semibold text-card-foreground outline-none focus:ring-2 focus:ring-primary transition"
                    />
                  </div>
                </div>

                <div className="bg-amber-50 rounded-xl p-3 border border-amber-200">
                  <p className="text-xs text-amber-800 text-center">
                    ⚡ Limited time: This task expires in <span className="font-bold">24 hours</span>
                  </p>
                </div>

                <motion.button
                  whileTap={{ scale: 0.97 }}
                  onClick={handlePay}
                  disabled={!isValidPhone}
                  className="w-full h-14 rounded-2xl gradient-primary text-primary-foreground font-bold text-base shadow-primary disabled:opacity-40 disabled:cursor-not-allowed flex items-center justify-center gap-2"
                >
                  <img src={mpesaIcon} alt="M-Pesa" className="w-6 h-6" />
                  Pay KSH {selectedPrice} to Unlock
                </motion.button>
              </div>
            )}

            {step === "processing" && (
              <div className="text-center py-8 space-y-4">
                <motion.div
                  animate={{ rotate: 360 }}
                  transition={{ repeat: Infinity, duration: 1.2, ease: "linear" }}
                  className="w-16 h-16 border-4 border-primary/20 border-t-primary rounded-full mx-auto"
                />
                <h3 className="text-lg font-bold text-card-foreground">Sending STK Push...</h3>
                <p className="text-sm text-muted-foreground">Check your phone and enter M-Pesa PIN</p>
                <p className="text-xs text-muted-foreground">
                  Unlocking task worth KSH {selectedPrice}
                </p>
              </div>
            )}

            {step === "success" && (
              <motion.div 
                initial={{ scale: 0.8, opacity: 0 }} 
                animate={{ scale: 1, opacity: 1 }} 
                className="text-center py-6 space-y-4"
              >
                <motion.div 
                  initial={{ scale: 0 }} 
                  animate={{ scale: 1 }} 
                  transition={{ delay: 0.2, type: "spring" }}
                  className="w-20 h-20 bg-green-100 rounded-full flex items-center justify-center mx-auto"
                >
                  <CheckCircle2 size={40} className="text-green-600" />
                </motion.div>
                <h3 className="text-xl font-bold text-card-foreground">Task Unlocked! 🎉</h3>
                <p className="text-sm text-muted-foreground px-4">
                  You can now complete <span className="font-bold text-primary">{unlockedSurvey?.title}</span> and earn 
                  <span className="font-bold text-green-600"> KSH {unlockedSurvey?.reward}</span>
                </p>
                <button 
                  onClick={handleClose} 
                  className="w-full h-12 rounded-2xl gradient-primary text-primary-foreground font-bold"
                >
                  Start Earning Now
                </button>
              </motion.div>
            )}

            {step === "error" && (
              <div className="text-center py-6 space-y-4">
                <div className="w-16 h-16 bg-destructive/10 rounded-full flex items-center justify-center mx-auto">
                  <AlertCircle size={32} className="text-destructive" />
                </div>
                <h3 className="text-xl font-bold text-card-foreground">Payment Failed</h3>
                <p className="text-sm text-destructive px-4">{errorMessage}</p>
                <div className="flex gap-3 px-4">
                  <button 
                    onClick={() => setStep("form")} 
                    className="flex-1 h-12 rounded-2xl bg-secondary text-secondary-foreground font-semibold"
                  >
                    Try Again
                  </button>
                </div>
              </div>
            )}
          </motion.div>
        </motion.div>
      )}
    </AnimatePresence>
  );
};

export default UnlockTaskModal;
