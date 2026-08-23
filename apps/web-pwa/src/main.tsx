import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { Cockpit } from "@/components/navikka/cockpit";
import "./styles.css";

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <Cockpit />
  </StrictMode>,
);
