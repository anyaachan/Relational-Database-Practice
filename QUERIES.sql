SELECT *
FROM zoo_keeper zk
         INNER JOIN public.employee e on zk.employee_id = e.employee_id;

SELECT a.*
FROM animal a
         LEFT JOIN parent_child pc1 ON a.animal_id = pc1.animal_id
         LEFT JOIN parent_child pc2 ON a.animal_id = pc2.animal_parent_id
WHERE pc1.animal_id IS NULL
  AND pc2.animal_parent_id IS NULL;

SELECT a.*
FROM animal a
         -- AND modifies the join to only consider records from animal_feeding where the date is equal to '2023-12-02'.
         LEFT JOIN animal_feeding af ON a.animal_id = af.animal_id AND DATE(af.timestamp) = '2023-12-02'
WHERE af.timestamp IS NULL;


SELECT
    -- DATE_PART extracts the year
    -- AGE is a POSTGRESQL function postgresqltutorial.com/postgresql-date-functions/postgresql-age/
    DATE_PART('year', AGE(CURRENT_DATE, birth_date)) AS age,
    COUNT(*)                                         AS number_of_animals
FROM animal
GROUP BY age
ORDER BY age;

SELECT name, binominal_name, sex, birth_date, type_name enc_type, enclosure_id enc_id, section_name
FROM animal a
         NATURAL JOIN public.enclosure e
         NATURAL JOIN section s
         NATURAL JOIN species sp
WHERE e.section_name = 'Africa';

SELECT a.enclosure_id,
       array_agg(name) AS animals_in_enclosure,
       e.type_name
FROM animal a
         INNER JOIN enclosure e on a.enclosure_id = e.enclosure_id
WHERE e.section_name = 'Oceanic'
GROUP BY a.enclosure_id,
         e.type_name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

-- Select all pairs of animals that are the same species and live in the same enclosure

SELECT *
FROM animal a
         CROSS JOIN animal a1
WHERE a.enclosure_id = a1.enclosure_id
  AND a.binominal_name = a1.binominal_name
  AND a.animal_id != a1.animal_id
  AND a.animal_id < a1.animal_id;

SELECT a.*
FROM animal a
         INNER JOIN animal_feeding af on a.animal_id = af.animal_id
         INNER JOIN employee e on af.employee_id = e.employee_id
WHERE e.name = 'Olivia'

EXCEPT

SELECT a.*
FROM animal a
         INNER JOIN animal_feeding af on a.animal_id = af.animal_id
         INNER JOIN employee e on af.employee_id = e.employee_id
WHERE e.name != 'Olivia';


SELECT a.animal_id,
       a.name AS animal_name,
       a.binominal_name,
       ag.godparent_id,
       ag.donation_amount,
       ag.donation_period
FROM animal a
         LEFT JOIN
     animal_godparent ag ON a.animal_id = ag.animal_id
ORDER BY a.animal_id;


SELECT DISTINCT e.*
FROM (SELECT zk.employee_id
      FROM zoo_keeper zk
               FULL OUTER JOIN
           animal_feeding af ON zk.employee_id = af.employee_id
               LEFT JOIN
           animal a ON af.animal_id = a.animal_id
      WHERE zk.employee_id IS NULL
         OR af.timestamp IS NULL
      ORDER BY zk.employee_id) AS emp_no_feeding
         INNER JOIN employee e ON emp_no_feeding.employee_id = e.employee_id;


SELECT e.employee_id,
       e.name,
       e.surname,
       'Zoo Keeper'              AS role,
       zk.animals_specialization AS specialization
FROM employee e
         JOIN
     zoo_keeper zk ON e.employee_id = zk.employee_id
UNION
SELECT e.employee_id,
       e.name,
       e.surname,
       'Security Guard'  AS role,
       sg.security_level AS specialization
FROM employee e
         JOIN
     security_guard sg ON e.employee_id = sg.employee_id
ORDER BY employee_id;


SELECT DISTINCT e.enclosure_id, e.type_name, e.section_name
FROM enclosure e
         INNER JOIN animal a ON a.enclosure_id = e.enclosure_id
