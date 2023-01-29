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

/* Who was the last animal seen by William Tatcher? */

SELECT vets.name AS vet, animals.name AS animal, 
   visits.date_of_visits AS visited_date 
   FROM visits 
JOIN vets ON vets_id = vets.id 
JOIN animals ON animals_id = animals.id 
WHERE vets_id =
  (SELECT id FROM vets WHERE name = 'William Tatcher') 
ORDER BY date_of_visits DESC LIMIT 1;

/* How many different animals did Stephanie Mendez see? */

SELECT COUNT(DISTINCT animals_id) as no_of_different_animals FROM visits 
JOIN vets ON visits.vets_id=vets.id 
WHERE visits.vets_id=(SELECT id FROM vets WHERE name = 'Stephanie Mendez');

/* List all vets and their specialties, including vets with no specialties. */

SELECT vets.name AS vet, species.name AS specialized_in_species FROM vets 
LEFT JOIN specializations ON vets.id=specializations.vets_id 
LEFT JOIN species ON species_id=species.id;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */

SELECT animals.name as animal_name FROM visits  
JOIN animals ON visits.animals_id = animals.id 
WHERE visits.vets_id= (SELECT id FROM vets WHERE name = 'Stephanie Mendez') 
AND visits.date_of_visits BETWEEN '2020-04-01' AND '2020-08-30';

/* What animal has the most visits to vets? */

 SELECT animals.name AS most_visited_animals, COUNT(*) AS number_of_visits FROM visits 
 JOIN animals ON visits.animals_id=animals.id 
 GROUP BY animals.name 
 ORDER BY number_of_visits DESC LIMIT 1;

/* Who was Maisy Smith's first visit? */

SELECT animals.name as first_visited_animal FROM visits 
JOIN vets ON visits.vets_id=vets.id
JOIN animals ON visits.animals_id = animals.id
WHERE vets.id=(SELECT id FROM vets WHERE name = 'Maisy Smith') 
ORDER BY date_of_visits LIMIT 1;


/* Details for most recent visit: animal information, vet information, and date of visit. */

SELECT animals.name as recently_visited_animal, vets.name as vet, date_of_visits as visited_date FROM visits 
JOIN animals on visits.animals_id = animals.id 
JOIN vets ON visits.vets_id=vets.id 
ORDER BY date_of_visits DESC LIMIT 1;

/* How many visits were with a vet that did not specialize in that animal's species? */

SELECT COUNT(*) as number_of_nonspecialist_visit from visits 
JOIN animals ON visits.animals_id = animals.id 
JOIN vets ON visits.vets_id=vets.id 
JOIN specializations ON visits.vets_id=specializations.vets_id 
WHERE animals.species_id != specializations.species_id;

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */

SELECT species.name AS MARY_SMITH_should_specialse_on FROM visits 
JOIN vets ON visits.vets_id=vets.id 
JOIN animals ON visits.animals_id=animals.id 
JOIN species ON animals.species_id=species.id 
WHERE visits.vets_id = (SELECT id FROM vets WHERE name = 'Maisy Smith') 
GROUP BY species.name 
ORDER BY COUNT(visits.animals_id) DESC LIMIT 1;
