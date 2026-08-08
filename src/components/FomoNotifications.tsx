import { useState, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { CheckCircle2, X, Sparkles, TrendingUp } from "lucide-react";
import mpesaIcon from "@/assets/mpesa-icon.png";

interface WithdrawalEvent {
  id: string;
  name: string;
  phone: string;
  amount: number;
  timeAgo: string;
}

const KENYAN_NAMES = [
  "Kevin M.", "Mercy W.", "Dennis K.", "Brian N.", "Faith C.", 
  "James O.", "Grace N.", "Peter M.", "Joy K.", "Victor O.", 
  "Brenda A.", "Samuel K.", "Anita W.", "Collins O.", "Stacy M."
];

const PHONE_PREFIXES = ["0712", "0722", "0798", "0745", "0701", "0757", "0768", "0790", "0719", "0742"];

function getRandomInt(min: number, max: number) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

function generateRandomEvent(): WithdrawalEvent {
  // Amounts between 4,000 and 16,000 rounded to nearest 500 or 100
  const baseAmount = getRandomInt(40, 160) * 100;
  const name = KENYAN_NAMES[getRandomInt(0, KENYAN_NAMES.length - 1)];
  const prefix = PHONE_PREFIXES[getRandomInt(0, PHONE_PREFIXES.length - 1)];
  const suffix = getRandomInt(100, 999);
  const phone = `${prefix}***${suffix}`;
  const timeAgo = `${getRandomInt(1, 4)} min ago`;

  return {
    id: `${Date.now()}-${Math.random()}`,
    name,
    phone,
    amount: baseAmount,
    timeAgo,
  };
}

export const FomoNotifications = () => {
  const [currentEvent, setCurrentEvent] = useState<WithdrawalEvent | null>(null);
  const [active, setActive] = useState(true);

  useEffect(() => {
    // Session 60s timer limit check
    const startTimeKey = "fomo_session_start";
    let sessionStart = sessionStorage.getItem(startTimeKey);
    if (!sessionStart) {
      sessionStart = Date.now().toString();
      sessionStorage.setItem(startTimeKey, sessionStart);
    }

    const elapsed = Date.now() - parseInt(sessionStart, 10);
    const remainingTime = 60000 - elapsed;

    if (remainingTime <= 0) {
      setActive(false);
      return;
    }

    // Stop active notifications after 60s from initial login/mount session
    const masterTimeout = setTimeout(() => {
      setActive(false);
      setCurrentEvent(null);
    }, remainingTime);

    // Initial popup delay (3 seconds after page loads)
    const initialDelay = setTimeout(() => {
      triggerNotification();
    }, 3000);

    let intervalId: NodeJS.Timeout;

    function triggerNotification() {
      const event = generateRandomEvent();
      setCurrentEvent(event);

      // Auto-hide popup after 4 seconds
      setTimeout(() => {
        setCurrentEvent(null);
      }, 4500);
    }

    // Interval to spawn popup every 10-14 seconds
    intervalId = setInterval(() => {
      triggerNotification();
    }, 11000);

    return () => {
      clearTimeout(masterTimeout);
      clearTimeout(initialDelay);
      clearInterval(intervalId);
    };
  }, []);

  if (!active || !currentEvent) return null;

  return (
    <div className="fixed top-4 left-1/2 -translate-x-1/2 z-[120] w-[92%] max-w-sm pointer-events-auto">
      <AnimatePresence mode="wait">
        <motion.div
          key={currentEvent.id}
          initial={{ opacity: 0, y: -25, scale: 0.92 }}
          animate={{ opacity: 1, y: 0, scale: 1 }}
          exit={{ opacity: 0, y: -20, scale: 0.95 }}
          transition={{ type: "spring", stiffness: 350, damping: 25 }}
          className="relative bg-card/95 backdrop-blur-xl border border-primary/20 shadow-2xl rounded-2xl p-3.5 flex items-center gap-3 overflow-hidden group"
        >
          {/* Subtle animated background gradient pulse */}
          <div className="absolute inset-0 bg-gradient-to-r from-emerald-500/10 via-primary/5 to-transparent pointer-events-none" />

          {/* M-Pesa Icon badge */}
          <div className="relative shrink-0">
            <div className="w-11 h-11 rounded-xl bg-emerald-500/10 border border-emerald-500/20 flex items-center justify-center p-1.5">
              <img src={mpesaIcon} alt="M-Pesa" className="w-full h-full object-contain" />
            </div>
            <span className="absolute -top-1 -right-1 w-3 h-3 bg-emerald-500 rounded-full border-2 border-card animate-pulse" />
          </div>

          {/* Details */}
          <div className="flex-1 min-w-0">
            <div className="flex items-center gap-1.5 text-xs text-muted-foreground font-medium">
              <span className="font-bold text-foreground truncate">{currentEvent.name}</span>
              <span className="text-[10px] text-muted-foreground/80">({currentEvent.phone})</span>
            </div>
            <div className="flex items-baseline gap-1 mt-0.5">
              <span className="text-xs font-semibold text-muted-foreground">withdrew</span>
              <span className="text-sm font-extrabold text-emerald-600 dark:text-emerald-400 tracking-tight">
                KSH {currentEvent.amount.toLocaleString()}
              </span>
              <span className="text-[10px] text-muted-foreground ml-auto">{currentEvent.timeAgo}</span>
            </div>
          </div>

          {/* Close button */}
          <button
            onClick={() => setCurrentEvent(null)}
            className="w-7 h-7 rounded-full bg-secondary/80 hover:bg-secondary flex items-center justify-center text-muted-foreground transition-colors shrink-0"
          >
            <X size={14} />
          </button>
        </motion.div>
      </AnimatePresence>
    </div>
  );
};
