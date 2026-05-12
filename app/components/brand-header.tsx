type BrandHeaderProps = {
  title?: string;
  subtitle?: string;
};

export function BrandHeader({ title = "Finance Intake", subtitle = "Employee income and expense submissions for Arch Auto." }: BrandHeaderProps) {
  return (
    <div className="brand-header">
      <div>
        <p className="brand-name">Arch Auto</p>
        <h1 className="title">{title}</h1>
        <p className="subtitle">{subtitle}</p>
      </div>
    </div>
  );
}
