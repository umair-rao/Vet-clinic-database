/* Database schema to keep the structure of entire database. */

vet_clinic=# CREATE TABLE animals (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  name CHAR(20) NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg DECIMAL );
  
  /*Add a column species of type string to your animals table.*/
  
vet_clinic=# ALTER TABLE animals
 ADD COLUMN species CHAR(50);
