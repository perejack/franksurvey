import { Link } from "react-router-dom";
import { ArrowLeft, Shield, Users, Target, Heart } from "lucide-react";

const About = () => {
  return (
    <div className="min-h-screen bg-background">
      <header className="border-b border-border sticky top-0 bg-background/90 backdrop-blur z-10">
        <div className="max-w-3xl mx-auto px-5 h-14 flex items-center gap-3">
          <Link to="/landing" className="flex items-center gap-2 text-foreground hover:text-primary transition-colors">
            <ArrowLeft size={18} />
            <span className="font-semibold text-sm">Back</span>
          </Link>
          <h1 className="font-extrabold text-base">About Us</h1>
        </div>
      </header>

      <main className="max-w-3xl mx-auto px-5 py-8 space-y-8">
        <div>
          <h2 className="text-3xl font-black text-foreground mb-3">About Survey Pay</h2>
          <p className="text-muted-foreground leading-relaxed">
            Survey Pay is a Kenyan-built online research platform that connects everyday people with brands, NGOs, and academic researchers who value local insight. Our mission is to make the voice of the Kenyan consumer count — and to fairly compensate participants for the time they share with us.
          </p>
        </div>

        <div className="grid gap-4 sm:grid-cols-2">
          <div className="bg-card border border-border rounded-2xl p-5">
            <Target className="text-primary mb-3" size={22} />
            <h3 className="font-bold text-card-foreground mb-1">Our Mission</h3>
            <p className="text-sm text-muted-foreground">Give Kenyans a meaningful way to influence the products and services that shape their daily lives.</p>
          </div>
          <div className="bg-card border border-border rounded-2xl p-5">
            <Heart className="text-primary mb-3" size={22} />
            <h3 className="font-bold text-card-foreground mb-1">Our Values</h3>
            <p className="text-sm text-muted-foreground">Honesty, transparency, and respect for our community of survey participants.</p>
          </div>
          <div className="bg-card border border-border rounded-2xl p-5">
            <Users className="text-primary mb-3" size={22} />
            <h3 className="font-bold text-card-foreground mb-1">Who We Serve</h3>
            <p className="text-sm text-muted-foreground">Adult Kenyans (18+) who want to share their opinions and earn rewards via M-Pesa.</p>
          </div>
          <div className="bg-card border border-border rounded-2xl p-5">
            <Shield className="text-primary mb-3" size={22} />
            <h3 className="font-bold text-card-foreground mb-1">Our Commitment</h3>
            <p className="text-sm text-muted-foreground">Compliance with the Kenya Data Protection Act, 2019 and industry-standard security.</p>
          </div>
        </div>

        <div className="bg-muted/30 rounded-2xl p-6 border border-border">
          <h3 className="font-bold text-foreground mb-2">Company Information</h3>
          <ul className="text-sm text-muted-foreground space-y-1">
            <li><strong className="text-foreground">Name:</strong> Survey Pay (operated by Axon Technologies)</li>
            <li><strong className="text-foreground">Address:</strong> 209 Lenana Road, Nairobi, 00100, Kenya</li>
            <li><strong className="text-foreground">Email:</strong> <a href="mailto:axontechnologies103@gmail.com" className="text-primary underline">axontechnologies103@gmail.com</a></li>
            <li><strong className="text-foreground">Website:</strong> https://www.surveypaykenya.site/</li>
          </ul>
        </div>
      </main>
    </div>
  );
};

export default About;
