import { Link } from "react-router-dom";
import { ArrowLeft } from "lucide-react";

const Terms = () => {
  return (
    <div className="min-h-screen bg-background">
      <header className="border-b border-border sticky top-0 bg-background/90 backdrop-blur z-10">
        <div className="max-w-3xl mx-auto px-5 h-14 flex items-center gap-3">
          <Link to="/landing" className="flex items-center gap-2 text-foreground hover:text-primary transition-colors">
            <ArrowLeft size={18} />
            <span className="font-semibold text-sm">Back</span>
          </Link>
          <h1 className="font-extrabold text-base">Terms of Service</h1>
        </div>
      </header>

      <main className="max-w-3xl mx-auto px-5 py-8">
        <p className="text-sm text-muted-foreground mb-6">Last updated: April 24, 2026</p>

        <section className="space-y-4 text-foreground">
          <h2 className="text-xl font-bold mt-6">1. Acceptance of Terms</h2>
          <p>By creating an account or using Survey Pay (https://www.surveypaykenya.site/), you agree to be bound by these Terms of Service. If you do not agree, do not use the service.</p>

          <h2 className="text-xl font-bold mt-6">2. Eligibility</h2>
          <p>You must be at least 18 years old and a legal resident of Kenya (or another supported region) to use Survey Pay. You are responsible for ensuring all information you provide is accurate.</p>

          <h2 className="text-xl font-bold mt-6">3. Survey Participation and Rewards</h2>
          <p>Survey availability, completion times, and reward amounts are not guaranteed and may vary depending on demand, your profile, and partner-research budgets. Survey Pay does not promise any specific level of income.</p>

          <h2 className="text-xl font-bold mt-6">4. Account Conduct</h2>
          <ul className="list-disc pl-5 space-y-1">
            <li>One account per person.</li>
            <li>Provide truthful answers in surveys.</li>
            <li>Do not use bots, scripts, or automated tools.</li>
            <li>Do not attempt to defraud, manipulate, or abuse the platform.</li>
          </ul>
          <p>Violations may result in suspension, forfeiture of pending rewards, and permanent ban.</p>

          <h2 className="text-xl font-bold mt-6">5. Withdrawals</h2>
          <p>Reward withdrawals are processed via M-Pesa subject to a minimum balance and verification requirements. Processing times depend on third-party payment networks.</p>

          <h2 className="text-xl font-bold mt-6">6. Account Activation Fee</h2>
          <p>A one-time account activation fee may apply to unlock withdrawal capabilities. This fee covers verification and platform infrastructure costs and is disclosed before payment.</p>

          <h2 className="text-xl font-bold mt-6">7. Intellectual Property</h2>
          <p>All Survey Pay content, branding, and software remain the property of Survey Pay. You receive a limited, non-exclusive license to use the platform for personal use only.</p>

          <h2 className="text-xl font-bold mt-6">8. Disclaimers</h2>
          <p>The service is provided "as is" without warranties of any kind. We do not guarantee uninterrupted access or specific outcomes from participation.</p>

          <h2 className="text-xl font-bold mt-6">9. Limitation of Liability</h2>
          <p>To the fullest extent permitted by law, Survey Pay is not liable for indirect, incidental, or consequential damages arising from your use of the service.</p>

          <h2 className="text-xl font-bold mt-6">10. Termination</h2>
          <p>You may close your account at any time. We may suspend or terminate accounts that violate these Terms.</p>

          <h2 className="text-xl font-bold mt-6">11. Governing Law</h2>
          <p>These Terms are governed by the laws of Kenya. Disputes will be resolved in the courts of Nairobi.</p>

          <h2 className="text-xl font-bold mt-6">12. Contact</h2>
          <p>Email <a href="mailto:axontechnologies103@gmail.com" className="text-primary underline">axontechnologies103@gmail.com</a> or write to 209 Lenana Road, Nairobi, 00100, Kenya.</p>
        </section>
      </main>
    </div>
  );
};

export default Terms;
