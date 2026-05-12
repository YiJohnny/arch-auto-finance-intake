PRAGMA foreign_keys = ON;

BEGIN TRANSACTION;

CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    full_name TEXT,
    email TEXT,
    is_active INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0, 1)),
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE vehicles (
    vehicle_id INTEGER PRIMARY KEY,
    stock_number TEXT NOT NULL UNIQUE,
    vin TEXT NOT NULL UNIQUE,
    year INTEGER,
    make TEXT NOT NULL,
    model TEXT NOT NULL,
    trim TEXT,
    color TEXT,
    mileage INTEGER,
    purchase_date TEXT NOT NULL,
    purchase_source TEXT,
    status TEXT NOT NULL DEFAULT 'IN_INVENTORY'
        CHECK (status IN ('IN_INVENTORY', 'SOLD', 'WHOLESALE', 'VOID')),
    acquisition_notes TEXT,
    sale_date TEXT,
    sale_price NUMERIC,
    sale_channel TEXT,
    buyer_name TEXT,
    dealercenter_deal_id TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER REFERENCES users(user_id),
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by INTEGER REFERENCES users(user_id),
    closed_at TEXT,
    closed_by INTEGER REFERENCES users(user_id),
    CHECK (length(vin) BETWEEN 11 AND 17),
    CHECK (
        (status = 'IN_INVENTORY' AND sale_date IS NULL AND sale_price IS NULL AND closed_at IS NULL)
        OR
        (status IN ('SOLD', 'WHOLESALE') AND sale_date IS NOT NULL AND sale_price IS NOT NULL)
        OR
        (status = 'VOID')
    )
);

CREATE TABLE vehicle_cost_ledger (
    ledger_entry_id INTEGER PRIMARY KEY,
    vehicle_id INTEGER NOT NULL REFERENCES vehicles(vehicle_id) ON DELETE RESTRICT,
    entry_date TEXT NOT NULL,
    entry_type TEXT NOT NULL
        CHECK (entry_type IN ('ACQUISITION', 'DIRECT_COST', 'ADJUSTMENT', 'SALE', 'REVERSAL')),
    category TEXT NOT NULL,
    amount NUMERIC NOT NULL,
    description TEXT,
    vendor_name TEXT,
    reference_number TEXT,
    source_system TEXT NOT NULL DEFAULT 'MANUAL',
    source_record_id TEXT,
    entered_by INTEGER REFERENCES users(user_id),
    is_voided INTEGER NOT NULL DEFAULT 0 CHECK (is_voided IN (0, 1)),
    voided_at TEXT,
    voided_by INTEGER REFERENCES users(user_id),
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK (
        category IN (
            'PURCHASE',
            'AUCTION_FEE',
            'BUYER_FEE',
            'TRANSPORTATION',
            'TOWING',
            'FUEL',
            'TITLE_FEE',
            'REGISTRATION_FEE',
            'INSPECTION',
            'SMOG',
            'REPAIR',
            'PARTS',
            'DETAIL',
            'CLEANING',
            'PHOTOGRAPHY',
            'KEY_REPLACEMENT',
            'WARRANTY_REPAIR',
            'OTHER_DIRECT_COST',
            'SALE_PROCEEDS',
            'COST_ADJUSTMENT',
            'REVERSAL'
        )
    ),
    CHECK (
        (entry_type = 'ACQUISITION' AND category = 'PURCHASE')
        OR
        (entry_type = 'DIRECT_COST' AND category IN (
            'AUCTION_FEE',
            'BUYER_FEE',
            'TRANSPORTATION',
            'TOWING',
            'FUEL',
            'TITLE_FEE',
            'REGISTRATION_FEE',
            'INSPECTION',
            'SMOG',
            'REPAIR',
            'PARTS',
            'DETAIL',
            'CLEANING',
            'PHOTOGRAPHY',
            'KEY_REPLACEMENT',
            'WARRANTY_REPAIR',
            'OTHER_DIRECT_COST'
        ))
        OR
        (entry_type = 'ADJUSTMENT' AND category = 'COST_ADJUSTMENT')
        OR
        (entry_type = 'SALE' AND category = 'SALE_PROCEEDS')
        OR
        (entry_type = 'REVERSAL' AND category = 'REVERSAL')
    ),
    CHECK (
        (is_voided = 0 AND voided_at IS NULL AND voided_by IS NULL)
        OR
        (is_voided = 1 AND voided_at IS NOT NULL)
    )
);

CREATE TABLE audit_log (
    audit_log_id INTEGER PRIMARY KEY,
    table_name TEXT NOT NULL,
    record_pk TEXT NOT NULL,
    action TEXT NOT NULL CHECK (action IN ('INSERT', 'UPDATE', 'DELETE')),
    changed_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    changed_by INTEGER REFERENCES users(user_id),
    old_values TEXT,
    new_values TEXT
);

CREATE VIEW vehicle_profit_snapshot AS
SELECT
    v.vehicle_id,
    v.stock_number,
    v.vin,
    v.year,
    v.make,
    v.model,
    v.status,
    v.purchase_date,
    v.sale_date,
    v.sale_price,
    COALESCE(SUM(
        CASE
            WHEN l.is_voided = 0
             AND l.entry_type IN ('ACQUISITION', 'DIRECT_COST', 'ADJUSTMENT')
            THEN l.amount
            ELSE 0
        END
    ), 0) AS total_cogs,
    CASE
        WHEN v.sale_price IS NOT NULL THEN
            v.sale_price - COALESCE(SUM(
                CASE
                    WHEN l.is_voided = 0
                     AND l.entry_type IN ('ACQUISITION', 'DIRECT_COST', 'ADJUSTMENT')
                    THEN l.amount
                    ELSE 0
                END
            ), 0)
        ELSE NULL
    END AS gross_profit
