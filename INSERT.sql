INSERT INTO enclosure_type (type_name) VALUES
('Aviary'),
('Cage'),
('Barrier'),
('Terrarium'),
('Aquarium');

INSERT INTO section (section_name) VALUES
('Asia'),
('Africa'),
('Oceanic'),
('North America'),
('South America'),
('Australia');

INSERT INTO enclosure (type_name, section_name, capacity) VALUES
-- Enclosures in Asia
('Aviary', 'Asia', 10),
('Cage', 'Asia', 2),
('Barrier', 'Asia', 12),
('Terrarium', 'Asia', 7),
('Aquarium', 'Asia', 15),

-- Enclosures in Africa
('Cage', 'Africa', 8),
('Barrier', 'Africa', 4),
('Aviary', 'Africa', 9),
('Terrarium', 'Africa', 4),
('Aquarium', 'Africa', 10),

-- Enclosures in Oceanic
('Aquarium', 'Oceanic', 20),
('Cage', 'Oceanic', 4),
('Aviary', 'Oceanic', 8),
('Barrier', 'Oceanic', 7),
('Terrarium', 'Oceanic', 6),

-- Enclosures in North America
('Barrier', 'North America', 8),
('Cage', 'North America', 10),
('Aviary', 'North America', 11),
('Aquarium', 'North America', 14),
('Terrarium', 'North America', 5),

-- Enclosures in South America
('Terrarium', 'South America', 5),
('Aviary', 'South America', 10),
('Cage', 'South America', 7),
('Barrier', 'South America', 9),
('Aquarium', 'South America', 12),

-- Enclosures in Australia
('Terrarium', 'Australia', 6),
('Barrier', 'Australia', 8),
('Aviary', 'Australia', 9),
('Cage', 'Australia', 5),
('Aquarium', 'Australia', 10),

-- Additional Enclosure for old animals.
('Barrier', 'Africa', 5);

-- Insert Species
INSERT INTO species (binominal_name) VALUES
('Panthera leo'),            -- Lion (ID 1)
('Ailuropoda melanoleuca'),  -- Panda (ID 2)
('Giraffa camelopardalis'),  -- Giraffe (ID 3)
('Elephas maximus'),         -- Elephant (ID 4)
('Panthera tigris'),         -- Tiger (ID 5)
('Equus zebra'),             -- Zebra (ID 6)
('Ursus maritimus'),         -- Polar Bear (ID 7)
('Cervus elaphus'),          -- Red Deer (ID 8)
('Ara macao'),               -- Scarlet Macaw (ID 9)
('Paracheirodon innesi'),    -- Neon Tetra (ID 10)
('Phoenicopterus roseus'),   -- Flamingo (ID 11)
('Pterophyllum scalare'),     -- Angelfish (ID 12)
('Carassius auratus'),        -- Goldfish (ID 13)
('Betula pendula'),           -- European White Birch (ID 14)
('Calidris alpina'),          -- Dunlin (ID 15)
('Agalychnis callidryas'),    -- Red-eyed Tree Frog (ID 16)
('Dendrobates tinctorius'),   -- Dyeing Dart Frog (ID 17)
('Chloropsis cochinchinensis'), -- Blue-winged Leafbird (ID 18)
('Lophura leucomelanos'),     -- Kalij Pheasant (ID 19)
('Aphyosemion australe');     -- Lyretail Killifish (ID 20)

