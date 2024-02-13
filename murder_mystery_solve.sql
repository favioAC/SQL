-- SEARCHING FOR CLUE IN crime_scene_report

SELECT * FROM crime_scene_report
WHERE 
	date = '20180115'
AND
	city = 'SQL City';
	
-- 2 WITNESSES: LAST HOUSE ON STREET = 'NORTHWESTERN DR.', AND SECOND WITNESS NAME = ANNABEL AND STREET = 'FRANKLIN AVE'

-- ----------------------------------------------------------------------------------------------------------------------

-- SEARCHING FOR TWO WITNESSES
SELECT * FROM person
WHERE address_street_name LIKE '%Northwestern%'
ORDER BY address_number DESC
LIMIT 1;

SELECT * FROM person
WHERE
	name LIKE '%Annabel%'
AND
	address_street_name LIKE '%Franklin Ave%';

-- RESULTS: MORTY AND ANNABEL ARE THE WITNESSES

-- ----------------------------------------------------------------------------------------------------------------------
	
-- REVIEWING WITNESS INTERVIEWS
SELECT p.name, i.transcript
FROM person AS p LEFT JOIN interview AS i ON (p.id = i.person_id)
WHERE p.id IN (14887, 16371);

-- RESULTS: 
-- MORTY CLUES: membership_status = GOLD, membership_id HAS '48Z', plate_number HAS 'H42W', gender = MALE
-- ANNABEL CLUES: get_fit_now_check_in ON 20180109

-- ----------------------------------------------------------------------------------------------------------------------

-- NARROWING DOWN SUSPECTS

SELECT 
	p.name,
	p.id,
	d.gender,
	d.plate_number, 
	c.membership_id,
	m.membership_status
FROM 
	drivers_license AS d JOIN person AS p ON (d.id = p.license_id)
JOIN
	get_fit_now_member AS m ON (p.id = m.person_id)
JOIN
	get_fit_now_check_in AS c ON (m.id = c.membership_id)
WHERE
	d.gender = 'male' AND d.plate_number LIKE '%H42W%'
AND
	c.membership_id LIKE '%48Z%' AND m.membership_status = 'gold';
	
-- ----------------------------------------------------------------------------------------------------------------------
-- ADDING SUSPECT TO solution TABLE
INSERT INTO solution
VALUES (1, 'Jeremy Bowers');

-- CHECKING SUSPECT RESULT
SELECT value
FROM solution;

-- ----------------------------------------------------------------------------------------------------------------------
-- GETTING MURDERER'S TRANSCRIPT
SELECT
	p.name,
	p.id,
	i.transcript
FROM person AS p JOIN interview AS i ON (p.id = i.person_id)
WHERE p.id = 67318;

-- RESULTS: HIRED BY WEALTHY WOMAN
-- DESCRIPTION: HEIGHT = 5'5" (65) OR 5'7" (67), HAIR = RED, CAR = TESLA MODEL S
-- ADDITIONAL: ATTENDED SQL SYMPHONY CONCERT 3 TIMES IN DECEMBER 2017

-- ----------------------------------------------------------------------------------------------------------------------
-- FINDING MASTERMIND SUSPECTS
SELECT p.name, p.id
FROM drivers_license AS d JOIN person AS p ON (d.id = p.license_id)
WHERE 
	d.hair_color = 'red' AND d.car_make = 'Tesla' AND d.gender = 'female' AND d.car_model = 'Model S'
AND 
	d.height BETWEEN 65 AND 67;

-- NARROWING DOWN MASTERMIND
SELECT p.name, event_name, f.date
FROM facebook_event_checkin AS f JOIN person AS p ON (f.person_id = p.id)
WHERE SUBSTR(f.date, 1,4) = '2017' AND p.id IN (78881, 90700, 99716);


-- ADDING SUSPECT TO solution TABLE
INSERT INTO solution
VALUES (1, 'Miranda Priestly');

-- CHECKING SUSPECT RESULT
SELECT value
FROM solution;

-- ----------------------------------------------------------------------------------------------------------------------
-- RESULTS:
-- MURDERER: JEREMY BOWERS
-- MASTERMIND: MIRANDA PRIESTLY