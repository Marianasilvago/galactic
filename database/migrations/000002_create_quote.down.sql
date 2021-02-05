ALTER TABLE items
	RENAME COLUMN owner_id TO contract_id;

ALTER TABLE ONLY items
    ADD CONSTRAINT items_contract_id_contracts_id_foreign FOREIGN KEY (contract_id) REFERENCES contracts(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY items
    ADD CONSTRAINT items_product_id_products_id_foreign FOREIGN KEY (product_id) REFERENCES products(id) ON UPDATE CASCADE ON DELETE CASCADE;