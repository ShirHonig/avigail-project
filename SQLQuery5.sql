SELECT FirstName, LastName, UserId
FROM tblUsers 
WHERE (Gender = 'Male' AND DATEDIFF(YEAR, BirthDate, '2025-06-10') > 30)
   OR (Gender = 'Female' AND DATEDIFF(YEAR, BirthDate, '2025-06-10') < 20)
ORDER BY DATEDIFF(YEAR, BirthDate, '2025-06-10') DESC;