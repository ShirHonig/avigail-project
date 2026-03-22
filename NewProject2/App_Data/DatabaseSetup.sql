-- Create Users table
CREATE TABLE [dbo].[tblUsers] (
    [UserID]      INT            IDENTITY (1, 1) NOT NULL,
    [Username]    NVARCHAR (50)  NOT NULL,
    [Password]    NVARCHAR (100) NOT NULL,
    [UserType]    INT            NOT NULL,
    [CreatedDate] DATETIME       NOT NULL,
    [IsActive]    BIT            NOT NULL,
    CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED ([UserID] ASC)
);

-- Add unique constraint on Username
ALTER TABLE [dbo].[tblUsers]
ADD CONSTRAINT [UQ_tblUsers_Username] UNIQUE ([Username]);

-- Insert default admin user
INSERT INTO [dbo].[tblUsers] ([Username], [Password], [UserType], [CreatedDate], [IsActive])
VALUES ('admin', 'Admin123!', 2, GETDATE(), 1);

-- Create index on Username for faster lookups
CREATE NONCLUSTERED INDEX [IX_tblUsers_Username]
ON [dbo].[tblUsers] ([Username]); 