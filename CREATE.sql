-- Remove conflicting tables
DROP TABLE IF EXISTS animal CASCADE;
DROP TABLE IF EXISTS animal_feeding CASCADE;
DROP TABLE IF EXISTS animal_godparent CASCADE;
DROP TABLE IF EXISTS employee CASCADE;
DROP TABLE IF EXISTS enclosure CASCADE;
DROP TABLE IF EXISTS enclosure_type CASCADE;
DROP TABLE IF EXISTS godparent CASCADE;
DROP TABLE IF EXISTS parent_child CASCADE;
DROP TABLE IF EXISTS section CASCADE;
DROP TABLE IF EXISTS security_guard CASCADE;
DROP TABLE IF EXISTS security_shift CASCADE;
DROP TABLE IF EXISTS species CASCADE;
DROP TABLE IF EXISTS zoo_keeper CASCADE;
DROP DOMAIN IF EXISTS email_type CASCADE;
-- End of removing

CREATE TABLE animal (
    animal_id SERIAL NOT NULL,
    enclosure_id INTEGER,
    binominal_name VARCHAR(75) NOT NULL,
    sex CHAR(1) CHECK (sex = 'M' OR sex = 'F'),
    birth_date DATE,
    name VARCHAR(50)
);
ALTER TABLE animal ADD CONSTRAINT pk_animal PRIMARY KEY (animal_id);

CREATE TABLE animal_feeding (
    timestamp TIMESTAMP NOT NULL,
    animal_id INTEGER NOT NULL,
    employee_id INTEGER NOT NULL
);
ALTER TABLE animal_feeding ADD CONSTRAINT pk_animal_feeding PRIMARY KEY (timestamp, animal_id, employee_id);

CREATE TABLE animal_godparent (
    animal_id INTEGER NOT NULL,
    godparent_id INTEGER NOT NULL,
    donation_amount INTEGER NOT NULL,
    donation_period SMALLINT NOT NULL
);
ALTER TABLE animal_godparent ADD CONSTRAINT pk_animal_godparent PRIMARY KEY (animal_id, godparent_id);

