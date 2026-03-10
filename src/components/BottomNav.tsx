import { useLocation, useNavigate } from "react-router-dom";
import { motion } from "framer-motion";

const tabs = [
  { path: "/", icon: "🏠", activeIcon: "🏡", label: "Home" },
  { path: "/surveys", icon: "📋", activeIcon: "📝", label: "Surveys" },
  { path: "/wallet", icon: "💳", activeIcon: "💰", label: "Wallet" },
  { path: "/profile", icon: "👤", activeIcon: "🧑", label: "Profile" },
];

const BottomNav = () => {
  const location = useLocation();
  const navigate = useNavigate();

  if (location.pathname.startsWith("/survey/")) return null;

  return (
    <nav className="fixed bottom-0 left-0 right-0 z-50 glass-card border-t border-border safe-area-bottom">
      <div className="flex items-center justify-around px-2 py-1.5 max-w-lg mx-auto">
        {tabs.map((tab) => {
          const isActive = location.pathname === tab.path;
          return (
            <button
              key={tab.path}
              onClick={() => navigate(tab.path)}
              className="relative flex flex-col items-center gap-0.5 px-5 py-2 rounded-2xl transition-colors"
            >
              {isActive && (
                <motion.div
                  layoutId="activeTab"
                  className="absolute inset-0 bg-primary/10 rounded-2xl"
                  transition={{ type: "spring", bounce: 0.2, duration: 0.5 }}
                />
              )}
              <span className="text-xl relative z-10">
                {isActive ? tab.activeIcon : tab.icon}
              </span>
              <span
                className={`text-[10px] font-bold relative z-10 ${
                  isActive ? "text-primary" : "text-muted-foreground"
                }`}
              >
                {tab.label}
              </span>
            </button>
          );
        })}
      </div>
    </nav>
  );
};

export default BottomNav;
