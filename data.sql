/* Populate database with sample data. */

vet_clinic=# INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
     ('Agumon', '2022-02-03', 0, 'TRUE', 10.23),
     ('Gabumon', '2018-11-15', 2, 'TRUE', 8),
     ('Pikachu', '2021-01-07', 1, 'FALSE', 15.04),
     ('Devimon', '2017-05-12', 5, 'TRUE', 11);


/*Insert More Data*/
vet_clinic=# INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
     ('Charmander', '2022-02-08', 0, 'FALSE', -11),
     ('Plantmon', '2021-11-15', 2, 'TRUE', -5.7),
     ('Squirtle', '1993-04-02', 3, 'FALSE', -12.13),
     ('Angemon', '2005-06-12', 1, 'TRUE', -45),
     ('Boarmon', '2005-06-07', 7, 'TRUE', 20.4),
     ('Blossom', '1998-08-13', 3, 'TRUE', 17),
     ('Ditto', '2022-05-14', 4, 'TRUE', 22);

/*Insert data into the owners table*/

 INSERT INTO owners (full_name,age) VALUES (
     'Sam Smith', 34), 
     ('Jennifer Orwell', 19), 
     ('Bob', 45), 
     ('Melody Pond', 77), 
     ('Dean Winchester', 14), 
     ('Jodie Whittaker', 38);
     
 /*Insert data into the species table*/
 INSERT INTO species (name) VALUES ( 'Pokemon'), ('Digimon');
 
 /*Modify your inserted animals so it includes the species_id value*/
 UPDATE animals SET species_id = (SELECT id FROM species WHERE name= 'Digimon') WHERE name LIKE '%mon%';
 UPDATE animals SET species_id = (SELECT id FROM species WHERE name= 'Pokemon') WHERE species_id IS NULL;
 
 /*Modify your inserted animals to include owner information (owner_id)*/
 
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE name = 'Sam Smith') WHERE name ='Agumon';
UPDATE animals SET owners_id = 2 WHERE name = 'Gabumon';
UPDATE animals SET owners_id = 2 WHERE name = 'Pikachu';
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');
     
     
