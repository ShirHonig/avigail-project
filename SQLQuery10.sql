UPDATE tblUsers
SET FirstName = FirstName + '_Minor'
WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) < 18;