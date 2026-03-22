-- 7. Select men over 30, women under 20, ordered by age descending
SELECT FirstName, LastName, UserId
FROM tblUsers
WHERE (Gender = 'Male' AND DATEDIFF(YEAR, BirthDate, GETDATE()) > 30)
   OR (Gender = 'Female' AND DATEDIFF(YEAR, BirthDate, GETDATE()) < 20)
ORDER BY DATEDIFF(YEAR, BirthDate, GETDATE()) DESC;
