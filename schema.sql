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
 
 /*Create owners tables */ 
 
 vet_clinic=# CREATE TABLE owners (
 id BIGSERIAL NOT NULL PRIMARY KEY,
 full_name CHAR(20) NOT NULL,
 age INT );
 
 
 /*Create species tables */ 
 
vet_clinic=# CREATE TABLE species (
 id BIGSERIAL NOT NULL PRIMARY KEY,
 name CHAR(20) NOT NULL);
 
/*Remove column species from animals table*/

ALTER TABLE animals DROP COLUMN species;
  
/*Add column species_id which is a foreign key referencing species table*/
    
    
    

  ALTER TABLE animals ADD COLUMN species_ID INT;
  ALTER TABLE animals ADD FOREIGN KEY (species_ID) REFERENCES species(id);  

  /*Add column owner_id which is a foreign key referencing the owners table*/  

  ALTER TABLE animals ADD COLUMN owners_ID INT;
  ALTER TABLE animals ADD FOREIGN KEY (owners_ID) REFERENCES owners(id);
  
  
  /*Create a table named vets*/
  
  vet_clinic=# CREATE TABLE vets (
 id BIGSERIAL NOT NULL PRIMARY KEY,
 name CHAR(50) NOT NULL,
 age INT,
 date_of_graduation DATE);
 
 /*Create a "join table" called specializations*/
 
 vet_clinic=# CREATE TABLE specializations (
 vets_id INT REFERENCES vets(id) ,
 species_id INT REFERENCES species(id),
 PRIMARY KEY(species_id, vets_id));

/*Create a "join table" called visits*/

vet_clinic=# CREATE TABLE visits (
 animals_id INT REFERENCES animals(id),
 vets_id INT REFERENCES vets(id),
 date_of_visits DATE,
 PRIMARY KEY(animals_id, vets_id));
 
/*Add an email column to your owners table*/

ALTER TABLE owners ADD COLUMN email VARCHAR(120);
