/* Database schema to keep the structure of entire database. */

vet_clinic=# CREATE TABLE animals (
vet_clinic(# id BIGSERIAL NOT NULL PRIMARY KEY,
vet_clinic(# name CHAR(20) NOT NULL,
vet_clinic(# date_of_birth DATE NOT NULL,
vet_clinic(# escape_attempts INT,
vet_clinic(# neutered BOOLEAN,
vet_clinic(# weight_kg DECIMAL );
