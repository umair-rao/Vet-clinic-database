--Create the patients table
CREATE TABLE patients (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
    name varchar(100) NOT NULL,
    date_of_birth  date
);

