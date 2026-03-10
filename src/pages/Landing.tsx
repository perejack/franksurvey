import { useState, useEffect } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { ArrowRight, CheckCircle2, Star, Zap, TrendingUp, Users, ChevronRight, Sparkles } from "lucide-react";
import { useNavigate } from "react-router-dom";
import heroImg from "@/assets/landing-hero-person.jpg";
import phoneMockup from "@/assets/landing-phone-mockup.png";
import earnImg from "@/assets/landing-earn.png";
import secureImg from "@/assets/landing-secure.png";
import mpesaImg from "@/assets/landing-mpesa.png";
import testimonialImg from "@/assets/landing-testimonial.jpg";

const STEPS = [
  { num: "01", title: "Create Your Account", desc: "Sign up in seconds — it's free to join and get started", icon: Users },
  { num: "02", title: "Complete Surveys", desc: "Share your opinions on topics you care about across many categories", icon: CheckCircle2 },
  { num: "03", title: "Get Paid via M-Pesa", desc: "Withdraw your survey rewards directly to your M-Pesa account", icon: Zap },
];

const FEATURES = [
  { img: earnImg, title: "Get Rewarded for Your Opinions", desc: "Complete surveys on topics you enjoy and earn rewards for each one. The more you participate, the more you can earn." },
  { img: secureImg, title: "Secure & Verified Platform", desc: "Your data is protected with industry-standard encryption. Every transaction is verified and transparent." },
  { img: mpesaImg, title: "M-Pesa Withdrawals", desc: "Cash out your rewards directly to M-Pesa. Simple, convenient, and designed for Kenyan users." },
];

const TESTIMONIALS = [
  { name: "Faith W.", location: "Nairobi", text: "I really enjoy sharing my opinions through surveys. The platform is easy to use and payments arrive quickly.", avatar: "🧑‍🦱" },
  { name: "James O.", location: "Kisumu", text: "Great way to share feedback and earn something extra. I like doing surveys during my free time.", avatar: "👨" },
  { name: "Grace M.", location: "Mombasa", text: "The premium surveys are interesting and the M-Pesa integration makes everything so convenient.", avatar: "👩" },
];

const AppLoader = ({ onComplete }: { onComplete: () => void }) => {
  const [progress, setProgress] = useState(0);

  useEffect(() => {
    const interval = setInterval(() => {
      setProgress((p) => {
        if (p >= 100) {
          clearInterval(interval);
          setTimeout(onComplete, 300);
          return 100;
        }
        return p + Math.random() * 15 + 5;
      });
    }, 150);
    return () => clearInterval(interval);
  }, [onComplete]);

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      className="fixed inset-0 z-[200] bg-foreground flex flex-col items-center justify-center gap-8"
    >
      <motion.div
        initial={{ scale: 0, rotate: -180 }}
        animate={{ scale: 1, rotate: 0 }}
        transition={{ type: "spring", stiffness: 200, damping: 15 }}
        className="relative"
      >
        <div className="w-24 h-24 rounded-3xl gradient-primary flex items-center justify-center shadow-primary">
          <span className="text-4xl font-black text-primary-foreground">S</span>
        </div>
        <motion.div
          animate={{ scale: [1, 1.3, 1], opacity: [0.5, 0, 0.5] }}
          transition={{ repeat: Infinity, duration: 1.5 }}
          className="absolute inset-0 rounded-3xl border-2 border-primary"
        />
      </motion.div>

      <div className="text-center">
        <motion.h2
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
          className="text-xl font-extrabold text-primary-foreground mb-1"
        >
          Survey Pay
        </motion.h2>
        <motion.p
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.5 }}
          className="text-sm text-primary-foreground/50"
        >
          Loading your dashboard...
        </motion.p>
      </div>

      <div className="w-56">
        <div className="h-1.5 bg-primary-foreground/10 rounded-full overflow-hidden">
          <motion.div
            className="h-full gradient-primary rounded-full"
            style={{ width: `${Math.min(progress, 100)}%` }}
            transition={{ ease: "easeOut" }}
          />
        </div>
        <motion.p
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.6 }}
          className="text-xs text-primary-foreground/40 text-center mt-2"
        >
          {Math.min(Math.round(progress), 100)}%
        </motion.p>
      </div>

      <div className="flex gap-2">
        {[0, 1, 2].map((i) => (
          <motion.span
            key={i}
            animate={{ y: [-4, 4, -4] }}
            transition={{ repeat: Infinity, duration: 0.8, delay: i * 0.15 }}
            className="w-2 h-2 rounded-full bg-primary"
          />
        ))}
      </div>
    </motion.div>
  );
};

