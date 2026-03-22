USE [UsersDB]
GO

-- Insert 10 sample users
INSERT INTO [dbo].[tblUsers] 
([Username], [Password], [FirstName], [LastName], [DateOfBirth], [City], [Gender], [IsAdmin])
VALUES 
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
GO 