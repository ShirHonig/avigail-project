SELECT FirstName, LastName, UserId
FROM tblUsers 
WHERE (Gender = 'Male' AND DATEDIFF(YEAR, BirthDate, GETDATE()) > 30)
   OR (Gender = 'Female' AND DATEDIFF(YEAR, BirthDate, GETDATE()) < 20)
ORDER BY DATEDIFF(YEAR, BirthDate, GETDATE()) DESC;