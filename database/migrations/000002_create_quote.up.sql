-- CREATEE QUOTES TABLE
CREATE TABLE IF NOT EXISTS quotes (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    business_id uuid,
    opportunity_id uuid,
    status text,
    start date,
    "end" date,
    billing_terms integer,
    tax numeric,
    amount numeric(20,8),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_quotes_deleted_at ON contracts (deleted_at);

-- CREATE QUOTE FORMS TABLE
CREATE TABLE IF NOT EXISTS quote_forms (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    business_id uuid,
    quote_id uuid,
    file_id uuid,
    version integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_quote_forms_deleted_at ON quote_forms (deleted_at);

-- CHANGE ITEM TABLE TO BE POLYMORPHIC
ALTER TABLE items
	DROP CONSTRAINT IF EXISTS items_contract_id_contracts_id_foreign;
ALTER TABLE items
	DROP CONSTRAINT IF EXISTS items_product_id_products_id_foreign;
ALTER TABLE items
	RENAME COLUMN contract_id TO owner_id;
ALTER TABLE items
	ADD COLUMN IF NOT EXISTS owner_type text NOT NULL DEFAULT 'contracts';