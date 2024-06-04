USE [master]
GO
/****** Object:  Database [PerfumeSalon1]    Script Date: 04.06.2024 5:30:04 ******/
CREATE DATABASE [PerfumeSalon1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PerfumeSalon1', FILENAME = N'D:\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PerfumeSalon1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PerfumeSalon1_log', FILENAME = N'D:\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PerfumeSalon1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [PerfumeSalon1] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PerfumeSalon1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PerfumeSalon1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PerfumeSalon1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PerfumeSalon1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PerfumeSalon1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PerfumeSalon1] SET ARITHABORT OFF 
GO
ALTER DATABASE [PerfumeSalon1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PerfumeSalon1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PerfumeSalon1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PerfumeSalon1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PerfumeSalon1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PerfumeSalon1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PerfumeSalon1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PerfumeSalon1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PerfumeSalon1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PerfumeSalon1] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PerfumeSalon1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PerfumeSalon1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PerfumeSalon1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PerfumeSalon1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PerfumeSalon1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PerfumeSalon1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PerfumeSalon1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PerfumeSalon1] SET RECOVERY FULL 
GO
ALTER DATABASE [PerfumeSalon1] SET  MULTI_USER 
GO
ALTER DATABASE [PerfumeSalon1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PerfumeSalon1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PerfumeSalon1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PerfumeSalon1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PerfumeSalon1] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PerfumeSalon1] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PerfumeSalon1', N'ON'
GO
ALTER DATABASE [PerfumeSalon1] SET QUERY_STORE = OFF
GO
USE [PerfumeSalon1]
GO
/****** Object:  Table [dbo].[Note]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Note](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Note] [nvarchar](64) NOT NULL,
	[NoteGroup] [int] NOT NULL,
 CONSTRAINT [PK__Notes__3213E83F9DFE496C] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[SearchNote]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[SearchNote]
(
@noteGroupId int, 
@search nvarchar(64)
)
returns table as return
(select TOP(500) [id],[Note],[NoteGroup] from [dbo].[Note]
where [NoteGroup] = @noteGroupId
and [Note] like('%'+@search+'%')
order by Note asc)
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](32) NOT NULL,
	[MiddleName] [nvarchar](32) NULL,
	[LastName] [nvarchar](32) NOT NULL,
	[Email] [nvarchar](32) NOT NULL,
	[Phone] [nvarchar](14) NOT NULL,
	[Login] [int] NOT NULL,
 CONSTRAINT [PK__Customer__3213E83F634540CB] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Customer] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[TotalPrice] [int] NOT NULL,
 CONSTRAINT [PK__Orders__3213E83FE32A9A46] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[ShowOrderAll]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[ShowOrderAll]
(

)
returns table
as return
(select O.id, 
C.LastName + ' ' + C.FirstName + ' ' + C.LastName
as 'Customer',
OrderDate,
Address,
TotalPrice
from [dbo].[Order] O
join Customer C on C.id = O.Customer)
GO
/****** Object:  UserDefinedFunction [dbo].[SearchOrder]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[SearchOrder]
(
@search nvarchar(64),
@dateAft datetime,
@dateBef datetime
)
returns table
as return
(
select * from ShowOrderAll() 
where (Customer like('%'+@search+'%')
or Address like('%'+@search+'%'))
and OrderDate >= @dateAft
and OrderDate <=@dateBef
)
GO
/****** Object:  Table [dbo].[NoteInAroma]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NoteInAroma](
	[Aroma] [int] NOT NULL,
	[NoteClass] [int] NOT NULL,
	[Note] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fGetUsedNote]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fGetUsedNote]()
returns table as return
(
	select distinct N.* from [dbo].[NoteInAroma] NA
	left join Note N on N.id = NA.Note
)
GO
/****** Object:  Table [dbo].[Aroma]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aroma](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Aroma] [nvarchar](64) NOT NULL,
	[Description] [nvarchar](512) NOT NULL,
 CONSTRAINT [PK__Aromas__3213E83F755EE6A8] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Favorite]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Favorite](
	[Customer] [int] NOT NULL,
	[AromaId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ProductType] [int] NOT NULL,
	[ProductCategory] [int] NOT NULL,
	[Aroma] [int] NOT NULL,
	[Volume] [int] NOT NULL,
	[Price] [int] NOT NULL,
 CONSTRAINT [PK__Products__3213E83F42248271] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductType]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK__Products__3213E83F81CF7AD0] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](32) NOT NULL,
	[Password] [nvarchar](32) NOT NULL,
	[Role] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[GetAromaFromFavorite]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetAromaFromFavorite]
(
@id int
)
returns table as return
(
select A.Aroma from Aroma A
join Product P on P.Aroma = A.id
join ProductType PT on PT.id = P.ProductType
join Favorite F on F.AromaId = A.Id
join Customer C on C.id = F.Customer
join [dbo].[User] U on U.id = C.Login
where U.id = @id
group by A.Aroma
)
GO
/****** Object:  Table [dbo].[AromaGroup]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AromaGroup](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[AromaGroup] [nvarchar](32) NOT NULL,
	[Image] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK__AromasGr__3213E83FED49DFFF] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AromaGroupInAroma]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AromaGroupInAroma](
	[Aroma] [int] NOT NULL,
	[AromaGroup] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Volume]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Volume](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Volume] [int] NOT NULL,
 CONSTRAINT [PK__Volumes__3213E83FA0080133] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[SearchAroma]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[SearchAroma]
(
@aromasGroup nvarchar(64),
@productType nvarchar(64),
@search nvarchar(64),
@noteId int
)
returns table as return
(
select A.[id],A.[Aroma],[Description],PT.Type,MIN([Price]) as 'MinPrice', Min(V.Volume) as 'MinVolume'
                 from Aroma A join Product P on P.Aroma = A.id 
                 join ProductType PT on PT.id = P.ProductType 
                 join AromaGroupInAroma AGA on AGA.Aroma = A.id 
                 join Volume V on V.id = P.Volume 
				 join AromaGroup AG on AG.id = AGA.AromaGroup
				 join NoteInAroma NIA on NIA.Aroma = A.id
				 join Note N on N.id = NIA.Note
                 where AG.AromaGroup like('%'+@aromasGroup+'%')
				 and PT.Type like('%' +@productType+ '%')
				 and (A.Description like('%' + @search + '%')
				 or A.Aroma like('%' + @search + '%') 
				 or AG.AromaGroup like('%' + @search + '%')
				 or PT.[Type] like('%' + @search + '%')
				 or N.Note like('%' + @search + '%'))
				 and (@noteId = -1 or N.id = @noteId)
                 group by A.[id], A.[Aroma],[Description], PT.[Type]
)
GO
/****** Object:  Table [dbo].[Basket]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Basket](
	[Customer] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Category] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK__Products__3213E83F7456C0C0] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[GetProductFromBasket]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetProductFromBasket]
(
@id int
)
returns table as return
(
select P.id,PT.Type,PC.Category,A.Aroma,V.Volume,Price,B.Quantity from Product P
join ProductType PT on PT.id = P.ProductType
join ProductCategory PC on PC.id = P.ProductCategory
join Volume V on V.id = P.Volume
join Aroma A on A.id = P.Aroma
join Basket B on B.ProductId = P.id
join Customer C on C.id = B.Customer
join [dbo].[User] U on U.id = C.Login
where U.id = @id
group by P.id,PT.Type,PC.Category,A.Aroma,V.Volume,Price,B.Quantity
)
GO
/****** Object:  UserDefinedFunction [dbo].[IsLoginTaken]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  function [dbo].[IsLoginTaken]
(
@login nvarchar(32)
)
returns table as return
(select * from [dbo].[User]
where Login = @login)
GO
/****** Object:  UserDefinedFunction [dbo].[IsLoginExists]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  function [dbo].[IsLoginExists]
(
@login nvarchar(32)
)
returns table as return
(select * from [dbo].[User]
where Login = @login)
GO
/****** Object:  UserDefinedFunction [dbo].[IsEmailTaken]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[IsEmailTaken]
(
@email nvarchar(32)
)
returns table as return
(
select * from [dbo].[Customer]
where Email = @email)
GO
/****** Object:  UserDefinedFunction [dbo].[IsPhoneTaken]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[IsPhoneTaken]
(
@phone nvarchar(14)
)
returns table as return
(
select * from [dbo].[Customer]
where Phone = @phone)
GO
/****** Object:  UserDefinedFunction [dbo].[GetProfileByUserId]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetProfileByUserId]
(
@userId int
)
returns table as return
(
select U.Login, U.Password, C.id, C.FirstName, C.MiddleName, C.LastName, C.Email, C.Phone 
from Customer C
join [dbo].[User] U on U.id = C.Login
where U.id = @userId
)
GO
/****** Object:  UserDefinedFunction [dbo].[GetFavoriteProduct]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetFavoriteProduct]
(
@id int
)
returns table as return
(
select A.id, A.Aroma, A.Description, PT.Type, Min(P.Price) as MinPrice from Aroma A
join Product P on P.Aroma = A.id
join ProductType PT on PT.id = P.ProductType
join Favorite F on F.AromaId = A.Id
where F.Customer = @id
group by A.id, A.Aroma, A.Description, PT.Type
)
GO
/****** Object:  UserDefinedFunction [dbo].[GetFavoriteAroma]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetFavoriteAroma]
(
@id int
)
returns table as return
(
select A.id, A.Aroma, A.Description, PT.Type, Min(P.Price) as MinPrice, Min(V.Volume) as MinVolume
from Aroma A
join Product P on P.Aroma = A.id
join ProductType PT on PT.id = P.ProductType
join Favorite F on F.AromaId = A.Id
join Customer C on C.id = F.Customer
join [dbo].[User] U on U.id = C.Login
join Volume V on V.id = P.Volume
where U.id = @id
group by A.id, A.Aroma, A.Description, PT.Type
)
GO
/****** Object:  UserDefinedFunction [dbo].[GetProductIdFromFavorite]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetProductIdFromFavorite]
(
@id int
)
returns table as return
(
select P.id from Aroma A
join Product P on P.Aroma = A.id
join ProductType PT on PT.id = P.ProductType
join Favorite F on F.AromaId = A.Id
join Customer C on C.id = F.Customer
join [dbo].[User] U on U.id = C.Login
where U.id = @id
group by P.id
)
GO
/****** Object:  Table [dbo].[OrderInfo]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderInfo](
	[id] [int] NOT NULL,
	[Product] [int] NOT NULL,
	[Quantity] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[ShowOrderInfo]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[ShowOrderInfo]
(
@orderId int
)
returns table as return
(
select P.id,PT.Type,PC.Category,A.Aroma,V.Volume,Price,OI.Quantity from dbo.[Order] O
join OrderInfo OI on OI.id = O.id
join Product P on P.id = OI.Product
join ProductType PT on PT.id = P.ProductType
join ProductCategory PC on PC.id = P.ProductCategory
join Volume V on V.id = P.Volume
join Aroma A on A.id = P.Aroma
where O.id = @orderId
group by P.id,PT.Type,PC.Category,A.Aroma,V.Volume,Price,OI.Quantity
)
GO
/****** Object:  UserDefinedFunction [dbo].[ShowOrder]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[ShowOrder]
(
@userId int
)
returns table as return
(
select O.id,[OrderDate],[Address],[TotalPrice] from dbo.[Order] O
join Customer C on C.id = O.Customer
join [dbo].[User] U on U.id = C.Login
where U.id = @userId
)
GO
/****** Object:  View [dbo].[vProducts]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vProducts]
as
select P.id, PT.Type, PC.Category, A.Aroma, V.Volume, Price  from Products P
join Aromas A on A.id = P.Aroma
join ProductsCategories PC on PC.id = P.ProductCategory
join ProductsTypes PT on PT.id = P.ProductType
join Volumes V on V.id = P.Volume
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](32) NOT NULL,
	[MiddleName] [nvarchar](32) NULL,
	[LastName] [nvarchar](32) NOT NULL,
	[Email] [nvarchar](32) NOT NULL,
	[Phone] [nvarchar](11) NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[Login] [int] NOT NULL,
 CONSTRAINT [PK__Employee__3213E83F61B05B7F] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NoteClass]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NoteClass](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Class] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK__NotesCla__3213E83F862C922F] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NoteGroup]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NoteGroup](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[NoteGroup] [nvarchar](32) NOT NULL,
	[Image] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK__NotesGro__3213E83F1534A383] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 04.06.2024 5:30:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Role] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK__Roles__3213E83F8069CB3B] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Aroma] ON 

INSERT [dbo].[Aroma] ([id], [Aroma], [Description]) VALUES (1, N'Аромат №1', N'Красный — цвет страсти! Он очаровывает и пьянит, его тепло наполнено спокойной уверенностью и силой. Амели и Пьер выбрали для его воплощения ароматную смесь кубинского табака и карибских пряностей, создав парфюмерный пейзаж вечернего неба окрашенного в бордовые оттенки лучами заходящего в карибское море солнца.')
INSERT [dbo].[Aroma] ([id], [Aroma], [Description]) VALUES (2, N'Аромат №2', N'Аромат №2')
INSERT [dbo].[Aroma] ([id], [Aroma], [Description]) VALUES (3, N'Аромат №3', N'Аромат №3')
INSERT [dbo].[Aroma] ([id], [Aroma], [Description]) VALUES (4, N'Аромат №4', N'Аромат №4')
INSERT [dbo].[Aroma] ([id], [Aroma], [Description]) VALUES (5, N'Аромат №5', N'Аромат №5')
INSERT [dbo].[Aroma] ([id], [Aroma], [Description]) VALUES (6, N'Аромат №6', N'Аромат №6')
INSERT [dbo].[Aroma] ([id], [Aroma], [Description]) VALUES (7, N'Аромат №7', N'Аромат №7')
INSERT [dbo].[Aroma] ([id], [Aroma], [Description]) VALUES (9, N'Лавовая Фантазия', N'Аромат лавы и гари')
INSERT [dbo].[Aroma] ([id], [Aroma], [Description]) VALUES (10, N'ТЕСТ', N'ТЕСТ')
SET IDENTITY_INSERT [dbo].[Aroma] OFF
GO
SET IDENTITY_INSERT [dbo].[AromaGroup] ON 

INSERT [dbo].[AromaGroup] ([id], [AromaGroup], [Image]) VALUES (1, N'Древесные', N'/Resources/AromasGroups/Древесные.jpg')
INSERT [dbo].[AromaGroup] ([id], [AromaGroup], [Image]) VALUES (2, N'Восточные', N'/Resources/AromasGroups/Восточные.jpg')
INSERT [dbo].[AromaGroup] ([id], [AromaGroup], [Image]) VALUES (3, N'Цитрусовые', N'/Resources/AromasGroups/Цитрусовые.jpg ')
INSERT [dbo].[AromaGroup] ([id], [AromaGroup], [Image]) VALUES (4, N'Цветочные', N'/Resources/AromasGroups/Цветочные.jpg')
INSERT [dbo].[AromaGroup] ([id], [AromaGroup], [Image]) VALUES (5, N'Шипровые', N'/Resources/AromasGroups/Шипровые.jpg ')
INSERT [dbo].[AromaGroup] ([id], [AromaGroup], [Image]) VALUES (6, N'Фужерные', N'/Resources/AromasGroups/Фужерные.jpg')
INSERT [dbo].[AromaGroup] ([id], [AromaGroup], [Image]) VALUES (7, N'Кожаные', N'/Resources/AromasGroups/Кожаные.jpg ')
INSERT [dbo].[AromaGroup] ([id], [AromaGroup], [Image]) VALUES (8, N'Зеленые', N'/Resources/AromasGroups/Зеленые.jpg')
INSERT [dbo].[AromaGroup] ([id], [AromaGroup], [Image]) VALUES (9, N'Морские', N'/Resources/AromasGroups/Морские.jpg')
INSERT [dbo].[AromaGroup] ([id], [AromaGroup], [Image]) VALUES (10, N'Гурманские', N'/Resources/AromasGroups/Гурманские.jpg')
INSERT [dbo].[AromaGroup] ([id], [AromaGroup], [Image]) VALUES (11, N'Фруктовые', N'/Resources/AromasGroups/Фруктовые.jpg')
SET IDENTITY_INSERT [dbo].[AromaGroup] OFF
GO
INSERT [dbo].[AromaGroupInAroma] ([Aroma], [AromaGroup]) VALUES (1, 1)
INSERT [dbo].[AromaGroupInAroma] ([Aroma], [AromaGroup]) VALUES (1, 2)
INSERT [dbo].[AromaGroupInAroma] ([Aroma], [AromaGroup]) VALUES (2, 2)
INSERT [dbo].[AromaGroupInAroma] ([Aroma], [AromaGroup]) VALUES (3, 3)
INSERT [dbo].[AromaGroupInAroma] ([Aroma], [AromaGroup]) VALUES (4, 4)
INSERT [dbo].[AromaGroupInAroma] ([Aroma], [AromaGroup]) VALUES (5, 5)
INSERT [dbo].[AromaGroupInAroma] ([Aroma], [AromaGroup]) VALUES (6, 6)
INSERT [dbo].[AromaGroupInAroma] ([Aroma], [AromaGroup]) VALUES (7, 1)
INSERT [dbo].[AromaGroupInAroma] ([Aroma], [AromaGroup]) VALUES (7, 7)
INSERT [dbo].[AromaGroupInAroma] ([Aroma], [AromaGroup]) VALUES (9, 1)
INSERT [dbo].[AromaGroupInAroma] ([Aroma], [AromaGroup]) VALUES (10, 11)
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([id], [FirstName], [MiddleName], [LastName], [Email], [Phone], [Login]) VALUES (1, N'Mike', N'M.', N'Tyson', N'tyson@gmail.com', N'111', 5)
INSERT [dbo].[Customer] ([id], [FirstName], [MiddleName], [LastName], [Email], [Phone], [Login]) VALUES (2, N'John', N'J.', N'Malkovich', N'john@yahoo.com', N'222', 6)
INSERT [dbo].[Customer] ([id], [FirstName], [MiddleName], [LastName], [Email], [Phone], [Login]) VALUES (3, N'Jack', N'J.', N'Herer', N'jack@outlook.com', N'333', 7)
INSERT [dbo].[Customer] ([id], [FirstName], [MiddleName], [LastName], [Email], [Phone], [Login]) VALUES (4, N'Steve', N'S.', N'Buscemi', N'steve@aolmail.com', N'444', 8)
INSERT [dbo].[Customer] ([id], [FirstName], [MiddleName], [LastName], [Email], [Phone], [Login]) VALUES (5, N'Martin', N'M.', N'Aston', N'martin@gmail.com', N'555', 9)
INSERT [dbo].[Customer] ([id], [FirstName], [MiddleName], [LastName], [Email], [Phone], [Login]) VALUES (6, N'Henry', N'H.', N'Ford', N'henry@yahoo.com', N'666', 10)
INSERT [dbo].[Customer] ([id], [FirstName], [MiddleName], [LastName], [Email], [Phone], [Login]) VALUES (7, N'Connor', N'C.', N'McConnor', N'connor@outlook.com', N'777', 11)
INSERT [dbo].[Customer] ([id], [FirstName], [MiddleName], [LastName], [Email], [Phone], [Login]) VALUES (8, N'Adam', N'A.', N'Smith', N'adam@aolmail.com', N'888', 12)
INSERT [dbo].[Customer] ([id], [FirstName], [MiddleName], [LastName], [Email], [Phone], [Login]) VALUES (9, N'newNameForGeorge', N'george', N'george', N'george@gmail.com', N'123', 13)
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([id], [FirstName], [MiddleName], [LastName], [Email], [Phone], [Address], [Login]) VALUES (1, N'A.', N'A.', N'Admin', N'admin@corpmail.com', N'2813308004', N'Admin Street, 1', 1)
INSERT [dbo].[Employee] ([id], [FirstName], [MiddleName], [LastName], [Email], [Phone], [Address], [Login]) VALUES (2, N'Ludwig.', N'L.', N'O`Ludwig', N'ludwig@corpmail.com', N'1110001111', N'Ludwig Street, 1', 2)
INSERT [dbo].[Employee] ([id], [FirstName], [MiddleName], [LastName], [Email], [Phone], [Address], [Login]) VALUES (3, N'Donald.', N'Donaldson', N'McDonald', N'donald@corpmail.com', N'2221112200', N'Donald Street, 2', 3)
INSERT [dbo].[Employee] ([id], [FirstName], [MiddleName], [LastName], [Email], [Phone], [Address], [Login]) VALUES (4, N'Jacob', N'Jacobson', N'McJacob', N'jacob@corpmail.com', N'3311224477', N'Jacob Street, 3', 4)
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
INSERT [dbo].[Favorite] ([Customer], [AromaId]) VALUES (9, 1)
INSERT [dbo].[Favorite] ([Customer], [AromaId]) VALUES (9, 7)
INSERT [dbo].[Favorite] ([Customer], [AromaId]) VALUES (1, 9)
GO
SET IDENTITY_INSERT [dbo].[Note] ON 

INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1, N'Бергамот', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2, N'Мандарин', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (3, N'Грейпфрут', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (4, N'Лимон', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (5, N'Апельсин', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (6, N'Цитрусовый аккорд (цитрусы)', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (7, N'Лайм', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (8, N'Петитгрейн', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (9, N'Лемонграсс', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (10, N'Горький апельсин (бигарадия)', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (11, N'Вербена', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (12, N'Танжерин', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (13, N'Красный апельсин', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (14, N'Юзу', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (15, N'Помело', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (16, N'Вербена лимонная', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (17, N'Клементин', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (18, N'Кумкват', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (19, N'Цедрат (цитрон)', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (20, N'Зеленый мандарин', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (21, N'Розовый грейпфрут', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (22, N'Калабрийский бергамот', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (23, N'Танжело', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (24, N'Кафрский лайм (каффир-лайм)', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (25, N'Хассаку', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (26, N'Пальчиковый лайм', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (27, N'Метил памплемусс (Methyl Pamplemousse)', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (28, N'Каламондин', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (29, N'Лаймкват', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (30, N'Мандора ', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (31, N'Citral (Цитраль)', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (32, N'Лимонный сахар ', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (33, N'Pamplewood (Памплвуд)', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (34, N'Цитрусовый сорбет', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (35, N'Цветок кинотто', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (36, N'Цитронеллол', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (37, N'Папеда крупнокрылая', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (38, N'Пэймплзест (Pamplezest)', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (39, N'Дигидромирценол ', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (40, N'Lemonile (Лемонил)', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (41, N'Судачи', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (42, N'Мандарин сацума', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (43, N'Кожура декопана', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (44, N'Оранжело', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (45, N'Валенсен (Valencene)', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (46, N'Бергамотовый сироп', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (47, N'Сорбет из грейпфрута', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (48, N'Сорбет из красного апельсина', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (49, N'Сушеные цитрусы ', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (50, N'Limettol (Лайметтол)', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (51, N'Рангпур ', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (52, N'Rhubafuran (Рубафуран)', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (53, N'Лимонный сироп', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (54, N'Лист кинотто', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (55, N'Бигаран (Bigarane)', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (56, N'Кинотто', 1)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (57, N'Черная смородина', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (58, N'Кокос', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (59, N'Арбуз', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (60, N'Груша', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (61, N'Персик', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (62, N'Малина', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (63, N'Вишня', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (64, N'Слива', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (65, N'Дыня', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (66, N'Ананас', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (67, N'Ежевика', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (68, N'Манго', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (69, N'Яблоко', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (70, N'Абрикос', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (71, N'Клубника', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (72, N'Личи', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (73, N'Виноград', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (74, N'Маракуйя', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (75, N'Гранат', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (76, N'Земляника', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (77, N'Банан', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (78, N'Зеленое яблоко', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (79, N'Айва', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (80, N'Инжир', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (81, N'Барбарис', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (82, N'Тыква', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (83, N'Фруктовая нота', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (84, N'Черника', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (85, N'Черешня', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (86, N'Клюква', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (87, N'Крыжовник', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (88, N'Красная смородина', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (89, N'Киви', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (90, N'Нектарин', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (91, N'Облепиха', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (92, N'Лесные ягоды', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (93, N'Карамбола', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (94, N'Красное яблоко', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (95, N'Масло ши', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (96, N'Тропические фрукты', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (97, N'Гуава', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (98, N'Чернослив', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (99, N'Фундук (лесной орех)', 2)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (100, N'Гуарана', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (101, N'Трюфель', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (102, N'Бузина черная', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (103, N'Слива Мирабель', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (104, N'Сухофрукты', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (105, N'Папайя', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (106, N'Рис', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (107, N'Грецкий орех', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (108, N'Ягоды можжевельника', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (109, N'Джекфрут', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (110, N'Авокадо', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (111, N'Ягоды', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (112, N'Морковь', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (113, N'Белый персик', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (114, N'Бойзенова ягода', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (115, N'Брусника', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (116, N'Фисташки', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (117, N'Мангостин', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (118, N'Красные фрукты', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (119, N'Нефелиум (рамбутан)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (120, N'Мандиока', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (121, N'Каштан', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (122, N'Финики', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (123, N'Помидор', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (124, N'Лимонник', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (125, N'Хурма', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (126, N'Ягоды годжи', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (127, N'Ягоды', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (128, N'Асаи', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (129, N'Арахис', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (130, N'Кокосовое молочко', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (131, N'Морошка', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (132, N'Голубика', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (133, N'Мушмула японская', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (134, N'Белая смородина', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (135, N'Кедровые орехи', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (136, N'Оливки', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (137, N'Орех пекан', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (138, N'Горох', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (139, N'Белый гриб', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (140, N'Ячмень', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (141, N'Бобы', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (142, N'Овес', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (143, N'Физалис', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (144, N'Саподилла', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (145, N'Изюм', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (146, N'Белая черешня', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (147, N'Помароза (Pomarosa)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (148, N'Бразильский орех', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (149, N'Лисички (грибы)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (150, N'Барбадосская вишня', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (151, N'Маслина', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (152, N'Зеленый перец', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (153, N'Артишок', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (154, N'Батат (сладкий картофель)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (155, N'Наранхилла (луло)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (156, N'Волчья ягода', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (157, N'Питанга', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (158, N'Зеленая груша', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (159, N'Калина', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (160, N'Черноплодная рябина', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (161, N'Кумбару', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (162, N'Капуста', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (163, N'Фиголид (Figolide)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (164, N'Купуасу', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (165, N'Свекла', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (166, N'Белая клубника', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (167, N'Солод', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (168, N'Каперсы', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (169, N'Кожица персика', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (170, N'Соя', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (171, N'Красная слива', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (172, N'Чайот (мексиканский огурец)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (173, N'Джаботикаба', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (174, N'Смородина', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (175, N'Фруктовые косточки', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (176, N'Дайкон', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (177, N'Манинка', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (178, N'Яванское яблоко', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (179, N'Сладкий перец', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (180, N'Редис', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (181, N'Звездное яблоко', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (182, N'Чуфа (земляной миндаль)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (183, N'Парадизамид (Paradisamide)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (184, N'Земляничное дерево (мадронья)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (185, N'Розовая смородина', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (186, N'Желудь', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (187, N'Семена рапса', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (188, N'Терновник', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (189, N'Умбу-каха', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (190, N'Снежноягодник (снежная ягода)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (191, N'Семена гибискуса', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (192, N'Шампиньон', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (193, N'Тайберри', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (194, N'Кожура абрикоса', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (195, N'Толокнянка', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (196, N'Мамея (сапота)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (197, N'Райский орех', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (198, N'Рогатая дыня', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (199, N'Зерно', 2)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (200, N'Грибной аккорд', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (201, N'Склерокария', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (202, N'Баклажан ', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (203, N'Veloutone (Велютон) ', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (204, N'Noreenal (Нориналь)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (205, N'Слива казуары ', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (206, N'Tropicalone (Тропикалон)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (207, N'Арбузная косточка', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (208, N'Генипа', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (209, N'Канталупа', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (210, N'Ананасовый сироп', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (211, N'Питайя (Питахайя)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (212, N'Мурумуру', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (213, N'Грушевая гранита', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (214, N'Алыча Prunol (Прюнол) ', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (215, N'Pharaone (Фараон)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (216, N'Свити', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (217, N'Малиновый кетон', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (218, N'Падуб', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (219, N'Ирга', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (220, N'Сметанное яблоко (Гравиола)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (221, N'Сорбет из манго', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (222, N'Тукума', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (223, N'Виноград сорта Рислинг', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (224, N'Кафрская слива', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (225, N'Сироп из черешни', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (226, N'Ананасовый сорбет', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (227, N'Ягоды падуба', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (228, N'Гриб', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (229, N'Мацутакэ Octanal (Октаналь) ', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (230, N'Ethyl Acetate (Этилацетат)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (231, N'Маклюра', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (232, N'Яблочный сироп ', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (233, N'Dewfruit (Дьюфрут)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (234, N'Тамарилло', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (235, N'Опунция', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (236, N'Плоды шиповника', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (237, N'Карамелизованная маракуйя', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (238, N'Бензилацетат', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (239, N'Арбузный сорбет', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (240, N'Воронец', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (241, N'Гриб трутовик Melonal (Мелональ)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (242, N'Султанен (Sultanene)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (243, N'Виноград сорта Гевюрцтраминер', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (244, N'Ежевичный мармелад', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (245, N'Сорбет из киви', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (246, N'Лансгат', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (247, N'Сорбет из лесных ягод', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (248, N'Персиковый сироп', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (249, N'Архат', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (250, N'Черимойя', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (251, N'Логанберри', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (252, N'Шелковица', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (253, N'Каму-каму', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (254, N'Орех ши', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (255, N'Лукума', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (256, N'Ягоды витекса', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (257, N'Смородиновый сорбет', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (258, N'Телопея', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (259, N'Атемойя ', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (260, N'Antillone (Антиллон)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (261, N'Куинчестер (Quincester)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (262, N'Сушеный персик', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (263, N'Ирга ольхолистная', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (264, N'Водяника', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (265, N'Гандария', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (266, N'Зизифус', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (267, N'Спондиас (Яблоко Цитеры)', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (268, N'Плоды Пало санто', 2)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (269, N'Нероли', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (270, N'Роза', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (271, N'Фрезия', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (272, N'Ирис', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (273, N'Фиалка', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (274, N'Пион', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (275, N'Франжипани', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (276, N'Магнолия', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (277, N'Гелиотроп', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (278, N'Цветок хлопка', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (279, N'Лотос', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (280, N'Липовый цвет', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (281, N'Кувшинка (водяная лилия)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (282, N'Белая акация', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (283, N'Гиацинт', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (284, N'Османтус', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (285, N'Мимоза', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (286, N'Орхидея', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (287, N'Гвоздика', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (288, N'Яблоневый цвет', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (289, N'Сирень', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (290, N'Дурман', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (291, N'Герань', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (292, N'Хризантема', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (293, N'Душистый (сладкий) горошек', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (294, N'Гортензия', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (295, N'Жимолость', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (296, N'Флокс', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (297, N'Тюльпан', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (298, N'Цветочные ноты', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (299, N'Гедион (Hedione)', 3)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (300, N'Ромашка', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (301, N'Душистый табак', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (302, N'Черная орхидея', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (303, N'Вистерия (глициния)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (304, N'Страстоцвет', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (305, N'Цикламен', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (306, N'Подснежник', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (307, N'Чампака', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (308, N'Шиповник', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (309, N'Калла', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (310, N'Колокольчик', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (311, N'Резеда', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (312, N'Камелия', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (313, N'Гибискус', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (314, N'Бархатцы', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (315, N'Вишневый цвет', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (316, N'Календула', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (317, N'Цветок миндаля', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (318, N'Клевер', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (319, N'Полевые цветы', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (320, N'Персиковый цвет', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (321, N'Цветок чайного дерева', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (322, N'Цветок лимона', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (323, N'Роза дамасская (rosa damascena)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (324, N'Чубушник (садовый жасмин)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (325, N'Амил салицилат', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (326, N'Цветок мандарина', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (327, N'Цветок сливы', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (328, N'Гладиолус', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (329, N'Незабудка', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (330, N'Райтия священная (водяной жасмин)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (331, N'Цветок граната', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (332, N'Настурция', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (333, N'Эдельвейс', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (334, N'Водяной гиацинт', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (335, N'Подсолнечник', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (336, N'Цветок абрикоса', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (337, N'Клематис', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (338, N'Астра', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (339, N'Василек', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (340, N'Цветы черной смородины', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (341, N'Примула', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (342, N'Белый ирис', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (343, N'Белладонна', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (344, N'Амариллис', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (345, N'Анемон', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (346, N'Гербер', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (347, N'Цветок кактуса', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (348, N'Олеандр', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (349, N'Голубой мак', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (350, N'Стефанотис', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (351, N'Белый пион', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (352, N'Цветок черешни', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (353, N'Мак', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (354, N'Одуванчик', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (355, N'Лён', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (356, N'Люпин', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (357, N'Мальва', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (358, N'Голубой лотос', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (359, N'Каро-корунд', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (360, N'Роза майская (rosa centifolia)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (361, N'Арника', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (362, N'Экзотические цветы', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (363, N'Цветок вишни', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (364, N'Горечавка', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (365, N'Ванильная орхидея', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (366, N'Лакфиоль (желтофиоль, желтый левкой)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (367, N'Георгин', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (368, N'Питтоспорум', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (369, N'Азалия', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (370, N'Борония', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (371, N'Абельмош', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (372, N'Белый лотос', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (373, N'Цветок груши', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (374, N'Маргаритка', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (375, N'Мирабилис (ночная красавица)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (376, N'Цветок малины', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (377, N'Каликантус', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (378, N'Цветок грейпфрута', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (379, N'Дельфиниум', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (380, N'Гелиотропин', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (381, N'Розовый пион', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (382, N'Цветок маслины', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (383, N'Костус', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (384, N'Фуксия', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (385, N'Дамаскон (Damascone)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (386, N'Бугенвиллея', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (387, N'Барбарис', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (388, N'Тунберга', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (389, N'Рододендрон', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (390, N'Петалия (Petalia)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (391, N'Хойя', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (392, N'Гелиональ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (393, N'Барвинок', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (394, N'Цветок папайи', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (395, N'Стрелиция', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (396, N'Цветок кофе', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (397, N'Аннато', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (398, N'Цветок манго', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (399, N'Кислица', 3)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (400, N'Селеницереус (царица ночи)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (401, N'Цветок танжерина', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (402, N'Крокус', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (403, N'Цветок киви', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (404, N'Цветок какао', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (405, N'Дафна (волчеягодник)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (406, N'Бегония', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (407, N'Голубая орхидея', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (408, N'Титан арум (аморфофаллус титанический)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (409, N'Химонантус', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (410, N'Любисток', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (411, N'Ашока', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (412, N'Кирказон', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (413, N'Бобовник', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (414, N'Квисквалис индийский', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (415, N'Бромелия', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (416, N'Цветок аниса', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (417, N'Карисса', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (418, N'Ипомея', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (419, N'Махониаль (Mahonial)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (420, N'Таволга', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (421, N'Аквилегия (водосбор)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (422, N'Пижма', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (423, N'Пыльца', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (424, N'Линалоол', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (425, N'Донник', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (426, N'Недотрога', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (427, N'Лавандин', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (428, N'Василистник', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (429, N'Снежноцвет (хионантус виргинский)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (430, N'Цветок лайма', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (431, N'Лиатрис', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (432, N'Чернушка дамасская', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (433, N'Бурачок', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (434, N'Лютик', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (435, N'Черноголовка', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (436, N'Целозия', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (437, N'Цветок имбиря', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (438, N'Аглая (рисовый цветок)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (439, N'Густавия', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (440, N'Тропические цветы', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (441, N'Цветок бергамота', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (442, N'Космея (берландиера, шоколадный цветок)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (443, N'Нефритовый цветок', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (444, N'Панданус', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (445, N'Водные цветы', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (446, N'Розифолия (Rosyfolia)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (447, N'Розовый лотос', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (448, N'Цветок банана', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (449, N'Ракитник', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (450, N'Тигровая орхидея', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (451, N'Морозник', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (452, N'Цветок шелкового дерева', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (453, N'Спирея (кейп-мей)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (454, N'Вьюнок', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (455, N'Шоколадная орхидея', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (456, N'Цветок пачули', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (457, N'Жакаранда', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (458, N'Хиверналь (Hivernal)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (459, N'Луноцвет', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (460, N'Гивескон (Givescone)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (461, N'Гамамелис', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (462, N'Виолеттин (Violettyne)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (463, N'Нигелла', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (464, N'Цветок сандала', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (465, N'Цветок нектарина', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (466, N'Цветок шелковицы', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (467, N'Морская лаванда (лимониум)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (468, N'Цветок кокоса', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (469, N'Солнцецвет монетолистный', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (470, N'Полуночная роза (гейхера)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (471, N'Лаватера', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (472, N'Панкраций морской', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (473, N'Волчья стопа (сангвинария канадская)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (474, N'Магония', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (475, N'Огуречник (Бурачник)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (476, N'Лилейник', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (477, N'Люцерна', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (478, N'Цветок ананаса', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (479, N'Цветок рапса', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (480, N'Саркокаулон (свеча бушменов)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (481, N'Крестовник', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (482, N'Цветок черного боярышника', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (483, N'Цветок айвы', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (484, N'Белый гибискус', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (485, N'Цветок инжира', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (486, N'Пуансеттия (молочай)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (487, N'Цветок клубники', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (488, N'Цветок личи', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (489, N'Окопник', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (490, N'Желтушник', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (491, N'Цветок кауваи', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (492, N'Цикорий', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (493, N'Цветы красной смородины', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (494, N'Золотарник', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (495, N'Цветок огурца', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (496, N'Цветок базилика', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (497, N'Линнея', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (498, N'Льнянка', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (499, N'Водная лобелия', 3)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (500, N'Цветок анноны', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (501, N'Наперстянка', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (502, N'Смолевка', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (503, N'Амсония', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (504, N'Протея', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (505, N'Цветок мускатной дыни', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (506, N'Цветок полыни', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (507, N'Цветок дыни', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (508, N'Кампсис', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (509, N'Ретама', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (510, N'Руэллия', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (511, N'Курупита гвианская', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (512, N'Цветок барбадосской вишни', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (513, N'Птицемлечник', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (514, N'Гелиопсис (желтая ромашка)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (515, N'Цветок крыжовника', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (516, N'Буддлея', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (517, N'Сцевола таккада', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (518, N'Петуния', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (519, N'Рудбекия волосистая', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (520, N'Терминалия хебула', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (521, N'Шиповник', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (522, N'Вудса', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (523, N'Монарда', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (524, N'Первоцвет весенний', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (525, N'Этил фенил ацетат (Ethyl phenyl acetate) ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (526, N'Mugane (Муган) ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (527, N'Nympheal (Нимфеаль) ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (528, N'Cyclosal (Циклозаль)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (529, N'Ронделетия', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (530, N'Кальмия широколистная', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (531, N'Катальпа ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (532, N'Beta Ionone (Бета-ионон) ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (533, N'Rose oxide (Розеноксид)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (534, N'Звездчатка лесная', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (535, N'Калохортус', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (536, N'Цеструм', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (537, N'Цветок табака', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (538, N'Табак крылатый ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (539, N'Karmaflor (Кармафлор)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (540, N'Пуэрария дольчатая (Кудзу)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (541, N'Озотамнус', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (542, N'Микелия белая', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (543, N'Гаультерия шаллон', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (544, N'Агапантус', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (545, N'Фенилэтиловый спирт', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (546, N'Каттлея', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (547, N'Трианы', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (548, N'Альфа-ионон ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (549, N'Geraniol (Гераниол)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (550, N'Ваточник', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (551, N'Сoranol (Коранол) ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (552, N'Damascenone (Дамасценон)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (553, N'Брунфельсия', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (554, N'Гигантея', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (555, N'Цветок дерева кадамба', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (556, N'Цветок ежевики', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (557, N'Акация густоцветковая', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (558, N'Цветок винограда', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (559, N'Оксипеталум', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (560, N'Анаденантера', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (561, N'Цветок дерева мескит ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (562, N'Iralia (Иралия)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (563, N'Фагрея ароматная ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (564, N'Isoraldeine (Изоральдеин)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (565, N'Освежающий аккорд розы и личи', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (566, N'Плюхея', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (567, N'Цератостигма', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (568, N'Уилмотта', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (569, N'Геранилацетат ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (570, N'Magnolan (Магнолан)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (571, N'Алоизия трёхлистная ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (572, N'Alpha Irone (Альфа-ирон)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (573, N'Родинол', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (574, N'Алоизия трёхлистная', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (575, N'Цветок тыквы', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (576, N'Цинния', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (577, N'Цветок чёрной смородины', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (578, N'Свайнсона прекрасная', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (579, N'Эрикамерия', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (580, N'Зефирантес', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (581, N'Акация голубая', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (582, N'Дуранта ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (583, N'Kharismal Super (Каризмаль Супер)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (584, N'Цветок кедра', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (585, N'Хохлатка', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (586, N'Пуршия', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (587, N'Хризотамнус', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (588, N'Лоропеталум китайский ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (589, N'Dianthine (База Диантин)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (590, N'Цветок фисташкового дерева', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (591, N'Портулак крупноцветковый', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (592, N'Робиния', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (593, N'Цветок бальсы', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (594, N'Дриада восьмилепестная', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (595, N'Сорбет из цветов апельсина', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (596, N'Пафиопедилум', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (597, N'Ротшильда', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (598, N'Эрика древовидная ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (599, N'Aquaflora (Аквафлора)', 3)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (600, N'Эриогонум метельчатый', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (601, N'Мелодорум', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (602, N'Скумпия', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (603, N'Эукрифия блестящая', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (604, N'Цветок литцеи кубебы', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (605, N'Пакалана (Китайская фиалка)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (606, N'Гвоздика турецкая', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (607, N'Цветок риса', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (608, N'Корилопсис', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (609, N'Цветок лавра', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (610, N'Цветок гвоздичного дерева ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (611, N'Firascone (Фираскон) ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (612, N'Starfleur (Старфлёр)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (613, N'Сусак зонтичный', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (614, N'Цветок шалфея', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (615, N'Сафлор красильный', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (616, N'Ломонос виноградолистный', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (617, N'Ороксилум индийский ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (618, N'Indolene (Индолен)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (619, N'Тиарелла', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (620, N'Цветок калины', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (621, N'Меум', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (622, N'Цветок ши', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (623, N'Антуриум', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (624, N'Аброния ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (625, N'Ionone (Ионон)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (626, N'Цветок клементина', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (627, N'Космидиум', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (628, N'Циклопия', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (629, N'Сильфий', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (630, N'Репешок ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (631, N'Lilybelle (Лилибелль)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (632, N'Фагрея душистая', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (633, N'Эпифиллум', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (634, N'Руизия сердцевидная', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (635, N'Розиран (Rosyrane)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (636, N'Гениостома борбоникум', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (637, N'Гревиллея', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (638, N'Цветок помело', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (639, N'Триллиум', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (640, N'Ирон', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (641, N'Эухарис крупноцветковый', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (642, N'Бувардия', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (643, N'Софора японская', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (644, N'Рябчик шахматный ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (645, N'Profarnesal (Профарнезаль)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (646, N'Сорговник', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (647, N'Цветок-призрак', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (648, N'Метил', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (649, N'Ионон', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (650, N'Цветок цуккини', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (651, N'Стробилянт', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (652, N'Цветок черники', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (653, N'Газонница', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (654, N'Амбербоа мускусная', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (655, N'Морина', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (656, N'Горянка', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (657, N'Фенетилацетат', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (658, N'Эуриопс', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (659, N'Кантуа', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (660, N'Гвоздика перистая', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (661, N'Цветок плюща', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (662, N'Цветок льна', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (663, N'Цветок пальмы', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (664, N'Цветок карамболы', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (665, N'Розелла', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (666, N'Цветок бузины', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (667, N'Этлингера высокая', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (668, N'Цветок каштана ', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (669, N'Methyl anthranilate (Метилантранилат)', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (670, N'Калиптранес', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (671, N'Лапчатка прямостоячая', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (672, N'Асфоделус', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (673, N'Цветок юзу', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (674, N'Цветок ванили', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (675, N'Эпигея', 3)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (676, N'Иланг-иланг', 4)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (677, N'Жасмин', 4)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (678, N'Тубероза', 4)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (679, N'Ландыш', 4)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (680, N'Гардения', 4)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (681, N'Апельсиновый цвет (флердоранж)', 4)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (682, N'Лилия', 4)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (683, N'Нарцисс', 4)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (684, N'Белые цветы', 4)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (685, N'Жасмин Самбак', 4)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (686, N'Тиаре', 4)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (687, N'Жасмин грандифлорум', 4)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (688, N'Индол (Indole)', 4)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (689, N'Парадизон (Paradisone)', 4)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (690, N'Марипоса (Имбирная лилия)', 4)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (691, N'Лисиланг (Lisylang)', 4)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (692, N'Конопля', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (693, N'Лаванда', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (694, N'Полынь (артемизия)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (695, N'Огурец', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (696, N'Гальбанум', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (697, N'Трава', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (698, N'Зеленый аккорд (зеленые ноты)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (699, N'Лист черной смородины', 5)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (700, N'Амбретта', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (701, N'Ревень', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (702, N'Алоэ', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (703, N'Лист томата', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (704, N'Чай', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (705, N'Папирус', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (706, N'Мате', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (707, N'Лист фиалки', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (708, N'Корень фиалки', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (709, N'Дягиль (ангелика)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (710, N'Папоротник', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (711, N'Кактус', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (712, N'Кинза (лист кориандра)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (713, N'Давана', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (714, N'Плющ', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (715, N'Морские водоросли', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (716, N'Хмель', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (717, N'Пшеница', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (718, N'Ятаманси (нард гималайский)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (719, N'Лист инжира', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (720, N'Женьшень', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (721, N'Дикие травы', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (722, N'Сельдерей', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (723, N'Лист березы', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (724, N'Агава', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (725, N'Почки черной смородины', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (726, N'Лист лимона', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (727, N'Бучу (агатосма)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (728, N'Иссоп', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (729, N'Кукуруза', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (730, N'Фужерный аккорд', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (731, N'Лист малины', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (732, N'Мандрагора', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (733, N'Каламус', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (734, N'Опавшие листья', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (735, N'Хна', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (736, N'Лист клена', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (737, N'Лист банана', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (738, N'Белый шалфей', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (739, N'Лист пальмы', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (740, N'Центелла азиатская (готу кола)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (741, N'Сахарный тростник', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (742, N'Водяная мята', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (743, N'Лист апельсина', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (744, N'Лист мандарина', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (745, N'Лист маслины', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (746, N'Виноградная лоза', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (747, N'Омела', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (748, N'Валериана', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (749, N'Лист груши', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (750, N'Лист корицы', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (751, N'Тростник', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (752, N'Лист яблони', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (753, N'Лист герани', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (754, N'Лантана', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (755, N'Лист бамбука', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (756, N'Лист пандана', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (757, N'Лист ананаса', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (758, N'Лист розы', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (759, N'Линалилацетат', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (760, N'Лист клубники', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (761, N'Лист лотоса', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (762, N'Гинкго', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (763, N'Лист бергамота', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (764, N'Ламинария', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (765, N'Лист земляники', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (766, N'Лист миндаля', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (767, N'Лист лайма', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (768, N'Обвойник греческий', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (769, N'Калган', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (770, N'Лаурелия', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (771, N'Араукария', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (772, N'Лист персика', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (773, N'Лист имбиря', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (774, N'Красные водоросли', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (775, N'Дерн', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (776, N'Лист гардении', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (777, N'Лист драцены', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (778, N'Лист мимозы', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (779, N'Бизоновая трава', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (780, N'Душистый колосок', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (781, N'Лист шелковицы', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (782, N'Лист перца', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (783, N'Красная трава', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (784, N'Лист магнолии', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (785, N'Лист ежевики', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (786, N'Почки конского каштана', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (787, N'Лист вяза', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (788, N'Лист чампаки', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (789, N'Дубровник', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (790, N'Восковник', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (791, N'Тысячелистник', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (792, N'Лист тамаринда', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (793, N'Васаби', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (794, N'Лист гиацинта', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (795, N'Лист лантаны', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (796, N'Лист вишни', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (797, N'Лист манго', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (798, N'Тулси', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (799, N'Лист душистого перца', 5)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (800, N'Геликония', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (801, N'Остролист', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (802, N'Равенсара', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (803, N'Лизихитон американский', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (804, N'Буквица', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (805, N'Ним (ниим)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (806, N'Салат латук', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (807, N'Филодендрон', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (808, N'Лимнофила (амбулия)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (809, N'Родиола розовая', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (810, N'Хвоя можжевельника', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (811, N'Чай юань чжи', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (812, N'Спартина изящная', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (813, N'Сассафрас', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (814, N'Кока листья', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (815, N'Патакейра', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (816, N'Турча', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (817, N'Стебель орхидеи', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (818, N'Железница', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (819, N'Губастик', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (820, N'Лох', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (821, N'Овощной аккорд', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (822, N'Лист юзу', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (823, N'Монарда двойчатая', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (824, N'Амброзия ', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (825, N'Galbanol (Гальбанол)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (826, N'Купена', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (827, N'Моринга', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (828, N'Котовник (Кошачья мята)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (829, N'Кирказон змеевидный', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (830, N'Мелалеука пятижилковая ', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (831, N'Phenyl oxide (Фенил оксид)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (832, N'Энотера (ослинник)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (833, N'Конопля сорная', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (834, N'Цеанотус', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (835, N'Гречиха', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (836, N'Зубровка душистая', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (837, N'Цитронелла', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (838, N'Хинное дерево', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (839, N'Юкка', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (840, N'Яснотка', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (841, N'Лист грейпфрута', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (842, N'Бородач виргинский', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (843, N'Солерос', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (844, N'Лист камелии', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (845, N'Хоста', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (846, N'Изоциклоцитраль', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (847, N'Поллия', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (848, N'Рейнутрия японская', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (849, N'Ситник', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (850, N'Рожь', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (851, N'Амми зубная', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (852, N'Лапчатка ', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (853, N'Adoxal (Адоксаль)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (854, N'Пеумус', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (855, N'Канна индийская', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (856, N'Череда', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (857, N'Сенна крылатая', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (858, N'Восковница пенсильванская', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (859, N'Сереноя', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (860, N'Копытень ', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (861, N'Irotyl (Иротил)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (862, N'Гипсофила', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (863, N'Шнитт-лук', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (864, N'Портулак огородный', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (865, N'Лист грецкого ореха', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (866, N'Дамиана', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (867, N'Подмаренник', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (868, N'Мексиканский чай ', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (869, N'Menthanyl acetate (Ментанил ацетат)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (870, N'Мыльнянка', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (871, N'Влажная листва ', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (872, N'Triplal (Триплаль)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (873, N'Бакопа', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (874, N'Монье', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (875, N'Лист бетеля', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (876, N'Азолла', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (877, N'Шандра обыкновенная', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (878, N'Гарпагофитум', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (879, N'Монстера', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (880, N'Виктория амазонская', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (881, N'Аконит синий ', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (882, N'Verbetryle (Вербетил)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (883, N'Аликсия звёздчатая', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (884, N'Подорожник', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (885, N'Талинум', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (886, N'Юниола метельчатая', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (887, N'Фукус пузырчатый', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (888, N'Смолёвка поникшая', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (889, N'Муррайя метельчатая', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (890, N'Кордилина ', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (891, N'Dodecanal (Додеканаль)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (892, N'Сабаль пальмовидный', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (893, N'Сабаль пальмовидный', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (894, N'Муррайя', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (895, N'Кёнига', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (896, N'Пастернак', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (897, N'Карапа гвианская', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (898, N'Лист клементина', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (899, N'Кали трагус', 5)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (900, N'Дальбергия', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (901, N'Агератина', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (902, N'Очиток корсиканский', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (903, N'Квассия горькая', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (904, N'Лист авокадо', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (905, N'Спинифекс', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (906, N'Лист сливы', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (907, N'Подокарп тотара', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (908, N'Катран', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (909, N'Зантоксилум', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (910, N'Стемон', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (911, N'Клетра ольхолистная', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (912, N'Псевдовинтера', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (913, N'Дихантелиум', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (914, N'Азолла папоротниковидная', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (915, N'Ворсянка', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (916, N'Чистец', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (917, N'Лесной', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (918, N'Кокколоба', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (919, N'Котула', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (920, N'Листья диптерикса', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (921, N'Толстянка яйцевидная', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (922, N'Каладиум', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (923, N'Корень смилакса', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (924, N'Чистец византийский', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (925, N'Ангелония узколистная', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (926, N'Сальвадора персидская', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (927, N'Лист кафрского лайма', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (928, N'Лист какао', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (929, N'Ундекавертол', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (930, N'Мелколепестник канадский', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (931, N'Лист личи ', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (932, N'Shisolia (Шисолия)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (933, N'Манжетка', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (934, N'Кервель ажурный', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (935, N'Лист франжипани', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (936, N'Каллистемон', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (937, N'Сушеница', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (938, N'Лист мирта ', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (939, N'Glycolierral (Гликоацеталь)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (940, N'Расторопша', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (941, N'Адесмия', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (942, N'Ямароза', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (943, N'Хеймия иволистная', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (944, N'Олеария аргофилла', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (945, N'Карнегия', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (946, N'Кислица разноцветная', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (947, N'Лист кордилины', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (948, N'Лист олеандра', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (949, N'Сеслерия голубая', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (950, N'Рами белое', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (951, N'Купырь лесной', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (952, N'Иксора ярко-красная', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (953, N'Посидония', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (954, N'Кореопсис мутовчатый', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (955, N'Гречишник', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (956, N'Лист агавы', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (957, N'Очиток (Седум)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (958, N'Лист кумквата', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (959, N'Мандевилла', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (960, N'Лист палисандра', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (961, N'Лист абрикоса', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (962, N'Эспарцет', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (963, N'Делоникс королевский', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (964, N'Киноа', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (965, N'Декопан ', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (966, N'Pescagreen (Пескагрин)', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (967, N'Клинтония', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (968, N'Фиттония', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (969, N'Баррингтония', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (970, N'Сигизиум', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (971, N'Смита', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (972, N'Сциадопитис', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (973, N'Клопогон кистевидный', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (974, N'Лист хризантемы', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (975, N'Лист шиповника', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (976, N'Лист пуэрарии', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (977, N'Монсония', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (978, N'Традесканция', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (979, N'Лист черники', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (980, N'Уотсония', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (981, N'Лист пиона', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (982, N'Равенала', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (983, N'Лаконос', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (984, N'Лист лилии', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (985, N'Хлорофитум', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (986, N'Цветок сахарного тростника', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (987, N'Лист бузины', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (988, N'Лист каффского лайма', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (989, N'Скандикс', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (990, N'Аодзиру', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (991, N'Софора', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (992, N'Лист жасмина', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (993, N'Очанка', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (994, N'Шлемник обыкновенный', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (995, N'Калатея', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (996, N'Слоновая трава', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (997, N'Ванда', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (998, N'Золототысячник', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (999, N'Кордия', 5)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1000, N'Лист танжерина', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1001, N'Осока', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1002, N'Горошек', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1003, N'Мюленберги', 5)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1004, N'Пачули', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1005, N'Сандал', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1006, N'Ветивер', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1007, N'Уд', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1008, N'Кедр', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1009, N'Древесный аккорд', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1010, N'Гваяковое дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1011, N'Исо е супер (Iso E Super)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1012, N'Табак', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1013, N'Можжевельник (каде)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1014, N'Белый кедр', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1015, N'Еловая хвоя', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1016, N'Сосна', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1017, N'Бамбук', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1018, N'Нагармота (ципреол, сыть, циперус)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1019, N'Береза', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1020, N'Кипарис', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1021, N'Эвкалипт', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1022, N'Махагони (красное дерево)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1023, N'Тиковое дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1024, N'Палисандр (розовое дерево)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1025, N'Массойя', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1026, N'Хиноки', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1027, N'Хлопок', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1028, N'Яванол', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1029, N'Альбиция (Шёлковое дерево)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1030, N'Дуб', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1031, N'Акигалавуд (Akigalawood)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1032, N'Амирис', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1033, N'Влажная древесина', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1034, N'Пихта', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1035, N'Вереск', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1036, N'Мирт', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1037, N'Плесень', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1038, N'Пало санто', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1039, N'Виргинский кедр', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1040, N'Эбеновое дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1041, N'Белое дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1042, N'Боярышник', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1043, N'Багульник', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1044, N'Ель', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1045, N'Кефалис (Kephalis)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1046, N'Норлимбанол (Norlimbanol)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1047, N'Благородные породы дерева', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1048, N'Светлые породы дерева', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1049, N'Лишайник', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1050, N'Черное дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1051, N'Аглая', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1052, N'Амарант', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1053, N'Клен', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1054, N'Лоренокс (Lorenox)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1055, N'Клирвуд (Clearwood)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1056, N'Секвойя', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1057, N'Кедр атласский', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1058, N'Лесной аккорд', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1059, N'Ива', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1060, N'Хвоя кедра', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1061, N'Оливковое (маслиновое) дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1062, N'Тополь', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1063, N'Лимонное дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1064, N'Камбоджийский уд', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1065, N'Самшит', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1066, N'Дрок', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1067, N'Сосновые иголки', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1068, N'Лаосский уд', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1069, N'Инжировое дерево смоква', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1070, N'Тимберсилк (Timbersilk)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1071, N'Манука (дерево)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1072, N'Литцея кубеба', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1073, N'Нард', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1074, N'Дерево миндаля', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1075, N'Экзотические породы дерева', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1076, N'Кабреува', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1077, N'Древесная кора', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1078, N'Акант', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1079, N'Яблоня', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1080, N'Сливовое дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1081, N'Сухая древесина', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1082, N'Туя', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1083, N'Древесно-фруктовый аккорд', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1084, N'Лиственница', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1085, N'Шипровые ноты', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1086, N'Красный кедр', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1087, N'Драцена киноварно-красная', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1088, N'Голубая ель', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1089, N'Липовое дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1090, N'Дерево карри', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1091, N'Баобаб', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1092, N'Вишневое дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1093, N'Ясень', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1094, N'Ветиверил ацетат', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1095, N'Гималайский кедр', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1096, N'Бругмансия', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1097, N'Фрагония', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1098, N'Кустарники', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1099, N'Черная ель', 6)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1100, N'Хиба (кипарис японский)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1101, N'Рябина', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1102, N'Дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1103, N'Будды', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1104, N'Банксия', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1105, N'Бразильское красное дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1106, N'Горчица полевая', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1107, N'Бирючина', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1108, N'Сикомор', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1109, N'Сиам', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1110, N'Дерево вакапу', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1111, N'Венге', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1112, N'Кизил', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1113, N'Американский перец', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1114, N'Техасский кедр', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1115, N'Мухуху', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1116, N'Гавайский кедр', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1117, N'Кокосовая пальма', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1118, N'Аралия', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1119, N'Форзиция', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1120, N'Пальма', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1121, N'Катрафей', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1122, N'Чайное дерево (Мелалеука)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1123, N'Линалое', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1124, N'Грушевое дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1125, N'Караналь (Karanal)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1126, N'Корни растений', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1127, N'Гикори (хикори)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1128, N'Чойя рал', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1129, N'Кумару', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1130, N'Критмум', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1131, N'Корень лотоса', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1132, N'Конфетное дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1133, N'Осина', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1134, N'Канука', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1135, N'Пероба (янтарное дерево)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1136, N'Испанская вишня', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1137, N'Чакония', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1138, N'Китайская красная береза', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1139, N'Пармелия', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1140, N'Чапараль', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1141, N'Давидия', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1142, N'Перечное дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1143, N'Двукрылоплодник', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1144, N'Чокоболо', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1145, N'Японский багрянник (кацура)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1146, N'Павловния', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1147, N'Каскарилла (кротон)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1148, N'Зеленое дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1149, N'Джордживуд (Georgywood)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1150, N'Каяпутовое дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1151, N'Железное дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1152, N'Тамариск', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1153, N'Зебрано', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1154, N'Голубой кипарис', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1155, N'Окоуме', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1156, N'Пробковое дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1157, N'Ванильное дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1158, N'Рождественское (огненное) дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1159, N'Рожковое дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1160, N'Адениум (пустынная роза)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1161, N'Орешник', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1162, N'Орбитон (Orbitone)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1163, N'Тис ягодный', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1164, N'Тсуга', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1165, N'Приприока', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1166, N'Манговое дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1167, N'Вяз', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1168, N'Похутукава', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1169, N'Тополь черный', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1170, N'Пиерис', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1171, N'Цедронелла канарская', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1172, N'Канелла', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1173, N'Йохимбе', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1174, N'Хо (Коричник камфорный)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1175, N'Семена мандарина', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1176, N'Лаконос двудомный (омбу)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1177, N'Баньян', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1178, N'Скипидар', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1179, N'Скларен ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1180, N'Polywood (Polywood) ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1181, N'Vertofix (Вертофикс) ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1182, N'Ambermax (Эмбермакс)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1183, N'Аргания', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1184, N'Американское мускусное дерево ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1185, N'Aldron (Альдрон)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1186, N'Платан ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1187, N'Guaiacol (Гваякол) ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1188, N'Sandalore (Сандалор)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1189, N'Сабинен', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1190, N'Дымное дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1191, N'Ольха', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1192, N'Болотная грязь ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1193, N'Timberol (Тимберол)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1194, N'Паслён', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1195, N'Хлебное дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1196, N'Ксимения американская', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1197, N'Итауба', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1198, N'Бакаут ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1199, N'Amberketal (Амберкеталь) ', 6)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1200, N'Operanide (Операнид)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1201, N'Вакциниум сетчатый', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1202, N'Аликсия ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1203, N'Мескит ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1204, N'Patchoulol (Пачулол)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1205, N'Аликсия ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1206, N'Bacdanol (Бакданол)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1207, N'Сухоцветы ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1208, N'Christalon (Кристалон) ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1209, N'Bois des Landes (Woodland,Вудленд)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1210, N'Танака', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1211, N'Сапота', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1212, N'Опилки', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1213, N'Сигарета ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1214, N'Hindinol (Хиндинол)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1215, N'Цератопеталум безлепестной', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1216, N'Фукьерия блестящая', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1217, N'Гвибурция', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1218, N'Сандаловое благовоние ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1219, N'Ambertonic (Эмбертоник)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1220, N'Бук', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1221, N'Нотофагус', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1222, N'Домби', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1223, N'Кадамба', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1224, N'Хлорокардиум', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1225, N'Криптокария', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1226, N'Дакридиум', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1227, N'Мадука длиннолистная', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1228, N'Орех кола', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1229, N'Паркинсония ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1230, N'Mystikal (Мистикаль) ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1231, N'Ebanol (Эбанол) ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1232, N'Karmawood (Кармавуд)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1233, N'Этоксилон', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1234, N'Мондия', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1235, N'Мавриция', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1236, N'Кипарисовик ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1237, N'Firsantol (Фирсантол)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1238, N'Окумаль (Okoumal) ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1239, N'Limbanol (Лимбанол)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1240, N'Магония японская ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1241, N'Cedramber (седрэмбер)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1242, N'Вирола ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1243, N'Sandanol (Санданол)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1244, N'Криптомерия ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1245, N'Limbwood база', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1246, N'Восковница', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1247, N'Энтандрофрагма', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1248, N'Персиковое дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1249, N'Джут', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1250, N'Виноградные косточки', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1251, N'Орех ареки', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1252, N'Апельсиновое дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1253, N'Цедрела китайская', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1254, N'Эремофила Митчелла ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1255, N'База Mousse de Saxe ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1256, N'Healingwood (Хилинвуд)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1257, N'Калоцедрус', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1258, N'Тетрадиум', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1259, N'Кампешевое дерево ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1260, N'Fragonia (Фрагония) ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1261, N'Woodleather (Вудлезэр)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1262, N'Тунг', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1263, N'Помадеррис', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1264, N'Кумераху', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1265, N'Тамботи', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1266, N'Брахихитон клёнолистный', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1267, N'Лириодендрон ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1268, N'Santamanol (Сантаманол)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1269, N'Бальса', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1270, N'Мраморное дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1271, N'Мыльное дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1272, N'Индийское масляное дерево', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1273, N'Сейшельская пальма', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1274, N'Чай из кореньев', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1275, N'Чага гриб', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1276, N'Граб', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1277, N'Древесина бехуко индио', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1278, N'Корень ниаули ', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1279, N'Boisiris (Буазирис)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1280, N'Мопане', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1281, N'Падук', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1282, N'Древесина американской вишни', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1283, N'Винилгваякол', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1284, N'Кингвуд', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1285, N'Дримвуд (Dreamwood)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1286, N'Бурсера', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1287, N'Дерево такамака', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1288, N'Эмбервуд (Amberwood)', 6)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1289, N'Ваниль', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1290, N'Миндаль', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1291, N'Кофе', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1292, N'Молоко', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1293, N'Попкорн', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1294, N'Сливки', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1295, N'Мороженое', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1296, N'Выпечка', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1297, N'Какао', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1298, N'Хлеб', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1299, N'Черная икра', 7)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1300, N'Мясо', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1301, N'Орехи', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1302, N'Сыр', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1303, N'Йогурт', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1304, N'Бекон', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1305, N'Кулфи', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1306, N'Сливочное масло', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1307, N'Барбекю', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1308, N'Вафли', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1309, N'Творог', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1310, N'Круассан', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1311, N'Масло', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1312, N'Пудинг', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1313, N'Крекеры', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1314, N'Канеле', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1315, N'Бальзамический уксус', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1316, N'Хала', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1317, N'Отруби', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1318, N'Соленое масло', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1319, N'Крендель', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1320, N'Гурманский аккорд', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1321, N'Солёная карамель', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1322, N'Тыквенный пирог', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1323, N'Молоко с мёдом', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1324, N'Моцарелла', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1325, N'Молоко из кешью', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1326, N'Пирог с пеканом', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1327, N'Ореховые конфеты', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1328, N'Ванильное молоко', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1329, N'Чеснок', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1330, N'Мапо тофу', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1331, N'Бейгл', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1332, N'Яблочный пирог', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1333, N'Обжаренный пекан', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1334, N'Кешью', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1335, N'Ванильный пирог', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1336, N'Персик в карамели', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1337, N'Вишнёвый пирог', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1338, N'Шоколад с мятой', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1339, N'Тесто', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1340, N'Грушевое мороженое', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1341, N'Песочное тесто', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1342, N'Цельнозерновое печенье', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1343, N'Карамелизированный грейпфрут', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1344, N'Малиновое пралине', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1345, N'Сливочный сыр', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1346, N'Карамелизированная слива', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1347, N'Голубичный маффин', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1348, N'Горчица', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1349, N'Арахисовое масло', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1350, N'Фисташковое мороженое', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1351, N'Рамен', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1352, N'Абрикос в шоколаде', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1353, N'Ванильный рис', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1354, N'Луковый суп', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1355, N'Ростбиф', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1356, N'Вишнёвые леденцы', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1357, N'Ежевичный крем', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1358, N'Черносмородиновый сироп', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1359, N'Малиновый рахат-лукум', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1360, N'Черносмородиновый джем', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1361, N'Солёное пралине', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1362, N'Солёные орехи', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1363, N'Персиковый джем', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1364, N'Пандоро', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1365, N'Ферментированная тыква', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1366, N'Малиновый пирог', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1367, N'Клейкий рис с кокосом', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1368, N'Маскарпоне', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1369, N'Цуккини', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1370, N'Кленовые ириски', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1371, N'Кленовый сахар', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1372, N'Тапай', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1373, N'Жареные тыквенные семечки', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1374, N'Кокосовый сорбет', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1375, N'Клубничная меренга', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1376, N'Ягодный крем', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1377, N'Тыквенный хлеб', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1378, N'Обжареная пшеница', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1379, N'Засахаренные цветы апельсина', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1380, N'Жареный рис басмати', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1381, N'Пекан в сахаре', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1382, N'Карамелизированный ананас', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1383, N'Жареный рис', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1384, N'Малиновый шоколад', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1385, N'Варенье из роз', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1386, N'Жареная индейка', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1387, N'Мандариновая меренга', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1388, N'Тост с маслом', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1389, N'Черносмородиновый пирог', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1390, N'Малиновый макарун', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1391, N'Ямс', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1392, N'Пицца Пепперони', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1393, N'Банановый хлеб', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1394, N'Кокосовый пирог', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1395, N'Жареное мясо', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1396, N'Халва', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1397, N'Овсяное печенье', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1398, N'Ореховый сорбет', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1399, N'Яблочные макаруны', 7)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1400, N'Кленовое масло', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1401, N'Кукурузный маффин', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1402, N'Вишнёвое пралине', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1403, N'Яблочный штрудель', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1404, N'Жареные ноты', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1405, N'Ванильное суфле', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1406, N'Скон', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1407, N'Лаймовый сироп', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1408, N'Клубничный сироп', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1409, N'Засахаренный инжир', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1410, N'Гранатовый сорбет', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1411, N'Карамелизованный лайм', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1412, N'Черничная конфета', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1413, N'Коричный крем', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1414, N'Кукурузный хлеб', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1415, N'Печёное тесто', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1416, N'Лимонные вафли', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1417, N'Медовое мороженое', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1418, N'Эль', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1419, N'Миндальный торт', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1420, N'Мочи', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1421, N'Блинчики', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1422, N'Абрикосовый сорбет', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1423, N'Ежевичный сироп', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1424, N'Ликёр из черешни', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1425, N'Клубничное маршмеллоу', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1426, N'Кокосовые макаруны', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1427, N'Малиновая конфета', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1428, N'Фисташковый крем', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1429, N'Лимонное печенье', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1430, N'Яблочный хлеб', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1431, N'Арбузная конфета', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1432, N'Эдамаме', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1433, N'Миндальное печенье', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1434, N'Карамелизованный грецкий орех', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1435, N'Персиковая конфета ', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1436, N'2-Ацетилфуран', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1437, N'Клубничный мусс', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1438, N'Ежевичная конфета', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1439, N'Миндальная помадка', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1440, N'Мандариновый чай', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1441, N'Имбирный чай', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1442, N'Запеченый батат', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1443, N'Засахаренная черника', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1444, N'Кофейный торт', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1445, N'Крем из маршмеллоу', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1446, N'Засахаренные фисташки', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1447, N'Персиковый пирог', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1448, N'Ванильный маффин', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1449, N'Клубничный торт', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1450, N'Фруктовый сорбет', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1451, N'Ягодный мусс', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1452, N'Бузиновый сироп', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1453, N'Пирог из цуккини', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1454, N'Засахаренная груша', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1455, N'Панкейки', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1456, N'Коричное пралине', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1457, N'Зелёный лук', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1458, N'Сметана', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1459, N'Тыквенный пудинг', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1460, N'Хлебный пудинг', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1461, N'Кокосовая конфета', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1462, N'Фисташковый сорбет', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1463, N'Морковный торт', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1464, N'База Bois de miel', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1465, N'Апельсиновое мороженое', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1466, N'Кокосовое печенье', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1467, N'Ореховая карамель', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1468, N'Розовый сорбет', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1469, N'Коричный торт', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1470, N'Тыквенное печенье', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1471, N'Солёные ириски', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1472, N'Семена чиа', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1473, N'Сморчок', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1474, N'Малиновый сироп', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1475, N'Черносмородиновая конфета', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1476, N'Каштановый пирог', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1477, N'Кукурузный сироп', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1478, N'Каша', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1479, N'Малиновый трюфель', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1480, N'Черничный джем', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1481, N'Пирог из батата', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1482, N'Масляное печенье', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1483, N'Протеиновый батончик', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1484, N'Тыквенный маффин', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1485, N'Банановая конфета', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1486, N'Абрикосовый джем', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1487, N'Имбирный джем', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1488, N'Миндальный сироп', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1489, N'Миндальный сироп', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1490, N'Апельсиновая конфета', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1491, N'Тыквенный крем', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1492, N'Лимонный мармелад', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1493, N'Ежевичный джем', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1494, N'Соевый соус', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1495, N'Ореховое молоко', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1496, N'Овсяное молоко', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1497, N'Нут', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1498, N'Вишневый сироп', 7)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1499, N'Карамель', 8)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1500, N'Сладкая вата', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1501, N'Мёд', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1502, N'Макадамия', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1503, N'Жженый сахар', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1504, N'Пралине', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1505, N'Сено', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1506, N'Шоколад', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1507, N'Маршмеллоу', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1508, N'Жевательная резинка', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1509, N'Белый шоколад', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1510, N'Марципан', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1511, N'Ириски', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1512, N'Зефир', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1513, N'Имбирный пряник', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1514, N'Кумарин', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1515, N'Взбитые сливки', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1516, N'Сахарное печенье', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1517, N'Мармелад', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1518, N'Сахар', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1519, N'Леденец', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1520, N'Пряник', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1521, N'Вареное сгущенное молоко', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1522, N'Яблоко в карамели', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1523, N'Темный шоколад', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1524, N'Пирожное', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1525, N'Сладкий аккорд', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1526, N'Безе', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1527, N'Заварной крем', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1528, N'Коричневый сахар', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1529, N'Кекс', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1530, N'Крем-брюле', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1531, N'Бисквит', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1532, N'Молочный шоколад', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1533, N'Сорбет', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1534, N'Торт', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1535, N'Кленовый сироп', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1536, N'Пастила', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1537, N'Чизкейк', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1538, N'Тирамису', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1539, N'Панна котта', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1540, N'Сахарная пудра', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1541, N'Молочный мусс', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1542, N'Космофрут (Cosmofruit)', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1543, N'Миндальные печенья', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1544, N'Нуга', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1545, N'Черная патока (меласса)', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1546, N'Дульче де лече', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1547, N'Рахат лукум', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1548, N'Цукаты', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1549, N'Драже', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1550, N'Мальтол', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1551, N'Джандуйя (шоколадно-ореховая паста)', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1552, N'Черный сахар', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1553, N'Джем', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1554, N'Коктейльная вишня', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1555, N'Щербет', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1556, N'Глазированный каштан', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1557, N'Каштановый крем', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1558, N'Кондитерская глазурь', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1559, N'Засахаренные фрукты', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1560, N'Сливочная помадка', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1561, N'Ганаш (шоколадная глазурь)', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1562, N'Инжирный джем', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1563, N'Макарун', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1564, N'Миндальный крем', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1565, N'Ванильное мороженое', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1566, N'Лимонная гранита', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1567, N'Грушевый сорбет', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1568, N'Булочка с корицей', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1569, N'Ягодный сорбет', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1570, N'Лимонное мороженое', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1571, N'Апельсиновый сорбет', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1572, N'Медовый торт', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1573, N'Ванильный сахар', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1574, N'Масляный крем', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1575, N'Яблочный сорбет', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1576, N'Персиковый крем', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1577, N'Лаймовый пирог', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1578, N'Шоколадный торт', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1579, N'Имбирный шоколад', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1580, N'Ванильный йогурт', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1581, N'Розовый сироп', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1582, N'Савоярди', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1583, N'Розовый сахар', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1584, N'Лимонный сорбет', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1585, N'Малиновый крем', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1586, N'Карамелизованные орехи', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1587, N'Клубничный сорбет', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1588, N'Кокосовое мороженое', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1589, N'Шоколадное печенье', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1590, N'Танжериновый сорбет', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1591, N'Малиновый сорбет', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1592, N'Смородиновый пирог', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1593, N'Ванильный сорбет', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1594, N'Жасминовый джем', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1595, N'Бергамотовый сорбет', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1596, N'Черничные вафли', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1597, N'Апельсиновый крем', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1598, N'Сорбет из маракуйи', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1599, N'Крем из фундука', 8)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1600, N'Смородиновый крем', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1601, N'Нутелла', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1602, N'Карамелизованная клубника', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1603, N'Этилмальтол', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1604, N'Лимонный пирог', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1605, N'Розмариновое молоко', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1606, N'Ревеневый пирог', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1607, N'Лавандовый сахар', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1608, N'Сорбет из личи', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1609, N'Этиллайтон', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1610, N'Гранита из бессмертника', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1611, N'Сорбет из базилика', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1612, N'Яблочные леденцы', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1613, N'Ореховый крем', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1614, N'Калиссон', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1615, N'Крем Шантийи', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1616, N'Ванильное пралине', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1617, N'Мороженое из киви', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1618, N'Смородиновый джем', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1619, N'Фиалковый сахар', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1620, N'Финиковый джем', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1621, N'Пралине в карамели', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1622, N'Лимонный курд', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1623, N'Клубничные леденцы ', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1624, N'Phenylacetaldehyde (Фенилацетальдегид)', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1625, N'Ванильный сироп', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1626, N'Апельсиновый джем', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1627, N'Сорбет из помело', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1628, N'Мармелад Jelly Beans', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1629, N'Джем из маракуйи', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1630, N'Шоколадные маршмеллоу', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1631, N'Пирожное Мадлен', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1632, N'Персиковый сорбет', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1633, N'Яблочный крамбл', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1634, N'Айвовый сорбет', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1635, N'Малиновый джем', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1636, N'Английский крем', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1637, N'Клубничный капкейк', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1638, N'Малиновая гранита', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1639, N'Яблочный мармелад', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1640, N'Лавандовый макарун', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1641, N'Абрикосовый крем', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1642, N'Карамелизованная груша', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1643, N'Ежевичный сорбет', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1644, N'Желе из черной смородины', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1645, N'Карамелизованные ягоды', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1646, N'Грушевый мармелад', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1647, N'Мятный сорбет', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1648, N'Мандариновый джем', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1649, N'Карамелизованный ананас', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1650, N'Медовое печенье', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1651, N'Танжериновый джем', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1652, N'Карамелизированный фундук', 8)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1653, N'Зеленый чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1654, N'Шампанское', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1655, N'Ром', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1656, N'Кока-кола', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1657, N'Пиво', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1658, N'Красное вино', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1659, N'Виски', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1660, N'Амаретто', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1661, N'Белый чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1662, N'Коньяк', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1663, N'Абсент', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1664, N'Коктейль Пина колада', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1665, N'Лимонад', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1666, N'Джин', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1667, N'Бренди', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1668, N'Чай матча', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1669, N'Розовое шампанское', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1670, N'Мохито', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1671, N'Ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1672, N'Глинтвейн', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1673, N'Бурбон', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1674, N'Кампари', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1675, N'Ликер Бейлис', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1676, N'Мартини', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1677, N'Каппучино', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1678, N'Крем-сода', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1679, N'Водка', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1680, N'Текила', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1681, N'Яблочный сидр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1682, N'Чай масала', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1683, N'Ройбуш (красный чай)', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1684, N'Чай эрл грей', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1685, N'Кюрасао', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1686, N'Коктейль Беллини', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1687, N'Улун', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1688, N'Гренадин', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1689, N'Белое вино', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1690, N'Коктейль Кир-рояль', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1691, N'Кокосовая вода', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1692, N'Малиновый ликер', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1693, N'Лимончелло', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1694, N'Вермут', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1695, N'Газированная вода', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1696, N'Мокко', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1697, N'Пуэр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1698, N'Яблочный сок', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1699, N'Эспрессо', 9)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1700, N'Карамельный латте', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1701, N'Голубой чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1702, N'Фруктовый пунш', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1703, N'Лапсанг сушонг', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1704, N'Портвейн', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1705, N'Куантро', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1706, N'Коктейль Дайкири', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1707, N'Имбирный эль', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1708, N'Коктейль Кайпиринья', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1709, N'Мальвазия', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1710, N'Эгг-ног', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1711, N'Черный коньяк', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1712, N'Медовуха', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1713, N'Юннаньский красный чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1714, N'Кашаса', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1715, N'Коктейль Май-тай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1716, N'Саке', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1717, N'Фруктовая вода', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1718, N'Пино-нуар', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1719, N'Марокканский чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1720, N'Сербское бренди', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1721, N'Токайское вино', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1722, N'Франжелико (ореховый ликер)', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1723, N'Коктейль Американо', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1724, N'Чай генмайча', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1725, N'Коктейль Ягер бомб', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1726, N'Амаро', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1727, N'Коктейль Космополитен', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1728, N'Юннаньский черный чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1729, N'Оршад (орчата)', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1730, N'Коктейль Мимоза', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1731, N'Ямайский ликер', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1732, N'Миндальное молоко', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1733, N'Ром', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1734, N'Такамака', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1735, N'Джин-тоник', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1736, N'Чай с бергамотом', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1737, N'Тыквенный латте', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1738, N'Коктейль', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1739, N'Физ', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1740, N'Жасминовый чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1741, N'Узо', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1742, N'Розовый ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1743, N'Тоник', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1744, N'Персиковое просекко', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1745, N'Кокосовый ром', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1746, N'Самбука', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1747, N'Чай с манго', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1748, N'Апельсиновый ликер', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1749, N'Сливовый компот', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1750, N'Соевое молоко', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1751, N'Абрикосовый ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1752, N'Черничный ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1753, N'Черносмородиновый ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1754, N'Чай лапсанг-сушонг', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1755, N'Ежевичный бренди', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1756, N'Лимонад из грейпфрута', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1757, N'Яблочный мартини', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1758, N'Мокаччино', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1759, N'Ежевичный ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1760, N'Грушевый ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1761, N'Коктейль Московский мул', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1762, N'Шабли (вино)', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1763, N'Инжирный компот', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1764, N'Коктейль Венецианский спритц', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1765, N'Коктейль Jagerbomb', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1766, N'Гречневый чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1767, N'Сливовый ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1768, N'Ванильный ром', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1769, N'Клубничное молоко', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1770, N'Кикеон', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1771, N'Коктейль Мятный джулеп', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1772, N'Травяные настойки', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1773, N'Яблочный бренди', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1774, N'Розовое вино', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1775, N'Напиток из сахарного тростника', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1776, N'Латте макиато', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1777, N'Клубничный молочный коктейль', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1778, N'Мескаль', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1779, N'Шардоне', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1780, N'Грог', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1781, N'Аррак', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1782, N'Сангрия', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1783, N'Молочный коктейль', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1784, N'Ванильный ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1785, N'Ликер Шамбор', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1786, N'Санджовезе (вино)', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1787, N'Просекко', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1788, N'Граппа', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1789, N'Лавандовый сироп', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1790, N'Пастис', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1791, N'Яблочный виски', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1792, N'Шоколадный ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1793, N'Чай с лимоном', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1794, N'Рислинг', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1795, N'Стаут', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1796, N'Ликёр из бергамота', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1797, N'Апельсиновый бренди', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1798, N'Ликёр Anisette', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1799, N'Чай из маракуйи', 9)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1800, N'Мятный ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1801, N'Арак', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1802, N'Ликёр из сливы Мирабель', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1803, N'Абрикосовый бренди', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1804, N'Лакричный ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1805, N'Розовый чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1806, N'Ванильный чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1807, N'Самогон', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1808, N'Миндальный ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1809, N'Клубничный ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1810, N'Ликёр Grand Marnier', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1811, N'Османтусовый чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1812, N'Чай из шиповника', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1813, N'Кофейный ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1814, N'Китайский зелёный чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1815, N'Фруктовый чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1816, N'Китайский белый чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1817, N'Коктейль Маргарита', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1818, N'Водка с тоником', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1819, N'Коктейль Гимлет', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1820, N'Персиковое вино', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1821, N'Ежевичное вино', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1822, N'Арбузный мартини', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1823, N'Каберне (вино)', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1824, N'Молоко с кардамоном', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1825, N'Рамунэ', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1826, N'Аккорд кофе с молоком', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1827, N'Херес', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1828, N'Чайный гриб', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1829, N'Чай Гёкуро', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1830, N'Божоле (вино)', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1831, N'Персиковый ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1832, N'Коктейль Чимайо', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1833, N'Японское сливовое вино', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1834, N'Сорбет из лимончелло', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1835, N'Горячий ром с маслом', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1836, N'Ликёр из цветов бузины', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1837, N'Ягодная гранита', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1838, N'Фиалковый чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1839, N'Матча латте', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1840, N'Яблочный ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1841, N'Малиновое вино', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1842, N'Ликёр Creme de violette', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1843, N'Лимонный чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1844, N'Ликёр из лесного ореха', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1845, N'Имбирное молоко', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1846, N'Биттер', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1847, N'Розовое мускатное вино', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1848, N'Инжировый чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1849, N'Неролевый чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1850, N'Ликёр Midori', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1851, N'Смородиновый ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1852, N'Ванильный мартини', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1853, N'Смородиновый ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1854, N'Мадейра', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1855, N'Цитрусовый ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1856, N'Травяной ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1857, N'Юннаньский зелёный чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1858, N'Мандариновый ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1859, N'Дынный ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1860, N'Ликёр Калуа', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1861, N'Чай Ходзитя', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1862, N'Айриш-крим', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1863, N'Чай Уи', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1864, N'Карамельное молоко', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1865, N'Инжировый ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1866, N'Индийский белый чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1867, N'Ванильная водка', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1868, N'Часуйма', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1869, N'Чай с молоком', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1870, N'Коктейль Лимонный Дайкири', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1871, N'Чай с женьшенем', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1872, N'Чай Бай Мудань', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1873, N'Чайная смесь Marco Polo', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1874, N'Чай с лотосом', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1875, N'Чай с шалфеем', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1876, N'Чай Сенча', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1877, N'Фиалковый ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1878, N'Анисовый ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1879, N'Японский белый чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1880, N'Кокосовый ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1881, N'Ликер Драмбуи', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1882, N'Карамельный ликёр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1883, N'Имбирный сидр', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1884, N'Чай Лунцзин', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1885, N'Вино из Мальбека', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1886, N'Коктейль Ананасовый Дайкири', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1887, N'Вишневый ликер', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1888, N'Вино', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1889, N'Черный чай', 9)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1890, N'Альдегиды', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1891, N'Мыло (мыльный аккорд)', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1892, N'Кровь', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1893, N'Порох', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1894, N'Кислый аккорд', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1895, N'Восточные ноты', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1896, N'Постельное белье', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1897, N'Огонь (костер)', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1898, N'Свежие ноты', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1899, N'Креозот', 10)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1900, N'Крем для лица', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1901, N'Бумага', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1902, N'Масло монои', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1903, N'Геосмин', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1904, N'Бетон', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1905, N'Чернила', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1906, N'Масло жожоба', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1907, N'Жженая резина', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1908, N'Лактон', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1909, N'Крем для загара', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1910, N'Губная помада', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1911, N'Винил', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1912, N'Тальк', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1913, N'Альдемон (Aldemone)', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1914, N'Краска (аэрозоль)', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1915, N'Резина', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1916, N'Нет сведений о составе', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1917, N'Мокрая штукатурка', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1918, N'Машинное масло', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1919, N'Бархат', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1920, N'Тигровая лиана', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1921, N'Атлас (сатин)', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1922, N'Феромоны', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1923, N'Промышленный клей', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1924, N'Сигара', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1925, N'Аккорд тюля', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1926, N'Шелк', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1927, N'Лак для ногтей', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1928, N'Клейкая лента (скотч)', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1929, N'Салицилат', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1930, N'База Iriseine De Laire', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1931, N'Теннисный мяч', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1932, N'Ткань', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1933, N'Нефтепродукты', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1934, N'Лак', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1935, N'Неопрен', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1936, N'Джинсовая ткань', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1937, N'Фарфор', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1938, N'Масло для загара', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1939, N'Лосьон для тела', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1940, N'Арктикаль (Arctical)', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1941, N'Аммиак', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1942, N'Шампунь', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1943, N'Формальдегид', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1944, N'Детская присыпка ', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1945, N'2-Метилундеканаль', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1946, N'Лак для волос', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1947, N'Метилбензоат', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1948, N'Зубная паста', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1949, N'Хлор', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1950, N'Воск для сёрфинга', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1951, N'Бахур', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1952, N'Запах старых книг', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1953, N'Муравьиная кислота', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1954, N'Моторное масло', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1955, N'Дизельное топливо', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1956, N'Велюр', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1957, N'Аккорд гуаши', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1958, N'Аттар Kewda', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1959, N'Стиральный порошок', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1960, N'Синяк', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1961, N'Аттар Кевра', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1962, N'Воск', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1963, N'Яйцо', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1964, N'Лава', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1965, N'Аттар Митти', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1966, N'Пергамент', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1967, N'Семена льна', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1968, N'Репеллент mothball', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1969, N'Сода', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1970, N'Аттар Бакул', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1971, N'Аккорд лавы', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1972, N'Нота гари', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1973, N'Метадон', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1974, N'Высушенные цветы', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1975, N'Блеск для губ', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1976, N'Аккорд тёплой кожи', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1977, N'Холст', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1978, N'Аттар Shamama', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1979, N'Семена акации', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1980, N'Клейкая лента', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1981, N'Уксус', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1982, N'Косметический аккорд', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1983, N'Аккорд солёного воздуха', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1984, N'Аттар Motia', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1985, N'Бронза', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1986, N'Белый мак', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1987, N'Деньги', 10)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1988, N'Розовый перец (красные ягоды)', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1989, N'Бобы тонка', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1990, N'Корица', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1991, N'Черный перец', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1992, N'Шафран', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1993, N'Кардамон', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1994, N'Имбирь', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1995, N'Кориандр', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1996, N'Мускатный орех', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1997, N'Лакричник', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1998, N'Жгучий перец (чили)', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (1999, N'Гвоздика (пряность)', 11)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2000, N'Специи (пряности)', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2001, N'Анис', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2002, N'Звездчатый анис (бадьян)', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2003, N'Белый перец', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2004, N'Тмин', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2005, N'Лавр', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2006, N'Бурбонская ваниль', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2007, N'Тамаринд', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2008, N'Зира (кумин)', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2009, N'Сычуаньский перец', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2010, N'Мадагаскарская ваниль', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2011, N'Кассия (Коричник китайский)', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2012, N'Черная ваниль', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2013, N'Кунжут', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2014, N'Семена моркови', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2015, N'Куркума', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2016, N'Ямайский перец', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2017, N'Галанга', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2018, N'Асафетида', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2019, N'Паприка', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2020, N'Сумах', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2021, N'Черный кардамон', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2022, N'Пажитник (Фенугрек)', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2023, N'Анетол (Anethol)', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2024, N'Длинный перец (пипалли)', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2025, N'Мускатник душистый', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2026, N'Сафралеин (Safraleine)', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2027, N'Чатни', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2028, N'Семена петрушки', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2029, N'Оболочка мускатного ореха', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2030, N'Тосканол', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2031, N'Ажгон (Коптский тмин) ', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2032, N'Safranal (Сафраналь)', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2033, N'Чойя Накх', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2034, N'Благовоние Nag champa', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2035, N'Благовоние Египетский жасмин', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2036, N'Кава', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2037, N'Кава (перец опьяняющий)', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2038, N'Мелегетский перец', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2039, N'Мелегетский перец', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2040, N'Таману коричный альдегид', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2041, N'Халапеньо', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2042, N'Коричный сахар ', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2043, N'Isoeugenol (Изоевгенол)', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2044, N'Кунцея', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2045, N'Эспелетский перец', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2046, N'Листья перца чили', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2047, N'Евгенол', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2048, N'Пимента', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2049, N'Благовоние Кровь дракона', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2050, N'Мадагаскарский (бурбонский) перец', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2051, N'Саро (мандравасаротра)', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2052, N'Пряности масала', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2053, N'Кампотский перец', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2054, N'Умэбоси', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2055, N'Белокрыльник', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2056, N'Ротандон (Rotundone)', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2057, N'Кариофиллен', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2058, N'Перец кубеба', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2059, N'Семена сельдерея', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2060, N'Перец Тимут', 11)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2061, N'Акватический аккорд (водяной аккорд)', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2062, N'Озон', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2063, N'Мокрый асфальт', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2064, N'Дым', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2065, N'Соль', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2066, N'Бензин', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2067, N'Металлические ноты', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2068, N'Дождевая вода', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2069, N'Морская соль', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2070, N'Горный воздух', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2071, N'Асфальт', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2072, N'Песок', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2073, N'Глина', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2074, N'Известь', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2075, N'Пыль', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2076, N'Торф', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2077, N'Лёд', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2078, N'Йод', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2079, N'Солнечные ноты', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2080, N'Снег', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2081, N'Пепел', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2082, N'Роса', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2083, N'Уголь', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2084, N'Галька', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2085, N'Алюминий', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2086, N'Минералы', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2087, N'Сера', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2088, N'Соляной цветок', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2089, N'Камень тес', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2090, N'Белая глина', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2091, N'Кремень', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2092, N'Пар', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2093, N'Золото ', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2094, N'Petrichor (Петрикор)', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2095, N'Щебень', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2096, N'Медь', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2097, N'Серебро ', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2098, N'Floralozone (Флоралозон)', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2099, N'Пластик', 12)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2100, N'Ацетон ', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2101, N'Ultrazur (Ультразур)', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2102, N'Мел', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2103, N'Керосин', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2104, N'Оксид алюминия', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2105, N'Грязь', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2106, N'Везувианит', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2107, N'Сепиолит', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2108, N'Рубин', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2109, N'Известняк', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2110, N'Парафин', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2111, N'Карбон', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2112, N'Песчаник ', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2113, N'Scentenal (Сцентеналь)', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2114, N'Магма ', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2115, N'Betahydrane (Бетагидран)', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2116, N'Турмалин ', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2117, N'Transluzone (Транслюзон)', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2118, N'Кианит ', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2119, N'Liquazone (Ликвазон)', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2120, N'Латекс', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2121, N'Графит', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2122, N'Пластилин', 12)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2123, N'Ладан', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2124, N'Бензоин', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2125, N'Лабданум', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2126, N'Элеми', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2127, N'Опопанакс', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2128, N'Мирра', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2129, N'Янтарь', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2130, N'Толуанский бальзам', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2131, N'Бальзамические ноты', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2132, N'Стиракс', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2133, N'Смолы', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2134, N'Бессмертник', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2135, N'Перуанский бальзам', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2136, N'Благовония', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2137, N'Пихтовая смола (бальзам)', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2138, N'Дёготь', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2139, N'Мастиковое дерево', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2140, N'Копайский бальзам', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2141, N'Гурьюнский бальзам', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2142, N'Еловый бальзам', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2143, N'Ониха', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2144, N'Тополиные сережки', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2145, N'Копал', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2146, N'Смола мастикового дерева', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2147, N'Нулу бальзам', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2148, N'Борнеол', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2149, N'Мумиё', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2150, N'Чойя Лобан (Boswellia serrata)', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2151, N'Каучук', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2152, N'Куфи', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2153, N'Галаадский бальзам', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2154, N'Омумбири', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2155, N'Канифоль ', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2156, N'Ambrostar (Амбростар) ', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2157, N'Ambermax 50 (Амбермакс 50) ', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2158, N'Tabanone (Табанон)', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2159, N'Линдера бензойная', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2160, N'Бензилсалицилат', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2161, N'Баланитес египетский', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2162, N'Кленовая смола', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2163, N'Аккорд армянской бумаги ', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2164, N'Amberlyn (Эмберлин)', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2165, N'Сандарак', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2166, N'Саркокаулон (Свечи бушменов)', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2167, N'Хвойная нота ', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2168, N'Ambreinol (амбреинол) ', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2169, N'Ambranum (Амбранум)', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2170, N'Амбринол', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2171, N'Даммарская камедь ', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2172, N'Ambercore (Эмберкор)', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2173, N'Смола кедра ', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2174, N'Dynamone (Динамон)', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2175, N'Смола ксанторреи ', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2176, N'Sinfonide (Синфонид)', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2177, N'База Ambre 83', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2178, N'Стиракс японский', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2179, N'Копаифера', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2180, N'Драконова кровь (смола)', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2181, N'База Ambre 84', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2182, N'Миросвелия бальзам', 13)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2183, N'Мята', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2184, N'Базилик', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2185, N'Розмарин', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2186, N'Шалфей', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2187, N'Тимьян (Чабрец)', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2188, N'Камфора', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2189, N'Мелисса', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2190, N'Тархун (эстрагон, таррагон)', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2191, N'Мускатный шалфей', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2192, N'Ментол', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2193, N'Ароматический аккорд', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2194, N'Пальмароза', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2195, N'Перечная мята', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2196, N'Шисо', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2197, N'Девясил', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2198, N'Майоран', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2199, N'Укроп', 14)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2200, N'Крапива', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2201, N'Камыш', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2202, N'Фенхель', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2203, N'Болиголов', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2204, N'Чертополох', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2205, N'Орегано (майоран)', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2206, N'Петрушка', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2207, N'Зверобой', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2208, N'Иван-чай (кипрей)', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2209, N'Душица', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2210, N'Мята колосковая (кудрявая)', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2211, N'Чабер', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2212, N'Лопух', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2213, N'Борщевик', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2214, N'Щавель', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2215, N'Солома', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2216, N'Шпинат', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2217, N'Кресс-салат', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2218, N'Жеруха обыкновенная', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2219, N'Руккола', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2220, N'Мятлик', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2221, N'Пырей', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2222, N'Цветок розмарина ', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2223, N'Estragole (Эстрагол)', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2224, N'Мятные леденцы ', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2225, N'Anisaldehyde (Анисовый альдегид)', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2226, N'Миррис душистая ', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2227, N'Myroxyde (Мироксид)', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2228, N'Сальвия стройная ', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2229, N'Eucalyptol (Эвкалиптол) ', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2230, N'Canthoxal (Кантоксаль)', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2231, N'Равенсара ароматическая', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2232, N'Горец переченый', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2233, N'Рута', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2234, N'Сантолина', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2235, N'Африканский розмарин', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2236, N'Сердечник луговой', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2237, N'Душевик котовниковый', 14)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2238, N'Серая амбра', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2239, N'Цибетин', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2240, N'Анималистические ноты', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2241, N'Кастореум', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2242, N'Африканский камень (хирацеум)', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2243, N'Пчелиный воск', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2244, N'Морские раковины', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2245, N'Козья шерсть', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2246, N'Нектар', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2247, N'Скатол (Skatole)', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2248, N'Морская звезда', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2249, N'Шерсть', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2250, N'Космон (Cosmone)', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2251, N'Коралл', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2252, N'Устрицы', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2253, N'Чамиса вонючая ', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2254, N'Animalys (Анималис)', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2255, N'Дрожжи', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2256, N'Касторка ', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2257, N'Ambrocenide (Амброценид)', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2258, N'Планктон', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2259, N'Моча', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2260, N'Животный жир', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2261, N'Ликвидамбар смолоносный ', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2262, N'Wolfwood (Вольфвуд) ', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2263, N'Grisalva (Грисальва)', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2264, N'Пот', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2265, N'Говядина', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2266, N'Дуриан', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2267, N'Якобея', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2268, N'Мех ', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2269, N'Thibetone (Тибетон)', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2270, N'Козье молоко', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2271, N'Тонкитон (Tonquitone)', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2272, N'Смилакс ', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2273, N'Phenylacetic acid (фенилуксусная кислота) ', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2274, N'Aldambre (Альдамбр)', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2275, N'Скунсовая струя', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2276, N'Медовый воск', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2277, N'Маточное молочко', 15)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2278, N'Мускус', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2279, N'Мускус (белый мускус)', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2280, N'Кашмеран', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2281, N'Черный мускус', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2282, N'Мускон (Muscone)', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2283, N'Галаксолид супер (Galaxolide Super)', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2284, N'Гельветолид (Helvetolide)', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2285, N'Амбретон (Ambretone)', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2286, N'Мускенон (Muscenone)', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2287, N'Нирванолид (Nirvanolide) ', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2288, N'Sylkolide (Силколид) ', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2289, N'Tonalid (Тоналид) ', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2290, N'Exaltolide (Экзальтолид) ', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2291, N'Ambrettolide (Амбреттолид) ', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2292, N'Exaltone (Экзальтон) ', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2293, N'Serenolide (Серенолид)', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2294, N'Андростенол ', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2295, N'Vulcanolide (Вулканолид) ', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2296, N'Globalide (Глобалид) ', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2297, N'Globanone (Глобанон) ', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2298, N'Habanolide (Габанолид) ', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2299, N'Velvione (Вельвион) ', 16)
GO
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2300, N'Animalid (Анималид) ', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2301, N'Nevenolide (Невенолид) ', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2302, N'Edenolide (Эденолид)', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2303, N'Мускусный кетон ', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2304, N'Nebulone (Небулон) ', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2305, N'Moxalone (Моксалон) ', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2306, N'Silvanone Supra (Сильванон Супра) ', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2307, N'Astratone (Астратон) ', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2308, N'Muscarome (Маскаром) ', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2309, N'Silvanone (Сильванон)', 16)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2310, N'Амбра', 17)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2311, N'Амброксан', 17)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2312, N'Амброкс (Ambrox)', 17)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2313, N'Цеталокс (Cetalox)', 17)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2314, N'Орканокс (Orcanox)', 17)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2315, N'Амбер экстрем (Amber Xtreme)', 17)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2316, N'Амбраром (Ambrarome)', 17)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2317, N'Амбрамон (Ambramone)', 17)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2318, N'Кахалокс (Cachalox) ', 17)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2319, N'Ambreine (Амбреин) ', 17)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2320, N'Ambrofix (Амброфикс) ', 17)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2321, N'Amberketal (Амберкетал)', 17)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2322, N'Дубовый мох', 18)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2323, N'Земляные ноты (почва)', 18)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2324, N'Мох', 18)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2325, N'Эвернил (Evernil)', 18)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2326, N'Морской мох', 18)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2327, N'Кедровый мох', 18)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2328, N'Перегной', 18)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2329, N'Компост', 18)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2330, N'Florymoss (Флоримосс)', 18)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2331, N'Морской аккорд (морская нота)', 19)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2332, N'Калон', 19)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2333, N'Каскалон (Cascalone)', 19)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2334, N'Калипсон (Calypsone)', 19)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2335, N'Акваль (Aqual)', 19)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2336, N'Аквозон', 19)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2337, N'Кожаный аккорд', 20)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2338, N'Замша (замшевый аккорд)', 20)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2339, N'Изобутилхинолин ', 20)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2340, N'Suederal (Суедераль) ', 20)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2341, N'Pyralone (Пиралон)', 20)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2342, N'Дульсе', 21)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2343, N'Maritima (Маритима)', 21)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2344, N'Symmarine (Симмарин)', 21)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2345, N'Пудровые ноты', 22)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2346, N'Рисовая пудра', 22)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2347, N'Альфа-пинен', 23)
INSERT [dbo].[Note] ([id], [Note], [NoteGroup]) VALUES (2348, N'Торрея', 23)
SET IDENTITY_INSERT [dbo].[Note] OFF
GO
SET IDENTITY_INSERT [dbo].[NoteClass] ON 

INSERT [dbo].[NoteClass] ([id], [Class]) VALUES (1, N'Верхние ноты')
INSERT [dbo].[NoteClass] ([id], [Class]) VALUES (2, N'Средние ноты')
INSERT [dbo].[NoteClass] ([id], [Class]) VALUES (3, N'Базовые ноты')
SET IDENTITY_INSERT [dbo].[NoteClass] OFF
GO
SET IDENTITY_INSERT [dbo].[NoteGroup] ON 

INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (1, N'Цитрусовые', N'/Resources/AromasGroups/Цитрусовые.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (2, N'Фруктовые', N'/Resources/AromasGroups/Фруктовые.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (3, N'Цветочные', N'/Resources/AromasGroups/Цветочные.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (4, N'Белоцветочные', N'/Resources/AromasGroups/Белоцветочные.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (5, N'Зеленые', N'/Resources/AromasGroups/Зеленые.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (6, N'Древесные', N'/Resources/AromasGroups/Древесные.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (7, N'Гурманские', N'/Resources/AromasGroups/Гурманские.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (8, N'Сладкие', N'/Resources/AromasGroups/Сладкие.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (9, N'Напитки', N'/Resources/AromasGroups/Напитки.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (10, N'Фантазийные', N'/Resources/AromasGroups/Фантазийные.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (11, N'Пряные', N'/Resources/AromasGroups/Пряные.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (12, N'Минеральные', N'/Resources/AromasGroups/Минеральные.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (13, N'Бальзамические', N'/Resources/AromasGroups/Бальзамические.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (14, N'Ароматические', N'/Resources/AromasGroups/Ароматические.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (15, N'Животные', N'/Resources/AromasGroups/Животные.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (16, N'Мускусные', N'/Resources/AromasGroups/Мускусные.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (17, N'Амбровые', N'/Resources/AromasGroups/Амбровые.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (18, N'Землистые / Мшистые', N'/Resources/AromasGroups/ЗемлистыеМшистые.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (19, N'Акватические', N'/Resources/AromasGroups/Акватические.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (20, N'Кожаные', N'/Resources/AromasGroups/Кожаные.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (21, N'Морские', N'/Resources/AromasGroups/Морские.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (22, N'Хвойные', N'/Resources/AromasGroups/Хвойные.jpg')
INSERT [dbo].[NoteGroup] ([id], [NoteGroup], [Image]) VALUES (23, N'Пудровые', N'/Resources/AromasGroups/Пудровые.jpg')
SET IDENTITY_INSERT [dbo].[NoteGroup] OFF
GO
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (1, 1, 1992)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (1, 1, 1990)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (1, 1, 2123)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (1, 1, 1996)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (1, 1, 1007)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (1, 1, 60)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (1, 2, 1004)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (1, 2, 301)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (1, 2, 2337)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (1, 2, 1006)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (1, 2, 677)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (1, 3, 2310)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (1, 3, 2010)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (1, 3, 1005)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (1, 3, 2279)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (2, 1, 1)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (2, 1, 4)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (2, 1, 681)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (2, 1, 314)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (2, 1, 57)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (2, 2, 273)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (2, 2, 677)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (2, 2, 305)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (2, 3, 2310)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (2, 3, 2278)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (2, 3, 1006)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (2, 3, 1039)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (3, 1, 6)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (3, 1, 2185)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (3, 1, 681)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (3, 2, 1290)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (3, 2, 1989)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (3, 3, 2337)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (3, 3, 1014)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (3, 3, 1006)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (4, 1, 3)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (4, 1, 1995)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (4, 1, 2184)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (4, 2, 1994)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (4, 2, 1993)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (4, 2, 743)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (4, 3, 2310)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (4, 3, 1012)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (4, 3, 1008)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (5, 1, 1)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (5, 1, 7)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (5, 1, 4)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (5, 1, 2)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (5, 1, 666)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (5, 1, 1993)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (5, 2, 1010)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (5, 2, 610)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (5, 2, 1991)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (5, 2, 699)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (5, 2, 94)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (5, 3, 1005)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (5, 3, 2337)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (5, 3, 1499)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (5, 3, 2133)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (5, 3, 1004)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (6, 1, 1081)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (6, 1, 715)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (6, 1, 1007)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (6, 1, 1993)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (6, 1, 2059)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (6, 1, 700)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (6, 2, 4)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (6, 2, 1020)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (6, 2, 2)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (6, 2, 693)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (6, 2, 1036)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (6, 2, 694)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (6, 3, 1006)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (6, 3, 2123)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (6, 3, 218)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (6, 3, 2139)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (6, 3, 1289)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (7, 1, 1663)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (7, 2, 1989)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (7, 2, 1991)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (7, 2, 1988)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (7, 2, 2337)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (7, 3, 1023)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (7, 3, 1004)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (9, 1, 1971)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (9, 2, 1964)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (9, 2, 1077)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (9, 3, 1897)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (9, 3, 1972)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (10, 1, 70)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (10, 2, 72)
INSERT [dbo].[NoteInAroma] ([Aroma], [NoteClass], [Note]) VALUES (10, 3, 66)
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([id], [Customer], [OrderDate], [Address], [TotalPrice]) VALUES (1, 4, CAST(N'2024-01-01T00:00:00.000' AS DateTime), N'Wall Street, 14', 32000)
INSERT [dbo].[Order] ([id], [Customer], [OrderDate], [Address], [TotalPrice]) VALUES (2, 9, CAST(N'2023-12-14T19:49:35.753' AS DateTime), N'test', 5000)
INSERT [dbo].[Order] ([id], [Customer], [OrderDate], [Address], [TotalPrice]) VALUES (3, 9, CAST(N'2023-12-15T13:30:18.413' AS DateTime), N'фывмфмвы', 800)
INSERT [dbo].[Order] ([id], [Customer], [OrderDate], [Address], [TotalPrice]) VALUES (4, 9, CAST(N'2023-12-17T14:13:12.920' AS DateTime), N'Адрес - Заказ всех миниатюр', 17300)
INSERT [dbo].[Order] ([id], [Customer], [OrderDate], [Address], [TotalPrice]) VALUES (7, 1, CAST(N'2024-05-23T09:29:06.853' AS DateTime), N'TEST LAVA', 2000)
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
INSERT [dbo].[OrderInfo] ([id], [Product], [Quantity]) VALUES (1, 3, 1)
INSERT [dbo].[OrderInfo] ([id], [Product], [Quantity]) VALUES (2, 1, 2)
INSERT [dbo].[OrderInfo] ([id], [Product], [Quantity]) VALUES (3, 19, 1)
INSERT [dbo].[OrderInfo] ([id], [Product], [Quantity]) VALUES (4, 1, 1)
INSERT [dbo].[OrderInfo] ([id], [Product], [Quantity]) VALUES (4, 4, 1)
INSERT [dbo].[OrderInfo] ([id], [Product], [Quantity]) VALUES (4, 7, 1)
INSERT [dbo].[OrderInfo] ([id], [Product], [Quantity]) VALUES (7, 28, 1)
INSERT [dbo].[OrderInfo] ([id], [Product], [Quantity]) VALUES (4, 10, 1)
INSERT [dbo].[OrderInfo] ([id], [Product], [Quantity]) VALUES (4, 13, 1)
INSERT [dbo].[OrderInfo] ([id], [Product], [Quantity]) VALUES (4, 16, 1)
INSERT [dbo].[OrderInfo] ([id], [Product], [Quantity]) VALUES (4, 19, 1)
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (1, 5, 3, 1, 1, 2500)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (2, 5, 3, 1, 4, 22000)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (3, 5, 3, 1, 5, 32000)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (4, 4, 1, 2, 1, 2400)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (5, 4, 1, 2, 3, 12000)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (6, 4, 1, 2, 4, 18000)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (7, 3, 2, 3, 3, 4600)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (8, 3, 2, 3, 4, 6400)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (9, 3, 2, 3, 5, 12000)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (10, 3, 3, 4, 1, 2200)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (11, 3, 3, 4, 2, 6000)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (12, 3, 3, 4, 3, 11200)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (13, 4, 1, 5, 1, 2000)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (14, 4, 1, 5, 2, 5000)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (15, 4, 1, 5, 3, 9600)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (16, 4, 2, 6, 3, 2800)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (17, 4, 2, 6, 4, 4600)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (18, 4, 2, 6, 5, 8800)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (19, 3, 3, 7, 1, 800)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (20, 3, 3, 7, 3, 3200)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (21, 3, 3, 7, 4, 5500)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (22, 3, 3, 7, 5, 9800)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (28, 5, 2, 9, 1, 2000)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (29, 5, 2, 9, 2, 5500)
INSERT [dbo].[Product] ([id], [ProductType], [ProductCategory], [Aroma], [Volume], [Price]) VALUES (30, 3, 1, 10, 1, 1800)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductCategory] ON 

INSERT [dbo].[ProductCategory] ([id], [Category]) VALUES (1, N'Женский')
INSERT [dbo].[ProductCategory] ([id], [Category]) VALUES (2, N'Мужской')
INSERT [dbo].[ProductCategory] ([id], [Category]) VALUES (3, N'Унисекс')
SET IDENTITY_INSERT [dbo].[ProductCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductType] ON 

INSERT [dbo].[ProductType] ([id], [Type]) VALUES (1, N'Душистая вода')
INSERT [dbo].[ProductType] ([id], [Type]) VALUES (2, N'Одеколон')
INSERT [dbo].[ProductType] ([id], [Type]) VALUES (3, N'Туалетная вода')
INSERT [dbo].[ProductType] ([id], [Type]) VALUES (4, N'Парфюмерная вода')
INSERT [dbo].[ProductType] ([id], [Type]) VALUES (5, N'Духи')
SET IDENTITY_INSERT [dbo].[ProductType] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([id], [Role]) VALUES (1, N'Администратор')
INSERT [dbo].[Role] ([id], [Role]) VALUES (2, N'Пользователь')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([id], [Login], [Password], [Role]) VALUES (1, N'admin', N'1', 1)
INSERT [dbo].[User] ([id], [Login], [Password], [Role]) VALUES (2, N'user1', N'1', 2)
INSERT [dbo].[User] ([id], [Login], [Password], [Role]) VALUES (3, N'user2', N'2', 2)
INSERT [dbo].[User] ([id], [Login], [Password], [Role]) VALUES (4, N'user3', N'3', 2)
INSERT [dbo].[User] ([id], [Login], [Password], [Role]) VALUES (5, N'mike', N'mike', 2)
INSERT [dbo].[User] ([id], [Login], [Password], [Role]) VALUES (6, N'john', N'john', 2)
INSERT [dbo].[User] ([id], [Login], [Password], [Role]) VALUES (7, N'jack', N'jack', 2)
INSERT [dbo].[User] ([id], [Login], [Password], [Role]) VALUES (8, N'steve', N'steve', 2)
INSERT [dbo].[User] ([id], [Login], [Password], [Role]) VALUES (9, N'martin', N'martin', 2)
INSERT [dbo].[User] ([id], [Login], [Password], [Role]) VALUES (10, N'henry', N'henry', 2)
INSERT [dbo].[User] ([id], [Login], [Password], [Role]) VALUES (11, N'connor', N'connor', 2)
INSERT [dbo].[User] ([id], [Login], [Password], [Role]) VALUES (12, N'adam', N'adam', 2)
INSERT [dbo].[User] ([id], [Login], [Password], [Role]) VALUES (13, N'george', N'1', 2)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[Volume] ON 

INSERT [dbo].[Volume] ([id], [Volume]) VALUES (1, 5)
INSERT [dbo].[Volume] ([id], [Volume]) VALUES (2, 15)
INSERT [dbo].[Volume] ([id], [Volume]) VALUES (3, 30)
INSERT [dbo].[Volume] ([id], [Volume]) VALUES (4, 50)
INSERT [dbo].[Volume] ([id], [Volume]) VALUES (5, 100)
SET IDENTITY_INSERT [dbo].[Volume] OFF
GO
ALTER TABLE [dbo].[AromaGroupInAroma]  WITH CHECK ADD  CONSTRAINT [FK__AromasGro__Aroma__403A8C7D] FOREIGN KEY([Aroma])
REFERENCES [dbo].[Aroma] ([id])
GO
ALTER TABLE [dbo].[AromaGroupInAroma] CHECK CONSTRAINT [FK__AromasGro__Aroma__403A8C7D]
GO
ALTER TABLE [dbo].[AromaGroupInAroma]  WITH CHECK ADD  CONSTRAINT [FK__AromasGro__Aroma__534D60F1] FOREIGN KEY([AromaGroup])
REFERENCES [dbo].[AromaGroup] ([id])
GO
ALTER TABLE [dbo].[AromaGroupInAroma] CHECK CONSTRAINT [FK__AromasGro__Aroma__534D60F1]
GO
ALTER TABLE [dbo].[Basket]  WITH CHECK ADD  CONSTRAINT [FK__Baskets__Custome__4E88ABD4] FOREIGN KEY([Customer])
REFERENCES [dbo].[Customer] ([id])
GO
ALTER TABLE [dbo].[Basket] CHECK CONSTRAINT [FK__Baskets__Custome__4E88ABD4]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Users] FOREIGN KEY([Login])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customers_Users]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Users] FOREIGN KEY([Login])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employees_Users]
GO
ALTER TABLE [dbo].[Favorite]  WITH CHECK ADD  CONSTRAINT [FK__Favorites__Custo__5165187F] FOREIGN KEY([Customer])
REFERENCES [dbo].[Customer] ([id])
GO
ALTER TABLE [dbo].[Favorite] CHECK CONSTRAINT [FK__Favorites__Custo__5165187F]
GO
ALTER TABLE [dbo].[Note]  WITH CHECK ADD  CONSTRAINT [FK__Notes__NoteGroup__34C8D9D1] FOREIGN KEY([NoteGroup])
REFERENCES [dbo].[NoteGroup] ([id])
GO
ALTER TABLE [dbo].[Note] CHECK CONSTRAINT [FK__Notes__NoteGroup__34C8D9D1]
GO
ALTER TABLE [dbo].[NoteInAroma]  WITH CHECK ADD  CONSTRAINT [FK__NotesInAr__Aroma__44FF419A] FOREIGN KEY([Aroma])
REFERENCES [dbo].[Aroma] ([id])
GO
ALTER TABLE [dbo].[NoteInAroma] CHECK CONSTRAINT [FK__NotesInAr__Aroma__44FF419A]
GO
ALTER TABLE [dbo].[NoteInAroma]  WITH CHECK ADD  CONSTRAINT [FK__NotesInAr__NoteC__5441852A] FOREIGN KEY([NoteClass])
REFERENCES [dbo].[NoteClass] ([id])
GO
ALTER TABLE [dbo].[NoteInAroma] CHECK CONSTRAINT [FK__NotesInAr__NoteC__5441852A]
GO
ALTER TABLE [dbo].[NoteInAroma]  WITH CHECK ADD  CONSTRAINT [FK__NotesInAro__Note__3B75D760] FOREIGN KEY([Note])
REFERENCES [dbo].[Note] ([id])
GO
ALTER TABLE [dbo].[NoteInAroma] CHECK CONSTRAINT [FK__NotesInAro__Note__3B75D760]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK__Orders__Customer__47DBAE45] FOREIGN KEY([Customer])
REFERENCES [dbo].[Customer] ([id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK__Orders__Customer__47DBAE45]
GO
ALTER TABLE [dbo].[OrderInfo]  WITH CHECK ADD  CONSTRAINT [FK__OrdersInf__Produ__571DF1D5] FOREIGN KEY([Product])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[OrderInfo] CHECK CONSTRAINT [FK__OrdersInf__Produ__571DF1D5]
GO
ALTER TABLE [dbo].[OrderInfo]  WITH CHECK ADD  CONSTRAINT [FK__OrdersInfo__id__5812160E] FOREIGN KEY([id])
REFERENCES [dbo].[Order] ([id])
GO
ALTER TABLE [dbo].[OrderInfo] CHECK CONSTRAINT [FK__OrdersInfo__id__5812160E]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK__Products__Aroma__4AB81AF0] FOREIGN KEY([Aroma])
REFERENCES [dbo].[Aroma] ([id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK__Products__Aroma__4AB81AF0]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK__Products__Produc__59FA5E80] FOREIGN KEY([ProductType])
REFERENCES [dbo].[ProductType] ([id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK__Products__Produc__59FA5E80]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK__Products__Produc__5AEE82B9] FOREIGN KEY([ProductCategory])
REFERENCES [dbo].[ProductCategory] ([id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK__Products__Produc__5AEE82B9]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK__Products__Volume__46E78A0C] FOREIGN KEY([Volume])
REFERENCES [dbo].[Volume] ([id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK__Products__Volume__46E78A0C]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK__Users__Role__267ABA7A] FOREIGN KEY([Role])
REFERENCES [dbo].[Role] ([id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK__Users__Role__267ABA7A]
GO
/****** Object:  StoredProcedure [dbo].[AddAroma]    Script Date: 04.06.2024 5:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[AddAroma]
(
	@Aroma nvarchar(64),
	@Description nvarchar(512),
	@AromaGroup nvarchar(32)
)
as
begin

	declare @AromaId int
	set @AromaId = (select id from Aroma
	where Aroma = @Aroma)
	
	if (ISNULL(@AromaId, 0) = 0)
	begin
		insert into [dbo].[Aroma](Aroma,[dbo].[Aroma].Description)
	values (@Aroma,@Description)
	end;

	set @AromaId = (select id from Aroma
	where Aroma = @Aroma)

	declare @AromaGroupId int
	set @AromaGroupId = (select id from AromaGroup 
	where AromaGroup = @AromaGroup)

	insert into [dbo].[AromaGroupInAroma]
	values (@AromaId, @AromaGroupId)

end
GO
/****** Object:  StoredProcedure [dbo].[AddNoteToAroma]    Script Date: 04.06.2024 5:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[AddNoteToAroma]
(
	@Aroma nvarchar(64),
	@NoteClassId int,
	@NoteId int
)
as
begin
	declare @AromaId int
	set @AromaId = (select id from Aroma
	where Aroma = @Aroma)

	insert into [dbo].[NoteInAroma]
	values (@AromaId, @NoteClassId, @NoteId)
end
GO
/****** Object:  StoredProcedure [dbo].[AddProductToAroma]    Script Date: 04.06.2024 5:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[AddProductToAroma]
(
	@ProductTypeId int,
	@ProductCategoryId int,
	@AromaId int,
	@VolumeId int,
	@Price int
)
as
begin

	declare @ProductExists int
	set @ProductExists = (select id from Product 
	where Aroma = @AromaId and ProductType = @ProductTypeId and Volume = @VolumeId)

	if (ISNULL(@ProductExists,0) = 0)
	begin
		insert into [dbo].[Product]([ProductType],
		[ProductCategory],[Aroma],[Volume],[Price])
		values (@ProductTypeId, @ProductCategoryId,@AromaId,@VolumeId,@Price)
	end

end;
GO
/****** Object:  StoredProcedure [dbo].[AddProductToBasket]    Script Date: 04.06.2024 5:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[AddProductToBasket]
(
@userId int,
@productId int
)
as
begin

declare @cId int
set @cId = (select C.id from Customer C
join dbo.[User] U on U.id = C.Login
where U.id = @userId)

declare @q int
set @q = 0
set @q = @q + ISNULL((select Quantity from Basket B
join Customer C on C.id = B.Customer
join dbo.[User] U on U.id = C.Login
where U.id = @userId
and B.ProductId = @productId),0)

if (@q = 0)
begin
insert into Basket
values (@cId, @productId, 1)
end;

else
begin
update Basket
set Quantity = Quantity + 1
where Customer = @cId
and ProductId = @productId
end;

end;
GO
/****** Object:  StoredProcedure [dbo].[CreateOrder]    Script Date: 04.06.2024 5:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[CreateOrder]
(
@userId int,
@date Datetime,
@address nvarchar(255)
)
as
begin

declare @cId int
set @cId = (select C.id from Customer C
join dbo.[User] U on U.id = C.Login
where U.id = @userId)

insert into dbo.[Order](Customer, OrderDate, Address, TotalPrice)
values
(@cId, @date, @address, 0)

declare @oId int
set @oId = (select id from dbo.[Order]
where Customer = @cId
and OrderDate = @date
and Address = @address
and TotalPrice = 0)

end;
GO
/****** Object:  StoredProcedure [dbo].[CreateOrderInfo]    Script Date: 04.06.2024 5:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[CreateOrderInfo]
(
@orderId int,
@productId int,
@quantity int
)
as 
begin

declare @cId int
set @cId = (select Customer from dbo.[Order]
where id = @orderId)

insert into OrderInfo
values
(@orderId, @productId, @quantity)

declare @totalPrice int
set @totalPrice = (select Price from Product
where id = @productId) * @quantity

update dbo.[Order]
set TotalPrice = TotalPrice + @totalPrice
where id = @orderId

delete from Basket
where Customer = @cId
and ProductId = @productId

end;
GO
/****** Object:  StoredProcedure [dbo].[DeleteFromBasket]    Script Date: 04.06.2024 5:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[DeleteFromBasket]
(
@userId int,
@productId int
)
as 
begin

declare @cId int
set @cId = (select C.id from Customer C
join dbo.[User] U on U.id = C.Login
where U.id = @userId)

delete from Basket
where Customer = @cId
and ProductId = @productId

end;
GO
/****** Object:  StoredProcedure [dbo].[EditUser]    Script Date: 04.06.2024 5:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[EditUser]
(
@id int,
@login nvarchar(32),
@password nvarchar(32),
@f nvarchar(32),
@m nvarchar(32),
@l nvarchar(32),
@email nvarchar(32),
@phone nvarchar(32)
)
as begin

update Customer
set FirstName = @f
where id = @id

update Customer
set MiddleName = @m
where id = @id

update Customer
set LastName = @l
where id = @id

update Customer
set Email = @email
where id = @id

update Customer
set Phone = @phone
where id = @id

update dbo.[User]
set Password = @password
where Login = @login

end;
GO
/****** Object:  StoredProcedure [dbo].[EditUserWithoutPassword]    Script Date: 04.06.2024 5:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[EditUserWithoutPassword]
(
@id int,
@f nvarchar(32),
@m nvarchar(32),
@l nvarchar(32),
@email nvarchar(32),
@phone nvarchar(32)
)
as begin

update Customer
set FirstName = @f
where id = @id

update Customer
set MiddleName = @m
where id = @id

update Customer
set LastName = @l
where id = @id

update Customer
set Email = @email
where id = @id

update Customer
set Phone = @phone
where id = @id

end;
GO
/****** Object:  StoredProcedure [dbo].[MarkAsFavorite]    Script Date: 04.06.2024 5:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[MarkAsFavorite]
(
@userId int,
@aroma nvarchar(64)
)
as
begin

declare @customerId int
set @customerId = (select C.id from Customer C
join dbo.[User] U on U.id = C.Login
where U.id = @userId)

declare @aromaId int
set @aromaId = (select A.id from Aroma A
where A.Aroma = @aroma)

if exists(
select TOP(1) F.Customer, F.AromaId from Favorite F
join Aroma A on A.id = F.AromaId
join Product P on P.Aroma = A.id
join Customer C on C.id = F.Customer
join dbo.[User] U on U.id = C.Login
where U.id = @userId
and A.Aroma = @aroma
)
begin


delete from Favorite
where Customer = @customerId
and AromaId = @aromaId
end;

else
begin

insert into Favorite values
(@customerId, @aromaId)

end;
end;
GO
/****** Object:  StoredProcedure [dbo].[RegisterNewUser]    Script Date: 04.06.2024 5:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[RegisterNewUser]
(
@login nvarchar(32),
@password nvarchar(32),
@f nvarchar(32),
@m nvarchar(32),
@l nvarchar(32),
@email nvarchar(32),
@phone nvarchar(32)
)
as begin

if not exists(
select * from [dbo].[Customer]
where [FirstName] = @f
and [MiddleName] = @m
and [LastName] = @l)
begin

if not exists(
select * from [dbo].[User]
where Login = @login)
begin

insert into [dbo].[User]([Login],[Password],[Role])
values (@login, @password, 2)

declare @userId int
set @userId = (select id from [dbo].[User] 
where Login = @Login)

insert into [dbo].[Customer]([FirstName],[MiddleName],[LastName],[Email],[Phone],[Login])
values (@f,@m,@l,@email,@phone,@userId)

end;
end;
end;
GO
USE [master]
GO
ALTER DATABASE [PerfumeSalon1] SET  READ_WRITE 
GO