-- Insert Animals with Realistic Enclosure IDs and Species IDs
INSERT INTO animal (enclosure_id, binominal_name, sex, birth_date, name) VALUES
(1, 'Panthera leo', 'M', '2013-06-10', 'Simba'),       -- Lion in Asia (Cage) 1
(6, 'Ailuropoda melanoleuca', 'F', '2013-04-23', 'Penny'),       -- Panda in Africa (Cage) 2
(15, 'Giraffa camelopardalis', 'M', '2023-09-11', 'Gerry'),      -- Giraffe in Oceanic (Barrier) 3
(7, 'Elephas maximus', 'F', '2018-12-05', 'Ella'),        -- Elephant in Africa (Barrier) 4
(2, 'Panthera tigris', 'M', '2014-05-20', 'Rajah'),       -- Tiger in Asia (Cage) 5
(17, 'Equus zebra', 'F', '2019-03-18', 'Zara'),       -- Zebra in North America (Cage) 6
(18, 'Ursus maritimus', 'M', '2015-11-25', 'Bjorn'),      -- Polar Bear in North America (Barrier) 7
(23, 'Cervus elaphus', 'F', '2018-06-15', 'Daisy'),      -- Red Deer in South America (Barrier) 8
(28, 'Phoenicopterus roseus', 'M', '2016-04-10', 'Felix'),     -- Flamingo in Australia (Aviary) 9
(8, 'Panthera leo', 'F', '2003-07-21', 'Nala'),        -- Lion in Africa (Cage) 10
(15, 'Ailuropoda melanoleuca', 'M', '2018-08-30', 'Bamboo'),     -- Panda in Oceanic (Barrier) 11
(21, 'Giraffa camelopardalis', 'F', '2016-11-05', 'Gigi'),       -- Giraffe in South America (Barrier) 12
(2, 'Elephas maximus', 'M', '2015-09-17', 'Zumbo'),       -- Elephant in Australia (Cage) 13
(1, 'Panthera leo', 'F', '2016-02-14', 'Layla'),       -- Another Lion in Asia (Cage) 14
(15, 'Giraffa camelopardalis', 'F', '2016-01-18', 'Grace'),      -- Another Giraffe in Oceanic (Barrier) 15
(7, 'Elephas maximus', 'M', '2003-05-22', 'Max'),         -- Another Elephant in Africa (Barrier) 16
(19, 'Panthera leo', 'M', '2021-08-12', 'Leo'),        -- Another Lion in North America (Cage) 17
(3, 'Ara macao', 'M', '2018-05-10', 'Blu'),         -- Scarlet Macaw in Asia (Aviary) 18
(20, 'Paracheirodon innesi', 'F', '2020-07-21', 'Nea'),       -- Neon Tetra in Oceanic (Aquarium) 19
(24, 'Ara macao', 'F', '2019-03-15', 'Ruby'),       -- Scarlet Macaw in South America (Aviary) 20
(25, 'Paracheirodon innesi', 'M', '2021-02-11', 'Finn'),      -- Neon Tetra in South America (Aquarium) 21
(5, 'Pterophyllum scalare', 'M', '2019-05-14', 'Angel'),      -- Angelfish in Asia (Aquarium) 22
(10, 'Carassius auratus', 'F', '2018-07-22', 'Goldie'),    -- Goldfish in Africa (Aquarium) 23
(30, 'Betula pendula', 'M', '2020-06-11', 'Birch'),     -- European White Birch in Australia (Terrarium) 24
(9, 'Calidris alpina', 'F', '2017-09-05', 'Dunnie'),     -- Dunlin in Africa (Aviary) 25
(4, 'Agalychnis callidryas', 'M', '2018-03-12', 'Red'),        -- Red-eyed Tree Frog in Asia (Terrarium) 26
(14, 'Dendrobates tinctorius', 'F', '2019-04-17', 'Dart'),      -- Dyeing Dart Frog in North America (Terrarium) 27
(3, 'Chloropsis cochinchinensis', 'M', '2017-11-23', 'Greenie'),    -- Blue-winged Leafbird in Asia (Aviary) 28
(8, 'Lophura leucomelanos', 'F', '2020-01-20', 'Kalij'),      -- Kalij Pheasant in Africa (Aviary) 29
(11, 'Aphyosemion australe', 'M', '2022-12-10', 'May'),       -- Lyretail Killifish in Oceanic (Aquarium) 30
(11, 'Aphyosemion australe', 'F', '2021-07-15', 'Lyre'),      -- Lyretail Killifish in Oceanic (Aquarium) 31
(7, 'Elephas maximus', 'F', '1999-12-20', 'Ellaria');        -- Elephant in Africa (Barrier) 32



