import { useState, useEffect } from "react";
import { motion } from "framer-motion";
import { Search, Loader2, Lock, Sparkles, Zap } from "lucide-react";
import { useNavigate } from "react-router-dom";
import CategoryChip from "@/components/CategoryChip";
import SurveyCard from "@/components/SurveyCard";
import { CATEGORIES } from "@/lib/store";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/contexts/AuthContext";
import UnlockTaskModal from "@/components/UnlockTaskModal";

const Surveys = () => {
  const navigate = useNavigate();
  const { profile, balance } = useAuth();
  const [activeCategory, setActiveCategory] = useState("all");
  const [search, setSearch] = useState("");
  const [surveys, setSurveys] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [showUnlockModal, setShowUnlockModal] = useState(false);
  
  const EARNING_CAP = 2000;
  const isAtEarningCap = balance >= EARNING_CAP;
  const remainingToWithdraw = Math.max(0, 2500 - balance);

  useEffect(() => {
    fetchSurveys();
  }, []);

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

  const filtered = surveys.filter((s) => {
    const matchesCategory = activeCategory === "all" || s.category === activeCategory;
    const matchesSearch = s.title.toLowerCase().includes(search.toLowerCase());
    // Show ALL surveys including locked ones - SurveyCard will handle locked state
    return matchesCategory && matchesSearch;
  });
  
  const lockedSurveys = surveys.filter((s) => s.is_locked && !s.is_premium);

  if (loading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <Loader2 className="animate-spin text-primary" size={32} />
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background pb-24">
      <div className="px-5 pt-6 pb-4">
        <h1 className="text-2xl font-extrabold text-foreground mb-1">Surveys</h1>
        <p className="text-sm text-muted-foreground mb-4">Pick a survey and start earning</p>

        {/* Search */}
        <div className="relative mb-4">
          <Search size={18} className="absolute left-4 top-1/2 -translate-y-1/2 text-muted-foreground" />
          <input
            type="text"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            placeholder="Search surveys..."
            className="w-full h-12 rounded-2xl bg-card border border-border pl-11 pr-4 text-sm font-medium text-foreground outline-none focus:ring-2 focus:ring-primary transition"
          />
        </div>
      </div>

      {/* Categories */}
      <div className="flex gap-2 overflow-x-auto px-5 pb-4 no-scrollbar">
        <CategoryChip icon="🔥" name="All" isActive={activeCategory === "all"} onClick={() => setActiveCategory("all")} />
        {CATEGORIES.map((cat) => (
          <CategoryChip key={cat.id} icon={cat.icon} name={cat.name} isActive={activeCategory === cat.id} onClick={() => setActiveCategory(cat.id)} />
        ))}
      </div>

      {/* Survey List */}
      <div className="px-5 space-y-3">
        {filtered.length === 0 ? (
          <div className="text-center py-12">
            <p className="text-4xl mb-3">🔍</p>
            <p className="text-muted-foreground font-medium">No surveys found</p>
          </div>
        ) : (
          filtered.map((s, i) => <SurveyCard key={s.id} survey={s} index={i} />)
        )}
        
        {/* Locked Tasks Section - Show when at earning cap */}
        {isAtEarningCap && lockedSurveys.length > 0 && (
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="mt-6"
          >
            <div className="bg-gradient-to-r from-amber-100 to-orange-100 rounded-2xl p-5 border border-amber-200">
              <div className="flex items-start gap-4">
                <div className="w-12 h-12 bg-amber-500 rounded-xl flex items-center justify-center flex-shrink-0">
                  <Lock size={24} className="text-white" />
                </div>
                <div className="flex-1">
                  <h3 className="font-bold text-amber-800 mb-1">🔥 Tasks Locked!</h3>
                  <p className="text-sm text-amber-700 mb-3">
                    You've earned KSH {balance}. You're only 
                    <span className="font-bold"> KSH {remainingToWithdraw}</span> from withdrawal!
                  </p>
                  <div className="bg-white/50 rounded-xl p-3 mb-3">
                    <p className="text-xs text-amber-800 text-center">
                      <span className="font-bold">{lockedSurveys.length} high-paying tasks</span> waiting!
                    </p>
                  </div>
                  <div className="flex gap-2">
                    <motion.button
                      whileTap={{ scale: 0.97 }}
                      onClick={() => setShowUnlockModal(true)}
                      className="flex-1 h-11 bg-amber-500 text-white rounded-xl font-bold text-sm"
                    >
                      Unlock Tasks
                    </motion.button>
                    <motion.button
                      whileTap={{ scale: 0.97 }}
                      onClick={() => navigate("/wallet?tab=upgrade")}
                      className="flex-1 h-11 bg-white text-amber-600 rounded-xl font-bold text-sm border-2 border-amber-500"
                    >
                      Upgrade
                    </motion.button>
                  </div>
                </div>
              </div>
            </div>
          </motion.div>
        )}
      </div>
      
      <UnlockTaskModal
        isOpen={showUnlockModal}
        onClose={() => setShowUnlockModal(false)}
        surveys={lockedSurveys}
        onUnlock={(surveyId) => {
          fetchSurveys();
        }}
      />
    </div>
  );
};

export default Surveys;
