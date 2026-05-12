"use client";

import { useMemo, useState, useTransition } from "react";
import { saveDraftSubmission } from "@/app/submissions/actions";
import { createClient } from "@/utils/supabase/client";

type BusinessCluster = "repair" | "rental" | "retail" | "general";
type Direction = "income" | "expense";

type VehicleMatch = {
  vehicle_id: number;
  stock_number: string | null;
  vin: string | null;
  year: number | null;
  make: string | null;
  model: string | null;
  trim: string | null;
  color: string | null;
  status: string | null;
};

const clusters: Array<{ value: BusinessCluster; label: string }> = [
  { value: "repair", label: "Repair" },
  { value: "rental", label: "Rental" },
  { value: "retail", label: "Retail" },
  { value: "general", label: "General" },
];

const repairContexts = [
  { value: "rental_vehicle", label: "Rental Vehicle" },
  { value: "retail_inventory", label: "Retail Inventory" },
  { value: "walk_in", label: "Walk-in Customer" },
  { value: "shop_general", label: "Shop General" },
];

const paymentMethods = [
  { value: "self_paid", label: "Self Paid" },
  { value: "visa_1209", label: "Visa 1209" },
  { value: "visa_2829", label: "Visa 2829" },
  { value: "visa_3173", label: "Visa 3173" },
  { value: "visa_3675", label: "Visa 3675" },
  { value: "visa_3687", label: "Visa 3687" },
  { value: "visa_4647", label: "Visa 4647" },
  { value: "visa_6755", label: "Visa 6755" },
  { value: "visa_7647", label: "Visa 7647" },
];

function vehicleLabel(vehicle: VehicleMatch) {
  return [
    vehicle.stock_number ? `#${vehicle.stock_number}` : null,
    vehicle.year,
    vehicle.make,
    vehicle.model,
    vehicle.trim,
    vehicle.color,
    vehicle.vin ? `VIN ${vehicle.vin}` : null,
    vehicle.status,
  ]
    .filter(Boolean)
    .join(" ");
}