-- Biological Parents (Same species, same section)
INSERT INTO parent_child (animal_id, animal_parent_id, parenting_type) VALUES
-- Simba (Lion, born 2013) and Nala (Lion, born 2003) in Asia (Cage)
(1, 10, 'Biological'),   -- Simba (Lion, age 10) and Nala (Lion, age 20)
-- Gerry (Giraffe, born 2016) and Grace (Giraffe, born 2023) in Oceanic (Barrier)
(3, 15, 'Biological'),  -- Gerry (Giraffe, age 0) and Grace (Giraffe, age 7)
-- Ella (Elephant, born 2003) and Max (Elephant, born 2018) in Africa (Barrier)
(4, 16, 'Biological');  -- Ella (Elephant, age 5) and Max (Elephant, age 20)

-- Adoptive Parents (Same species, different sections)
INSERT INTO parent_child (animal_id, animal_parent_id, parenting_type) VALUES
-- Leo (Lion in North America, born 2021) as adoptive parent of Simba (Lion in Asia, born 2013)
(17, 1, 'Adoptive');    -- Leo (Lion, age 2) and Simba (Lion, age 10)

-- Adoptive Parents (Same species, different sections)
INSERT INTO parent_child (animal_id, animal_parent_id, parenting_type) VALUES
-- Penny (Panda in Africa, born 2018) as adoptive parent of Bamboo (Panda in Oceanic, born 2017)
(11, 2, 'Adoptive');    -- Penny (Panda, age 5) and Bamboo (Panda, age 10)

INSERT INTO godparent (name, primary_contact, secondary_contact, surname) VALUES
('John', 'john.d@example.com', '555-2323', 'Doe'),
('Jane', 'jane.r@example.com', '555-3434', 'Roe'),
('Michael', 'michael.m@example.com', '555-4545', 'Miller'),
('Sarah', 'sarah.s@example.com', '555-5656', 'Smith'),
('Olivia', 'olivia.o@example.com', '555-6767', 'Olsen'),
('Alex', 'alex.a@example.com', '555-7878', 'Anderson'),
('Emily', 'emily.e@example.com', '555-8989', 'Evans'),
('Daniel', 'daniel.d@example.com', '555-1010', 'Davis'),
('Linda', 'linda.l@example.com', '555-1212', 'Lee'),
('Carlos', 'carlos.c@example.com', '555-1313', 'Cruz');


-- Linking Godparents with Animals
INSERT INTO animal_godparent (animal_id, godparent_id, donation_amount, donation_period) VALUES
(1, 1, 100, 30),   -- John is the godparent of Simba (Lion)
(2, 2, 150, 60),   -- Jane is the godparent of Penny (Panda)
(3, 3, 200, 100),  -- Michael is the godparent of Gerry (Giraffe)
(4, 4, 120, 60),   -- Sarah is the godparent of Ella (Elephant)
(5, 5, 130, 150),  -- Olivia is the godparent of Rajah (Tiger)
(7, 7, 110, 30),   -- Emily is the godparent of Bjorn (Polar Bear)
(27, 7, 110, 30),   -- Emily is the godparent of Bjorn (Polar Bear)
(8, 8, 160, 90),   -- Daniel is the godparent of Daisy (Red Deer)
(9, 9, 175, 120),  -- Linda is the godparent of Felix (Flamingo)
(1, 5, 100, 30),   -- Olivia is the godparent of Simba (Lion)
(19, 5, 100, 30),   -- Olivia is the godparent of Simba (Lion)
(10, 10, 150, 80); -- Carlos is the godparent of Nala (Lion)

BEGIN;
INSERT INTO employee (name, surname, phone, email) VALUES
('Alice', 'Johnson', '555-1234', 'alice.j@example.com'),
('Bob', 'Smith', '555-5678', 'bob.s@example.com'),
('Emma', 'Williams', '555-6789', 'emma.w@example.com'),
('James', 'Brown', '555-7890', 'james.b@example.com'),
('Liam', 'Wilson', '555-8901', 'liam.w@example.com'),
('Olivia', 'Taylor', '555-9012', 'olivia.t@example.com'),
('Noah', 'Anderson', '555-0123', 'noah.a@example.com');

