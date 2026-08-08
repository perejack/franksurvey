import { Link } from "react-router-dom";
import { ArrowLeft } from "lucide-react";

const Refund = () => {
  return (
    <div className="min-h-screen bg-background">
      <header className="border-b border-border sticky top-0 bg-background/90 backdrop-blur z-10">
        <div className="max-w-3xl mx-auto px-5 h-14 flex items-center gap-3">
          <Link to="/landing" className="flex items-center gap-2 text-foreground hover:text-primary transition-colors">
            <ArrowLeft size={18} />
            <span className="font-semibold text-sm">Back</span>
          </Link>
          <h1 className="font-extrabold text-base">Refund Policy</h1>
        </div>
      </header>

      <main className="max-w-3xl mx-auto px-5 py-8">
        <p className="text-sm text-muted-foreground mb-6">Last updated: April 24, 2026</p>
        <section className="space-y-4 text-foreground">
          <h2 className="text-xl font-bold">Account Activation Fee</h2>
          <p>The one-time account activation fee unlocks withdrawal functionality and is generally non-refundable once the account has been activated and access has been granted.</p>

          <h2 className="text-xl font-bold mt-6">Eligibility for a Refund</h2>
          <p>You may request a full refund within <strong>7 days</strong> of payment if:</p>
          <ul className="list-disc pl-5 space-y-1">
            <li>You have not yet completed any survey on the platform; and</li>
            <li>You have not requested a withdrawal.</li>
          </ul>

          <h2 className="text-xl font-bold mt-6">Premium Membership</h2>
          <p>Premium membership packages are refundable on a pro-rata basis within the first 7 days of purchase, provided no premium-locked surveys have been completed.</p>

          <h2 className="text-xl font-bold mt-6">How to Request a Refund</h2>
          <p>Send an email to <a href="mailto:axontechnologies103@gmail.com" className="text-primary underline">axontechnologies103@gmail.com</a> with your registered email, the M-Pesa transaction code, and the reason for the request. We respond within 1–2 business days.</p>

          <h2 className="text-xl font-bold mt-6">Processing Time</h2>
          <p>Approved refunds are returned via M-Pesa within 5–7 business days.</p>

          <h2 className="text-xl font-bold mt-6">Contact</h2>
          <p>Questions about this policy? Reach us at 209 Lenana Road, Nairobi, 00100, Kenya or by email above.</p>
        </section>
      </main>
    </div>
  );
};

export default Refund;
