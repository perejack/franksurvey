import { Link } from "react-router-dom";
import { ArrowLeft } from "lucide-react";

const Disclaimer = () => {
  return (
    <div className="min-h-screen bg-background">
      <header className="border-b border-border sticky top-0 bg-background/90 backdrop-blur z-10">
        <div className="max-w-3xl mx-auto px-5 h-14 flex items-center gap-3">
          <Link to="/landing" className="flex items-center gap-2 text-foreground hover:text-primary transition-colors">
            <ArrowLeft size={18} />
            <span className="font-semibold text-sm">Back</span>
          </Link>
          <h1 className="font-extrabold text-base">Disclaimer</h1>
        </div>
      </header>

      <main className="max-w-3xl mx-auto px-5 py-8">
        <p className="text-sm text-muted-foreground mb-6">Last updated: April 24, 2026</p>
        <section className="space-y-4 text-foreground">
          <h2 className="text-xl font-bold">Earnings Disclaimer</h2>
          <p>Survey Pay is a market-research participation platform. Reward amounts shown anywhere on this site or in the application are illustrative examples, not a promise of income. Actual earnings depend on survey availability, your profile match, and partner-research budgets. Many users will earn small amounts; some may not qualify for surveys at any given time.</p>

          <h2 className="text-xl font-bold mt-6">No Guaranteed Income</h2>
          <p>Survey Pay does not guarantee any minimum income, frequency of surveys, or speed of payouts. We do not present this service as a job, employment opportunity, or "get-rich" scheme.</p>

          <h2 className="text-xl font-bold mt-6">Third-Party Services</h2>
          <p>Withdrawals are processed through Safaricom M-Pesa. We are not responsible for delays, fees, or outages caused by third-party payment networks.</p>

          <h2 className="text-xl font-bold mt-6">Accuracy of Information</h2>
          <p>We strive to keep all information accurate and up to date, but we make no warranties about completeness, reliability, or fitness for a particular purpose.</p>

          <h2 className="text-xl font-bold mt-6">External Links</h2>
          <p>Our website may contain links to external sites. We are not responsible for the content or privacy practices of those sites.</p>

          <h2 className="text-xl font-bold mt-6">Contact</h2>
          <p>Questions? Email <a href="mailto:axontechnologies103@gmail.com" className="text-primary underline">axontechnologies103@gmail.com</a>.</p>
        </section>
      </main>
    </div>
  );
};

export default Disclaimer;
