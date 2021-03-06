USE [dbWebMobi]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 09-04-2021 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmpID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](300) NULL,
	[LastName] [varchar](300) NULL,
	[Gender] [char](1) NULL,
	[DOB] [date] NULL,
	[ImgUrl] [varchar](250) NULL,
	[DepartmentID] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[EmpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Department]    Script Date: 09-04-2021 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DeptID] [int] IDENTITY(1,1) NOT NULL,
	[Department] [varchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DeptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[vwEmpDetail]    Script Date: 09-04-2021 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vwEmpDetail]
as
SELECT        e.EmpID, e.FirstName, e.LastName, e.Gender,CASE e.Gender WHEN 'M' THEN 'Male'
																				   WHEN 'F' THEN 'Female'
																				   WHEN 'O' THEN 'Other' End FGender,format( e.DOB,'dd/MMM/yyyy') DOB, e.ImgUrl, e.DepartmentID, d.Department
			FROM            Employee AS e INNER JOIN
									 Department AS d ON d.DeptID = e.DepartmentID
									 WHERE e.IsActive=1
GO
ALTER TABLE [dbo].[Department] ADD  CONSTRAINT [DF_Department_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
/****** Object:  StoredProcedure [dbo].[sp_Employee]    Script Date: 09-04-2021 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nikhil
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_Employee] 
	-- Add the parameters for the stored procedure here
	        @flag Char(1) = NULL
		   ,@EmpID int = NULL
		   ,@FirstName varchar(300) = NULL
           ,@LastName varchar(300) = NULL
           ,@Gender char(1) = NULL
           ,@DOB date = NULL
           ,@ImgUrl varchar(250) = NULL
           ,@DepartmentID int = NULL
           ,@IsActive bit = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	IF(@flag='I')
		BEGIN
				INSERT INTO Employee
					   (FirstName
					   ,LastName
					   ,Gender
					   ,DOB
					   ,ImgUrl
					   ,DepartmentID
					   ,IsActive)
				 OUTPUT inserted.EmpID
				 VALUES
					   (@FirstName
					   ,@LastName 
					   ,@Gender
					   ,@DOB 
					   ,@ImgUrl
					   ,@DepartmentID
					   ,@IsActive)
		END
	IF(@flag='S')
		BEGIN
		    SET NOCount off;
			SELECT        e.EmpID, e.FirstName, e.LastName, e.Gender,CASE e.Gender WHEN 'M' THEN 'Male'
																				   WHEN 'F' THEN 'Female'
																				   WHEN 'O' THEN 'Other' End FGender, e.DOB, e.ImgUrl, e.DepartmentID, d.Department
			FROM            Employee AS e INNER JOIN
									 Department AS d ON d.DeptID = e.DepartmentID
									 WHERE e.IsActive=1
		END	
	IF(@flag='U')
		BEGIN
				UPDATE Employee
				SET FirstName=@FirstName,
					LastName=@LastName,
					Gender=@Gender,
					DOB=@DOB,
					ImgUrl=@ImgUrl,
					DepartmentID=@DepartmentID
				OUTPUT inserted.EmpID
				Where EmpID=@EmpID and IsActive=1
		END
	IF(@flag='D')
		BEGIN
			UPDATE Employee
				SET IsActive=0
				OUTPUT inserted.EmpID
				Where EmpID=@EmpID and IsActive=1	
		END
END

GO
/****** Object:  StoredProcedure [dbo].[spEmployee]    Script Date: 09-04-2021 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Nikhil
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[spEmployee] 
	-- Add the parameters for the stored procedure here
	        @flag Char(1) = NULL
		   ,@EmpID int = NULL
		   ,@FirstName varchar(300) = NULL
           ,@LastName varchar(300) = NULL
           ,@Gender char(1) = NULL
           ,@DOB date = NULL
           ,@ImgUrl varchar(250) = NULL
           ,@DepartmentID int = NULL
           ,@IsActive bit = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	IF(@flag='I')
		BEGIN
				INSERT INTO Employee
					   (FirstName
					   ,LastName
					   ,Gender
					   ,DOB
					   ,ImgUrl
					   ,DepartmentID
					   ,IsActive)
				 OUTPUT inserted.EmpID
				 VALUES
					   (@FirstName
					   ,@LastName 
					   ,@Gender
					   ,@DOB 
					   ,@ImgUrl
					   ,@DepartmentID
					   ,@IsActive)
		END
	IF(@flag='S')
		BEGIN
		    SET NOCount off;
			SELECT        e.EmpID, e.FirstName, e.LastName, e.Gender,CASE e.Gender WHEN 'M' THEN 'Male'
																				   WHEN 'F' THEN 'Female'
																				   WHEN 'O' THEN 'Other' End FGender, e.DOB, e.ImgUrl, e.DepartmentID, d.Department
			FROM            Employee AS e INNER JOIN
									 Department AS d ON d.DeptID = e.DepartmentID
									 WHERE e.IsActive=1
		END	
	IF(@flag='U')
		BEGIN
				UPDATE Employee
				SET FirstName=@FirstName,
					LastName=@LastName,
					Gender=@Gender,
					DOB=@DOB,
					ImgUrl=@ImgUrl,
					DepartmentID=@DepartmentID
				OUTPUT inserted.EmpID
				Where EmpID=@EmpID and IsActive=1
		END
	IF(@flag='D')
		BEGIN
			UPDATE Employee
				SET IsActive=0
				OUTPUT inserted.EmpID
				Where EmpID=@EmpID and IsActive=1	
		END
END

GO