-- Security Guards
INSERT INTO employee (name, surname, phone, email) VALUES
('Charlie', 'Brown', '555-9101', 'charlie.b@example.com'),
('Diana', 'Prince', '555-1122', 'diana.p@example.com'),
('Lucas', 'Miller', '555-2233', 'lucas.m@example.com'),
('Sophia', 'Davis', '555-3344', 'sophia.d@example.com'),
('Mia', 'Harris', '555-4455', 'mia.h@example.com'),
('Ethan', 'Clark', '555-5566', 'ethan.c@example.com');

-- Assigning Roles to Employees
-- Zoo Keepers
INSERT INTO zoo_keeper (employee_id, animals_specialization) VALUES
(1, 'Mammals'),
(2, 'Birds'),
(3, 'Reptiles'),
(4, 'Amphibians'),
(5, 'Fish'),
(6, 'Mammals'),
(7, 'Birds');

-- Security Guards
INSERT INTO security_guard (employee_id, security_level, emergency_role) VALUES
(8, 'Intermediate', 'Fire Safety'),
(9, 'Entry', 'First Aid'),
(10, 'Advanced', 'Crisis Management'),
(11, 'Intermediate', 'Surveillance'),
(12, 'Entry', 'Public Relations'),
(13, 'Intermediate', 'Emergency Evacuation');

COMMIT;

INSERT INTO security_shift (date, employee_id, section_name) VALUES
('2023-12-05', 8, 'Asia'),
('2023-12-05', 9, 'Africa'),
('2023-12-05', 11, 'Oceanic'),
('2023-12-05', 12, 'South America'),
('2023-12-05', 13, 'North America'),
('2023-12-06', 9, 'North America'),
('2023-12-06', 13, 'Oceanic'),
('2023-12-06', 11, 'Asia'),
('2023-12-06', 12, 'Australia'),
('2023-12-03', 13, 'Africa'),
('2023-12-06', 8, 'South America'),
('2023-12-07', 13, 'South America'),
('2023-12-07', 11, 'North America'),
('2023-12-07', 12, 'Africa'),
('2023-12-14', 13, 'Oceanic'),
('2023-12-07', 8, 'Australia'),
('2023-12-07', 9, 'Asia'),
('2023-12-08', 11, 'South America'),
('2023-12-08', 12, 'Oceanic'),
('2023-12-08', 13, 'Asia'),
('2023-12-08', 8, 'North America'),
('2023-12-08', 9, 'Australia'),
('2023-12-08', 10, 'Africa'),
('2023-12-09', 8, 'North America'),
('2023-12-09', 9, 'Australia'),
('2023-12-13', 11, 'Africa'),
('2023-12-09', 11, 'Africa'),
('2023-12-09', 12, 'North America'),
('2023-12-09', 13, 'Australia'),
('2023-12-10', 8, 'Africa'),
('2023-12-10', 9, 'Oceanic'),
('2023-12-10', 10, 'North America'),
('2023-12-10', 11, 'Australia'),
('2023-12-10', 12, 'Asia'),
('2023-12-10', 13, 'South America'),
('2023-12-11', 8, 'Australia'),
('2023-12-11', 9, 'Asia'),
('2023-12-11', 10, 'South America'),
('2023-12-11', 11, 'North America'),
('2023-12-11', 12, 'Oceanic'),
('2023-12-11', 13, 'Africa'),
('2023-12-12', 8, 'North America'),
('2023-12-12', 9, 'Australia'),
('2023-12-12', 10, 'Oceanic'),
('2023-12-12', 11, 'South America'),
('2023-12-12', 12, 'Africa'),
('2023-12-12', 13, 'Asia');;