WHERE NOT EXISTS (SELECT 1
                  FROM animal_feeding af
                           JOIN animal a ON af.animal_id = a.animal_id
                  WHERE a.enclosure_id = e.enclosure_id
                    AND DATE(af.timestamp) = '2023-12-01')
ORDER BY e.section_name, e.type_name;

-- Preparing a reports for godparents about when their animal was fed during the month 12 of the year 2023
SELECT animal_id
FROM animal_godparent

INTERSECT

SELECT DISTINCT animal_id
FROM animal_feeding
WHERE EXTRACT(MONTH FROM timestamp) = 12
  AND EXTRACT(YEAR FROM timestamp) = 2023;

SELECT animal_id,
       AVG(donation_amount)                                AS avg_donation_per_animal,
       (SELECT AVG(donation_amount) FROM animal_godparent) AS overall_avg_donation
FROM animal_godparent
GROUP BY animal_id
ORDER BY animal_id;

SELECT a.*
FROM animal a
         INNER JOIN ((SELECT pc.animal_id
                      FROM parent_child pc)

                     INTERSECT

                     (SELECT ag.animal_id
                      FROM animal_godparent ag)) AS godparent_child_ids
ON a.animal_id = godparent_child_ids.animal_id;


SELECT
    sg.employee_id,
    s.section_name,
    COALESCE(COUNT(ss.employee_id), 0) AS shift_count
FROM
    security_guard sg
CROSS JOIN
    section s
LEFT JOIN
    security_shift ss ON sg.employee_id = ss.employee_id AND s.section_name = ss.section_name
GROUP BY
    sg.employee_id,
    s.section_name
ORDER BY
    sg.employee_id,
    shift_count DESC;

-- Delete animal_godparent relationship if the animal hasn't been fed for 6 Month.
DELETE FROM animal_godparent
WHERE animal_id IN (
    SELECT a.animal_id
    FROM animal a
    WHERE NOT EXISTS (
        SELECT 1
        FROM animal_feeding af
        WHERE af.animal_id = a.animal_id
        AND af.timestamp > CURRENT_DATE - INTERVAL '6 months'
    )
);


UPDATE animal
SET enclosure_id = 31
WHERE animal_id IN (
    SELECT a.animal_id
    FROM animal a
    WHERE a.binominal_name IN ('Elephas maximus')
      AND a.birth_date <= '2010-01-01'
)
AND enclosure_id != 31;


SELECT *
FROM (SELECT e.enclosure_id, e.capacity, COUNT(a.animal_id) as animal_count
FROM enclosure e
JOIN animal a ON e.enclosure_id = a.enclosure_id
GROUP BY e.enclosure_id) AS an_enc
WHERE animal_count >= capacity * 0.75
ORDER BY enclosure_id;



SELECT a.binominal_name, COUNT(*)
FROM animal a
-- First filter the animals that don't have godparents, then select their binominal names
WHERE NOT EXISTS (
    SELECT 1
    FROM animal_godparent ag
    WHERE ag.animal_id = a.animal_id
)
GROUP BY a.binominal_name;

SELECT e.enclosure_id, a.binominal_name, a.sex
FROM enclosure e
JOIN animal a ON e.enclosure_id = a.enclosure_id
GROUP BY e.enclosure_id, a.binominal_name, a.sex
HAVING COUNT(DISTINCT a.sex) = 1;

INSERT INTO security_shift (date, employee_id, section_name)
SELECT '2023-12-22', sg.employee_id, s.section_name
FROM security_guard sg
CROSS JOIN section s
LEFT JOIN (
    SELECT ss.employee_id, ss.section_name
    FROM security_shift ss
    WHERE ss.date > CAST('2023-12-21' AS DATE) - INTERVAL '30 days'
) AS recent_shifts ON sg.employee_id = recent_shifts.employee_id AND s.section_name = recent_shifts.section_name
WHERE recent_shifts.employee_id IS NULL;

CREATE VIEW View_AnimalDetails AS
SELECT
    a.animal_id,
    a.name,
    a.binominal_name,
    a.enclosure_id,
    e.type_name AS enclosure_type,
    COUNT(af.timestamp) AS feeding_count
FROM
    animal a