CREATE DOMAIN email_type AS
    varchar(254) CHECK (value ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$');

CREATE TABLE employee (
    employee_id SERIAL NOT NULL,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email email_type NOT NULL
);

ALTER TABLE employee ADD CONSTRAINT pk_employee PRIMARY KEY (employee_id);

CREATE TABLE enclosure (
    enclosure_id SERIAL NOT NULL,
    type_name VARCHAR(50) NOT NULL,
    section_name VARCHAR(80),
    capacity SMALLINT NOT NULL CHECK (capacity > 0)
);

ALTER TABLE enclosure ADD CONSTRAINT pk_enclosure PRIMARY KEY (enclosure_id);

CREATE TABLE enclosure_type (
    type_name VARCHAR(50) NOT NULL
);

ALTER TABLE enclosure_type ADD CONSTRAINT pk_enclosure_type PRIMARY KEY (type_name);

CREATE TABLE godparent (
    godparent_id SERIAL NOT NULL,
    name VARCHAR(50) NOT NULL,
    primary_contact VARCHAR(100) NOT NULL,
    secondary_contact VARCHAR(100),
    surname VARCHAR(50)
);
ALTER TABLE godparent ADD CONSTRAINT pk_godparent PRIMARY KEY (godparent_id);

CREATE TABLE parent_child (
    animal_id INTEGER NOT NULL,
    animal_parent_id INTEGER NOT NULL,
    parenting_type VARCHAR(20) CHECK (parenting_type IN ('Biological', 'Adoptive'))
);
ALTER TABLE parent_child ADD CONSTRAINT pk_parent_child PRIMARY KEY (animal_id, animal_parent_id);

CREATE TABLE section (
    section_name VARCHAR(80) NOT NULL
);

ALTER TABLE section ADD CONSTRAINT pk_section PRIMARY KEY (section_name);

CREATE TABLE security_guard (
    employee_id INTEGER NOT NULL,
    security_level VARCHAR(20) CHECK (security_level IN ('Entry', 'Intermediate', 'Advanced')),
    emergency_role VARCHAR(50)
);

ALTER TABLE security_guard ADD CONSTRAINT pk_security_guard PRIMARY KEY (employee_id);

CREATE TABLE security_shift (
    date DATE NOT NULL,
    employee_id INTEGER NOT NULL,
    section_name VARCHAR(80) NOT NULL
);
ALTER TABLE security_shift ADD CONSTRAINT pk_security_shift PRIMARY KEY (date, employee_id);

CREATE TABLE species (
    binominal_name VARCHAR(75) NOT NULL
                     );

ALTER TABLE species ADD CONSTRAINT pk_species PRIMARY KEY (binominal_name);

CREATE TABLE zoo_keeper (
    employee_id INTEGER NOT NULL,
    animals_specialization VARCHAR(20) NOT NULL CHECK (animals_specialization IN ('Mammals',
                                                                        'Birds',
                                                                        'Reptiles',
                                                                        'Amphibians',
                                                                        'Fish')));

ALTER TABLE zoo_keeper ADD CONSTRAINT pk_zoo_keeper PRIMARY KEY (employee_id);

ALTER TABLE animal ADD CONSTRAINT fk_animal_enclosure FOREIGN KEY (enclosure_id) REFERENCES enclosure (enclosure_id) ON DELETE CASCADE;
ALTER TABLE animal ADD CONSTRAINT fk_animal_species FOREIGN KEY (binominal_name) REFERENCES species (binominal_name) ON DELETE CASCADE;

ALTER TABLE animal_feeding ADD CONSTRAINT fk_animal_feeding_animal FOREIGN KEY (animal_id) REFERENCES animal (animal_id) ON DELETE CASCADE;
ALTER TABLE animal_feeding ADD CONSTRAINT fk_animal_feeding_zoo_keeper FOREIGN KEY (employee_id) REFERENCES zoo_keeper (employee_id) ON DELETE CASCADE;

ALTER TABLE animal_godparent ADD CONSTRAINT fk_animal_godparent_animal FOREIGN KEY (animal_id) REFERENCES animal (animal_id) ON DELETE CASCADE;
ALTER TABLE animal_godparent ADD CONSTRAINT fk_animal_godparent_godparent FOREIGN KEY (godparent_id) REFERENCES godparent (godparent_id) ON DELETE CASCADE;

ALTER TABLE enclosure ADD CONSTRAINT fk_enclosure_enclosure_type FOREIGN KEY (type_name) REFERENCES enclosure_type (type_name) ON DELETE CASCADE;
ALTER TABLE enclosure ADD CONSTRAINT fk_enclosure_section FOREIGN KEY (section_name) REFERENCES section (section_name) ON DELETE CASCADE;

ALTER TABLE parent_child ADD CONSTRAINT fk_parent_child_animal FOREIGN KEY (animal_id) REFERENCES animal (animal_id) ON DELETE CASCADE;
ALTER TABLE parent_child ADD CONSTRAINT fk_parent_child_animal_1 FOREIGN KEY (animal_parent_id) REFERENCES animal (animal_id) ON DELETE CASCADE;

ALTER TABLE security_guard ADD CONSTRAINT fk_security_guard_employee FOREIGN KEY (employee_id) REFERENCES employee (employee_id) ON DELETE CASCADE;

ALTER TABLE security_shift ADD CONSTRAINT fk_security_shift_security_guar FOREIGN KEY (employee_id) REFERENCES security_guard (employee_id) ON DELETE CASCADE;
ALTER TABLE security_shift ADD CONSTRAINT fk_security_shift_section FOREIGN KEY (section_name) REFERENCES section (section_name) ON DELETE CASCADE;

ALTER TABLE zoo_keeper ADD CONSTRAINT fk_zoo_keeper_employee FOREIGN KEY (employee_id) REFERENCES employee (employee_id) ON DELETE CASCADE;

COMMIT;


CREATE OR REPLACE FUNCTION check_enclosure_capacity()
-- Specify that the function should return trigger (a special data type that lets the function to be used later in trigger
-- Start the function with $$
RETURNS TRIGGER AS $$
-- Declare the variables
DECLARE
    current_animal_num INTEGER;
    enc_capacity INTEGER;
BEGIN
    -- Get the current number of animals in the enclosure and store them into current_animal_num variable.
    -- Basically, we check each row of the current animal table and count those with specific enclosure_id.
    SELECT COUNT(*) INTO  current_animal_num
    FROM animal
    -- In the context of a trigger function, NEW refers to the new row that is being inserted.
    WHERE enclosure_id = NEW.enclosure_id;
    -- Get the maximum capacity of the enclosure.
    SELECT capacity INTO enc_capacity
    FROM enclosure
    WHERE enclosure_id = NEW.enclosure_id;

    -- Check if adding the new animal exceeds capacity
    IF current_animal_num >= enc_capacity THEN
        RAISE EXCEPTION 'Enclosure capacity exceeded. Cannot add more animals.';
    END IF;
    -- Return NEW to allow the insert operation to proceed.
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger which will call the function every time the user adds an animal to the enclosure
CREATE TRIGGER trigger_check_capacity
BEFORE INSERT OR UPDATE ON animal
FOR EACH ROW EXECUTE FUNCTION check_enclosure_capacity();

-- A trigger that won’t allow to make a parent-child tuple if the child is not younger than the parent.
CREATE OR REPLACE FUNCTION check_parent_age()
RETURNS TRIGGER AS $$
DECLARE
    child_birth_date DATE;
    parent_birth_date DATE;
BEGIN
    SELECT birth_date INTO child_birth_date
    FROM animal
    WHERE animal_id = NEW.animal_id;

    SELECT birth_date INTO parent_birth_date
    FROM animal
    WHERE animal_id = NEW.animal_parent_id;

    IF parent_birth_date >= child_birth_date THEN
    RAISE EXCEPTION 'Parent must be older than the child.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_parent_age
BEFORE INSERT OR UPDATE ON parent_child
FOR EACH ROW EXECUTE FUNCTION check_parent_age();


CREATE OR REPLACE FUNCTION disjoint_complete_isa()
RETURNS TRIGGER AS $$
DECLARE
    zoo_keeper_count INTEGER;
    security_guard_count INTEGER;
    total_count INTEGER;
BEGIN
    -- Check the count of the employee as a zoo keeper
    SELECT COUNT(*)
    INTO zoo_keeper_count
    FROM zoo_keeper
    WHERE employee_id = NEW.employee_id;

    -- Check the count of the employee as a security guard
    SELECT COUNT(*)
    INTO security_guard_count
    FROM security_guard
    WHERE employee_id = NEW.employee_id;

    -- Ensure the employee is either a zoo keeper or a security guard, but not both or neither
    IF  (zoo_keeper_count + security_guard_count) != 1 THEN
        RAISE EXCEPTION 'Each employee must be either a zoo keeper or a security guard.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Trigger to enforce role assignment on employee creation
CREATE CONSTRAINT TRIGGER trigger_disjoint_complete
AFTER INSERT OR UPDATE ON employee
DEFERRABLE INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION disjoint_complete_isa();

-- Trigger to enforce role assignment on employee creation
CREATE CONSTRAINT TRIGGER trigger_disjoint_complete
AFTER INSERT OR UPDATE ON security_guard
DEFERRABLE INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION disjoint_complete_isa();

CREATE CONSTRAINT TRIGGER trigger_disjoint_complete
AFTER INSERT OR UPDATE ON zoo_keeper
DEFERRABLE INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION disjoint_complete_isa();

-- Trigger to prevent role deletion if it would leave an employee without a role
CREATE TRIGGER trigger_prevent_role_deletion
BEFORE DELETE ON zoo_keeper
FOR EACH ROW EXECUTE FUNCTION disjoint_complete_isa();

CREATE TRIGGER trigger_prevent_role_deletion
BEFORE DELETE ON security_guard
FOR EACH ROW EXECUTE FUNCTION disjoint_complete_isa();

COMMIT;