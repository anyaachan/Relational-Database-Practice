-- Procedures
DROP PROCEDURE IF EXISTS update_godparent_donation_info;

CREATE OR REPLACE PROCEDURE update_godparent_donation_info(animalid INTEGER,
                                                           godparentid INTEGER,
                                                           new_donation_amount INTEGER,
                                                           new_donation_period INTEGER)
AS $$
DECLARE
    record_exists BOOLEAN;
BEGIN
    -- Check if the godparent-animal relationship exists
    SELECT EXISTS(SELECT 1 FROM animal_godparent ag WHERE ag.animal_id = animalid AND ag.godparent_id = godparentid) INTO record_exists;

    IF record_exists THEN
        UPDATE animal_godparent ag2
        SET donation_amount = new_donation_amount, donation_period = new_donation_period
        WHERE ag2.animal_id = animalid AND ag2.godparent_id = godparentid;
    ELSE
        RAISE EXCEPTION 'No existing godparent relationship found for animal % and godparent %.', animalid, godparentid;
    END IF;
END;
$$ LANGUAGE plpgsql;

CALL update_godparent_donation_info(1, 1, 2000, 29);



CREATE OR REPLACE PROCEDURE add_feeding_for_enclosure(enc_id INTEGER, emp_id INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO animal_feeding (timestamp, animal_id, employee_id)
    SELECT CURRENT_TIMESTAMP, animal_id, emp_id
    FROM animal
    WHERE enclosure_id = enc_id;
END;
$$;

CALL add_feeding_for_enclosure(1, 1);



CREATE OR REPLACE PROCEDURE delete_inactive_zookeepers()
AS $$
DECLARE
    employee_record RECORD;
BEGIN
    -- Loop through employees who haven't fed any animals for a year or at all
    FOR employee_record IN
        SELECT e.employee_id
        FROM employee e
        LEFT JOIN animal_feeding af ON e.employee_id = af.employee_id
        LEFT JOIN security_guard sg ON e.employee_id = sg.employee_id
        WHERE (af.timestamp IS NULL OR af.timestamp < NOW() - INTERVAL '1 year') AND sg.employee_id IS NULL
        GROUP BY e.employee_id
    LOOP
        -- Delete tuple from zoo_keeper
        DELETE FROM zoo_keeper WHERE employee_id = employee_record.employee_id;
        DELETE FROM animal_feeding WHERE employee_id = employee_record.employee_id;

        -- Delete the employee tuple
        DELETE FROM employee WHERE employee_id = employee_record.employee_id;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


CALL delete_inactive_zookeepers();
