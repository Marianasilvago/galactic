CREATE SCHEMA IF NOT EXISTS status
Valid response example:
{
"data": [
{
"id": 1,
"name": "Devastator",
"status": "Operational"
},
{
"id": 2,
"name": "Red Five",
"status": "Damaged"
},
....
}
Alchemy Telco Solutions Limited, Proprietary and Confidential;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS accounts (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    business_id uuid,
    name text,
    website text,
    phone text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    executive_id uuid,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_accounts_deleted_at ON accounts (deleted_at);

CREATE SEQUENCE IF NOT EXISTS address_acccounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE TABLE IF NOT EXISTS address_acccounts (
    id integer NOT NULL DEFAULT nextval('address_acccounts_id_seq'),
    business_id uuid,
    address_id uuid,
    account_id uuid,
    type text,
    PRIMARY KEY (id)
);
ALTER SEQUENCE address_acccounts_id_seq OWNED BY address_acccounts.id;


CREATE TABLE IF NOT EXISTS address_business (
    business_id text NOT NULL,
    address_id uuid NOT NULL,
    PRIMARY KEY (business_id, address_id)
);

CREATE TABLE IF NOT EXISTS addresses (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    address_one text,
    address_two text,
    zipcode text,
    city text,
    state text,
    country text,
    places_id text,
    latitude numeric(10,8),
    longitude numeric(11,8),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_addresses_deleted_at ON addresses (deleted_at);

CREATE TABLE IF NOT EXISTS businesses (
    id text NOT NULL,
    status text,
    name text,
    licenses integer,
    level text,
    phone text,
    logo text,
    reachout integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_businesses_deleted_at ON businesses (deleted_at);

CREATE SEQUENCE IF NOT EXISTS contact_opportunity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE TABLE IF NOT EXISTS contact_opportunity (
    id integer NOT NULL DEFAULT nextval('contact_opportunity_id_seq'),
    business_id uuid,
    contact_id uuid,
    opportunity_id uuid,
    type text,
    PRIMARY KEY (id)
);
ALTER SEQUENCE contact_opportunity_id_seq OWNED BY contact_opportunity.id;

CREATE TABLE IF NOT EXISTS contacts (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    account_id uuid,
    title text,
    first_name text,
    last_name text,
    email text,
    phone text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_contacts_deleted_at ON contacts (deleted_at);

CREATE TABLE IF NOT EXISTS contracts (
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
CREATE INDEX IF NOT EXISTS idx_contracts_deleted_at ON contracts (deleted_at);

CREATE TABLE IF NOT EXISTS files (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    business_id uuid,
    mime text,
    src text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_files_deleted_at ON files (deleted_at);

CREATE TABLE IF NOT EXISTS financials (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    business_id uuid,
    day integer,
    month integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_financials_deleted_at ON financials (deleted_at);

CREATE TABLE IF NOT EXISTS insight_notes (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    business_id uuid,
    insight_id uuid,
    note text,
    rating integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_insight_notes_deleted_at ON insight_notes (deleted_at);

CREATE TABLE IF NOT EXISTS insights (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    business_id uuid,
    opportunity_id uuid,
    insight text,
    description text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_insights_deleted_at ON insights (deleted_at);

CREATE TABLE IF NOT EXISTS items (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    contract_id uuid,
    product_id uuid,
    name text,
    renewable boolean,
    quantity integer,
    list_price numeric,
    discount numeric,
    discount_type text,
    total numeric,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_items_deleted_at ON items (deleted_at);

CREATE TABLE IF NOT EXISTS msas (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    business_id uuid,
    account_id uuid,
    file_id uuid,
    signing_date date,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_msas_deleted_at ON msas (deleted_at);

CREATE TABLE IF NOT EXISTS notes (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    user_id uuid,
    owner_id uuid,
    owner_type text,
    note text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_notes_deleted_at ON notes (deleted_at);

CREATE TABLE IF NOT EXISTS opportunities (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    business_id uuid,
    account_id uuid,
    user_id uuid,
    status text,
    rolled_id text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_opportunities_deleted_at ON opportunities (deleted_at);

CREATE TABLE IF NOT EXISTS order_forms (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    business_id uuid,
    contract_id uuid,
    file_id uuid,
    total numeric(20,8),
    version integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_order_forms_deleted_at ON order_forms (deleted_at);

CREATE SEQUENCE IF NOT EXISTS passwords_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
CREATE TABLE IF NOT EXISTS passwords (
    id integer NOT NULL DEFAULT nextval('passwords_id_seq'),
    owner_id text,
    owner_type text,
    password text,
    remember_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_passwords_deleted_at ON order_forms (deleted_at);
ALTER SEQUENCE passwords_id_seq OWNED BY passwords.id;

CREATE TABLE IF NOT EXISTS playbooks (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    business_id uuid,
    name text,
    intro integer,
    check_in_interval integer,
    reach_out integer,
    reach_out_count integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_playbooks_deleted_at ON playbooks (deleted_at);

CREATE TABLE IF NOT EXISTS price_books (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    business_id uuid,
    file_id uuid,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_price_books_deleted_at ON price_books (deleted_at);

CREATE TABLE IF NOT EXISTS pricebook_products (
    price_book_id uuid NOT NULL,
    product_id uuid NOT NULL,
    PRIMARY KEY (price_book_id, product_id)
);

CREATE TABLE IF NOT EXISTS prices (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    business_id uuid,
    price numeric(20,8),
    unit text,
    date timestamp with time zone,
    product_id uuid,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_prices_deleted_at ON prices (deleted_at);

CREATE TABLE IF NOT EXISTS products (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    business_id uuid,
    name text,
    renewable boolean,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_products_deleted_at ON products (deleted_at);

CREATE TABLE IF NOT EXISTS signatures (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    user_id uuid,
    body text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);b
CREATE INDEX IF NOT EXISTS idx_signatures_deleted_at ON signatures (deleted_at);

CREATE TABLE IF NOT EXISTS tasks (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    business_id uuid,
    opportunity_id uuid,
    user_id uuid,
    completed boolean,
    status text,
    name text,
    type text,
    due_date date,
    payload json,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_tasks_deleted_at ON tasks (deleted_at);

CREATE TABLE IF NOT EXISTS templates (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    business_id uuid,
    type text,
    title text,
    body text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_templates_deleted_at ON templates (deleted_at);

CREATE TABLE IF NOT EXISTS touch_points (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    business_id uuid,
    contract_id uuid,
    task_id uuid,
    name text,
    active boolean,
    type text,
    due_date date,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_touch_points_deleted_at ON touch_points (deleted_at);

CREATE TABLE IF NOT EXISTS users (
    id uuid NOT NULL DEFAULT uuid_generate_v4(),
    business_id uuid,
    first_name text,
    last_name text,
    email text,
    status text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    PRIMARY KEY (id)
);
CREATE INDEX IF NOT EXISTS idx_users_deleted_at ON users (deleted_at);

-- Create Relationships
ALTER TABLE address_acccounts DROP CONSTRAINT IF EXISTS address_acccounts_account_id_accounts_id_foreign;
ALTER TABLE ONLY address_acccounts
    ADD CONSTRAINT address_acccounts_account_id_accounts_id_foreign FOREIGN KEY (account_id) REFERENCES accounts(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE address_acccounts DROP CONSTRAINT IF EXISTS address_acccounts_address_id_addresses_id_foreign;
ALTER TABLE ONLY address_acccounts
    ADD CONSTRAINT address_acccounts_address_id_addresses_id_foreign FOREIGN KEY (address_id) REFERENCES addresses(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE contracts DROP CONSTRAINT IF EXISTS contracts_opportunity_id_opportunities_id_foreign;
ALTER TABLE ONLY contracts
    ADD CONSTRAINT contracts_opportunity_id_opportunities_id_foreign FOREIGN KEY (opportunity_id) REFERENCES opportunities(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE insight_notes DROP CONSTRAINT IF EXISTS insight_notes_insight_id_insights_id_foreign;
ALTER TABLE ONLY insight_notes
    ADD CONSTRAINT insight_notes_insight_id_insights_id_foreign FOREIGN KEY (insight_id) REFERENCES insights(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE insights DROP CONSTRAINT IF EXISTS insights_opportunity_id_opportunities_id_foreign;
ALTER TABLE ONLY insights
    ADD CONSTRAINT insights_opportunity_id_opportunities_id_foreign FOREIGN KEY (opportunity_id) REFERENCES opportunities(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE items DROP CONSTRAINT IF EXISTS items_contract_id_contracts_id_foreign;
ALTER TABLE ONLY items
    ADD CONSTRAINT items_contract_id_contracts_id_foreign FOREIGN KEY (contract_id) REFERENCES contracts(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE items DROP CONSTRAINT IF EXISTS items_product_id_products_id_foreign;
ALTER TABLE ONLY items
    ADD CONSTRAINT items_product_id_products_id_foreign FOREIGN KEY (product_id) REFERENCES products(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE opportunities DROP CONSTRAINT IF EXISTS opportunities_account_id_accounts_id_foreign;
ALTER TABLE ONLY opportunities
    ADD CONSTRAINT opportunities_account_id_accounts_id_foreign FOREIGN KEY (account_id) REFERENCES accounts(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE order_forms DROP CONSTRAINT IF EXISTS order_forms_contract_id_contracts_id_foreign;
ALTER TABLE ONLY order_forms
    ADD CONSTRAINT order_forms_contract_id_contracts_id_foreign FOREIGN KEY (contract_id) REFERENCES contracts(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE order_forms DROP CONSTRAINT IF EXISTS order_forms_file_id_files_id_foreign;
ALTER TABLE ONLY order_forms
    ADD CONSTRAINT order_forms_file_id_files_id_foreign FOREIGN KEY (file_id) REFERENCES files(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE prices DROP CONSTRAINT IF EXISTS prices_product_id_products_id_foreign;
ALTER TABLE ONLY prices
    ADD CONSTRAINT prices_product_id_products_id_foreign FOREIGN KEY (product_id) REFERENCES products(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE signatures DROP CONSTRAINT IF EXISTS signatures_user_id_users_id_foreign;
ALTER TABLE ONLY signatures
    ADD CONSTRAINT signatures_user_id_users_id_foreign FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE tasks DROP CONSTRAINT IF EXISTS tasks_opportunity_id_opportunities_id_foreign;
ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_opportunity_id_opportunities_id_foreign FOREIGN KEY (opportunity_id) REFERENCES opportunities(id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE tasks DROP CONSTRAINT IF EXISTS tasks_user_id_users_id_foreign;
ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_user_id_users_id_foreign FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE;
