-- Duplicate original dataset to preserve raw data
CREATE TABLE dataset2
LIKE dataset;

SELECT *
FROM dataset;

INSERT dataset2
SELECT *
FROM dataset;

SELECT *
FROM dataset2;

-- Rename columns for clarity and consistency
ALTER TABLE dataset2
RENAME COLUMN `Choose your gender` TO Gender;

ALTER TABLE dataset2
RENAME COLUMN `What is your course?` TO Course;

ALTER TABLE dataset2
RENAME COLUMN `Your current year of Study` TO Year_of_study;

ALTER TABLE dataset2
RENAME COLUMN `What is your CGPA?` TO CGPA;

ALTER TABLE dataset2
RENAME COLUMN `Do you have Depression?` TO Depression_status;

ALTER TABLE dataset2
RENAME COLUMN `Do you have Anxiety?` TO Anxiety_status;

ALTER TABLE dataset2
RENAME COLUMN `Do you have Panic attack?` TO Panic_attack_status;

ALTER TABLE dataset2
RENAME COLUMN `Did you seek any specialist for a treatment?` TO Sought_treatment;

-- Clean inconsistent gender entries
UPDATE dataset2
SET Gender = 'Male'
WHERE Gender IN ('male', 'M', 'm');

UPDATE dataset2
SET Gender = 'Female'
WHERE Gender IN ('female', 'F', 'f');

 -- Remove outliers: age must be between 18 and 80
DELETE FROM dataset2
WHERE Age < 18 OR Age > 80;

-- Standardize Marital Status
ALTER TABLE dataset2
RENAME COLUMN `Marital status` TO Marital_status;

UPDATE dataset2
SET Marital_status= 'Yes'
WHERE TRIM(LOWER(Marital_status)) = 'yes';

UPDATE dataset2
SET Marital_status = 'No'
WHERE TRIM(LOWER(Marital_status)) = 'no';

-- Clean Depression status
UPDATE dataset2
SET Depression_status = 'Yes'
WHERE TRIM(LOWER(Depression_status)) = 'yes';

UPDATE dataset2
SET Depression_status = 'No'
WHERE TRIM(LOWER(Depression_status)) = 'no';

-- Clean Anxiety_status
UPDATE dataset2
SET Anxiety_status = 'Yes'
WHERE TRIM(LOWER(Anxiety_status)) = 'yes';

UPDATE dataset2
SET Anxiety_status = 'No'
WHERE TRIM(LOWER(Anxiety_status)) = 'no';

-- Clean Panic_attack_status
UPDATE dataset2
SET Panic_attack_status = 'Yes'
WHERE TRIM(LOWER(Panic_attack_status)) = 'yes';

UPDATE dataset2
SET Panic_attack_status = 'No'
WHERE TRIM(LOWER(Panic_attack_status)) = 'no';

-- Clean Sought_treatment
UPDATE dataset2
SET Sought_treatment = 'Yes'
WHERE TRIM(LOWER(Sought_treatment)) = 'yes';

UPDATE dataset2
SET Sought_treatment = 'No'
WHERE TRIM(LOWER(Sought_treatment)) = 'no';

-- Standardize Year of Study values
SELECT DISTINCT Year_of_study FROM dataset2;

-- Year 1 variation
UPDATE dataset2
SET Year_of_study = 'Year 1'
WHERE Year_of_study IN ('year 1');

-- Year 2 variation
UPDATE dataset2
SET Year_of_study = 'Year 2'
WHERE Year_of_study IN ('year 2');

-- Year 3 variation
UPDATE dataset2
SET Year_of_study = 'Year 3'
WHERE Year_of_study IN ('year 3');

-- Year 4 variation
UPDATE dataset2
SET Year_of_study = 'Year 4'
WHERE Year_of_study IN ('year 4');

-- Standardize Year of Study values
ALTER TABLE dataset2 ADD COLUMN extracted_date DATE;

UPDATE dataset2
SET extracted_date = DATE(
  CASE
    WHEN `Timestamp` REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4} [0-9]{1,2}:[0-9]{2}$' THEN
      STR_TO_DATE(`Timestamp`, '%e/%c/%Y %H:%i')

    WHEN `Timestamp` REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4} [0-9]{2}:[0-9]{2}:[0-9]{2}$' THEN
      STR_TO_DATE(`Timestamp`, '%d/%m/%Y %H:%i:%s')

    ELSE NULL
  END
);

ALTER TABLE dataset2 ADD COLUMN extracted_time TIME;

