#what are all the types of pokemon that a pokemon can have
SELECT * FROM types;

#What is the name of the pokemon with id 45?
SELECT * FROM pokemons WHERE id=45;

#How many pokemon are there?
SELECT COUNT(*) FROM pokemons;

#How many types are there?
SELECT COUNT(*) FROM types;

#How many pokemon have a secondary type?
SELECT COUNT(*) FROM pokemons WHERE secondary_type IS NOT NULL;

#What is each pokemon's primary type?
SELECT pokemons.name, types.name FROM types LEFT JOIN pokemons ON types.id = pokemons.primary_type ORDER BY pokemons.id;

#What is Rufflet's secondary type?
SELECT pokemons.name, types.name FROM types LEFT JOIN pokemons ON types.id = pokemons.secondary_type WHERE pokemons.name = "Rufflet";

#What are the names of the pokemon that belong to the trainer with trainerID 303?
SELECT pokemons.name FROM pokemons LEFT JOIN pokemon_trainer pt ON pt.pokemon_id = pokemons.id WHERE pt.trainerID = 303;

#How many pokemon have a secondary type Poison
SELECT COUNT(*) FROM types LEFT JOIN pokemons ON types.id = pokemons.secondary_type WHERE types.name =
 "Poison";

#What are all the primary types and how many pokemon have that type?
SELECT types.name, COUNT(*) FROM pokemons INNER JOIN types ON types.id = pokemons.primary_type GROUP BY types.name;

#How many pokemon at level 100 does each trainer with at least one level 100 pokemone have?
SELECT COUNT(*) FROM pokemon_trainer pt WHERE pt.pokelevel = 100 GROUP BY pt.trainerID;

#How many pokemon only belong to one trainer and no other?
select COUNT(*) FROM (SELECT pokemon_id FROM pokemon_trainer GROUP BY pokemon_id HAVING COUNT(*) = 1) p;
#I wasted a bunch of time cause I initially thought of nesting selects but decided against then immediately got it when i went back and nested em

#part 4
SELECT p.name Pokemon_Name, t.trainername Trainer_Name, pt.pokeLevel Level, p.primary_type Primary_Type, p.secondary_type Secondary_Type
FROM pokemon_trainer pt
LEFT JOIN pokemons p ON p.id = pt.pokemon_id
LEFT JOIN trainers t ON pt.trainerID = t.trainerID
ORDER BY pt.pokeLevel, COUNT(*) OVER(PARTITION BY t.trainername);
#I ordered this by the trainers with the most and highest level pokemon, i found over partition by which let me do this, which is pretty neat