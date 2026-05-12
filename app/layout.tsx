import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Arch Auto Finance Intake",
  description: "Internal intake workflow for Arch Auto finance submissions",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