JOIN
    enclosure e ON a.enclosure_id = e.enclosure_id
LEFT JOIN
    animal_feeding af ON a.animal_id = af.animal_id
GROUP BY
    a.animal_id, e.type_name;

CREATE VIEW AvgFeedingCount AS
SELECT
    vd_inner.binominal_name,
    AVG(vd_inner.feeding_count) AS avg_feeding
FROM
    View_AnimalDetails vd_inner
GROUP BY
    vd_inner.binominal_name;

SELECT
    vd.animal_id,
    vd.name,
    vd.binominal_name,
    vd.enclosure_id,
    vd.feeding_count,
    afc.avg_feeding
FROM
    View_AnimalDetails vd
INNER JOIN AvgFeedingCount afc ON vd.binominal_name = afc.binominal_name
WHERE
    vd.feeding_count < afc.avg_feeding
ORDER BY
    vd.binominal_name, vd.feeding_count;

SELECT e.*
FROM enclosure e
LEFT JOIN animal a ON e.enclosure_id = a.enclosure_id
WHERE a.enclosure_id IS NULL
ORDER BY enclosure_id;

SELECT s.section_name, COUNT(DISTINCT a.binominal_name) AS species_count
FROM section s
INNER JOIN enclosure e ON s.section_name = e.section_name
INNER JOIN animal a ON e.enclosure_id = a.enclosure_id
GROUP BY s.section_name
ORDER BY species_count DESC;

SELECT
    e.enclosure_id,
    e.capacity,
    COUNT(a.animal_id) AS animal_count,
    ROUND((COUNT(a.animal_id) / CAST(e.capacity AS FLOAT)) * 100) AS utilization_percentage
FROM
    enclosure e
LEFT JOIN
    animal a ON e.enclosure_id = a.enclosure_id
GROUP BY
    e.enclosure_id,
    e.capacity
ORDER BY utilization_percentage DESC;



SELECT s.section_name, a.binominal_name
FROM section s
JOIN enclosure e ON s.section_name = e.section_name
JOIN animal a ON e.enclosure_id = a.enclosure_id
GROUP BY s.section_name, a.binominal_name
HAVING COUNT(DISTINCT e.section_name) = 1;


SELECT DISTINCT e.enclosure_id, ss.section_name
FROM enclosure e
INNER JOIN security_shift ss ON ss.section_name = e.section_name
INNER JOIN security_guard sg ON sg.employee_id = ss.employee_id
WHERE sg.security_level = 'Advanced';

CREATE OR REPLACE FUNCTION get_animal_feedings(animal_id_param INTEGER, month_param INTEGER, year_param INTEGER)
RETURNS TABLE(
    feeding_time TIMESTAMP,
    employee_name VARCHAR(50)
) AS $$
BEGIN
    RETURN QUERY
    SELECT af.timestamp, e.name
    FROM animal_feeding af
    INNER JOIN employee e ON e.employee_id = af.employee_id
    WHERE af.animal_id = animal_id_param
      AND EXTRACT(MONTH FROM af.timestamp) = month_param
      AND EXTRACT(YEAR FROM af.timestamp) = year_param;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_animal_feedings(3, 12, 2023);


CREATE OR REPLACE FUNCTION is_zoo_fully_staffed(date_param DATE)
RETURNS BOOLEAN AS $$
DECLARE
    section_count INTEGER;
BEGIN
    SELECT COUNT(DISTINCT section_name) INTO section_count
    FROM security_shift
    WHERE date = date_param;

    RETURN section_count = 6;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM is_zoo_fully_staffed('2023-12-12');


CREATE OR REPLACE FUNCTION check_feeding_compliance(animal_id_param INTEGER, feedings_needed INTEGER, check_date DATE)
RETURNS BOOLEAN AS $$
DECLARE
    feedings_on_date INTEGER;
BEGIN
    SELECT COUNT(*) INTO feedings_on_date
    FROM animal_feeding
    WHERE animal_id = animal_id_param AND CAST(timestamp AS DATE) = check_date;
    RETURN feedings_on_date >= feedings_needed;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM check_feeding_compliance(2, 2, DATE '2023-12-01');


