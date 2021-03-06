USE [master]
GO
/****** Object:  Database [Yellow Moon Shop]    Script Date: 10/18/2020 4:06:55 PM ******/
CREATE DATABASE [Yellow Moon Shop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Yellow Moon Shop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Yellow Moon Shop.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Yellow Moon Shop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Yellow Moon Shop_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Yellow Moon Shop] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Yellow Moon Shop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Yellow Moon Shop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Yellow Moon Shop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Yellow Moon Shop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Yellow Moon Shop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Yellow Moon Shop] SET ARITHABORT OFF 
GO
ALTER DATABASE [Yellow Moon Shop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Yellow Moon Shop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Yellow Moon Shop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Yellow Moon Shop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Yellow Moon Shop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Yellow Moon Shop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Yellow Moon Shop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Yellow Moon Shop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Yellow Moon Shop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Yellow Moon Shop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Yellow Moon Shop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Yellow Moon Shop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Yellow Moon Shop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Yellow Moon Shop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Yellow Moon Shop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Yellow Moon Shop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Yellow Moon Shop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Yellow Moon Shop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Yellow Moon Shop] SET  MULTI_USER 
GO
ALTER DATABASE [Yellow Moon Shop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Yellow Moon Shop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Yellow Moon Shop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Yellow Moon Shop] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Yellow Moon Shop] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Yellow Moon Shop]
GO
/****** Object:  Table [dbo].[tblCategory]    Script Date: 10/18/2020 4:06:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategory](
	[categoryID] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tblCategory] PRIMARY KEY CLUSTERED 
(
	[categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblLog]    Script Date: 10/18/2020 4:06:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLog](
	[logID] [uniqueidentifier] NOT NULL CONSTRAINT [DF__tblLog__logID__38996AB5]  DEFAULT (newid()),
	[userID] [nvarchar](50) NOT NULL,
	[productID] [uniqueidentifier] NOT NULL,
	[date] [date] NOT NULL,
 CONSTRAINT [PK__tblLog__7839F62D6365AAA5] PRIMARY KEY CLUSTERED 
(
	[logID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblOrder]    Script Date: 10/18/2020 4:06:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrder](
	[orderID] [nvarchar](50) NOT NULL,
	[userID] [nvarchar](50) NULL,
	[total] [int] NOT NULL,
	[date] [date] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[address] [nvarchar](max) NOT NULL,
	[phoneNumber] [nvarchar](50) NOT NULL,
	[paymentMethod] [nvarchar](50) NOT NULL,
	[paymentStatus] [int] NOT NULL,
 CONSTRAINT [PK_tblOrder] PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblOrderDetail]    Script Date: 10/18/2020 4:06:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrderDetail](
	[orderDetailID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_tblOrderDetail_orderDetailID]  DEFAULT (newid()),
	[productID] [uniqueidentifier] NOT NULL,
	[price] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[orderID] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tblOrderDetail] PRIMARY KEY CLUSTERED 
(
	[orderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblProduct]    Script Date: 10/18/2020 4:06:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProduct](
	[productID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_tblProduct_productID]  DEFAULT (newid()),
	[name] [nvarchar](50) NOT NULL,
	[image] [nvarchar](max) NULL,
	[description] [nvarchar](max) NULL,
	[price] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[createDate] [date] NOT NULL,
	[expirationDate] [date] NOT NULL,
	[categoryID] [nvarchar](50) NOT NULL,
	[status] [int] NOT NULL,
 CONSTRAINT [PK_tblProduct] PRIMARY KEY CLUSTERED 
(
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblRole]    Script Date: 10/18/2020 4:06:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRole](
	[roleID] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblRole] PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblStatus]    Script Date: 10/18/2020 4:06:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblStatus](
	[statusID] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tblStatus] PRIMARY KEY CLUSTERED 
(
	[statusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 10/18/2020 4:06:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[userID] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NULL,
	[roleID] [nvarchar](50) NOT NULL,
	[phone] [nvarchar](50) NULL,
	[address] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[tblCategory] ([categoryID], [name]) VALUES (N'C01', N'Baked moon cake')
INSERT [dbo].[tblCategory] ([categoryID], [name]) VALUES (N'C02', N'Snow skin moon cake')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'7575af4f-55ca-4795-86e1-08555ba3917b', N'SE140996', N'2f544d22-25ed-42b9-9a78-3189cb9a4fa7', CAST(N'2020-10-18' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'e6c78737-6347-4413-a6e1-138f7fdce403', N'SE140996', N'96da0995-50dc-4963-9cc0-0ca1b68fd6a6', CAST(N'2020-10-18' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'ff44c26f-bad5-4a67-b313-20587d9ea4b3', N'SE140996', N'caff18b6-119f-4b61-bc53-00ac1585a598', CAST(N'2020-10-09' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'1f16f8c0-ad91-4290-bd08-25faea1cb8f0', N'SE140996', N'5522c9c9-2c5e-4625-bfc8-d8a7d9a3811d', CAST(N'2020-10-18' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'11a9e66b-6e46-449b-bc45-599394a627be', N'SE140996', N'54decdec-b981-42c3-b20a-b2915f93d5ad', CAST(N'2020-10-15' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'bc15fd4b-3ecd-4b7e-bed7-5d2e2278a340', N'SE140996', N'f5933fd1-00fd-4e19-8eb7-268191038d75', CAST(N'2020-10-13' AS Date))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [date]) VALUES (N'9a3849ca-d500-49ec-9ebb-bf0320f64966', N'SE140996', N'c237fe9a-fb65-4879-9dd0-ccf0deb48c00', CAST(N'2020-10-09' AS Date))
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [address], [phoneNumber], [paymentMethod], [paymentStatus]) VALUES (N'1602495353213', NULL, 2750000, CAST(N'2020-10-12' AS Date), N'Nguyen Van Hung', N'Buon Ma Thuot', N'0909090', N'Cash', 4)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [address], [phoneNumber], [paymentMethod], [paymentStatus]) VALUES (N'1602495777856', N'SE140995', 800000, CAST(N'2020-10-12' AS Date), N'Nguyen Van Son', N'Buon Ma Thuot', N'0945513679', N'Cash', 4)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [address], [phoneNumber], [paymentMethod], [paymentStatus]) VALUES (N'1602496029298', NULL, 1975000, CAST(N'2020-10-12' AS Date), N'Nguyen Van Son', N'Ho Chi Minh', N'092748319', N'Cash', 4)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [address], [phoneNumber], [paymentMethod], [paymentStatus]) VALUES (N'1602499312315', NULL, 2500000, CAST(N'2020-10-12' AS Date), N'Thi Ly Vu', N'Da Nang city', N'096789678', N'Cash', 4)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [address], [phoneNumber], [paymentMethod], [paymentStatus]) VALUES (N'1602499762142', N'SE140995', 2000000, CAST(N'2020-10-12' AS Date), N'Nguyen Van Son', N'Buon Ma Thuot city', N'09455455', N'Cash', 4)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [address], [phoneNumber], [paymentMethod], [paymentStatus]) VALUES (N'1602578405461', N'SE140995', 4200000, CAST(N'2020-10-13' AS Date), N'Nguyen Van Son', N'Ho Chi Minh', N'0945512345', N'Cash', 4)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [address], [phoneNumber], [paymentMethod], [paymentStatus]) VALUES (N'1602580597801', NULL, 20700000, CAST(N'2020-10-13' AS Date), N'Nguyen Hoang Minh Tu', N'Thu Duc, Ho Chi Minh', N'0914148921', N'Cash', 4)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [address], [phoneNumber], [paymentMethod], [paymentStatus]) VALUES (N'1602580621304', N'SE140995', 9300000, CAST(N'2020-10-13' AS Date), N'Nguyen Van Son', N'Buon Ma Thuot', N'0945513679', N'Cash', 4)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [address], [phoneNumber], [paymentMethod], [paymentStatus]) VALUES (N'1602584642790', NULL, 5200000, CAST(N'2020-10-13' AS Date), N'Tran Kim Lien', N'Dong Tam, Buon Ma Thuot', N'092831939', N'Cash', 4)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [address], [phoneNumber], [paymentMethod], [paymentStatus]) VALUES (N'1602585664627', NULL, 800000, CAST(N'2020-10-13' AS Date), N'Nguyen Thi Quy', N'Duy Hoa, Buon Ma Thuot', N'08232831', N'Cash', 4)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [address], [phoneNumber], [paymentMethod], [paymentStatus]) VALUES (N'1602585938977', NULL, 5600000, CAST(N'2020-10-13' AS Date), N'Ngo Diem Quynh', N'Ho Chi Minh', N'087642733', N'Cash', 4)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [address], [phoneNumber], [paymentMethod], [paymentStatus]) VALUES (N'1602586383381', NULL, 1075000, CAST(N'2020-10-13' AS Date), N'Ngo Thu Huong', N'Ha Noi', N'0831233123', N'Cash', 4)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [address], [phoneNumber], [paymentMethod], [paymentStatus]) VALUES (N'1602586578764', NULL, 5020000, CAST(N'2020-10-13' AS Date), N'Anthony Phan', N'America', N'023123124', N'Cash', 4)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [address], [phoneNumber], [paymentMethod], [paymentStatus]) VALUES (N'1602650127003', NULL, 1775000, CAST(N'2020-10-14' AS Date), N'Cao Ngoc Nhat Vy', N'Thu Duc, Ho Chi Minh', N'0857621372', N'Cash', 4)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [address], [phoneNumber], [paymentMethod], [paymentStatus]) VALUES (N'1602752924574', N'SE140995', 4355000, CAST(N'2020-10-15' AS Date), N'Nguyen Van Son', N'Buon Ma Thuot city', N'094554263', N'Cash', 4)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [address], [phoneNumber], [paymentMethod], [paymentStatus]) VALUES (N'1603004364777', N'SE140995', 2100000, CAST(N'2020-10-18' AS Date), N'Nguyen Van Son', N'Buon Ma Thuot', N'0909090', N'Cash', 4)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [address], [phoneNumber], [paymentMethod], [paymentStatus]) VALUES (N'1603004629676', N'1314944815516021', 3320000, CAST(N'2020-10-18' AS Date), N'Hùng Nguyễn', N'Buon Ma Thuot city', N'0914148921', N'Cash', 4)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [address], [phoneNumber], [paymentMethod], [paymentStatus]) VALUES (N'1603010002825', NULL, 1190000, CAST(N'2020-10-18' AS Date), N'Thanh Lam', N'Ha Noi', N'034924882', N'Cash', 4)
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [date], [name], [address], [phoneNumber], [paymentMethod], [paymentStatus]) VALUES (N'1603010104985', N'1314944815516021', 2770000, CAST(N'2020-10-18' AS Date), N'Hùng Nguyễn', N'Buon Ma Thuot city', N'09239488', N'Cash', 4)
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'1718d421-3669-45f8-a448-032f66182c95', N'd400c3b6-fb05-43ad-831b-9aa51f8e16ba', 250000, 2, N'1602495777856')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'03d07af6-e950-40a9-867d-035a6be7ae5b', N'f4d04113-d54d-4881-8df1-9778884bb395', 150000, 5, N'1603010002825')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'03313d3d-1789-4b7a-8049-06136e63f3bb', N'caff18b6-119f-4b61-bc53-00ac1585a598', 210000, 5, N'1603010104985')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'41fbc373-475a-4042-97d1-07b34652e145', N'caff18b6-119f-4b61-bc53-00ac1585a598', 210000, 10, N'1602584642790')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'07a63c33-f5d8-4e76-8f5c-0abf044807ac', N'd400c3b6-fb05-43ad-831b-9aa51f8e16ba', 250000, 2, N'1602585664627')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'e51a383d-2444-4584-ac21-0c0835d8105c', N'9d906c21-8f9d-4f2b-8c01-ad707786cc15', 175000, 2, N'1602584642790')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'8a586737-458d-4c48-8d35-0e0a1ec698ce', N'f4d04113-d54d-4881-8df1-9778884bb395', 150000, 10, N'1602580621304')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'e27aad31-8a99-42ce-8eb2-1b4136c98fe4', N'd400c3b6-fb05-43ad-831b-9aa51f8e16ba', 250000, 2, N'1602650127003')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'370687d3-8578-4987-b2aa-1d0b3f761efc', N'caff18b6-119f-4b61-bc53-00ac1585a598', 210000, 5, N'1602650127003')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'28e90513-5c89-410c-a2a6-29294e7625d1', N'f4d04113-d54d-4881-8df1-9778884bb395', 150000, 2, N'1602495353213')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'17a66195-2ab2-4dc9-8207-2b69c93b009f', N'd7e8a758-af1f-4355-be91-70f2e921281e', 170000, 10, N'1602580597801')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'eca8e6b6-72df-4ec6-adc4-37ea9861d631', N'd7e8a758-af1f-4355-be91-70f2e921281e', 170000, 10, N'1602578405461')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'c6360b8d-e4de-44e2-a6eb-39fda83a3170', N'f4d04113-d54d-4881-8df1-9778884bb395', 150000, 10, N'1602752924574')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'3edb3bb1-acad-45ba-a7b1-3abdc07afac0', N'392601c6-2288-4fbd-85d0-b3b3102f6f75', 120000, 1, N'1603010104985')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'b1b113a4-83e6-4063-b2e9-3de8455bd70d', N'd400c3b6-fb05-43ad-831b-9aa51f8e16ba', 250000, 1, N'1603010002825')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'2c9165a1-39ad-4720-b0cc-4115bb0afa6d', N'1191bba4-56a7-4377-9e91-ef4978d5c9fc', 190000, 1, N'1603010002825')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'c3d1d5f1-548a-4e29-8fa4-452c82e833c4', N'96da0995-50dc-4963-9cc0-0ca1b68fd6a6', 120000, 10, N'1603010104985')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'16bb9398-2603-439e-8ac0-4632165f1b0b', N'f4d04113-d54d-4881-8df1-9778884bb395', 150000, 10, N'1602584642790')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'eb2917b1-9385-4432-9a99-46953d882971', N'f4d04113-d54d-4881-8df1-9778884bb395', 150000, 2, N'1602585664627')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'611330ee-a719-4ffa-9a99-596f75f0f5e0', N'1191bba4-56a7-4377-9e91-ef4978d5c9fc', 190000, 10, N'1602496029298')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'50ec77c8-0e2f-4d86-b8a2-5d0d672a7ef1', N'9d906c21-8f9d-4f2b-8c01-ad707786cc15', 175000, 2, N'1602495353213')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'a7beb702-ddf3-4cd1-aa9c-67a631bd7e2f', N'd400c3b6-fb05-43ad-831b-9aa51f8e16ba', 250000, 8, N'1602499762142')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'201d7bbb-0f3d-426c-a9eb-6865d15b14f4', N'2f544d22-25ed-42b9-9a78-3189cb9a4fa7', 140000, 3, N'1603004629676')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'05f8751b-b871-4b32-959f-6c15290da796', N'd400c3b6-fb05-43ad-831b-9aa51f8e16ba', 250000, 10, N'1602586578764')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'23b9cdc6-2ec4-42b6-9f65-73b3ace4aa5e', N'6e461f7c-0280-4dc1-b093-d9d86cf3e93d', 75000, 1, N'1602752924574')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'47562c2e-27f7-404e-9fdf-7554464883e6', N'1191bba4-56a7-4377-9e91-ef4978d5c9fc', 190000, 30, N'1602580621304')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'37ed088b-8fa5-49c5-b0da-75836447cd27', N'9d906c21-8f9d-4f2b-8c01-ad707786cc15', 175000, 2, N'1602578405461')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'd900a1eb-d0c5-4859-95ef-75961e910934', N'1191bba4-56a7-4377-9e91-ef4978d5c9fc', 190000, 2, N'1602752924574')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'8e72d9ba-4678-47fa-8a8f-781edde31b14', N'1191bba4-56a7-4377-9e91-ef4978d5c9fc', 190000, 10, N'1602585938977')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'35a1c66c-27ba-40f4-89f9-8a1243f17fba', N'1191bba4-56a7-4377-9e91-ef4978d5c9fc', 190000, 100, N'1602580597801')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'b22a44c5-41d7-4cfd-9f8d-99a17b0e742c', N'f4d04113-d54d-4881-8df1-9778884bb395', 150000, 1, N'1602578405461')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'37f2dd07-64bc-4edd-bbca-9df351900b47', N'caff18b6-119f-4b61-bc53-00ac1585a598', 210000, 5, N'1603004629676')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'af30d989-aa45-4f55-94c9-a1e94bd06b8d', N'6e461f7c-0280-4dc1-b093-d9d86cf3e93d', 75000, 1, N'1602496029298')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'e36e0443-7316-4f23-b18d-a2ed226214ad', N'd400c3b6-fb05-43ad-831b-9aa51f8e16ba', 250000, 10, N'1602499312315')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'fcb065ea-49b4-41b6-a284-a2ff1f3cb7e5', N'caff18b6-119f-4b61-bc53-00ac1585a598', 210000, 10, N'1603004364777')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'edc37f15-b8d1-45fb-8bc7-b100490df91a', N'd400c3b6-fb05-43ad-831b-9aa51f8e16ba', 250000, 1, N'1603010104985')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'dd1ded5f-048e-4ab5-b0fd-b17a50614a88', N'd400c3b6-fb05-43ad-831b-9aa51f8e16ba', 250000, 5, N'1602584642790')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'b6f27a21-54dd-4563-9542-cb56e780e798', N'f5933fd1-00fd-4e19-8eb7-268191038d75', 185000, 10, N'1603004629676')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'53437276-7ff3-4736-8c27-d4918542cf8b', N'6e461f7c-0280-4dc1-b093-d9d86cf3e93d', 75000, 3, N'1602650127003')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'e8c71045-1a0b-4fac-a1fa-d5bad7f35bc3', N'caff18b6-119f-4b61-bc53-00ac1585a598', 210000, 12, N'1602586578764')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'a5d0eb4a-1a89-4452-b7ae-dfd778c12553', N'392601c6-2288-4fbd-85d0-b3b3102f6f75', 120000, 20, N'1602752924574')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'e42bd244-66ef-4dc0-a9e1-e82251815d89', N'f4d04113-d54d-4881-8df1-9778884bb395', 150000, 2, N'1602495777856')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'703b8efa-1495-48bc-8ca6-e8fc5d54cbc5', N'caff18b6-119f-4b61-bc53-00ac1585a598', 210000, 10, N'1602580621304')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'd0c7770d-778e-4757-a138-ed726342477f', N'f4d04113-d54d-4881-8df1-9778884bb395', 150000, 1, N'1602586383381')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'1feb3127-fac9-4e03-bef7-f555e1c434b3', N'd400c3b6-fb05-43ad-831b-9aa51f8e16ba', 250000, 8, N'1602578405461')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'dc767b43-c4c4-4781-ad30-f8bd39331e93', N'caff18b6-119f-4b61-bc53-00ac1585a598', 210000, 10, N'1602495353213')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'67bb2c81-baa0-497d-aa71-fb8549d53dfa', N'f4d04113-d54d-4881-8df1-9778884bb395', 150000, 1, N'1603010104985')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'f8be44fe-1ddd-4091-8465-fc0f3f6d913f', N'f5933fd1-00fd-4e19-8eb7-268191038d75', 185000, 5, N'1602586383381')
INSERT [dbo].[tblOrderDetail] ([orderDetailID], [productID], [price], [quantity], [orderID]) VALUES (N'4195e350-fdfd-4056-b2be-fc728cfe9a57', N'f5933fd1-00fd-4e19-8eb7-268191038d75', 185000, 20, N'1602585938977')
INSERT [dbo].[tblProduct] ([productID], [name], [image], [description], [price], [quantity], [createDate], [expirationDate], [categoryID], [status]) VALUES (N'caff18b6-119f-4b61-bc53-00ac1585a598', N'Snow Skin Mooncake', N'snow-skin-mooncake-5-copyth-300x300-1-300x270.jpg', N'Snow skin mooncake is a new mooncake flavor in recent years. It is small and cute, and the cake skin is crystal clear made of glutinous rice flour. It is very suitable for young people who are pursuing fashion trends. Different from other mooncakes, it needs to be stored in the refrigerator. ', 210000, 90, CAST(N'2020-10-06' AS Date), CAST(N'2020-11-16' AS Date), N'C02', 1)
INSERT [dbo].[tblProduct] ([productID], [name], [image], [description], [price], [quantity], [createDate], [expirationDate], [categoryID], [status]) VALUES (N'96da0995-50dc-4963-9cc0-0ca1b68fd6a6', N'White Lotus Mooncake', N'images.jpg', N'The lotus mooncake is the representative of Cantonese-style mooncake. The filling is white lotus paste, which is made of the fresh lotus seeds of the year with a natural fragrance. Since the sugar is added and calories are high in lotus paste mooncake, the elderly and diabetics should not eat too much.', 120000, 90, CAST(N'2020-10-05' AS Date), CAST(N'2020-10-31' AS Date), N'C01', 1)
INSERT [dbo].[tblProduct] ([productID], [name], [image], [description], [price], [quantity], [createDate], [expirationDate], [categoryID], [status]) VALUES (N'f5933fd1-00fd-4e19-8eb7-268191038d75', N'Green Tea Mooncake', N'mmc1copy.jpg', N'The biggest feature of green tea mooncake is the fresh natural taste. Green tea powder is added into the skin or the fillings. Different from other types of mooncakes, it is not overly sweet and has a certain health effect!', 185000, 175, CAST(N'2020-10-07' AS Date), CAST(N'2020-10-29' AS Date), N'C01', 1)
INSERT [dbo].[tblProduct] ([productID], [name], [image], [description], [price], [quantity], [createDate], [expirationDate], [categoryID], [status]) VALUES (N'2f544d22-25ed-42b9-9a78-3189cb9a4fa7', N'New MoonCake', N'20429691680_ac9a525815_o.jpg', N'MoonCake', 140000, 117, CAST(N'2020-10-15' AS Date), CAST(N'2020-11-05' AS Date), N'C01', 2)
INSERT [dbo].[tblProduct] ([productID], [name], [image], [description], [price], [quantity], [createDate], [expirationDate], [categoryID], [status]) VALUES (N'd7e8a758-af1f-4355-be91-70f2e921281e', N'Wuren Mooncake - Mixed Nuts Mooncake', N'50fc7305695084051efb18eac7b08790.jpg', N'Wuren literally means five kinds of nuts or kernels such as walnut kernels, almonds, sesame seeds, melon seeds, hawthorn, red beans and so on. Wuren Mooncake is a typical and popular mooncake flavor in China. Though Chinese young people donât like it very much, Wuren mooncake is much welcomed by the old.', 170000, 80, CAST(N'2020-10-06' AS Date), CAST(N'2020-10-27' AS Date), N'C01', 1)
INSERT [dbo].[tblProduct] ([productID], [name], [image], [description], [price], [quantity], [createDate], [expirationDate], [categoryID], [status]) VALUES (N'f4d04113-d54d-4881-8df1-9778884bb395', N'Salted Egg Yolk Mooncake', N'DoubleYolk-500x500.jpg', N'As it implied in the name, the filling of this kind of mooncake is the solid salted egg yolk. The unique taste makes this mooncake popular. The fresh lotus seeds paste or red bean paste are the most common combinations for mooncake fillings with egg yolks.', 150000, 58, CAST(N'2020-10-06' AS Date), CAST(N'2020-10-31' AS Date), N'C01', 1)
INSERT [dbo].[tblProduct] ([productID], [name], [image], [description], [price], [quantity], [createDate], [expirationDate], [categoryID], [status]) VALUES (N'd400c3b6-fb05-43ad-831b-9aa51f8e16ba', N'Fruits Mooncake', N'20429691680_ac9a525815_o.jpg', N'Fruit mooncake blends the taste of fruit. The sweet but not greasy taste is loved by many people. The fillings is usually added with the freshest fruits like strawberry, orange, peach, and pineapple. The durian mooncake is the popular fruit mooncake flavor in recent years.', 250000, 121, CAST(N'2020-10-07' AS Date), CAST(N'2020-10-31' AS Date), N'C01', 1)
INSERT [dbo].[tblProduct] ([productID], [name], [image], [description], [price], [quantity], [createDate], [expirationDate], [categoryID], [status]) VALUES (N'9d906c21-8f9d-4f2b-8c01-ad707786cc15', N'Minced Pork Mooncake', N'100365829-purple-taro-paste-with-minced-pork-sauce-moon-cake-chinese-mid-autumn-festival-food-.jpg', N'Minced pork mooncake is a traditional snack in Jiangsu, Zhejiang and Shanghai regions. The filling is fresh minced pork. The wrapper is permeated by meat juice and baked, which makes it crisp and a special taste. Meat lovers can also have a try of another meat mooncake flavor, Cantonese style ham mooncake. ', 175000, 196, CAST(N'2020-10-06' AS Date), CAST(N'2020-11-16' AS Date), N'C01', 1)
INSERT [dbo].[tblProduct] ([productID], [name], [image], [description], [price], [quantity], [createDate], [expirationDate], [categoryID], [status]) VALUES (N'54decdec-b981-42c3-b20a-b2915f93d5ad', N'Dinh Tri Thuc', N'icon_search.png', N'aaaaaaa', 200000, 100, CAST(N'2020-10-13' AS Date), CAST(N'2020-10-28' AS Date), N'C02', 2)
INSERT [dbo].[tblProduct] ([productID], [name], [image], [description], [price], [quantity], [createDate], [expirationDate], [categoryID], [status]) VALUES (N'392601c6-2288-4fbd-85d0-b3b3102f6f75', N'New Product', N'mmc1copy.jpg', N'This is a new product!!', 120000, 129, CAST(N'2020-10-15' AS Date), CAST(N'2020-10-29' AS Date), N'C01', 1)
INSERT [dbo].[tblProduct] ([productID], [name], [image], [description], [price], [quantity], [createDate], [expirationDate], [categoryID], [status]) VALUES (N'c237fe9a-fb65-4879-9dd0-ccf0deb48c00', N'Yam Mooncake', N'122232ddddddadfc.jpg', N'Yam mooncake is also a new mooncake flavor. The filling is sweet yam paste. The mucus protein contained in the yam can improve the bodyÃÂ¢ÃÂÃÂs resistance. So the yam mooncake is popular among those who want to keep healthy. ', 85000, 170, CAST(N'2020-10-08' AS Date), CAST(N'2020-10-14' AS Date), N'C01', 1)
INSERT [dbo].[tblProduct] ([productID], [name], [image], [description], [price], [quantity], [createDate], [expirationDate], [categoryID], [status]) VALUES (N'5522c9c9-2c5e-4625-bfc8-d8a7d9a3811d', N'111111', N'100365829-purple-taro-paste-with-minced-pork-sauce-moon-cake-chinese-mid-autumn-festival-food-.jpg', N'11111111111', 135000, 210, CAST(N'2020-10-13' AS Date), CAST(N'2020-10-17' AS Date), N'C01', 1)
INSERT [dbo].[tblProduct] ([productID], [name], [image], [description], [price], [quantity], [createDate], [expirationDate], [categoryID], [status]) VALUES (N'6e461f7c-0280-4dc1-b093-d9d86cf3e93d', N'Red Bean Mooncake', N'51qXjw0bBTL.jpg', N'Sweet red bean mooncake has always been a classic type that many people prefer. Through careful production, the combination of sweet bean paste and the outer skin makes the mooncake smooth and have a richer flavor, which makes it a most popular mooncake flavor.', 75000, 1495, CAST(N'2020-10-05' AS Date), CAST(N'2020-10-28' AS Date), N'C01', 1)
INSERT [dbo].[tblProduct] ([productID], [name], [image], [description], [price], [quantity], [createDate], [expirationDate], [categoryID], [status]) VALUES (N'1191bba4-56a7-4377-9e91-ef4978d5c9fc', N'Flower Cake', N'a2c3bc2dcacbd78acf086aca11e8675f.jpg', N'Flower mooncakes have been well received in the market in recent years. The fillings are added with flowers, bringing a fragrant taste. The variety is quite rich and the most popular ones are rose and sweet-scented osmanthus. ', 190000, 97, CAST(N'2020-10-05' AS Date), CAST(N'2020-10-29' AS Date), N'C01', 1)
INSERT [dbo].[tblRole] ([roleID], [name]) VALUES (N'R01', N'Guest')
INSERT [dbo].[tblRole] ([roleID], [name]) VALUES (N'R02', N'Member')
INSERT [dbo].[tblRole] ([roleID], [name]) VALUES (N'R03', N'Admin')
INSERT [dbo].[tblStatus] ([statusID], [name]) VALUES (1, N'Active')
INSERT [dbo].[tblStatus] ([statusID], [name]) VALUES (2, N'Deactive')
INSERT [dbo].[tblStatus] ([statusID], [name]) VALUES (3, N'Done')
INSERT [dbo].[tblStatus] ([statusID], [name]) VALUES (4, N'Not yet')
INSERT [dbo].[tblUser] ([userID], [name], [password], [roleID], [phone], [address]) VALUES (N'1314944815516021', N'Hùng Nguyễn', NULL, N'R02', NULL, NULL)
INSERT [dbo].[tblUser] ([userID], [name], [password], [roleID], [phone], [address]) VALUES (N'HungNV', N'Steven Nguyen', N'123456', N'R02', N'0957223727', N'Buon Ma Thuot')
INSERT [dbo].[tblUser] ([userID], [name], [password], [roleID], [phone], [address]) VALUES (N'SE140995', N'Nguyen Van Son', N'123456', N'R02', N'0945513679', N'Buon Ma Thuot')
INSERT [dbo].[tblUser] ([userID], [name], [password], [roleID], [phone], [address]) VALUES (N'SE140996', N'Nguyen Van Hung', N'123456', N'R03', N'0945513678', N'Ho Chi Minh')
ALTER TABLE [dbo].[tblLog]  WITH CHECK ADD FOREIGN KEY([productID])
REFERENCES [dbo].[tblProduct] ([productID])
GO
ALTER TABLE [dbo].[tblLog]  WITH CHECK ADD  CONSTRAINT [FK__tblLog__userID__398D8EEE] FOREIGN KEY([userID])
REFERENCES [dbo].[tblUser] ([userID])
GO
ALTER TABLE [dbo].[tblLog] CHECK CONSTRAINT [FK__tblLog__userID__398D8EEE]
GO
ALTER TABLE [dbo].[tblOrder]  WITH CHECK ADD  CONSTRAINT [FK__tblOrder__paymen__7E37BEF6] FOREIGN KEY([paymentStatus])
REFERENCES [dbo].[tblStatus] ([statusID])
GO
ALTER TABLE [dbo].[tblOrder] CHECK CONSTRAINT [FK__tblOrder__paymen__7E37BEF6]
GO
ALTER TABLE [dbo].[tblOrder]  WITH CHECK ADD  CONSTRAINT [FK__tblOrder__userID__66603565] FOREIGN KEY([userID])
REFERENCES [dbo].[tblUser] ([userID])
GO
ALTER TABLE [dbo].[tblOrder] CHECK CONSTRAINT [FK__tblOrder__userID__66603565]
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK__tblOrderD__order__693CA210] FOREIGN KEY([orderID])
REFERENCES [dbo].[tblOrder] ([orderID])
GO
ALTER TABLE [dbo].[tblOrderDetail] CHECK CONSTRAINT [FK__tblOrderD__order__693CA210]
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK__tblOrderD__produ__6477ECF3] FOREIGN KEY([productID])
REFERENCES [dbo].[tblProduct] ([productID])
GO
ALTER TABLE [dbo].[tblOrderDetail] CHECK CONSTRAINT [FK__tblOrderD__produ__6477ECF3]
GO
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD FOREIGN KEY([categoryID])
REFERENCES [dbo].[tblCategory] ([categoryID])
GO
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD FOREIGN KEY([status])
REFERENCES [dbo].[tblStatus] ([statusID])
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD  CONSTRAINT [FK__tblUser__roleID__6EF57B66] FOREIGN KEY([roleID])
REFERENCES [dbo].[tblRole] ([roleID])
GO
ALTER TABLE [dbo].[tblUser] CHECK CONSTRAINT [FK__tblUser__roleID__6EF57B66]
GO
USE [master]
GO
ALTER DATABASE [Yellow Moon Shop] SET  READ_WRITE 
GO
