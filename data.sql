/* Populate database with sample data. */

vet_clinic=# INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
vet_clinic-#     ('Agumon', '2022-02-03', 0, 'TRUE', 10.23),
vet_clinic-#     ('Gabumon', '2018-11-15', 2, 'TRUE', 8),
vet_clinic-#     ('Pikachu', '2021-01-07', 1, 'FALSE', 15.04),
vet_clinic-#     ('Devimon', '2017-05-12', 5, 'TRUE', 11)
vet_clinic-# ;
