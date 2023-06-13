--Create the patients table
CREATE TABLE patients (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR,
  date_of_birth DATE,
  PRIMARY KEY(id)
);

--Create the medical_histories table
CREATE TABLE medical_histories (
  id INT GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP,
  patient_id INT,
  status VARCHAR,
  PRIMARY KEY(id),
  CONSTRAINT patient_key
    FOREIGN KEY (patient_id)
      REFERENCES patients(id)
);

--Create the invoices table
CREATE TABLE invoices (
   id INT GENERATED ALWAYS AS IDENTITY,
   total_amount DECIMAL,
   generated_at TIMESTAMP,
   payed_at TIMESTAMP,
   medical_history_id INT UNIQUE,
   PRIMARY KEY(id),
    CONSTRAINT medical_history_key
    FOREIGN KEY (medical_history_id)
      REFERENCES medical_histories(id)
);
--create the index for the patient_id in ascending order to reduce query execution time
CREATE INDEX patients_id_asc ON medical_histories (patient_id ASC);


--Create the treatments table
CREATE TABLE treatments (
  id INT GENERATED ALWAYS AS IDENTITY,
  type VARCHAR,
  name VARCHAR,
  PRIMARY KEY(id)
);

--create diagnostic table for the many to many relationship between the treatment and medical_histories tables.
--Here we can not create the index because both the medical_history_id and treatment_id are the primary keys which means the index already exist.
CREATE TABLE diagnostic (
    medical_history_id int,
    treatment_id int,
    PRIMARY KEY (medical_history_id, treatment_id),
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

--create the index for the medical_history_asc in ascending order to reduce query execution time
CREATE INDEX medical_history_asc ON invoices (medical_history_id ASC);
--Create the invoices_items table
CREATE TABLE invoice_items (
  id INT GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT,
  treatment_id INT,
  PRIMARY KEY(id),
  CONSTRAINT invoice_item_id
    FOREIGN KEY (invoice_id)
      REFERENCES invoices(id),
  CONSTRAINT treatment_item_id
    FOREIGN KEY (treatment_id)
      REFERENCES treatments(id)
);
--create the index for the invoice_id and treatment_id in ascending order to reduce query execution time
CREATE INDEX invoice_asc ON invoice_items (invoice_id ASC);
CREATE INDEX treatment_asc ON invoice_items (treatment_id ASC);

CREATE TABLE join_treatments (
  medical_history_id INT,
  treatment_id INT,
  CONSTRAINT medical_history_key
    FOREIGN KEY (medical_history_id)
      REFERENCES medical_histories(id),
  CONSTRAINT treatment_key
    FOREIGN KEY (treatment_id)
      REFERENCES treatments(id)  
);