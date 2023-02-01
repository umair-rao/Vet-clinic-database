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


