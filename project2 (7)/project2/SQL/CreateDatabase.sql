USE [master]
GO

-- Create the database if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'UsersDB')
BEGIN
    CREATE DATABASE [UsersDB]
END
GO

USE [UsersDB]
GO

-- Drop the table if it exists
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblUsers]') AND type in (N'U'))
DROP TABLE [dbo].[tblUsers]
GO

-- Create Users Table
CREATE TABLE tblUsers
(
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    City NVARCHAR(50) NULL,
    Gender NVARCHAR(10) NOT NULL CHECK (Gender IN ('Male', 'Female')),
    IsAdmin BIT NOT NULL DEFAULT 0
)

-- Insert sample users
INSERT INTO tblUsers 
(Username, Password, FirstName, LastName, DateOfBirth, City, Gender, IsAdmin)
VALUES 
-- Admin users
('admin1', 'admin123', 'John', 'Admin', '1990-01-01', 'Nes Ziona', 'Male', 1),
('admin2', 'admin456', 'Jane', 'Admin', '1992-02-02', 'Nes Ziona', 'Female', 1),

-- Regular users
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

-- Create separate files for queries to make them easier to run individually

-- Query 4: Find users with username starting with 'L'
SELECT * FROM tblUsers WHERE Username LIKE 'L%'

-- Query 5: Find non-admin users from Nes Ziona
SELECT Username, Password 
FROM tblUsers 
WHERE City = 'Nes Ziona' AND IsAdmin = 0

-- Query 6: Count users over 18
SELECT COUNT(*) as UsersOver18
FROM tblUsers 
WHERE DATEDIFF(YEAR, DateOfBirth, GETDATE()) > 18

-- Query 7: Males over 30 and females under 20, sorted by age
SELECT FirstName, LastName, UserId
FROM tblUsers
WHERE (Gender = 'Male' AND DATEDIFF(YEAR, DateOfBirth, GETDATE()) > 30)
   OR (Gender = 'Female' AND DATEDIFF(YEAR, DateOfBirth, GETDATE()) < 20)
ORDER BY DateOfBirth DESC

-- Query 8: Distinct list of cities
SELECT DISTINCT City FROM tblUsers

-- Query 9: Update empty cities to 'NA'
UPDATE tblUsers 
SET City = 'NA' 
WHERE City IS NULL OR City = ''

-- Query 10: Add '_Minor' to users under 18
UPDATE tblUsers
SET FirstName = FirstName + '_Minor'
WHERE DATEDIFF(YEAR, DateOfBirth, GETDATE()) < 18

-- Query 11: Update city name from 'Nes-Tziona' to 'Nes Ziona'
UPDATE tblUsers
SET City = 'Nes Ziona'
WHERE City = 'Nes-Tziona'

-- Query 12: Delete users not from Nes Ziona with UserId between 10 and 20
DELETE FROM tblUsers
WHERE City != 'Nes Ziona' 
AND UserId BETWEEN 10 AND 20 