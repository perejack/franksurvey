import { Link } from "react-router-dom";
import { ArrowLeft } from "lucide-react";

const Privacy = () => {
  return (
    <div className="min-h-screen bg-background">
      <header className="border-b border-border sticky top-0 bg-background/90 backdrop-blur z-10">
        <div className="max-w-3xl mx-auto px-5 h-14 flex items-center gap-3">
          <Link to="/landing" className="flex items-center gap-2 text-foreground hover:text-primary transition-colors">
            <ArrowLeft size={18} />
            <span className="font-semibold text-sm">Back</span>
          </Link>
          <h1 className="font-extrabold text-base">Privacy Policy</h1>
        </div>
      </header>

      <main className="max-w-3xl mx-auto px-5 py-8">
        <p className="text-sm text-muted-foreground mb-6">Last updated: April 24, 2026</p>

        <section className="space-y-4 text-foreground">
          <h2 className="text-xl font-bold mt-6">1. Introduction</h2>
          <p>Survey Pay ("we", "us", "our") respects your privacy. This Privacy Policy explains how we collect, use, and safeguard information when you use our website at https://www.surveypaykenya.site/ and related services.</p>

          <h2 className="text-xl font-bold mt-6">2. Information We Collect</h2>
          <ul className="list-disc pl-5 space-y-1">
            <li><strong>Account information:</strong> name and email address used for sign-up.</li>
            <li><strong>Survey responses:</strong> answers you submit when participating in surveys.</li>
            <li><strong>Payment details:</strong> M-Pesa phone number used solely to deliver rewards.</li>
            <li><strong>Technical data:</strong> device type, browser, IP address, and usage logs.</li>
          </ul>

          <h2 className="text-xl font-bold mt-6">3. How We Use Your Information</h2>
          <p>We use your information to operate the platform, deliver survey rewards, prevent fraud, communicate with you about your account, and improve our service.</p>

          <h2 className="text-xl font-bold mt-6">4. Data Sharing</h2>
          <p>We do not sell your personal information. We may share aggregated, non-identifiable survey data with research partners. Personal data may be disclosed only when required by law.</p>

          <h2 className="text-xl font-bold mt-6">5. Data Security</h2>
          <p>We use industry-standard encryption (HTTPS/TLS) and access controls to protect your data. No method of transmission over the internet is 100% secure, but we work continuously to protect your information.</p>

          <h2 className="text-xl font-bold mt-6">6. Your Rights</h2>
          <p>You may request access to, correction of, or deletion of your personal data at any time by contacting us at the address below. We comply with the Kenya Data Protection Act, 2019.</p>

          <h2 className="text-xl font-bold mt-6">7. Cookies</h2>
          <p>We use essential cookies and local storage to keep you signed in and remember preferences. We do not use cookies for cross-site advertising.</p>

          <h2 className="text-xl font-bold mt-6">8. Children</h2>
          <p>Survey Pay is not intended for users under 18 years of age. We do not knowingly collect data from children.</p>

          <h2 className="text-xl font-bold mt-6">9. Third-Party Services</h2>
          <p>We use Google Analytics and M-Pesa (Safaricom PLC) to operate the service. Their use of your data is governed by their respective privacy policies.</p>

          <h2 className="text-xl font-bold mt-6">10. Changes to This Policy</h2>
          <p>We may update this Privacy Policy periodically. Material changes will be communicated through the platform.</p>

          <h2 className="text-xl font-bold mt-6">11. Contact Us</h2>
          <p>For privacy questions, email <a href="mailto:axontechnologies103@gmail.com" className="text-primary underline">axontechnologies103@gmail.com</a> or write to us at 209 Lenana Road, Nairobi, 00100, Kenya.</p>
        </section>
      </main>
    </div>
  );
};

export default Privacy;