INSERT INTO animal_feeding (timestamp, animal_id, employee_id) VALUES
('2023-12-01 08:30:00', 1, 1),    -- Alice (Mammals) fed Simba (Lion)
('2023-12-02 09:00:00', 14, 1),   -- Alice (Mammals) fed Layla (Lion)
('2023-12-01 14:30:00', 17, 1),   -- Alice (Mammals) fed Leo (Lion)
('2023-12-01 10:00:00', 2, 6),    -- Olivia (Mammals) fed Penny (Panda)
('2023-12-02 11:00:00', 7, 6),    -- Olivia (Mammals) fed Bjorn (Polar Bear)
('2023-12-01 15:30:00', 18, 2),   -- Bob (Birds) fed Blu (Scarlet Macaw)
('2023-12-01 16:00:00', 29, 2),   -- Bob (Birds) fed Kalij (Kalij Pheasant)
('2023-12-02 08:45:00', 3, 6),    -- Olivia (Mammals) fed Gerry (Giraffe)
('2023-12-01 12:30:00', 21, 5),   -- Liam (Fish) fed Lyre (Lyretail Killifish)
('2023-12-02 10:15:00', 26, 4),   -- James (Amphibians) fed Red (Red-eyed Tree Frog)
('2023-12-02 09:30:00', 4, 6),    -- Olivia (Mammals) fed Ella (Elephant)
('2023-12-01 11:00:00', 5, 1),    -- Alice (Mammals) fed Rajah (Tiger)
('2023-12-01 13:00:00', 6, 1),    -- Alice (Mammals) fed Zara (Zebra)
('2023-12-02 12:00:00', 11, 1),   -- Alice (Mammals) fed Bamboo (Panda)
('2023-12-01 10:30:00', 12, 6),   -- Olivia (Mammals) fed Gigi (Giraffe)
('2023-12-02 14:00:00', 13, 1),   -- Alice (Mammals) fed Zumbo (Elephant)
('2023-12-01 15:00:00', 14, 1),   -- Alice (Mammals) fed Layla (Another Lion)
('2023-12-02 08:30:00', 15, 6),   -- Olivia (Mammals) fed Grace (Giraffe)
('2023-12-01 16:30:00', 22, 5),   -- Liam (Fish) fed Angel (Angelfish)
('2023-12-02 11:30:00', 23, 5),   -- Liam (Fish) fed Goldie (Goldfish)
('2023-12-01 20:00:00', 2, 6),    -- Olivia (Mammals) feeds Penny (Panda)
('2023-12-04 09:15:00', 3, 6),    -- Olivia (Mammals) feeds Gerry (Giraffe)
('2023-12-03 11:30:00', 32, 6),    -- Olivia (Mammals) feeds Ellaria (Elephant)
('2023-12-04 08:45:00', 5, 1),    -- Alice (Mammals) feeds Rajah (Tiger)
('2023-12-05 14:00:00', 6, 1),    -- Alice (Mammals) feeds Zara (Zebra)
('2023-12-03 15:30:00', 7, 1),    -- Alice (Mammals) feeds Bjorn (Polar Bear)
('2023-12-04 10:30:00', 8, 2),    -- Bob (Birds) feeds Daisy (Red Deer)
('2023-12-05 09:00:00', 9, 2),    -- Bob (Birds) feeds Felix (Flamingo)
('2023-12-13 20:00:00', 20, 2),    -- Bob (Birds) feeds Scarlet Macaw
('2023-12-12 09:00:00', 28, 2),    -- Bob (Birds) feeds Greenie
('2023-12-03 16:15:00', 10, 1),   -- Alice (Mammals) feeds Nala (Another Lion)
('2023-12-04 13:45:00', 11, 6),   -- Olivia (Mammals) feeds Bamboo (Panda)
('2023-12-05 08:30:00', 12, 6),   -- Olivia (Mammals) feeds Gigi (Giraffe)
('2023-12-03 12:00:00', 13, 6),   -- Olivia (Mammals) feeds Zumbo (Elephant)
('2023-12-04 11:00:00', 15, 6),   -- Olivia (Mammals) feeds Grace (Another Giraffe)
('2023-12-05 10:15:00', 16, 6);   -- Olivia (Mammals) feeds Max (Another Elephant)


COMMIT;
