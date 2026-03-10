import { motion } from "framer-motion";

interface CategoryChipProps {
  icon: string;
  name: string;
  image?: string;
  isActive: boolean;
  onClick: () => void;
}

const CategoryChip = ({ icon, name, image, isActive, onClick }: CategoryChipProps) => (
  <motion.button
    whileTap={{ scale: 0.95 }}
    onClick={onClick}
    className={`flex flex-col items-center gap-2 min-w-[90px] py-3 px-3 rounded-2xl text-xs font-semibold whitespace-nowrap transition-all ${
      isActive
        ? "gradient-primary text-primary-foreground shadow-primary"
        : "bg-card text-card-foreground border border-border hover:border-primary/30 shadow-card"
    }`}
  >
    {image ? (
      <div className="w-12 h-12 rounded-xl overflow-hidden bg-secondary">
        <img src={image} alt={name} className="w-full h-full object-cover" />
      </div>
    ) : (
      <div className="w-12 h-12 rounded-xl bg-secondary flex items-center justify-center">
        <span className="text-2xl">{icon}</span>
      </div>
    )}
    {name}
  </motion.button>
);

export default CategoryChip;
