import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import { AuthProvider, useAuth } from "@/contexts/AuthContext";
import Index from "./pages/Index";
import SurveyTake from "./pages/SurveyTake";
import WalletPage from "./pages/WalletPage";
import Profile from "./pages/Profile";
import Login from "./pages/Login";
import Signup from "./pages/Signup";
import Landing from "./pages/Landing";
import Privacy from "./pages/Privacy";
import Terms from "./pages/Terms";
import Contact from "./pages/Contact";
import About from "./pages/About";
import Disclaimer from "./pages/Disclaimer";
import Refund from "./pages/Refund";
import EarningCapPage from "./pages/EarningCapPage";
import ExtraSurveys from "./pages/ExtraSurveys";
import NotFound from "./pages/NotFound";
import BottomNav from "./components/BottomNav";

const queryClient = new QueryClient();

function ProtectedRoute({ children }: { children: React.ReactNode }) {
  const { session, isLoading } = useAuth();
  
  if (isLoading) {
    return <div className="min-h-screen flex items-center justify-center">Loading...</div>;
  }
  
  if (!session) {
    return <Navigate to="/landing" replace />;
  }
  
  return <>{children}</>;
}

function AppContent() {
  const { session } = useAuth();
  const location = window.location.pathname;
  const isLanding = ["/landing", "/login", "/signup", "/privacy", "/terms", "/contact", "/about", "/disclaimer", "/refund"].includes(location);
  
  return (
    <div className={`min-h-screen relative ${isLanding ? "" : "max-w-lg mx-auto"}`}>
      <Routes>
        <Route path="/landing" element={<Landing />} />
        <Route path="/login" element={<Login />} />
        <Route path="/signup" element={<Signup />} />
        <Route path="/privacy" element={<Privacy />} />
        <Route path="/terms" element={<Terms />} />
        <Route path="/contact" element={<Contact />} />
        <Route path="/about" element={<About />} />
        <Route path="/disclaimer" element={<Disclaimer />} />
        <Route path="/refund" element={<Refund />} />
        <Route path="/" element={<ProtectedRoute><Index /></ProtectedRoute>} />
        <Route path="/surveys" element={<ProtectedRoute><Navigate to="/" replace /></ProtectedRoute>} />
        <Route path="/survey/:id" element={<ProtectedRoute><SurveyTake /></ProtectedRoute>} />
        <Route path="/wallet" element={<ProtectedRoute><WalletPage /></ProtectedRoute>} />
        <Route path="/earning-cap" element={<ProtectedRoute><EarningCapPage /></ProtectedRoute>} />
        <Route path="/extra-surveys" element={<ProtectedRoute><ExtraSurveys /></ProtectedRoute>} />
        <Route path="/profile" element={<ProtectedRoute><Profile /></ProtectedRoute>} />
        <Route path="*" element={<NotFound />} />
      </Routes>
      {session && <BottomNav />}
    </div>
  );
}

const App = () => (
  <QueryClientProvider client={queryClient}>
    <AuthProvider>
      <TooltipProvider>
        <Toaster />
        <Sonner />
        <BrowserRouter>
          <AppContent />
        </BrowserRouter>
      </TooltipProvider>
    </AuthProvider>
  </QueryClientProvider>
);

export default App;
