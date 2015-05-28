USE Master
GO
CREATE DATABASE [newDoc]
GO
USE [newDoc]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Пользователи]') AND type in (N'U'))
    DROP TABLE [dbo].[Пользователи]
GO
CREATE TABLE [dbo].[Пользователи] (
[userID] SHORT  NOT NULL  
, [e-mail] CHAR(10)  NOT NULL  
, [password] CHAR(10)  NOT NULL  
, [role] CHAR(10)  NOT NULL  
)
GO

ALTER TABLE [dbo].[Пользователи] ADD CONSTRAINT [Пользователи_PK] PRIMARY KEY CLUSTERED (
[userID]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Каталог]') AND type in (N'U'))
    DROP TABLE [dbo].[Каталог]
GO
CREATE TABLE [dbo].[Каталог] (
[catID] SHORT  NOT NULL  
, [name] CHAR(10)  NOT NULL  
, [owner] SHORT  NOT NULL  
)
GO

ALTER TABLE [dbo].[Каталог] ADD CONSTRAINT [Каталог_PK] PRIMARY KEY CLUSTERED (
[catID]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Доступ каталогов]') AND type in (N'U'))
    DROP TABLE [dbo].[Доступ каталогов]
GO
CREATE TABLE [dbo].[Доступ каталогов] (
[writeAcces] CHAR(10)  NOT NULL  
, [userID] SHORT  NOT NULL  
, [catID] SHORT  NOT NULL  
)
GO

ALTER TABLE [dbo].[Доступ каталогов] ADD CONSTRAINT [Доступ каталогов_PK] PRIMARY KEY CLUSTERED (
[userID]
, [catID]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Уравнения]') AND type in (N'U'))
    DROP TABLE [dbo].[Уравнения]
GO
CREATE TABLE [dbo].[Уравнения] (
[name] CHAR(10)  NOT NULL  
, [expression] TEXT(10)  NOT NULL  
, [expID] SHORT  NOT NULL  
, [catalog] SHORT  NULL  
)
GO

ALTER TABLE [dbo].[Уравнения] ADD CONSTRAINT [Уравнения_PK] PRIMARY KEY CLUSTERED (
[expID]
)
GO
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Доступ уравнений]') AND type in (N'U'))
    DROP TABLE [dbo].[Доступ уравнений]
GO
CREATE TABLE [dbo].[Доступ уравнений] (
[writeAcces] CHAR(10)  NOT NULL  
, [userID] SHORT  NOT NULL  
, [expID] SHORT  NOT NULL  
)
GO

ALTER TABLE [dbo].[Доступ уравнений] ADD CONSTRAINT [Доступ уравнений_PK] PRIMARY KEY CLUSTERED (
[userID]
, [expID]
)
GO
GO

GO

ALTER TABLE [dbo].[Каталог] WITH CHECK ADD CONSTRAINT [Пользователи_Каталог_FK1] FOREIGN KEY (
[owner]
)
REFERENCES [dbo].[Пользователи] (
[userID]
)
GO

ALTER TABLE [dbo].[Доступ каталогов] WITH CHECK ADD CONSTRAINT [Пользователи_Доступ каталогов_FK1] FOREIGN KEY (
[userID]
)
REFERENCES [dbo].[Пользователи] (
[userID]
)
ALTER TABLE [dbo].[Доступ каталогов] WITH CHECK ADD CONSTRAINT [Каталог_Доступ каталогов_FK1] FOREIGN KEY (
[catID]
)
REFERENCES [dbo].[Каталог] (
[catID]
)
GO

ALTER TABLE [dbo].[Уравнения] WITH CHECK ADD CONSTRAINT [Каталог_Уравнения_FK1] FOREIGN KEY (
[catalog]
)
REFERENCES [dbo].[Каталог] (
[catID]
)
GO

ALTER TABLE [dbo].[Доступ уравнений] WITH CHECK ADD CONSTRAINT [Пользователи_Доступ уравнений_FK1] FOREIGN KEY (
[userID]
)
REFERENCES [dbo].[Пользователи] (
[userID]
)
ALTER TABLE [dbo].[Доступ уравнений] WITH CHECK ADD CONSTRAINT [Уравнения_Доступ уравнений_FK1] FOREIGN KEY (
[expID]
)
REFERENCES [dbo].[Уравнения] (
[expID]
)
GO