const Landing = () => {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);
  const [scrollY, setScrollY] = useState(0);

  useEffect(() => {
    const handleScroll = () => setScrollY(window.scrollY);
    window.addEventListener("scroll", handleScroll, { passive: true });
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  const handleGetStarted = () => {
    setLoading(true);
  };

  const handleLoaderComplete = () => {
    navigate("/signup");
  };

  const handleSignIn = () => {
    navigate("/login");
  };

  return (
    <>
      <AnimatePresence>
        {loading && <AppLoader onComplete={handleLoaderComplete} />}
      </AnimatePresence>

      <div className="min-h-screen bg-background overflow-x-hidden">
        <motion.nav
          initial={{ y: -20, opacity: 0 }}
          animate={{ y: 0, opacity: 1 }}
          className="fixed top-0 left-0 right-0 z-50 glass-card border-b border-border/50"
        >
          <div className="max-w-6xl mx-auto px-5 h-16 flex items-center justify-between">
            <div className="flex items-center gap-2">
              <div className="w-9 h-9 rounded-xl gradient-primary flex items-center justify-center">
                <span className="text-lg font-black text-primary-foreground">S</span>
              </div>
              <span className="font-extrabold text-lg text-foreground tracking-tight">Survey Pay</span>
            </div>
            <div className="flex items-center gap-2">
              <motion.button
                whileTap={{ scale: 0.95 }}
                onClick={handleSignIn}
                className="h-10 px-4 rounded-xl text-foreground text-sm font-semibold"
              >
                Sign In
              </motion.button>
              <motion.button
                whileTap={{ scale: 0.95 }}
                onClick={handleGetStarted}
                className="h-10 px-5 rounded-xl gradient-primary text-primary-foreground text-sm font-bold shadow-primary"
              >
                Get Started
              </motion.button>
            </div>
          </div>
        </motion.nav>

        <section className="relative min-h-screen flex items-center pt-16 overflow-hidden">
          <div className="absolute inset-0">
            <img
              src={heroImg}
              alt="Survey Pay user"
              className="w-full h-full object-cover"
              style={{ transform: `translateY(${scrollY * 0.3}px)` }}
            />
            <div className="absolute inset-0 bg-gradient-to-t from-foreground via-foreground/70 to-foreground/30" />
            <div className="absolute inset-0 bg-gradient-to-r from-foreground/80 to-transparent" />
          </div>

          <div className="relative z-10 w-full px-5 py-20">
            <div className="max-w-6xl mx-auto">
              <div className="max-w-xl">
              <motion.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.2 }}
                className="inline-flex items-center gap-2 bg-primary/20 backdrop-blur-sm border border-primary/30 rounded-full px-4 py-1.5 mb-6"
              >
                <Sparkles size={14} className="text-primary" />
                <span className="text-xs font-bold text-primary">Survey Platform for Kenyans</span>
              </motion.div>

              <motion.h1
                initial={{ opacity: 0, y: 30 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.3, duration: 0.6 }}
                className="text-4xl sm:text-5xl lg:text-6xl font-black text-primary-foreground leading-[1.1] tracking-tight mb-5"
              >
                Get Paid for{" "}
                <span className="text-gradient-primary">Sharing</span>{" "}
                Your Opinions
              </motion.h1>

              <motion.p
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.5 }}
                className="text-base sm:text-lg text-primary-foreground/70 leading-relaxed mb-8 max-w-md"
              >
                Complete surveys on topics you enjoy and receive rewards directly to your M-Pesa. Join thousands of Kenyans already participating.
              </motion.p>

              <motion.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.7 }}
                className="flex flex-col sm:flex-row gap-3"
              >
                <motion.button
                  whileTap={{ scale: 0.96 }}
                  whileHover={{ scale: 1.02 }}
                  onClick={handleGetStarted}
                  className="h-14 px-8 rounded-2xl gradient-primary text-primary-foreground font-bold text-base shadow-primary flex items-center justify-center gap-2"
                >
                  Start Earning Now <ArrowRight size={18} />
                </motion.button>
                <motion.button
                  whileTap={{ scale: 0.96 }}
                  onClick={handleSignIn}
                  className="h-14 px-8 rounded-2xl bg-primary-foreground/10 backdrop-blur-sm border border-primary-foreground/20 text-primary-foreground font-bold text-base flex items-center justify-center gap-2"
                >
                  Sign In
                </motion.button>
              </motion.div>

              <motion.div
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                transition={{ delay: 0.9 }}
                className="flex items-center gap-4 mt-8"
              >
                <div className="flex -space-x-2">
                  {["🧑‍🦱", "👩", "👨", "👩‍🦰"].map((e, i) => (
                    <div key={i} className="w-8 h-8 rounded-full bg-primary/30 backdrop-blur-sm border-2 border-foreground flex items-center justify-center text-sm">
                      {e}
                    </div>
                  ))}
                </div>
                <div>
                  <div className="flex items-center gap-1">
                    {[...Array(5)].map((_, i) => (
                      <Star key={i} size={12} className="text-accent fill-accent" />
                    ))}
                  </div>
                  <p className="text-xs text-primary-foreground/60">Joined by thousands of users</p>
                </div>
              </motion.div>
            </div>
          </div>
          </div>

          <motion.div
            animate={{ y: [0, 8, 0] }}
            transition={{ repeat: Infinity, duration: 1.5 }}
            className="absolute bottom-8 left-1/2 -translate-x-1/2"
          >
            <div className="w-6 h-10 rounded-full border-2 border-primary-foreground/30 flex justify-center pt-2">
              <div className="w-1.5 h-3 rounded-full bg-primary" />
            </div>
          </motion.div>
        </section>

        <section className="py-20 sm:py-28 px-5">
          <div className="w-full">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              className="text-center mb-14"
            >
              <span className="text-xs font-bold uppercase tracking-widest text-primary mb-3 block">How It Works</span>
              <h2 className="text-3xl sm:text-4xl font-black text-foreground tracking-tight">
                Three Steps to <span className="text-gradient-primary">Start Earning</span>
              </h2>
            </motion.div>

            <div className="grid sm:grid-cols-3 gap-6 max-w-5xl mx-auto">
              {STEPS.map((step, i) => (
                <motion.div
                  key={step.num}
                  initial={{ opacity: 0, y: 30 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{ delay: i * 0.15 }}
                  className="relative bg-card rounded-3xl p-6 border border-border shadow-card hover:shadow-card-hover transition-all group"
                >
                  <div className="flex items-center gap-3 mb-4">
                    <span className="text-4xl font-black text-primary/15">{step.num}</span>
                    <div className="w-12 h-12 rounded-2xl bg-primary/10 flex items-center justify-center group-hover:bg-primary group-hover:text-primary-foreground transition-colors">
                      <step.icon size={22} className="text-primary group-hover:text-primary-foreground transition-colors" />
                    </div>
                  </div>
                  <h3 className="text-lg font-extrabold text-card-foreground mb-2">{step.title}</h3>
                  <p className="text-sm text-muted-foreground leading-relaxed">{step.desc}</p>
                </motion.div>
              ))}
            </div>
          </div>
        </section>

        <section className="py-20 sm:py-28 px-5 bg-secondary/30">
          <div className="w-full">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              className="text-center mb-14"
            >
              <span className="text-xs font-bold uppercase tracking-widest text-accent mb-3 block">Why Survey Pay</span>
              <h2 className="text-3xl sm:text-4xl font-black text-foreground tracking-tight">
                Built for <span className="text-gradient-coral">Kenyan Users</span>
              </h2>
            </motion.div>

            <div className="space-y-8 max-w-5xl mx-auto">
              {FEATURES.map((feat, i) => (
                <motion.div
                  key={feat.title}
                  initial={{ opacity: 0, y: 30 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{ delay: i * 0.1 }}
                  className={`flex flex-col ${i % 2 === 1 ? "sm:flex-row-reverse" : "sm:flex-row"} items-center gap-8 bg-card rounded-3xl p-6 sm:p-8 border border-border shadow-card`}
                >
                  <div className="w-full sm:w-2/5 flex justify-center">
                    <motion.img
                      whileHover={{ scale: 1.05, rotate: 2 }}
                      src={feat.img}
                      alt={feat.title}
                      className="w-40 h-40 sm:w-48 sm:h-48 object-contain"
                    />
                  </div>
                  <div className="flex-1 text-center sm:text-left">
                    <h3 className="text-xl sm:text-2xl font-extrabold text-card-foreground mb-3">{feat.title}</h3>
                    <p className="text-sm sm:text-base text-muted-foreground leading-relaxed">{feat.desc}</p>
                  </div>
                </motion.div>
              ))}
            </div>
          </div>
        </section>

        <section className="py-20 sm:py-28 px-5 overflow-hidden">
          <div className="w-full max-w-6xl mx-auto flex flex-col sm:flex-row items-center gap-10">
            <motion.div
              initial={{ opacity: 0, x: -40 }}
              whileInView={{ opacity: 1, x: 0 }}
              viewport={{ once: true }}
              className="flex-1"
            >
              <span className="text-xs font-bold uppercase tracking-widest text-primary mb-3 block">The App Experience</span>
              <h2 className="text-3xl sm:text-4xl font-black text-foreground tracking-tight mb-5">
                Beautiful. Fast.{" "}
                <span className="text-gradient-primary">Rewarding.</span>
              </h2>
              <p className="text-muted-foreground leading-relaxed mb-6">
                Our intuitive interface makes participating in surveys enjoyable. Browse categories, track your progress, and withdraw rewards — all in one place.
              </p>
              <div className="space-y-3">
                {["Swipe through survey categories", "Track earnings in real-time", "One-tap M-Pesa withdrawals", "Premium surveys for VIP members"].map((item, i) => (
                  <motion.div
                    key={item}
                    initial={{ opacity: 0, x: -20 }}
                    whileInView={{ opacity: 1, x: 0 }}
                    viewport={{ once: true }}
                    transition={{ delay: i * 0.1 }}
                    className="flex items-center gap-3"
                  >
                    <div className="w-6 h-6 rounded-full bg-primary/10 flex items-center justify-center flex-shrink-0">
                      <CheckCircle2 size={14} className="text-primary" />
                    </div>
                    <span className="text-sm font-medium text-foreground">{item}</span>
                  </motion.div>
                ))}
              </div>
            </motion.div>
            <motion.div
              initial={{ opacity: 0, x: 40, rotate: 5 }}
              whileInView={{ opacity: 1, x: 0, rotate: 0 }}
              viewport={{ once: true }}
              className="flex-shrink-0"
            >
              <motion.img
                animate={{ y: [0, -10, 0] }}
                transition={{ repeat: Infinity, duration: 4, ease: "easeInOut" }}
                src={phoneMockup}
                alt="Survey Pay App"
                className="w-64 sm:w-80 drop-shadow-2xl"
              />
            </motion.div>
          </div>
        </section>

        <section className="py-20 sm:py-28 px-5 bg-secondary/30">
          <div className="w-full max-w-6xl mx-auto">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              className="text-center mb-14"
            >
              <span className="text-xs font-bold uppercase tracking-widest text-primary mb-3 block">Testimonials</span>
              <h2 className="text-3xl sm:text-4xl font-black text-foreground tracking-tight">
                Loved by <span className="text-gradient-primary">Thousands</span>
              </h2>
            </motion.div>

            <motion.div
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              className="bg-card rounded-3xl overflow-hidden border border-border shadow-card mb-8"
            >
              <div className="flex flex-col sm:flex-row">
                <div className="sm:w-2/5">
                  <img src={testimonialImg} alt="Happy Survey Pay user" className="w-full h-48 sm:h-full object-cover" />
                </div>
                <div className="flex-1 p-6 sm:p-8 flex flex-col justify-center">
                  <div className="flex gap-1 mb-3">
                    {[...Array(5)].map((_, i) => (
                      <Star key={i} size={16} className="text-accent fill-accent" />
                    ))}
                  </div>
                  <p className="text-base sm:text-lg text-card-foreground font-medium leading-relaxed mb-4 italic">
                    "Survey Pay makes it so easy to participate in surveys during my free time. The M-Pesa withdrawals are convenient and the interface is really well designed."
                  </p>
                  <div>
                    <p className="font-bold text-card-foreground">Amina O.</p>
                    <p className="text-sm text-muted-foreground">University Student, Nairobi</p>
                  </div>
                </div>
              </div>
            </motion.div>

            <div className="grid sm:grid-cols-3 gap-4">
              {TESTIMONIALS.map((t, i) => (
                <motion.div
                  key={t.name}
                  initial={{ opacity: 0, y: 20 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{ delay: i * 0.1 }}
                  className="bg-card rounded-2xl p-5 border border-border shadow-card"
                >
                  <div className="flex gap-1 mb-3">
                    {[...Array(5)].map((_, j) => (
                      <Star key={j} size={12} className="text-accent fill-accent" />
                    ))}
                  </div>
                  <p className="text-sm text-card-foreground leading-relaxed mb-4 italic">"{t.text}"</p>
                  <div className="flex items-center gap-3">
                    <span className="text-2xl">{t.avatar}</span>
                    <div>
                      <p className="text-sm font-bold text-card-foreground">{t.name}</p>
                      <p className="text-xs text-muted-foreground">{t.location}</p>
                    </div>
                  </div>
                </motion.div>
              ))}
            </div>
          </div>
        </section>

        <section className="py-20 sm:py-28 px-5">
          <div className="w-full max-w-4xl mx-auto">
            <motion.div
              initial={{ opacity: 0, scale: 0.95 }}
              whileInView={{ opacity: 1, scale: 1 }}
              viewport={{ once: true }}
              className="relative rounded-3xl overflow-hidden p-8 sm:p-12 text-center"
            >
              <div className="absolute inset-0 gradient-primary" />
              <div className="absolute -top-16 -right-16 w-48 h-48 rounded-full bg-primary-foreground/10" />
              <div className="absolute -bottom-12 -left-12 w-40 h-40 rounded-full bg-primary-foreground/5" />

              <div className="relative z-10">
                <motion.div
                  animate={{ rotate: [0, 5, -5, 0] }}
                  transition={{ repeat: Infinity, duration: 3 }}
                  className="text-5xl mb-4 inline-block"
                >
                  💰
                </motion.div>
                <h2 className="text-3xl sm:text-4xl font-black text-primary-foreground mb-4 tracking-tight">
                  Ready to Get Started?
                </h2>
                <p className="text-base text-primary-foreground/80 mb-8 max-w-md mx-auto">
                  Join thousands of Kenyans sharing their opinions and earning rewards. Your first survey is waiting.
                </p>
                <motion.button
                  whileTap={{ scale: 0.96 }}
                  whileHover={{ scale: 1.03 }}
                  onClick={handleGetStarted}
                  className="h-14 px-10 rounded-2xl bg-primary-foreground text-primary font-bold text-lg shadow-xl flex items-center justify-center gap-2 mx-auto"
                >
                  Get Started Free <ArrowRight size={20} />
                </motion.button>
              </div>
            </motion.div>
          </div>
        </section>

        <footer className="border-t border-border py-8 px-5">
          <div className="w-full max-w-6xl mx-auto flex flex-col sm:flex-row items-center justify-between gap-4">
            <div className="flex items-center gap-2">
              <div className="w-8 h-8 rounded-lg gradient-primary flex items-center justify-center">
                <span className="text-sm font-black text-primary-foreground">S</span>
              </div>
              <span className="font-bold text-foreground">Survey Pay</span>
            </div>
            <p className="text-xs text-muted-foreground">© 2026 Survey Pay. All rights reserved. Made with 💚 in Kenya.</p>
            <div className="flex gap-4 text-xs text-muted-foreground">
              <a href="#" className="hover:text-primary transition-colors">Privacy</a>
              <a href="#" className="hover:text-primary transition-colors">Terms</a>
              <a href="#" className="hover:text-primary transition-colors">Support</a>
            </div>
          </div>
        </footer>
      </div>
    </>
  );
};

export default Landing;
