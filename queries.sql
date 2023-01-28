/*Queries that provide answers to the questions from all projects.*/


/*Find all animals whose name ends in "mon".*/

SELECT * FROM animals WHERE name LIKE 'mon';

/*List the name of all animals born between 2016 and 2019.*/

SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

/*List the name of all animals that are neutered and have less than 3 escape attempts.*/

SELECT * FROM animals WHERE neutered = 't' AND escape_attempts < 3;

/*List the date of birth of all animals named either "Agumon" or "Pikachu".*/

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

/*List name and escape attempts of animals that weigh more than 10.5kg*/

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

/*Find all animals that are neutered.*/

SELECT * FROM animals WHERE neutered;

/*Find all animals not named Gabumon.*/

SELECT * FROM animals WHERE name != 'Gabumon';

/*Find all animals with a weight between 10.4kg and 17.3kg*/

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Rollback practise */
 BEGIN;
 UPDATE animals SET species = 'unspecified';
 ROLLBACK;
 
 /* Add species data as transaction */
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species='pokemon' WHERE species IS NULL;
COMMIT;

/* Delete table and rollback */
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/* Transaction deleting 3 rows and changing all -ve weights*/
 BEGIN;
 DELETE FROM animals WHERE date_of_birth > '2022-01-01';
 SAVEPOINT SP1;
 UPDATE animals SET weight_kg = weight_kg * -1 ;
 SELECT * FROM animals;
 ROLLBACK TO SP1;
 SELECT * FROM animals;
 UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg <0 ;
 COMMIT;
 SELECT * FROM animals;
 
 /*Queries */

 /* How many animals are there?*/

  SELECT COUNT (*) FROM animals;

 /*How many animals have never tried to escape?*/

 SELECT COUNT (*) FROM animals WHERE escape_attempts = 0;

 /*What is the average weight of animals?*/

  SELECT AVG(weight_kg) FROM animals;

 /*Who escapes the most, neutered or not neutered animals?*/

  SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

 /*What is the minimum and maximum weight of each type of animal?*/

 SELECT species, MIN(weight_kg) , MAX(weight_kg) FROM animals GROUP BY species;

 /*What is the average number of escape attempts per animal type of those born between 1990 and 2000?*/

 SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth between '1990-01-01' AND '2000-12-31' GROUP BY species;
 
 /* What animals belong to Melody Pond?*/

SELECT name FROM animals JOIN owners ON animals.owners_id = owners.id WHERE owners.full_name = 'Melody Pond';

/*List of all animals that are pokemon (their type is Pokemon).*/

SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name= 'Pokemon';

/*List all owners and their animals, remember to include those that don't own any animal.*/

SELECT full_name, name FROM owners LEFT JOIN animals ON owners.id=animals.owners_id;

/*How many animals are there per species?*/

SELECT COUNT(animals.name) , species.name FROM animals JOIN species ON 
animals.species_id = species.id GROUP BY species.name;

/*List all Digimon owned by Jennifer Orwell.*/

SELECT animals.name FROM animals
LEFT JOIN owners ON owners.id = animals.owners_id
LEFT JOIN species ON species.id = animals.species_id
WHERE owners.full_name ='Jennifer Orwell' AND species.name = 'Digimon';

/*List all animals owned by Dean Winchester that haven't tried to escape.*/

SELECT animals.name FROM animals
LEFT JOIN owners ON owners.id = animals.owners_id
WHERE owners.full_name ='Dean Winchester' AND animals.escape_attempts = 0;

/*Who owns the most animals?*/

SELECT owners.full_name as OWNER , COUNT(animals.name) as count FROM
owners JOIN animals ON owners.id = animals.owners_id GROUP BY owners.full_name
ORDER BY count DESC LIMIT 1;

