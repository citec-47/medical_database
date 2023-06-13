--Create the patients table
CREATE TABLE patients (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
    name varchar(100) NOT NULL,
    date_of_birth  date
);

--Create the medical_histories table
CREATE TABLE medical_histories (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
    admitted_at timestamp NOT NULL,
    patient_id int,
    status varchar(100),
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);

--create the index for the patient_id in ascending order to reduce query execution time
CREATE INDEX patients_id_asc ON medical_histories (patient_id ASC);


--Create the treatments table
CREATE TABLE treatments (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type varchar(100) NOT NULL,
    name varchar(100) NOT NULL
);

--create diagnostic table for the many to many relationship between the treatment and medical_histories tables.
--Here we cant create the index because both the medical_history_id and treatment_id are the primary keys which means the index already exist.
CREATE TABLE diagnostic (
    medical_history_id int,
    treatment_id int,
    PRIMARY KEY (medical_history_id, treatment_id),
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);
--Create the invoices table
CREATE TABLE invoices (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
    total_amount  decimal,
    generated_at timestamp,
    payed_at timestamp,
    medical_history_id int,
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);
--create the index for the medical_history_asc in ascending order to reduce query execution time
CREATE INDEX medical_history_asc ON invoices (medical_history_id ASC);
--Create the invoices_items table
CREATE TABLE invoice_items (
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    unit_price  decimal  NOT NULL,
    quantity   int,
    total_price  decimal,
    invoice_id  int,
    treatment_id int,
    FOREIGN KEY (invoice_id) REFERENCES invoices (id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(id)
)
--create the index for the invoice_id and treatment_id in ascending order to reduce query execution time
CREATE INDEX invoice_asc ON invoice_items (invoice_id ASC);
CREATE INDEX treatment_asc ON invoice_items (treatment_id ASC);