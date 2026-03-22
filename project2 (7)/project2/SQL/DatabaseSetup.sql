-- Create Users table
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL,
    PasswordHash NVARCHAR(256) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    UserType INT NOT NULL,
    CreatedDate DATETIME NOT NULL,
    LastLoginDate DATETIME NOT NULL,
    IsDeleted BIT NOT NULL DEFAULT 0,
    CONSTRAINT UQ_Username UNIQUE (Username)
);

-- Create index for faster login queries
CREATE NONCLUSTERED INDEX IX_Users_Username
ON Users (Username)
INCLUDE (PasswordHash, UserType, IsDeleted);

-- Create index for email searches
CREATE NONCLUSTERED INDEX IX_Users_Email
ON Users (Email);

-- Insert admin user (password is 'admin123' hashed with SHA256)
INSERT INTO Users (Username, PasswordHash, Email, UserType, CreatedDate, LastLoginDate, IsDeleted)
VALUES ('admin', 'YWRtaW4xMjM=', 'admin@recipes.com', 2, GETDATE(), GETDATE(), 0);

-- Create Recipes table
CREATE TABLE Recipes (
    RecipeId INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    Instructions NVARCHAR(MAX) NOT NULL,
    CreatedByUserId INT NOT NULL,
    CreatedDate DATETIME NOT NULL,
    ModifiedDate DATETIME NOT NULL,
    IsDeleted BIT NOT NULL DEFAULT 0,
    FOREIGN KEY (CreatedByUserId) REFERENCES Users(UserId)
);

-- Create index for recipe searches
CREATE NONCLUSTERED INDEX IX_Recipes_Title
ON Recipes (Title)
WHERE IsDeleted = 0;

-- Create Comments table
CREATE TABLE Comments (
    CommentId INT IDENTITY(1,1) PRIMARY KEY,
    RecipeId INT NOT NULL,
    UserId INT NOT NULL,
    CommentText NVARCHAR(500) NOT NULL,
    CreatedDate DATETIME NOT NULL,
    ModifiedDate DATETIME NOT NULL,
    IsDeleted BIT NOT NULL DEFAULT 0,
    FOREIGN KEY (RecipeId) REFERENCES Recipes(RecipeId),
    FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- Create index for comment retrieval
CREATE NONCLUSTERED INDEX IX_Comments_Recipe
ON Comments (RecipeId)
INCLUDE (CommentText, CreatedDate, UserId)
WHERE IsDeleted = 0; 