UPDATE dataset2
SET extracted_time = TIME (
  CASE
    -- Format without seconds: '9/7/2020 6:57'
    WHEN `Timestamp` REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4} [0-9]{1,2}:[0-9]{2}$' THEN
      TIME(STR_TO_DATE(`Timestamp`, '%e/%c/%Y %H:%i'))

    -- Format with seconds: '13/07/2020 11:54:58'
    WHEN `Timestamp` REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4} [0-9]{2}:[0-9]{2}:[0-9]{2}$' THEN
      TIME(STR_TO_DATE(`Timestamp`, '%d/%m/%Y %H:%i:%s'))

    ELSE NULL
  END );

-- Move new columns for readability
ALTER TABLE dataset2
MODIFY COLUMN extracted_date DATE FIRST,
MODIFY COLUMN extracted_time TIME AFTER extracted_date;

-- Drop irrelevant column
ALTER TABLE dataset2
DROP COLUMN `Timestamp`;

-- Further clean and standardize Marital status
SELECT DISTINCT Marital_status FROM dataset2;

-- Clean up Marital status values (case-sensitive match)
UPDATE dataset2
SET Marital_status = 'Married'
WHERE TRIM(Marital_status) = 'Yes';

UPDATE dataset2
SET Marital_status = 'Single'
WHERE TRIM(Marital_status) = 'No';

--  Clean and normalize Course names
SELECT DISTINCT Course 
FROM dataset2 
ORDER BY Course;

-- Fix Accounting
UPDATE dataset2
SET Course = 'Accounting'
WHERE TRIM(Course) = 'Accounting ';

-- Fix Engineering variants
UPDATE dataset2
SET Course = 'Engineering'
WHERE TRIM(Course) IN ('engin', 'Engine', 'Engineering', 'ENM');

-- Fix Law duplicates
UPDATE dataset2
SET Course = 'Law'
WHERE TRIM(Course) IN ('Law', 'Laws');

-- Fix Mathematics typo
UPDATE dataset2
SET Course = 'Mathematics'
WHERE TRIM(Course) IN ('Mathemathics', 'Mathematics');

-- Fix Pendidikan Islam casing
UPDATE dataset2
SET Course = 'Pendidikan Islam'
WHERE TRIM(Course) IN ('Pendidikan islam', 'Pendidikan Islam');

-- Fix Fiqh variations
UPDATE dataset2
SET Course = 'Fiqh'
WHERE TRIM(Course) IN ('Fiqh', 'Fiqh fatwa');

-- Fix Usuluddin duplicate
UPDATE dataset2
SET Course = 'Usuluddin'
WHERE TRIM(Course) = 'Usuluddin ';

-- Fix casing and spacing issues
-- Fix typo Malcom -> Malcolm
UPDATE dataset2
SET Course = 'Malcolm'
WHERE Course = 'Malcom';

-- Normalize Diploma TESL casing
UPDATE dataset2
SET Course = 'Diploma TESL'
WHERE LOWER(Course) = 'diploma tesl';

-- Normalize Biomedical Science casing
UPDATE dataset2
SET Course = 'Biomedical Science'
WHERE LOWER(Course) = 'biomedical science';

-- Normalize Marine Science casing
UPDATE dataset2
SET Course = 'Marine Science'
WHERE LOWER(Course) = 'marine science';

-- Normalize Mathematics casing
UPDATE dataset2
SET Course = 'Mathematics'
WHERE LOWER(Course) = 'mathematics';

-- Normalize Communication spacing
UPDATE dataset2
SET Course = 'Communication'
WHERE TRIM(Course) = 'Communication ';

-- Flag unknown or unclear course entries
ALTER TABLE dataset2 
ADD COLUMN Course_flag 
VARCHAR(10) DEFAULT 'Known';

UPDATE dataset2
SET Course_flag = 'Unknown'
WHERE Course IN ('ALA', 'BENL', 'Kop', 'KENMS', 'KIRKHS');

-- Reorder columns for better readability
ALTER TABLE dataset2
MODIFY COLUMN Course_flag VARCHAR(10) AFTER Course;

-- Check for duplicate survey entries
SELECT *, COUNT(*) as duplicate_count
FROM dataset2
GROUP BY 
    extracted_date, extracted_time, Gender, Age, Course, Course_flag, Year_of_study, CGPA, Marital_status,
    Depression_status, Anxiety_status, Panic_attack_status, Sought_treatment
HAVING COUNT(*) > 1;

-- Rename date/time columns for clarity
ALTER TABLE dataset2
CHANGE extracted_date Survey_date DATE;

ALTER TABLE dataset2
CHANGE extracted_time Survey_time TIME;

-- Final check: view cleaned data
SELECT * 
FROM dataset2;