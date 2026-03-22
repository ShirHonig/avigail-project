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