export function IntakeWizard() {
  const [step, setStep] = useState(1);
  const [businessCluster, setBusinessCluster] = useState<BusinessCluster>("repair");
  const [repairContext, setRepairContext] = useState("rental_vehicle");
  const [direction, setDirection] = useState<Direction>("expense");
  const [vehicleQuery, setVehicleQuery] = useState("");
  const [vehicleMatches, setVehicleMatches] = useState<VehicleMatch[]>([]);
  const [selectedVehicle, setSelectedVehicle] = useState<VehicleMatch | null>(null);
  const [manualVehicleMode, setManualVehicleMode] = useState(false);
  const [searchError, setSearchError] = useState("");
  const [isPending, startTransition] = useTransition();

  const needsVehicleStep = useMemo(() => businessCluster !== "general", [businessCluster]);
  const vehicleStepTitle = useMemo(() => {
    if (businessCluster === "repair" && repairContext === "rental_vehicle") {
      return "Match the rental vehicle being repaired";
    }

    if (businessCluster === "repair" && repairContext === "retail_inventory") {
      return "Match the retail inventory vehicle being repaired";
    }

    if (businessCluster === "rental") {
      return "Match the rental vehicle";
    }

    if (businessCluster === "retail") {
      return "Match the retail vehicle";
    }

    return "Match the vehicle";
  }, [businessCluster, repairContext]);

  async function searchVehicles() {
    const query = vehicleQuery.trim();

    setSearchError("");
    setVehicleMatches([]);
    setSelectedVehicle(null);
    setManualVehicleMode(false);

    if (!query) {
      setSearchError("Enter a VIN, stock number, year, make, model, or color.");
      return;
    }

    startTransition(async () => {
      const supabase = createClient();
      const terms = query.split(/\s+/).filter(Boolean).slice(0, 5);
      const normalizedTerms = terms.map((term) => term.toLowerCase().replace(/[%,()]/g, ""));
      const orFilter = terms
        .flatMap((term) => {
          const safeTerm = term.replace(/[%,()]/g, "");
          const filters = [
            `stock_number.ilike.%${safeTerm}%`,
            `vin.ilike.%${safeTerm}%`,
            `make.ilike.%${safeTerm}%`,
            `model.ilike.%${safeTerm}%`,
            `trim.ilike.%${safeTerm}%`,
            `color.ilike.%${safeTerm}%`,
          ];

          if (/^\d{4}$/.test(safeTerm)) {
            filters.push(`year.eq.${safeTerm}`);
          }

          return filters;
        })
        .join(",");

      const { data, error } = await supabase
        .from("vehicle_master_sheet")
        .select("vehicle_id,stock_number,vin,year,make,model,trim,color,status,purchase_date")
        .or(orFilter)
        .order("purchase_date", { ascending: false })
        .limit(50);

      if (error) {
        setSearchError(error.message);
        return;
      }

      const filteredMatches = (data ?? [])
        .filter((vehicle) =>
          normalizedTerms.every((term) => {
            const fields = [
              vehicle.stock_number,
              vehicle.vin,
              vehicle.year?.toString(),
              vehicle.make,
              vehicle.model,
              vehicle.trim,
              vehicle.color,
              vehicle.status,
            ]
              .filter(Boolean)
              .map((field) => String(field).toLowerCase());

            return fields.some((field) => field.includes(term));
          }),
        )
        .sort((left, right) => scoreVehicleMatch(right, normalizedTerms) - scoreVehicleMatch(left, normalizedTerms))
        .slice(0, 12);

      setVehicleMatches(filteredMatches);
      if (!filteredMatches.length) {
        setSearchError("No matching vehicles found. Try VIN, stock number, or fewer words.");
      }
    });
  }

  function handleFormKeyDown(event: React.KeyboardEvent<HTMLFormElement>) {
    if (event.key !== "Enter") {
      return;
    }

    const target = event.target;

    if (target instanceof HTMLTextAreaElement) {
      return;
    }

    event.preventDefault();

    if (step === 3) {
      void searchVehicles();
    }
  }

  return (
    <form action={saveDraftSubmission} onKeyDown={handleFormKeyDown}>
      <input type="hidden" name="business_cluster" value={businessCluster} />
      <input type="hidden" name="repair_context" value={businessCluster === "repair" ? repairContext : ""} />
      <input type="hidden" name="direction" value={direction} />
      <input type="hidden" name="vehicle_id" value={manualVehicleMode ? "" : (selectedVehicle?.vehicle_id ?? "")} />

      <div className="wizard-steps">
        <div className={step === 1 ? "step active" : "step"}>
          1 Business
        </div>
        <div className={step === 2 ? "step active" : "step"}>
          2 Direction
        </div>
        <div className={step === 3 ? "step active" : "step"}>
          3 Vehicle
        </div>
        <div className={step === 4 ? "step active" : "step"}>
          4 Details
        </div>
      </div>

      {step === 1 ? (
        <section className="wizard-panel">
          <h3>What is this related to?</h3>
          <div className="choice-grid">
            {clusters.map((cluster) => (
              <button
                className={businessCluster === cluster.value ? "choice selected" : "choice"}
                key={cluster.value}
                type="button"
                onClick={() => {
                  setBusinessCluster(cluster.value);
                  if (cluster.value !== "repair") {
                    setRepairContext("");
                  } else {
                    setRepairContext("rental_vehicle");
                  }
                  setSelectedVehicle(null);
                  setManualVehicleMode(false);
                  setVehicleMatches([]);
                  setVehicleQuery("");
                }}
              >
                {cluster.label}
              </button>
            ))}
          </div>

          {businessCluster === "repair" ? (
            <div className="field wizard-field">
              <label htmlFor="repair_context_ui">Repair Context</label>
              <select
                id="repair_context_ui"
                value={repairContext}
                onChange={(event) => {
                  setRepairContext(event.target.value);
                  setSelectedVehicle(null);
                  setVehicleMatches([]);
                  setVehicleQuery("");
                  setManualVehicleMode(false);
                }}
              >
                {repairContexts.map((context) => (
                  <option key={context.value} value={context.value}>
                    {context.label}
                  </option>
                ))}
              </select>
            </div>
          ) : null}

          {businessCluster !== "repair" ? (
            <p className="summary-line">
              {businessCluster === "rental"
                ? "Rental is already selected as the business context."
                : businessCluster === "retail"
                  ? "Retail is already selected as the business context."
                  : "General submissions do not require a repair sub-context."}
            </p>
          ) : null}

          <div className="actions">
            <button className="button" type="button" onClick={() => setStep(2)}>
              Next
            </button>
          </div>
        </section>
      ) : null}

      {step === 2 ? (
        <section className="wizard-panel">
          <h3>Is this income or expense?</h3>
          <div className="choice-grid two">
            <button className={direction === "expense" ? "choice selected" : "choice"} type="button" onClick={() => setDirection("expense")}>
              Expense
            </button>
            <button className={direction === "income" ? "choice selected" : "choice"} type="button" onClick={() => setDirection("income")}>
              Income
            </button>
          </div>
          <div className="actions">
            <button className="button secondary" type="button" onClick={() => setStep(1)}>
              Back
            </button>
            <button className="button" type="button" onClick={() => setStep(needsVehicleStep ? 3 : 4)}>
              Next
            </button>
          </div>
        </section>
      ) : null}

      {step === 3 ? (
        <section className="wizard-panel">
          <h3>{vehicleStepTitle}</h3>
          {needsVehicleStep ? (
            <>
              <div className="field">
                <label htmlFor="vehicle_query">Vehicle Search</label>
                <p className="field-hint">Searches the vehicle master sheet. Press Enter searches only; it will not submit the form.</p>
                <div className="search-row">
                  <input
                    id="vehicle_query"
                    value={vehicleQuery}
                    onChange={(event) => setVehicleQuery(event.target.value)}
                    placeholder="Example: 2018 Toyota Camry, VIN, stock number"
                  />
                  <button className="button" type="button" onClick={searchVehicles} disabled={isPending}>
                    {isPending ? "Searching" : "Search"}
                  </button>
                </div>
              </div>

              {searchError ? <p className="notice">{searchError}</p> : null}

              {vehicleMatches.length > 0 ? (
                <div className="match-list">
                  {vehicleMatches.map((vehicle) => (
                    <button
                      className={selectedVehicle?.vehicle_id === vehicle.vehicle_id ? "match selected" : "match"}
                      key={vehicle.vehicle_id}
                      type="button"
                      onClick={() => setSelectedVehicle(vehicle)}
                    >
                      <strong>{vehicleLabel(vehicle)}</strong>
                      <span>Click to confirm this vehicle</span>
                    </button>
                  ))}
                </div>
              ) : null}

              {selectedVehicle ? <p className="success">Selected: {vehicleLabel(selectedVehicle)}</p> : null}

              <button
                className="link-button standalone"
                type="button"
                onClick={() => {
                  setManualVehicleMode(true);
                  setSelectedVehicle(null);
                }}
              >
                I cannot find the vehicle
              </button>

              {manualVehicleMode ? (
                <div className="manual-vehicle">
                  <div className="field">
                    <label htmlFor="unmatched_vehicle_vin">VIN Number</label>
                    <input id="unmatched_vehicle_vin" name="unmatched_vehicle_vin" required />
                  </div>
                  <div className="field">
                    <label htmlFor="unmatched_vehicle_model">Model</label>
                    <input id="unmatched_vehicle_model" name="unmatched_vehicle_model" required />
                  </div>
                  <div className="field">
                    <label htmlFor="unmatched_vehicle_year">Year</label>
                    <input id="unmatched_vehicle_year" name="unmatched_vehicle_year" type="number" min="1900" max="2100" />
                  </div>
                  <div className="field">
                    <label htmlFor="unmatched_vehicle_make">Make</label>
                    <input id="unmatched_vehicle_make" name="unmatched_vehicle_make" />
                  </div>
                  <div className="field">
                    <label htmlFor="unmatched_vehicle_stock_number">Stock Number</label>
                    <input id="unmatched_vehicle_stock_number" name="unmatched_vehicle_stock_number" />
                  </div>
                </div>
              ) : null}
            </>
          ) : (
            <p className="muted">This submission does not need a vehicle match.</p>
          )}

          <div className="actions">
            <button className="button secondary" type="button" onClick={() => setStep(2)}>
              Back
            </button>
            <button className="button" type="button" onClick={() => setStep(4)}>
              Next
            </button>
          </div>
        </section>
      ) : null}

      {step === 4 ? (
        <section className="wizard-panel">
          <h3>Upload and finish</h3>
          <div className="form-grid">
            <div className="field">
              <label htmlFor="transaction_date">Transaction Date</label>
              <input id="transaction_date" name="transaction_date" type="date" />
            </div>

            <div className="field">
              <label htmlFor="amount">Amount</label>
              <input id="amount" name="amount" type="number" min="0" step="0.01" placeholder="0.00" />
            </div>

            <div className="field full">
              <label htmlFor="payment_method">Payment Method</label>
              <select id="payment_method" name="payment_method" defaultValue="self_paid">
                {paymentMethods.map((method) => (
                  <option key={method.value} value={method.value}>
                    {method.label}
                  </option>
                ))}
              </select>
            </div>

            <div className="field full">
              <label htmlFor="document">Receipt or PDF</label>
              <input id="document" name="document" type="file" accept="image/*,application/pdf" />
            </div>

            <div className="field full">
              <label htmlFor="memo">Notes</label>
              <textarea id="memo" name="memo" placeholder="Add vendor, customer, payment, or context details." />
            </div>
          </div>

          <div className="summary-line">
            <strong>Summary:</strong> {businessCluster} {businessCluster === "repair" ? `/ ${repairContext}` : ""} / {direction}
            {selectedVehicle ? ` / ${vehicleLabel(selectedVehicle)}` : ""}
            {manualVehicleMode ? " / unmatched vehicle entered manually" : ""}
          </div>

          <div className="actions">
            <button className="button secondary" type="button" onClick={() => setStep(needsVehicleStep ? 3 : 2)}>
              Back
            </button>
            <button className="button secondary" name="intent" value="draft" type="submit">
              Save Draft
            </button>
            <button className="button" name="intent" value="submit" type="submit">
              Submit for Review
            </button>
          </div>
        </section>
      ) : null}
    </form>
  );
}

function scoreVehicleMatch(vehicle: VehicleMatch, terms: string[]) {
  const values = {
    stock: vehicle.stock_number?.toLowerCase() ?? "",
    vin: vehicle.vin?.toLowerCase() ?? "",
    year: vehicle.year?.toString() ?? "",
    make: vehicle.make?.toLowerCase() ?? "",
    model: vehicle.model?.toLowerCase() ?? "",
    trim: vehicle.trim?.toLowerCase() ?? "",
    color: vehicle.color?.toLowerCase() ?? "",
  };

  return terms.reduce((score, term) => {
    if (values.vin === term || values.stock === term) return score + 100;
    if (values.year === term) return score + 30;
    if (values.make === term) return score + 25;
    if (values.model === term) return score + 25;
    if (values.vin.includes(term) || values.stock.includes(term)) return score + 20;
    if (values.trim.includes(term) || values.color.includes(term)) return score + 10;
    return score + 1;
  }, 0);
}
