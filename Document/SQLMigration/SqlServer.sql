USE [RZ-SOLDB]
GO
/****** Object:  Table [dbo].[APPROLES]    Script Date: 07-01-2018 10:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APPROLES](
	[Id] [NVARCHAR](128) NOT NULL,
	[ParentId] [NVARCHAR](128) NOT NULL,
	[AddBy] [NVARCHAR](128) NOT NULL,
	[AddOn] [DATETIME] NOT NULL DEFAULT GETUTCDATE(),
	[ModBy] [NVARCHAR](128) NOT NULL,
	[ModOn] [DATETIME] NOT NULL DEFAULT GETUTCDATE(),
	[Name] [NVARCHAR](256) NOT NULL,
 CONSTRAINT [PK_DBO.APPROLES] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[APPUSERS]    Script Date: 07-01-2018 10:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APPUSERS](
	[Id] [NVARCHAR](128) NOT NULL,
	[ParentId] [NVARCHAR](128) NOT NULL,
	[FullName] [NVARCHAR](50) NOT NULL,
	[UserDOB] [DATETIME] NOT NULL DEFAULT GETUTCDATE(),
	[Address] [NVARCHAR](250) NOT NULL,
	[DeviceId1] [NVARCHAR](50) NULL,
	[DeviceId2] [NVARCHAR](50) NULL,
	[DeviceType] [NVARCHAR](3) NULL,
	[TokenId] [NVARCHAR](500) NULL,
	[IsLocked] [BIT] NOT NULL,
	[IsOnline] [BIT] NOT NULL,
	[AltNumber] [NVARCHAR](20) NULL,
	[AddBy] [NVARCHAR](128) NOT NULL,
	[AddOn] [DATETIME] NOT NULL DEFAULT GETUTCDATE(),
	[ModBy] [NVARCHAR](128) NOT NULL,
	[ModOn] [DATETIME] NOT NULL DEFAULT GETUTCDATE(),
	[Email] [NVARCHAR](256) NULL,
	[EmailConfirmed] [BIT] NOT NULL,
	[PasswordHash] [NVARCHAR](2048) NULL,
	[SecurityStamp] [NVARCHAR](2048) NULL,
	[PhoneNumber] [NVARCHAR](10) NULL,
	[PhoneNumberConfirmed] [BIT] NOT NULL,
	[TwoFactorEnabled] [BIT] NOT NULL,
	[LockoutEndDateUtc] [DATETIME] NULL,
	[LockoutEnabled] [BIT] NOT NULL,
	[AccessFailedCount] [INT] NOT NULL,
	[UserName] [NVARCHAR](256) NOT NULL,
 CONSTRAINT [PK_DBO.APPUSERS] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[APPCLAIMS]    Script Date: 07-01-2018 10:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APPCLAIMS](
	[Id] [INT] IDENTITY(1,1) NOT NULL,
	[UserId] [NVARCHAR](128) NOT NULL,
	[ClaimType] [NVARCHAR](2048) NULL,
	[ClaimValue] [NVARCHAR](2048) NULL,
 CONSTRAINT [PK_DBO.APPCLAIMS] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[APPLOGINS]    Script Date: 07-01-2018 10:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APPLOGINS](
	[LoginProvider] [NVARCHAR](128) NOT NULL,
	[ProviderKey] [NVARCHAR](128) NOT NULL,
	[UserId] [NVARCHAR](128) NOT NULL,
 CONSTRAINT [PK_DBO.APPLOGINS] PRIMARY KEY CLUSTERED ([LoginProvider] ASC, [ProviderKey] ASC, [UserId] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[APPUSERROLES]    Script Date: 07-01-2018 10:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APPUSERROLES](
	[UserId] [NVARCHAR](128) NOT NULL,
	[RoleId] [NVARCHAR](128) NOT NULL,
 CONSTRAINT [PK_DBO.APPUSERROLES] PRIMARY KEY CLUSTERED ([UserId] ASC, [RoleId] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOGBOOK]    Script Date: 07-01-2018 10:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOGBOOK](
	[LogId] [NVARCHAR](50) NOT NULL,
	[UserId] [NVARCHAR](128) NOT NULL,
	[LogType] [NVARCHAR](5) NOT NULL,
	[SLogTime] [DATETIME] NOT NULL,
	[CLogTime] [DATETIME] NOT NULL,
	[LogLat] [NVARCHAR](30) NULL,
	[LogLng] [NVARCHAR](30) NULL,
 CONSTRAINT [PK_DBO.LOGBOOK] PRIMARY KEY CLUSTERED ([LogId] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MENUMASTER]    Script Date: 07-01-2018 10:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MENUMASTER](
	[MenuId] [INT] IDENTITY(1,1) NOT NULL,
	[MenuName] [NVARCHAR](50) NOT NULL,
	[MenuIndex] [INT] NOT NULL,
	[ParentId] [INT] NOT NULL,
	[ActionUrl] [NVARCHAR](500) NOT NULL DEFAULT '',
	[AddBy] [NVARCHAR](128) NOT NULL,
	[AddOn] [DATETIME] NOT NULL DEFAULT GETUTCDATE(),
	[ModBy] [NVARCHAR](128) NOT NULL,
	[ModOn] [DATETIME] NOT NULL DEFAULT GETUTCDATE(),
 CONSTRAINT [PK_DBO.MENUMASTER] PRIMARY KEY CLUSTERED ([MenuId] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OPERATIONMASTER]    Script Date: 07-01-2018 10:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OPERATIONMASTER](
	[OperationId] [INT] IDENTITY(1,1) NOT NULL,
	[OperationName] [NVARCHAR](50) NOT NULL,
	[MenuId] [INT] NOT NULL,
	[MenuIndex] [INT] NOT NULL,
	[ActionUrl] [NVARCHAR](500) NULL,
	[AddBy] [NVARCHAR](128) NOT NULL,
	[AddOn] [DATETIME] NOT NULL DEFAULT GETUTCDATE(),
	[ModBy] [NVARCHAR](128) NOT NULL,
	[ModOn] [DATETIME] NOT NULL DEFAULT GETUTCDATE(),
 CONSTRAINT [PK_DBO.OPERATIONMASTER] PRIMARY KEY CLUSTERED ([OperationId] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ROLEMENUMAP]    Script Date: 07-01-2018 10:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROLEMENUMAP](
	[MapId] [INT] IDENTITY(1,1) NOT NULL,
	[RoleId] [NVARCHAR](128) NOT NULL,
	[MenuId] [INT] NOT NULL,
	[AddBy] [NVARCHAR](128) NOT NULL,
	[AddOn] [DATETIME] NOT NULL DEFAULT GETUTCDATE(),
	[ModBy] [NVARCHAR](128) NOT NULL,
	[ModOn] [DATETIME] NOT NULL DEFAULT GETUTCDATE(),
 CONSTRAINT [PK_DBO.ROLEMENUMAP] PRIMARY KEY CLUSTERED ([MapId] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USEROPERATIONMAP]    Script Date: 07-01-2018 10:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USEROPERATIONMAP](
	[MapId] [uniqueidentifier] NOT NULL,
	[OperationId] [INT] NOT NULL,
	[UserId] [NVARCHAR](128) NOT NULL,
	[AddBy] [NVARCHAR](128) NOT NULL,
	[AddOn] [DATETIME] NOT NULL DEFAULT GETUTCDATE(),
	[ModBy] [NVARCHAR](128) NOT NULL,
	[ModOn] [DATETIME] NOT NULL DEFAULT GETUTCDATE(),
 CONSTRAINT [PK_DBO.USEROPERATIONMAP] PRIMARY KEY CLUSTERED ([MapId] ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[USEROPERATIONMAP] ADD  DEFAULT (NEWSEQUENTIALID()) FOR [MapId]
GO
ALTER TABLE [dbo].[APPCLAIMS]  WITH CHECK ADD  CONSTRAINT [FK_DBO.APPCLAIMS_DBO.APPUSERS_UserId] FOREIGN KEY([UserId]) REFERENCES [dbo].[APPUSERS] ([Id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[APPCLAIMS] CHECK CONSTRAINT [FK_DBO.APPCLAIMS_DBO.APPUSERS_UserId]
GO
ALTER TABLE [dbo].[APPLOGINS]  WITH CHECK ADD  CONSTRAINT [FK_DBO.APPLOGINS_DBO.APPUSERS_UserId] FOREIGN KEY([UserId]) REFERENCES [dbo].[APPUSERS] ([Id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[APPLOGINS] CHECK CONSTRAINT [FK_DBO.APPLOGINS_DBO.APPUSERS_UserId]
GO
ALTER TABLE [dbo].[APPUSERROLES]  WITH CHECK ADD  CONSTRAINT [FK_DBO.APPUSERROLES_DBO.APPROLES_RoleId] FOREIGN KEY([RoleId]) REFERENCES [dbo].[APPROLES] ([Id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[APPUSERROLES] CHECK CONSTRAINT [FK_DBO.APPUSERROLES_DBO.APPROLES_RoleId]
GO
ALTER TABLE [dbo].[APPUSERROLES]  WITH CHECK ADD  CONSTRAINT [FK_DBO.APPUSERROLES_DBO.APPUSERS_UserId] FOREIGN KEY([UserId]) REFERENCES [dbo].[APPUSERS] ([Id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[APPUSERROLES] CHECK CONSTRAINT [FK_DBO.APPUSERROLES_DBO.APPUSERS_UserId]
GO
ALTER TABLE [dbo].[LOGBOOK]  WITH CHECK ADD  CONSTRAINT [FK_DBO.LOGBOOK_DBO.APPUSERS_UserId] FOREIGN KEY([UserId]) REFERENCES [dbo].[APPUSERS] ([Id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LOGBOOK] CHECK CONSTRAINT [FK_DBO.LOGBOOK_DBO.APPUSERS_UserId]
GO
ALTER TABLE [dbo].[OPERATIONMASTER]  WITH CHECK ADD  CONSTRAINT [FK_DBO.OPERATIONMASTER_DBO.MENUMASTER_MenuId] FOREIGN KEY([MenuId]) REFERENCES [dbo].[MENUMASTER] ([MenuId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OPERATIONMASTER] CHECK CONSTRAINT [FK_DBO.OPERATIONMASTER_DBO.MENUMASTER_MenuId]
GO
ALTER TABLE [dbo].[ROLEMENUMAP]  WITH CHECK ADD  CONSTRAINT [FK_DBO.ROLEMENUMAP_DBO.APPROLES_RoleId] FOREIGN KEY([RoleId]) REFERENCES [dbo].[APPROLES] ([Id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ROLEMENUMAP] CHECK CONSTRAINT [FK_DBO.ROLEMENUMAP_DBO.APPROLES_RoleId]
GO
ALTER TABLE [dbo].[ROLEMENUMAP]  WITH CHECK ADD  CONSTRAINT [FK_DBO.ROLEMENUMAP_DBO.MENUMASTER_MenuId] FOREIGN KEY([MenuId]) REFERENCES [dbo].[MENUMASTER] ([MenuId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ROLEMENUMAP] CHECK CONSTRAINT [FK_DBO.ROLEMENUMAP_DBO.MENUMASTER_MenuId]
GO
ALTER TABLE [dbo].[USEROPERATIONMAP]  WITH CHECK ADD  CONSTRAINT [FK_DBO.USEROPERATIONMAP_DBO.APPUSERS_UserId] FOREIGN KEY([UserId]) REFERENCES [dbo].[APPUSERS] ([Id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[USEROPERATIONMAP] CHECK CONSTRAINT [FK_DBO.USEROPERATIONMAP_DBO.APPUSERS_UserId]
GO
ALTER TABLE [dbo].[USEROPERATIONMAP]  WITH CHECK ADD  CONSTRAINT [FK_DBO.USEROPERATIONMAP_DBO.OPERATIONMASTER_OperationId] FOREIGN KEY([OperationId]) REFERENCES [dbo].[OPERATIONMASTER] ([OperationId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[USEROPERATIONMAP] CHECK CONSTRAINT [FK_DBO.USEROPERATIONMAP_DBO.OPERATIONMASTER_OperationId]
GO
/****** Object:  View [dbo].[USERHIERARCHY]    Script Date: 07-01-2018 10:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[USERHIERARCHY] AS SELECT CHILD.Id as Id, CHILD.Name AS Name, CHILD.ParentId AS ParentId, PARENT.Name AS ParentName FROM [dbo].[APPROLES] AS CHILD INNER JOIN [dbo].[APPROLES] AS PARENT ON CHILD.ParentId = PARENT.Id;
GO
/****** Object:  StoredProcedure [dbo].[BACKDATEDDATACLEANUP]    Script Date: 07-01-2018 10:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
INSERT [dbo].[APPROLES] ([Id], [ParentId], [AddBy], [AddOn], [ModBy], [ModOn], [Name]) VALUES (N'Web Master', N'Web Master', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE(), N'Web Master')
GO
INSERT [dbo].[APPROLES] ([Id], [ParentId], [AddBy], [AddOn], [ModBy], [ModOn], [Name]) VALUES (N'Administrator', N'Web Master', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE(), N'Administrator')
GO
INSERT [dbo].[APPUSERS] ([Id], [ParentId], [FullName], [UserDOB], [Address], [DeviceId1], [DeviceId2], [DeviceType], [TokenId], [IsLocked], [IsOnline], [AltNumber], [AddBy], [AddOn], [ModBy], [ModOn], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'WebMaster', N'WebMaster', N'Web Master (Super Admin)', CAST(N'1984-06-19T18:30:00.000' AS DATETIME), N'Not available', NULL, NULL, N'WEB', NULL, 0, 0, N'8617263060', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE(), N'webmaster@rzsolution.co.in', 1, N'AGewXc2/acYQ4U5aUiySMbU/kKs3bXzxEPqvxtvuVhKf39rZNTDTfbLiiriF/D0W4A==', N'3baf7d8a-6c47-4302-8bbe-118350d95133', N'9635212741', 1, 0, NULL, 0, 0, N'WebMaster')
GO
INSERT [dbo].[APPUSERROLES] ([UserId], [RoleId]) VALUES (N'WebMaster', N'Web Master')
GO
INSERT [dbo].[APPUSERROLES] ([UserId], [RoleId]) VALUES (N'WebMaster', N'Administrator')
GO
SET IDENTITY_INSERT [dbo].[MENUMASTER] ON 
GO
INSERT [dbo].[MENUMASTER] ([MenuId], [MenuName], [MenuIndex], [ParentId], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (1, N'DASHBOARD', 1, 0, N'dashboard', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[MENUMASTER] ([MenuId], [MenuName], [MenuIndex], [ParentId], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (2, N'MASTER', 2, 0, N'', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[MENUMASTER] ([MenuId], [MenuName], [MenuIndex], [ParentId], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (3, N'TRANSACTION', 3, 0, N'', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[MENUMASTER] ([MenuId], [MenuName], [MenuIndex], [ParentId], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (4, N'ACCOUNTS', 4, 0, N'', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[MENUMASTER] ([MenuId], [MenuName], [MenuIndex], [ParentId], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (5, N'REPORTS', 5, 0, N'', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[MENUMASTER] ([MenuId], [MenuName], [MenuIndex], [ParentId], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (6, N'SETTINGS', 6, 0, N'', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[MENUMASTER] ([MenuId], [MenuName], [MenuIndex], [ParentId], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (7, N'APPLICATION TOOL', 7, 0, N'', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[MENUMASTER] ([MenuId], [MenuName], [MenuIndex], [ParentId], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (8, N'ROLE MANAGEMENT', 1, 2, N'roles', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[MENUMASTER] ([MenuId], [MenuName], [MenuIndex], [ParentId], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (9, N'USER MANAGEMENT', 2, 2, N'users', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[MENUMASTER] ([MenuId], [MenuName], [MenuIndex], [ParentId], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (10, N'ATTENDENCE REPORT', 1, 5, N'attendencereport', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[MENUMASTER] ([MenuId], [MenuName], [MenuIndex], [ParentId], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (11, N'CHANGE PASSWORD', 1, 6, N'changepassword', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[MENUMASTER] ([MenuId], [MenuName], [MenuIndex], [ParentId], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (12, N'EDIT MY PROFILE', 2, 6, N'editmyprofile', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[MENUMASTER] ([MenuId], [MenuName], [MenuIndex], [ParentId], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (13, N'MENU MANAGEMENT', 1, 7, N'menus', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[MENUMASTER] ([MenuId], [MenuName], [MenuIndex], [ParentId], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (14, N'APPLICATION CLEANUP', 2, 7, N'cleanup', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[MENUMASTER] ([MenuId], [MenuName], [MenuIndex], [ParentId], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (15, N'DATA BACKUP / RESTORE', 3, 7, N'backuprestore', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
SET IDENTITY_INSERT [dbo].[MENUMASTER] OFF
GO
SET IDENTITY_INSERT [dbo].[ROLEMENUMAP] ON
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (1, N'Web Master', 1, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (2, N'Web Master', 2, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (3, N'Web Master', 3, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (4, N'Web Master', 4, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (5, N'Web Master', 5, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (6, N'Web Master', 6, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (7, N'Web Master', 7, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (8, N'Web Master', 8, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (9, N'Web Master', 9, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (10, N'Web Master', 10, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (11, N'Web Master', 11, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (12, N'Web Master', 12, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (13, N'Web Master', 13, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (14, N'Web Master', 14, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (15, N'Web Master', 15, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (16, N'Administrator', 1, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (17, N'Administrator', 2, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (18, N'Administrator', 3, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (19, N'Administrator', 4, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (20, N'Administrator', 5, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (21, N'Administrator', 6, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (22, N'Administrator', 8, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (23, N'Administrator', 9, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (24, N'Administrator', 10, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (25, N'Administrator', 11, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[ROLEMENUMAP] ([MapId], [RoleId], [MenuId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (26, N'Administrator', 12, N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
SET IDENTITY_INSERT [dbo].[ROLEMENUMAP] OFF
GO
SET IDENTITY_INSERT [dbo].[OPERATIONMASTER] ON
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (1, N'GET ROLES', 8, 1, N'/master/api/roles', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (2, N'GET ROLE', 8, 2, N'/master/api/getrole', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (3, N'ADD ROLE', 8, 3, N'/master/api/addrole', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (4, N'EDIT ROLE', 8, 4, N'/master/api/editrole', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (5, N'DELETE ROLE', 8, 5, N'/master/api/deleterole', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (6, N'MAP MENU', 8, 6, N'/master/api/mapmenu', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (7, N'GET USERS', 9, 1, N'/master/api/users', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (8, N'GET USER', 9, 2, N'/master/api/getuser', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (9, N'ADD USER', 9, 3, N'/master/api/adduser', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (10, N'EDIT USER', 9, 4, N'/master/api/edituser', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (11, N'DELETE USER', 9, 5, N'/master/api/deleteuser', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (12, N'MAP OPERATION', 9, 6, N'/master/api/mapoperation', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (13, N'GET ATTENDENCE', 10, 1, N'/report/api/getattendence', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (14, N'CHANGE PASSWORD', 11, 1, N'/settings/api/changepassword', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (15, N'EDIT MY PROFILE', 12, 1, N'/settings/api/editmyprofile', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (16, N'GET MENUS', 13, 1, N'/applicationtool/api/menus', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (17, N'GET MENU', 13, 2, N'/applicationtool/api/getmenu', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (18, N'ADD MENU', 13, 3, N'/applicationtool/api/addmenu', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (19, N'EDIT MENU', 13, 4, N'/applicationtool/api/editmenu', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (20, N'DELETE MENU', 13, 5, N'/applicationtool/api/deletemenu', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (21, N'APPLICATION CLEANUP', 14, 1, N'/applicationtool/api/cleanup', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (22, N'DATABASE BACKUP', 15, 1, N'/applicationtool/api/backup', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[OPERATIONMASTER] ([OperationId], [OperationName], [MenuId], [MenuIndex], [ActionUrl], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (23, N'DATABASE RESTORE', 15, 2, N'/applicationtool/api/restore', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
SET IDENTITY_INSERT [dbo].[OPERATIONMASTER] OFF
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (1, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (2, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (3, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (4, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (5, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (6, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (7, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (8, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (9, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (10, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (11, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (12, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (13, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (14, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (15, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (16, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (17, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (18, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (19, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (20, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (21, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (22, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO
INSERT [dbo].[USEROPERATIONMAP] ([OperationId], [UserId], [AddBy], [AddOn], [ModBy], [ModOn]) VALUES (23, N'WebMaster', N'WebMaster', GETUTCDATE(), N'WebMaster', GETUTCDATE())
GO