import { Link } from "react-router-dom";
import { ArrowLeft, Mail, MessageCircle, Clock, MapPin } from "lucide-react";

const Contact = () => {
  return (
    <div className="min-h-screen bg-background">
      <header className="border-b border-border sticky top-0 bg-background/90 backdrop-blur z-10">
        <div className="max-w-3xl mx-auto px-5 h-14 flex items-center gap-3">
          <Link to="/landing" className="flex items-center gap-2 text-foreground hover:text-primary transition-colors">
            <ArrowLeft size={18} />
            <span className="font-semibold text-sm">Back</span>
          </Link>
          <h1 className="font-extrabold text-base">Contact Us</h1>
        </div>
      </header>

      <main className="max-w-3xl mx-auto px-5 py-8 space-y-6">
        <div>
          <h2 className="text-2xl font-black text-foreground mb-2">We're here to help</h2>
          <p className="text-muted-foreground">Reach out for support, feedback, or partnership inquiries. We respond to every message.</p>
        </div>

        <div className="grid gap-4 sm:grid-cols-2">
          <div className="bg-card border border-border rounded-2xl p-5">
            <Mail className="text-primary mb-3" size={22} />
            <h3 className="font-bold text-card-foreground mb-1">Email Support</h3>
            <p className="text-sm text-muted-foreground mb-2">For account help, withdrawals, and general questions.</p>
            <a href="mailto:axontechnologies103@gmail.com" className="text-sm text-primary font-semibold underline break-all">axontechnologies103@gmail.com</a>
          </div>

          <div className="bg-card border border-border rounded-2xl p-5">
            <MessageCircle className="text-primary mb-3" size={22} />
            <h3 className="font-bold text-card-foreground mb-1">Partnerships & Press</h3>
            <p className="text-sm text-muted-foreground mb-2">Research firms, brand partners, and media inquiries.</p>
            <a href="mailto:axontechnologies103@gmail.com" className="text-sm text-primary font-semibold underline break-all">axontechnologies103@gmail.com</a>
          </div>

          <div className="bg-card border border-border rounded-2xl p-5">
            <Clock className="text-primary mb-3" size={22} />
            <h3 className="font-bold text-card-foreground mb-1">Response Times</h3>
            <p className="text-sm text-muted-foreground">Mon–Fri, 9:00–17:00 EAT. Most emails are answered within 1–2 business days.</p>
          </div>

          <div className="bg-card border border-border rounded-2xl p-5">
            <MapPin className="text-primary mb-3" size={22} />
            <h3 className="font-bold text-card-foreground mb-1">Office Address</h3>
            <p className="text-sm text-muted-foreground">209 Lenana Road<br />Nairobi, 00100<br />Kenya</p>
          </div>
        </div>

        <div className="bg-muted/30 rounded-2xl p-5 border border-border">
          <h3 className="font-bold text-foreground mb-2">Frequently asked</h3>
          <ul className="space-y-2 text-sm text-muted-foreground">
            <li><strong className="text-foreground">How do I withdraw rewards?</strong> Sign in, open your wallet, and request an M-Pesa withdrawal once you reach the minimum balance.</li>
            <li><strong className="text-foreground">Why are no surveys available?</strong> Survey availability depends on partner research demand and your profile match.</li>
            <li><strong className="text-foreground">Account disabled?</strong> Email us with your registered details for review.</li>
          </ul>
        </div>
      </main>
    </div>
  );
};

export default Contact;
