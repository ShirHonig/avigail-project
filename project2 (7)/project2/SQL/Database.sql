-- Create the table with enhanced security and constraints
CREATE TABLE tblUsers
(
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Password NVARCHAR(128) NOT NULL, -- Increased length for hashed passwords
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL CHECK (DateOfBirth <= GETDATE()),
    City NVARCHAR(50) NULL,
    Gender NVARCHAR(10) NOT NULL CHECK (Gender IN ('Male', 'Female')),
    IsAdmin BIT NOT NULL DEFAULT 0,
    CreatedDate DATETIME NOT NULL DEFAULT GETDATE(),
    LastLoginDate DATETIME NULL,
    IsActive BIT NOT NULL DEFAULT 1
)

-- Create indexes for better performance
CREATE INDEX IX_Username ON tblUsers(Username)
CREATE INDEX IX_City ON tblUsers(City)
CREATE INDEX IX_DateOfBirth ON tblUsers(DateOfBirth)

-- Insert all users at once (Note: In production, passwords should be properly hashed)
INSERT INTO tblUsers (Username, Password, FirstName, LastName, DateOfBirth, City, Gender, IsAdmin) VALUES 
('admin1', 'admin123', 'John', 'Admin', '1990-01-01', 'Nes Ziona', 'Male', 1),
('admin2', 'admin456', 'Jane', 'Admin', '1992-02-02', 'Nes Ziona', 'Female', 1),
('user1', 'pass123', 'David', 'Cohen', '1985-03-15', 'Nes Ziona', 'Male', 0),
('user2', 'pass456', 'Sarah', 'Levy', '2005-07-22', 'Tel Aviv', 'Female', 0),
('Lucy123', 'pass789', 'Lucy', 'Goldman', '1995-11-30', 'Nes Ziona', 'Female', 0),
('user4', 'pass321', 'Michael', 'Brown', '1988-04-25', 'Jerusalem', 'Male', 0),
('Liam22', 'pass654', 'Liam', 'Wilson', '2010-12-10', NULL, 'Male', 0),
('user6', 'pass987', 'Emma', 'Davis', '2004-09-18', 'Nes-Tziona', 'Female', 0),
('user7', 'passabc', 'Daniel', 'Miller', '1992-06-05', 'Nes Ziona', 'Male', 0),
('Laura89', 'passdef', 'Laura', 'Taylor', '1978-08-20', 'Nes Ziona', 'Female', 0),
('user9', 'passghi', 'Noah', 'Anderson', '2006-01-12', 'Ramat Gan', 'Male', 0),
('user10', 'passjkl', 'Sophia', 'Martin', '1998-05-28', 'Nes Ziona', 'Female', 0)

-- All required queries
-- 1. Find users with username starting with 'L'
SELECT * FROM tblUsers WHERE Username LIKE 'L%' AND IsActive = 1

-- 2. Non-admin users from Nes Ziona
SELECT Username, FirstName, LastName FROM tblUsers 
WHERE City = 'Nes Ziona' AND IsAdmin = 0 AND IsActive = 1

-- 3. Count users over 18
SELECT COUNT(*) as UsersOver18 
FROM tblUsers 
WHERE DATEDIFF(YEAR, DateOfBirth, GETDATE()) > 18 AND IsActive = 1

-- 4. Males over 30 and females under 20
SELECT FirstName, LastName, UserId 
FROM tblUsers
WHERE IsActive = 1 AND (
    (Gender = 'Male' AND DATEDIFF(YEAR, DateOfBirth, GETDATE()) > 30)
    OR (Gender = 'Female' AND DATEDIFF(YEAR, DateOfBirth, GETDATE()) < 20)
)
ORDER BY DateOfBirth DESC

-- 5. List of unique cities
SELECT DISTINCT City 
FROM tblUsers 
WHERE IsActive = 1 AND City IS NOT NULL

-- 6. Update NULL cities to 'NA'
UPDATE tblUsers 
SET City = 'NA' 
WHERE City IS NULL AND IsActive = 1

-- 7. Mark minors (using a transaction for safety)
BEGIN TRANSACTION
    UPDATE tblUsers 
    SET FirstName = FirstName + '_Minor' 
    WHERE DATEDIFF(YEAR, DateOfBirth, GETDATE()) < 18 
    AND IsActive = 1
    AND FirstName NOT LIKE '%_Minor'
COMMIT

-- 8. Fix city name (using a transaction for safety)
BEGIN TRANSACTION
    UPDATE tblUsers 
    SET City = 'Nes Ziona' 
    WHERE City = 'Nes-Tziona' AND IsActive = 1
COMMIT

-- 9. Soft delete specific users instead of hard delete
UPDATE tblUsers 
SET IsActive = 0 
WHERE City != 'Nes Ziona' AND UserId BETWEEN 10 AND 20 