-- 6. Count users over age 18
SELECT COUNT(*) AS UserCount
FROM tblUsers
WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) > 18;