FROM vehicles v
LEFT JOIN vehicle_cost_ledger l
    ON l.vehicle_id = v.vehicle_id
GROUP BY
    v.vehicle_id,
    v.stock_number,
    v.vin,
    v.year,
    v.make,
    v.model,
    v.status,
    v.purchase_date,
    v.sale_date,
    v.sale_price;

CREATE INDEX idx_vehicles_status ON vehicles(status);
CREATE INDEX idx_vehicles_purchase_date ON vehicles(purchase_date);
CREATE INDEX idx_vehicle_cost_ledger_vehicle_date
    ON vehicle_cost_ledger(vehicle_id, entry_date);
CREATE INDEX idx_vehicle_cost_ledger_source
    ON vehicle_cost_ledger(source_system, source_record_id);
CREATE INDEX idx_audit_log_table_record
    ON audit_log(table_name, record_pk, changed_at);

CREATE TRIGGER vehicles_set_updated_at
AFTER UPDATE ON vehicles
FOR EACH ROW
WHEN NEW.updated_at = OLD.updated_at
BEGIN
    UPDATE vehicles
    SET updated_at = CURRENT_TIMESTAMP
    WHERE vehicle_id = NEW.vehicle_id;
END;

CREATE TRIGGER vehicle_cost_ledger_set_updated_at
AFTER UPDATE ON vehicle_cost_ledger
FOR EACH ROW
WHEN NEW.updated_at = OLD.updated_at
BEGIN
    UPDATE vehicle_cost_ledger
    SET updated_at = CURRENT_TIMESTAMP
    WHERE ledger_entry_id = NEW.ledger_entry_id;
END;

CREATE TRIGGER users_set_updated_at
AFTER UPDATE ON users
FOR EACH ROW
WHEN NEW.updated_at = OLD.updated_at
BEGIN
    UPDATE users
    SET updated_at = CURRENT_TIMESTAMP
    WHERE user_id = NEW.user_id;
END;

CREATE TRIGGER vehicles_audit_insert
AFTER INSERT ON vehicles
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (
        table_name,
        record_pk,
        action,
        changed_by,
        new_values
    )
    VALUES (
        'vehicles',
        CAST(NEW.vehicle_id AS TEXT),
        'INSERT',
        NEW.created_by,
        json_object(
            'stock_number', NEW.stock_number,
            'vin', NEW.vin,
            'status', NEW.status,
            'purchase_date', NEW.purchase_date,
            'sale_date', NEW.sale_date,
            'sale_price', NEW.sale_price
        )
    );
END;

CREATE TRIGGER vehicles_audit_update
AFTER UPDATE ON vehicles
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (
        table_name,
        record_pk,
        action,
        changed_by,
        old_values,
        new_values
    )
    VALUES (
        'vehicles',
        CAST(NEW.vehicle_id AS TEXT),
        'UPDATE',
        COALESCE(NEW.updated_by, OLD.updated_by),
        json_object(
            'stock_number', OLD.stock_number,
            'vin', OLD.vin,
            'status', OLD.status,
            'purchase_date', OLD.purchase_date,
            'sale_date', OLD.sale_date,
            'sale_price', OLD.sale_price
        ),
        json_object(
            'stock_number', NEW.stock_number,
            'vin', NEW.vin,
            'status', NEW.status,
            'purchase_date', NEW.purchase_date,
            'sale_date', NEW.sale_date,
            'sale_price', NEW.sale_price
        )
    );
END;

CREATE TRIGGER vehicle_cost_ledger_audit_insert
AFTER INSERT ON vehicle_cost_ledger
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (
        table_name,
        record_pk,
        action,
        changed_by,
        new_values
    )
    VALUES (
        'vehicle_cost_ledger',
        CAST(NEW.ledger_entry_id AS TEXT),
        'INSERT',
        NEW.entered_by,
        json_object(
            'vehicle_id', NEW.vehicle_id,
            'entry_date', NEW.entry_date,
            'entry_type', NEW.entry_type,
            'category', NEW.category,
            'amount', NEW.amount,
            'is_voided', NEW.is_voided
        )
    );
END;

CREATE TRIGGER vehicle_cost_ledger_audit_update
AFTER UPDATE ON vehicle_cost_ledger
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (
        table_name,
        record_pk,
        action,
        changed_by,
        old_values,
        new_values
    )
    VALUES (
        'vehicle_cost_ledger',
        CAST(NEW.ledger_entry_id AS TEXT),
        'UPDATE',
        COALESCE(NEW.entered_by, OLD.entered_by),
        json_object(
            'vehicle_id', OLD.vehicle_id,
            'entry_date', OLD.entry_date,
            'entry_type', OLD.entry_type,
            'category', OLD.category,
            'amount', OLD.amount,
            'is_voided', OLD.is_voided
        ),
        json_object(
            'vehicle_id', NEW.vehicle_id,
            'entry_date', NEW.entry_date,
            'entry_type', NEW.entry_type,
            'category', NEW.category,
            'amount', NEW.amount,
            'is_voided', NEW.is_voided
        )
    );
END;

COMMIT;
