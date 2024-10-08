
/****** Object:  Database [HELPDESK]    Script Date: 10/4/2024 16:28:13 ******/
CREATE DATABASE [PROYECT_MANAGER_BD]
GO
USE [PROYECT_MANAGER_BD]
GO
/****** Object:  Schema [helpdesk]    Script Date: 10/4/2024 16:28:13 ******/
CREATE SCHEMA [helpdesk]
GO
/****** Object:  Schema [security]    Script Date: 10/4/2024 16:28:13 ******/
CREATE SCHEMA [security]
GO
/****** Object:  Table [helpdesk].[Tbl_Case]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Tbl_Case](
	[Id_Case] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [nvarchar](500) NULL,
	[Descripcion] [nvarchar](max) NULL,
	[Id_Perfil] [int] NULL,
	[Estado] [nvarchar](50) NULL,
	[Id_Dependencia] [int] NULL,
	[Fecha_Inicio] [datetime] NULL,
	[Fecha_Final] [datetime] NULL,
	[Id_Servicio] [int] NULL,
	[Id_Vinculate] [int] NULL,
	[Mail] [nvarchar](max) NULL,
	[MimeMessageCaseData] [nvarchar](max) NULL,
	[Case_Priority] [varchar](50) NULL,
 CONSTRAINT [PK_Tbl_Case] PRIMARY KEY CLUSTERED 
(
	[Id_Case] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Tbl_Calendario]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Tbl_Calendario](
	[IdCalendario] [int] IDENTITY(1,1) NOT NULL,
	[Id_Tarea] [int] NULL,
	[Estado] [nvarchar](50) NULL,
	[Fecha_Inicio] [datetime] NULL,
	[Fecha_Final] [datetime] NULL,
	[Id_Dependencia] [int] NULL,
 CONSTRAINT [PK_Tbl_Calendario] PRIMARY KEY CLUSTERED 
(
	[IdCalendario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Tbl_Tareas]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Tbl_Tareas](
	[Id_Tarea] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [nvarchar](500) NULL,
	[Id_TareaPadre] [int] NULL,
	[Id_Case] [int] NULL,
	[Descripcion] [nvarchar](max) NULL,
	[Estado] [nvarchar](50) NULL,
	[Fecha_Inicio] [datetime] NULL,
	[Fecha_Finalizacion] [datetime] NULL,
	[Fecha_Inicio_Proceso] [datetime] NULL,
	[Fecha_Finalizacion_Proceso] [datetime] NULL,
 CONSTRAINT [PK_Tbl_Tareas] PRIMARY KEY CLUSTERED 
(
	[Id_Tarea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [helpdesk].[ViewCalendarioByDependencia]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- helpdesk.ViewCalendarioByDependencia source

CREATE VIEW [helpdesk].[ViewCalendarioByDependencia]
AS
SELECT        helpdesk.Tbl_Tareas.Id_Case, helpdesk.Tbl_Tareas.Id_TareaPadre,  helpdesk.Tbl_Calendario.Fecha_Inicio , helpdesk.Tbl_Calendario.Estado, 
                         helpdesk.Tbl_Calendario.IdCalendario, helpdesk.Tbl_Calendario.Id_Tarea, helpdesk.Tbl_Case.Id_Dependencia
FROM            helpdesk.Tbl_Case INNER JOIN
                         helpdesk.Tbl_Tareas ON helpdesk.Tbl_Case.Id_Case = helpdesk.Tbl_Tareas.Id_Case INNER JOIN
                         helpdesk.Tbl_Calendario ON helpdesk.Tbl_Tareas.Id_Tarea = helpdesk.Tbl_Calendario.Id_Tarea
GO
/****** Object:  Table [helpdesk].[Tbl_Participantes]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Tbl_Participantes](
	[Id_Perfil] [int] NOT NULL,
	[Id_Tarea] [int] NOT NULL,
	[Id_Tipo_Participacion] [int] NULL,
 CONSTRAINT [PK_Tbl_Participantes] PRIMARY KEY CLUSTERED 
(
	[Id_Perfil] ASC,
	[Id_Tarea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [helpdesk].[ViewActividadesParticipantes]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [helpdesk].[ViewActividadesParticipantes]
AS
SELECT        helpdesk.Tbl_Case.Id_Case, helpdesk.Tbl_Case.Titulo, helpdesk.Tbl_Case.Descripcion, helpdesk.Tbl_Case.Estado, helpdesk.Tbl_Case.Id_Perfil
FROM            helpdesk.Tbl_Case INNER JOIN
                         helpdesk.Tbl_Tareas ON helpdesk.Tbl_Case.Id_Case = helpdesk.Tbl_Tareas.Id_Case INNER JOIN
                         helpdesk.Tbl_Participantes ON helpdesk.Tbl_Tareas.Id_Tarea = helpdesk.Tbl_Participantes.Id_Tarea
GROUP BY helpdesk.Tbl_Case.Id_Case, helpdesk.Tbl_Case.Titulo, helpdesk.Tbl_Case.Descripcion, helpdesk.Tbl_Case.Estado, helpdesk.Tbl_Case.Id_Perfil
GO
/****** Object:  Table [dbo].[Log]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log](
	[Id_Log] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NULL,
	[body] [nvarchar](max) NULL,
	[message] [varchar](max) NULL,
 CONSTRAINT [PK_Tbl_Agendas] PRIMARY KEY CLUSTERED 
(
	[Id_Log] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Tbl_Agenda]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Tbl_Agenda](
	[IdAgenda] [int] IDENTITY(1,1) NOT NULL,
	[Id_Perfil] [int] NULL,
	[Id_Dependencia] [int] NULL,
	[Dia] [nvarchar](50) NULL,
	[Hora_Inicial] [nvarchar](50) NULL,
	[Hora_Final] [nvarchar](50) NULL,
	[Fecha_Caducidad] [datetime] NULL,
 CONSTRAINT [PK_Tbl_Agendas] PRIMARY KEY CLUSTERED 
(
	[IdAgenda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Tbl_Comments]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Tbl_Comments](
	[Id_Comentario] [int] IDENTITY(1,1) NOT NULL,
	[Body] [nvarchar](max) NULL,
	[Estado] [nvarchar](50) NULL,
	[Fecha] [datetime] NULL,
	[Id_Case] [int] NULL,
	[Id_User] [int] NULL,
	[NickName] [nvarchar](max) NULL,
	[Mail] [nvarchar](max) NULL,
	[Attach_Files] [nvarchar](max) NULL,
	[Mails] [varchar](max) NULL,
 CONSTRAINT [PK_Tbl_Coments] PRIMARY KEY CLUSTERED 
(
	[Id_Comentario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Tbl_Comments_Tasks]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Tbl_Comments_Tasks](
	[Id_Comentario] [int] IDENTITY(1,1) NOT NULL,
	[Body] [nvarchar](max) NULL,
	[Estado] [nvarchar](50) NULL,
	[Fecha] [datetime] NULL,
	[Id_Tarea] [int] NULL,
	[Id_User] [int] NULL,
	[NickName] [nvarchar](max) NULL,
	[Mail] [nvarchar](max) NULL,
	[Attach_Files] [nvarchar](max) NULL,
	[Mails] [varchar](max) NULL,
 CONSTRAINT [PK_Tbl_Coments_Tasks] PRIMARY KEY CLUSTERED 
(
	[Id_Comentario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Tbl_Dependencias_Usuarios]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Tbl_Dependencias_Usuarios](
	[Id_Perfil] [int] NOT NULL,
	[Id_Dependencia] [int] NOT NULL,
	[Id_Cargo] [int] NULL,
 CONSTRAINT [PK_Tbl_Dependencias_Usuarios] PRIMARY KEY CLUSTERED 
(
	[Id_Perfil] ASC,
	[Id_Dependencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Tbl_Evidencias]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Tbl_Evidencias](
	[IdEvidencia] [int] IDENTITY(1,1) NOT NULL,
	[IdTipo] [int] NULL,
	[Data] [nvarchar](max) NULL,
	[Id_Tarea] [int] NULL,
 CONSTRAINT [PK_Tbl_Evidencias] PRIMARY KEY CLUSTERED 
(
	[IdEvidencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Tbl_Mails]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Tbl_Mails](
	[Id_Mail] [int] IDENTITY(1,1) NOT NULL,
	[Id_Case] [int] NULL,
	[Subject] [nvarchar](max) NULL,
	[MessageID] [nvarchar](max) NULL,
	[Sender] [nvarchar](max) NULL,
	[FromAdress] [nvarchar](max) NULL,
	[ReplyTo] [nvarchar](max) NULL,
	[Bcc] [nvarchar](max) NULL,
	[Cc] [nvarchar](max) NULL,
	[ToAdress] [nvarchar](max) NULL,
	[Date] [datetime] NULL,
	[Uid] [nvarchar](max) NULL,
	[Flags] [nvarchar](max) NULL,
	[Estado] [varchar](100) NULL,
	[Body] [nvarchar](max) NULL,
	[Attach_Files] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Mail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Tbl_VinculateCase]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Tbl_VinculateCase](
	[Id_Vinculate] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](500) NULL,
	[Fecha] [datetime] NULL,
 CONSTRAINT [PK_Tbl_VinculateCase] PRIMARY KEY CLUSTERED 
(
	[Id_Vinculate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Cat_Cargos_Dependencias]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Cat_Cargos_Dependencias](
	[Id_Cargo] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
 CONSTRAINT [PK_Cat_Cargos_Dependencias] PRIMARY KEY CLUSTERED 
(
	[Id_Cargo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Cat_Dependencias]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Cat_Dependencias](
	[Id_Dependencia] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Id_Dependencia_Padre] [int] NULL,
	[Username] [varchar](100) NULL,
	[Password] [varchar](100) NULL,
	[Host] [varchar](100) NULL,
	[AutenticationType] [varchar](max) NULL,
	[TENAT] [varchar](max) NULL,
	[CLIENT] [varchar](max) NULL,
	[OBJECTID] [varchar](max) NULL,
	[CLIENT_SECRET] [varchar](max) NULL,
	[HostService] [varchar](max) NULL,
	[SMTPHOST] [varchar](500) NULL,
	[default] [bit] NULL,
 CONSTRAINT [PK_Cat_Dependencias] PRIMARY KEY CLUSTERED 
(
	[Id_Dependencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Cat_Paises]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Cat_Paises](
	[Id_Pais] [int] IDENTITY(1,1) NOT NULL,
	[Estado] [nvarchar](50) NULL,
	[Descripcion] [nvarchar](50) NULL,
 CONSTRAINT [PK_Cat_Nacionalidad] PRIMARY KEY CLUSTERED 
(
	[Id_Pais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Cat_Tipo_Evidencia]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Cat_Tipo_Evidencia](
	[IdTipo] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Estado] [nvarchar](50) NULL,
 CONSTRAINT [PK_Cat_Tipo_Evidencia] PRIMARY KEY CLUSTERED 
(
	[IdTipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Cat_Tipo_Participaciones]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Cat_Tipo_Participaciones](
	[Id_Tipo_Participacion] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
 CONSTRAINT [PK_Cat_Tipo_Participaciones] PRIMARY KEY CLUSTERED 
(
	[Id_Tipo_Participacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Cat_Tipo_Servicio]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Cat_Tipo_Servicio](
	[Id_Tipo_Servicio] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Estado] [nvarchar](50) NULL,
	[Icon] [nvarchar](max) NULL,
 CONSTRAINT [PK_Cat_Tipo_Servicio] PRIMARY KEY CLUSTERED 
(
	[Id_Tipo_Servicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Tbl_Profile_CasosAsignados]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Tbl_Profile_CasosAsignados](
	[Id_Perfil] [int] NOT NULL,
	[Id_Case] [int] NOT NULL,
	[Fecha] [date] NULL,
 CONSTRAINT [PK_Tbl_Profile_CasosAsignados] PRIMARY KEY CLUSTERED 
(
	[Id_Perfil] ASC,
	[Id_Case] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Tbl_Servicios]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Tbl_Servicios](
	[Id_Servicio] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_Servicio] [nvarchar](250) NULL,
	[Descripcion_Servicio] [nvarchar](2000) NULL,
	[Id_Tipo_Servicio] [int] NULL,
	[Visibilidad] [nvarchar](50) NULL,
	[Estado] [nvarchar](50) NULL,
	[Fecha_Inicio] [date] NULL,
	[Fecha_Finalizacion] [date] NULL,
	[Id_Dependencia] [int] NULL,
 CONSTRAINT [PK_Tbl_Servicios] PRIMARY KEY CLUSTERED 
(
	[Id_Servicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Tbl_Servicios_Profile]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Tbl_Servicios_Profile](
	[Id_Perfil] [int] NOT NULL,
	[Id_Servicio] [int] NOT NULL,
 CONSTRAINT [PK_Tbl_Servicios_Profile] PRIMARY KEY CLUSTERED 
(
	[Id_Perfil] ASC,
	[Id_Servicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [security].[Security_Permissions]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [security].[Security_Permissions](
	[Id_Permission] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](100) NULL,
	[Estado] [nvarchar](50) NULL,
 CONSTRAINT [PK_Security_Permissions] PRIMARY KEY CLUSTERED 
(
	[Id_Permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [security].[Security_Permissions_Roles]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [security].[Security_Permissions_Roles](
	[Id_Role] [int] NOT NULL,
	[Id_Permission] [int] NOT NULL,
	[Estado] [nvarchar](50) NULL,
 CONSTRAINT [PK_Security_Permissions_Roles] PRIMARY KEY CLUSTERED 
(
	[Id_Role] ASC,
	[Id_Permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [security].[Security_Roles]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [security].[Security_Roles](
	[Id_Role] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](150) NULL,
	[Estado] [nvarchar](50) NULL,
 CONSTRAINT [PK_Security_Roles] PRIMARY KEY CLUSTERED 
(
	[Id_Role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [security].[Security_Users]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [security].[Security_Users](
	[Id_User] [int] IDENTITY(1,1) NOT NULL,
	[Nombres] [nvarchar](150) NULL,
	[Estado] [nvarchar](50) NULL,
	[Descripcion] [nvarchar](500) NULL,
	[Password] [nvarchar](500) NULL,
	[Mail] [nvarchar](150) NULL,
	[Token] [nvarchar](500) NULL,
	[Token_Date] [datetime] NULL,
	[Token_Expiration_Date] [datetime] NULL,
 CONSTRAINT [PK_Security_Users] PRIMARY KEY CLUSTERED 
(
	[Id_User] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [security].[Security_Users_Roles]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [security].[Security_Users_Roles](
	[Id_Role] [int] NOT NULL,
	[Id_User] [int] NOT NULL,
	[Estado] [nvarchar](50) NULL,
 CONSTRAINT [PK_Security_Users_Roles] PRIMARY KEY CLUSTERED 
(
	[Id_Role] ASC,
	[Id_User] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [security].[Tbl_Profile]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [security].[Tbl_Profile](
	[Id_Perfil] [int] IDENTITY(1,1) NOT NULL,
	[Nombres] [nvarchar](50) NULL,
	[Apellidos] [nvarchar](50) NULL,
	[FechaNac] [date] NULL,
	[IdUser] [int] NULL,
	[Sexo] [nvarchar](50) NULL,
	[Foto] [nvarchar](max) NULL,
	[DNI] [nvarchar](50) NULL,
	[Correo_institucional] [nvarchar](50) NULL,
	[Id_Pais_Origen] [int] NULL,
	[Estado] [nvarchar](50) NULL,
 CONSTRAINT [PK_Tbl_InvestigatorProfile] PRIMARY KEY CLUSTERED 
(
	[Id_Perfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Log] ON 

INSERT [dbo].[Log] ([Id_Log], [Fecha], [body], [message]) VALUES (5099, NULL, N'procedure', NULL)
INSERT [dbo].[Log] ([Id_Log], [Fecha], [body], [message]) VALUES (5100, NULL, N'procedure', NULL)
INSERT [dbo].[Log] ([Id_Log], [Fecha], [body], [message]) VALUES (5101, NULL, N'procedure', NULL)
INSERT [dbo].[Log] ([Id_Log], [Fecha], [body], [message]) VALUES (5102, NULL, N'procedure', NULL)
INSERT [dbo].[Log] ([Id_Log], [Fecha], [body], [message]) VALUES (5103, NULL, N'procedure', NULL)
SET IDENTITY_INSERT [dbo].[Log] OFF
GO
SET IDENTITY_INSERT [helpdesk].[Tbl_Agenda] ON 

INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (4, 1, 1, N'Lunes', N'08:00', N'17:00', CAST(N'2022-12-12T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (5, 1, 1, N'Martes', N'08:00', N'17:00', CAST(N'2022-12-30T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (8, 1, 1, N'Domingo', N'08:00', N'17:00', CAST(N'2022-12-30T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (9, 1, 1, N'Jueves', N'08:00', N'17:00', CAST(N'2022-12-30T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (10, 1, 1, N'Viernes', N'08:00', N'17:00', CAST(N'2022-12-30T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (15, NULL, 2, N'Lunes', N'08:00', N'17:00', CAST(N'2024-01-17T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (50, NULL, 3, N'Jueves', N'08:00', N'08:00', CAST(N'2024-03-14T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (51, NULL, 3, N'Domingo', N'08:00', N'08:00', CAST(N'2024-03-14T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [helpdesk].[Tbl_Agenda] OFF
GO
SET IDENTITY_INSERT [helpdesk].[Tbl_Calendario] ON 

INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (2, 2, NULL, CAST(N'2024-01-22T08:00:00.000' AS DateTime), CAST(N'2024-01-22T08:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (3, 2, NULL, CAST(N'2024-01-22T09:00:00.000' AS DateTime), CAST(N'2024-01-22T09:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (4, 3, NULL, CAST(N'2024-01-22T08:00:00.000' AS DateTime), CAST(N'2024-01-22T08:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (5, 3, NULL, CAST(N'2024-01-22T09:00:00.000' AS DateTime), CAST(N'2024-01-22T09:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (6, 4, NULL, CAST(N'2024-01-22T08:00:00.000' AS DateTime), CAST(N'2024-01-22T08:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (7, 5, NULL, CAST(N'2024-01-22T08:00:00.000' AS DateTime), CAST(N'2024-01-22T08:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (8, 6, NULL, CAST(N'2024-01-22T09:00:00.000' AS DateTime), CAST(N'2024-01-22T09:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (9, 7, NULL, CAST(N'2024-01-22T09:00:00.000' AS DateTime), CAST(N'2024-01-22T09:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (10, 8, NULL, CAST(N'2024-01-22T13:00:00.000' AS DateTime), CAST(N'2024-01-22T13:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (11, 8, NULL, CAST(N'2024-01-22T11:00:00.000' AS DateTime), CAST(N'2024-01-22T11:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (12, 9, NULL, CAST(N'2024-01-22T11:00:00.000' AS DateTime), CAST(N'2024-01-22T11:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (13, 10, NULL, CAST(N'2024-01-22T10:00:00.000' AS DateTime), CAST(N'2024-01-22T10:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (14, 11, NULL, CAST(N'2024-01-22T10:00:00.000' AS DateTime), CAST(N'2024-01-22T10:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (15, 12, NULL, CAST(N'2024-01-22T09:00:00.000' AS DateTime), CAST(N'2024-01-22T09:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (16, 12, NULL, CAST(N'2024-01-22T11:00:00.000' AS DateTime), CAST(N'2024-01-22T11:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (17, 13, NULL, CAST(N'2024-01-22T09:00:00.000' AS DateTime), CAST(N'2024-01-22T09:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (18, 13, NULL, CAST(N'2024-01-22T10:00:00.000' AS DateTime), CAST(N'2024-01-22T10:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (19, 14, NULL, CAST(N'2024-01-22T08:00:00.000' AS DateTime), CAST(N'2024-01-22T08:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (20, 15, NULL, CAST(N'2024-01-22T08:00:00.000' AS DateTime), CAST(N'2024-01-22T08:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (21, 15, NULL, CAST(N'2024-01-22T10:00:00.000' AS DateTime), CAST(N'2024-01-22T10:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (22, 16, NULL, CAST(N'2024-01-22T08:00:00.000' AS DateTime), CAST(N'2024-01-22T08:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (23, 16, NULL, CAST(N'2024-01-22T10:00:00.000' AS DateTime), CAST(N'2024-01-22T10:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (24, 19, NULL, CAST(N'2024-01-22T11:00:00.000' AS DateTime), CAST(N'2024-01-22T11:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (25, 19, NULL, CAST(N'2024-01-22T13:00:00.000' AS DateTime), CAST(N'2024-01-22T13:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (26, 20, NULL, CAST(N'2024-01-29T11:00:00.000' AS DateTime), CAST(N'2024-01-29T11:59:00.000' AS DateTime), NULL)
INSERT [helpdesk].[Tbl_Calendario] ([IdCalendario], [Id_Tarea], [Estado], [Fecha_Inicio], [Fecha_Final], [Id_Dependencia]) VALUES (27, 20, NULL, CAST(N'2024-01-29T13:00:00.000' AS DateTime), CAST(N'2024-01-29T13:59:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [helpdesk].[Tbl_Calendario] OFF
GO
SET IDENTITY_INSERT [helpdesk].[Tbl_Case] ON 

INSERT [helpdesk].[Tbl_Case] ([Id_Case], [Titulo], [Descripcion], [Id_Perfil], [Estado], [Id_Dependencia], [Fecha_Inicio], [Fecha_Final], [Id_Servicio], [Id_Vinculate], [Mail], [Case_Priority]) VALUES (1199, N'TEST', N'<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
</head>
<body dir="ltr">
<div style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
test</div>
</body>
</html>
', NULL, N'Activo', 2, CAST(N'2023-08-23T17:17:54.000' AS DateTime), NULL, NULL, NULL, N'"wilber jose" <wdevexp@outlook.com>', NULL)
INSERT [helpdesk].[Tbl_Case] ([Id_Case], [Titulo], [Descripcion], [Id_Perfil], [Estado], [Id_Dependencia], [Fecha_Inicio], [Fecha_Final], [Id_Servicio], [Id_Vinculate], [Mail], [Case_Priority]) VALUES (1200, N'TEST2', N'<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
</head>
<body dir="ltr">
<div style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
<span style="color: rgb(237, 92, 87);"><b>TEST</b></span></div>
</body>
</html>
', NULL, N'Activo', 2, CAST(N'2023-08-23T17:20:31.000' AS DateTime), NULL, NULL, NULL, N'"wilber jose" <wdevexp@outlook.com>', NULL)
INSERT [helpdesk].[Tbl_Case] ([Id_Case], [Titulo], [Descripcion], [Id_Perfil], [Estado], [Id_Dependencia], [Fecha_Inicio], [Fecha_Final], [Id_Servicio], [Id_Vinculate], [Mail], [Case_Priority]) VALUES (1201, N'PRUEBA BASICA', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', NULL, N'Activo', 3, CAST(N'2023-12-28T17:47:17.000' AS DateTime), NULL, 7, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', NULL)
INSERT [helpdesk].[Tbl_Case] ([Id_Case], [Titulo], [Descripcion], [Id_Perfil], [Estado], [Id_Dependencia], [Fecha_Inicio], [Fecha_Final], [Id_Servicio], [Id_Vinculate], [Mail], [Case_Priority]) VALUES (1202, N'CASO BASIC V2', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', NULL, N'Activo', 2, CAST(N'2023-12-28T21:08:01.000' AS DateTime), NULL, NULL, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', NULL)
INSERT [helpdesk].[Tbl_Case] ([Id_Case], [Titulo], [Descripcion], [Id_Perfil], [Estado], [Id_Dependencia], [Fecha_Inicio], [Fecha_Final], [Id_Servicio], [Id_Vinculate], [Mail], [Case_Priority]) VALUES (1203, N'CASO N2 30/10 TEST SERVER', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', NULL, N'Activo', 2, CAST(N'2023-10-30T16:25:02.000' AS DateTime), NULL, NULL, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', NULL)
INSERT [helpdesk].[Tbl_Case] ([Id_Case], [Titulo], [Descripcion], [Id_Perfil], [Estado], [Id_Dependencia], [Fecha_Inicio], [Fecha_Final], [Id_Servicio], [Id_Vinculate], [Mail], [Case_Priority]) VALUES (1204, N'TEST SERVER 30/10/2023', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr">TEST</div>
', NULL, N'Activo', 2, CAST(N'2023-10-30T15:43:26.000' AS DateTime), NULL, NULL, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', NULL)
INSERT [helpdesk].[Tbl_Case] ([Id_Case], [Titulo], [Descripcion], [Id_Perfil], [Estado], [Id_Dependencia], [Fecha_Inicio], [Fecha_Final], [Id_Servicio], [Id_Vinculate], [Mail], [Case_Priority]) VALUES (1205, N'TEST DE HELP', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', NULL, N'Activo', 2, CAST(N'2023-10-30T12:15:05.000' AS DateTime), NULL, NULL, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', NULL)
INSERT [helpdesk].[Tbl_Case] ([Id_Case], [Titulo], [Descripcion], [Id_Perfil], [Estado], [Id_Dependencia], [Fecha_Inicio], [Fecha_Final], [Id_Servicio], [Id_Vinculate], [Mail], [Case_Priority]) VALUES (1206, N'TEST DE HELP', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', NULL, N'Activo', 2, CAST(N'2023-10-30T12:15:05.000' AS DateTime), NULL, NULL, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', NULL)
INSERT [helpdesk].[Tbl_Case] ([Id_Case], [Titulo], [Descripcion], [Id_Perfil], [Estado], [Id_Dependencia], [Fecha_Inicio], [Fecha_Final], [Id_Servicio], [Id_Vinculate], [Mail], [Case_Priority]) VALUES (1207, N'TESTSSS', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr">TESTTTTT</div>
', NULL, N'Activo', 2, CAST(N'2024-01-18T14:04:06.000' AS DateTime), NULL, NULL, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', NULL)
INSERT [helpdesk].[Tbl_Case] ([Id_Case], [Titulo], [Descripcion], [Id_Perfil], [Estado], [Id_Dependencia], [Fecha_Inicio], [Fecha_Final], [Id_Servicio], [Id_Vinculate], [Mail], [Case_Priority]) VALUES (1208, N'TEST PDF', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', NULL, N'Activo', 2, CAST(N'2024-01-29T15:49:43.000' AS DateTime), NULL, NULL, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', NULL)
INSERT [helpdesk].[Tbl_Case] ([Id_Case], [Titulo], [Descripcion], [Id_Perfil], [Estado], [Id_Dependencia], [Fecha_Inicio], [Fecha_Final], [Id_Servicio], [Id_Vinculate], [Mail], [Case_Priority]) VALUES (1209, N'TEST DE CASOS CON PDF("Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>)', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><p style="box-sizing:inherit;border:0px;margin:0px 0px 24px;padding:0px;vertical-align:initial;font-size:16px;line-height:1.75;font-family:rubik,helvetica,arial,sans-serif;background-color:rgb(235,242,245)"><font color="#3a3a3a">Freya vivía separada de su Familia en la cima de&nbsp;</font><a href="https://danmachi.fandom.com/es/wiki/Babel" title="Babel" style="color:rgb(58,58,58);box-sizing:inherit;border:0px;margin:0px;padding:0px;vertical-align:initial;line-height:inherit">Babel</a><font color="#3a3a3a">. El hogar de la Familia Freya era conocido como&nbsp;</font><b style="color:rgb(58,58,58);box-sizing:inherit;border:0px;margin:0px;padding:0px;vertical-align:initial">Folkvangr</b><font color="#3a3a3a">&nbsp;(</font><span style="color:rgb(58,58,58);box-sizing:inherit;border:0px;margin:0px;padding:0px;vertical-align:initial"><span style="box-sizing:inherit">????</span><span style="box-sizing:inherit">?????????</span></span><font color="#3a3a3a">), ubicado alrededor del centro del área de negocios y en el lado opuesto de </font>Orario<font color="#3a3a3a"> desde el hogar de la&nbsp;</font><a href="https://danmachi.fandom.com/es/wiki/Familia_Loki" title="Familia Loki" style="color:rgb(58,58,58);box-sizing:inherit;border:0px;margin:0px;padding:0px;vertical-align:initial;line-height:inherit">Familia Lok<i>i</i></a><i style=""><font color="#3a3a3a">. </font><font color="#8e7cc3">Folkvangr es una gran mansión que tiene una estructura solemne similar a un templo. Cubre una gran cantidad de terreno y está rodeado por cuatro grandes muros. El terreno de Folkvangr contiene un jardín lo suficientemente grande </font><font color="#3a3a3a">para que todos los miembros de la Familia se </font>reunieran<font color="#3a3a3a">. Verlo mostraba la riqueza, el</font></i><font color="#3a3a3a"> poder y el honor de la Familia Freya. Luego de que la facción fuera disuelta su hogar fue confiscado por el&nbsp;</font><a href="https://danmachi.fandom.com/es/wiki/Gremio" title="Gremio" style="color:rgb(58,58,58);box-sizing:inherit;border:0px;margin:0px;padding:0px;vertical-align:initial;line-height:inherit">Gremio</a><font color="#3a3a3a">.</font></p><p style="box-sizing:inherit;border:0px;margin:24px 0px;padding:0px;vertical-align:initial;font-size:16px;line-height:1.75;color:rgb(58,58,58);font-family:rubik,helvetica,arial,sans-serif;background-color:rgb(235,242,245)">Está conformada 157 miembros y, si se contaban los no combatientes y seguidores, el número t<b>otal era más de 5,000 antes de su disolución oficial. La mayoría de miembros son Nivel 2 o 3 y todo</b>s entrenaban diariamente peleando seriamente entre sí en el jardín del hogar de la Familia. Por lo menos cincuenta de sus miembros eran aventureros de segunda clase, entre Nivel 3 y 4, y ellos solos conformaban una fuerza equivalente a alrededor de 20 Familias de rango medio.</p></div>
', NULL, N'Activo', 2, CAST(N'2024-01-31T20:43:25.000' AS DateTime), NULL, 6, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', NULL)
INSERT [helpdesk].[Tbl_Case] ([Id_Case], [Titulo], [Descripcion], [Id_Perfil], [Estado], [Id_Dependencia], [Fecha_Inicio], [Fecha_Final], [Id_Servicio], [Id_Vinculate], [Mail], [Case_Priority]) VALUES (1210, N'TESTPDF("Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>)', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', NULL, N'Activo', 2, CAST(N'2024-01-29T18:42:03.000' AS DateTime), NULL, 6, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', NULL)
INSERT [helpdesk].[Tbl_Case] ([Id_Case], [Titulo], [Descripcion], [Id_Perfil], [Estado], [Id_Dependencia], [Fecha_Inicio], [Fecha_Final], [Id_Servicio], [Id_Vinculate], [Mail], [Case_Priority]) VALUES (1211, N'TEST PDF("Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>)', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', NULL, N'Finalizado', 2, CAST(N'2024-01-29T15:49:43.000' AS DateTime), NULL, 6, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', NULL)
INSERT [helpdesk].[Tbl_Case] ([Id_Case], [Titulo], [Descripcion], [Id_Perfil], [Estado], [Id_Dependencia], [Fecha_Inicio], [Fecha_Final], [Id_Servicio], [Id_Vinculate], [Mail], [Case_Priority]) VALUES (1212, N'TESTSSS("Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>)', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr">TESTTTTT</div>
', NULL, N'Activo', 2, CAST(N'2024-01-18T14:04:06.000' AS DateTime), NULL, 6, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', NULL)
SET IDENTITY_INSERT [helpdesk].[Tbl_Case] OFF
GO
SET IDENTITY_INSERT [helpdesk].[Tbl_Comments] ON 

INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (49, N'<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
</head>
<body dir="ltr">
<div style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
test</div>
</body>
</html>
', N'Pendiente', CAST(N'2023-08-23T17:17:54.000' AS DateTime), 1199, NULL, N'"wilber jose" <wdevexp@outlook.com>', N'"wilber jose" <wdevexp@outlook.com>', N'[]', NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (50, N'<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
</head>
<body dir="ltr">
<div style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
<span style="color: rgb(237, 92, 87);"><b>TEST</b></span></div>
</body>
</html>
', N'Pendiente', CAST(N'2023-08-23T17:20:31.000' AS DateTime), 1200, NULL, N'"wilber jose" <wdevexp@outlook.com>', N'"wilber jose" <wdevexp@outlook.com>', N'[]', NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (51, N'<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
</head>
<body dir="ltr">
<div style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
TEST3 <span style="color: rgb(237, 92, 87);"><b>RESPUESTA&nbsp;</b></span></div>
<div style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
<span style="color: rgb(237, 92, 87); background-color: rgb(0, 255, 0);"><b>TEST</b></span></div>
<div id="appendonsend"></div>
<hr style="display:inline-block;width:98%" tabindex="-1">
<div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" style="font-size:11pt" color="#000000"><b>De:</b> wilber jose &lt;wdevexp@outlook.com&gt;<br>
<b>Enviado:</b> miércoles, 23 de agosto de 2023 11:20<br>
<b>Para:</b> wilber jose &lt;wdevexp@outlook.com&gt;<br>
<b>Asunto:</b> TEST2</font>
<div>&nbsp;</div>
</div>
<style type="text/css" style="display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir="ltr">
<div class="x_elementToProof" style="font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<span style="color:rgb(237,92,87)"><b>TEST</b></span></div>
</div>
</body>
</html>
', N'Pendiente', CAST(N'2023-08-23T17:21:44.000' AS DateTime), 1200, NULL, N'"wilber jose" <wdevexp@outlook.com>', N'"wilber jose" <wdevexp@outlook.com>', N'[]', NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (52, N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', N'Pendiente', CAST(N'2023-12-28T17:47:17.000' AS DateTime), 1201, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[]', NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (53, N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', N'Pendiente', CAST(N'2023-12-28T21:08:01.000' AS DateTime), 1202, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[]', NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (54, N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', N'Pendiente', CAST(N'2023-10-30T16:25:02.000' AS DateTime), 1203, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[]', NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (55, N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr">TEST</div>
', N'Pendiente', CAST(N'2023-10-30T15:43:26.000' AS DateTime), 1204, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[]', NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (56, N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', N'Pendiente', CAST(N'2023-10-30T12:15:05.000' AS DateTime), 1205, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[]', NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (57, N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', N'Pendiente', CAST(N'2023-10-30T12:15:05.000' AS DateTime), 1206, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[]', NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (58, N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', N'Pendiente', CAST(N'2024-01-16T14:47:44.000' AS DateTime), 1206, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (59, N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', N'Pendiente', CAST(N'2024-01-16T14:47:44.000' AS DateTime), 1205, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (60, N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', N'Pendiente', CAST(N'2024-01-16T14:47:44.000' AS DateTime), 1204, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (61, N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', N'Pendiente', CAST(N'2024-01-17T10:19:00.000' AS DateTime), 1203, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (62, N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', N'Pendiente', CAST(N'2024-01-17T10:19:00.000' AS DateTime), 1202, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (63, N'Se a creado una nueva tarea: tarea 1', N'Pendiente', CAST(N'2024-01-17T10:34:53.000' AS DateTime), 1202, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (64, N'Se a creado una nueva tarea: test', N'Pendiente', CAST(N'2024-01-17T10:36:46.000' AS DateTime), 1206, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (65, N'Se a creado una nueva tarea: ert', N'Pendiente', CAST(N'2024-01-17T13:27:13.000' AS DateTime), 1205, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (66, N'Se a creado una nueva tarea: wer', N'Pendiente', CAST(N'2024-01-17T13:28:39.000' AS DateTime), 1205, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (67, N'Se a creado una nueva tarea: asd', N'Pendiente', CAST(N'2024-01-17T13:29:19.000' AS DateTime), 1205, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (68, N'Se a creado una nueva tarea: sdf', N'Pendiente', CAST(N'2024-01-17T13:29:41.000' AS DateTime), 1205, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (69, N'Se a creado una nueva tarea: sdf', N'Pendiente', CAST(N'2024-01-17T13:30:03.000' AS DateTime), 1205, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (70, N'Se a creado una nueva tarea: wer', N'Pendiente', CAST(N'2024-01-17T13:30:32.000' AS DateTime), 1205, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (71, N'Se a creado una nueva tarea: asd', N'Pendiente', CAST(N'2024-01-17T13:32:38.000' AS DateTime), 1205, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (72, N'Se a creado una nueva tarea: sdf', N'Pendiente', CAST(N'2024-01-17T13:33:46.000' AS DateTime), 1205, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (73, N'Se a creado una nueva tarea: asd', N'Pendiente', CAST(N'2024-01-17T13:34:17.000' AS DateTime), 1205, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (74, N'Se a creado una nueva tarea: zxc', N'Pendiente', CAST(N'2024-01-17T13:35:39.000' AS DateTime), 1205, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (75, N'Se a creado una nueva tarea: ads', N'Pendiente', CAST(N'2024-01-17T13:38:40.000' AS DateTime), 1205, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (76, N'Se a creado una nueva tarea: wer', N'Pendiente', CAST(N'2024-01-17T13:40:15.000' AS DateTime), 1205, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (77, N'Se a creado una nueva tarea: sdf', N'Pendiente', CAST(N'2024-01-17T13:45:53.000' AS DateTime), 1205, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (81, N'Se a creado una nueva tarea: Ejecución y resolución del caso: #1200', N'Pendiente', CAST(N'2024-01-17T14:09:16.000' AS DateTime), 1200, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (82, N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', N'Pendiente', CAST(N'2024-01-17T14:09:16.000' AS DateTime), 1200, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (83, N'Se a creado una nueva tarea: Ejecución y resolución del caso: #1199', N'Pendiente', CAST(N'2024-01-17T14:10:15.000' AS DateTime), 1199, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (84, N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', N'Pendiente', CAST(N'2024-01-17T14:10:15.000' AS DateTime), 1199, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (85, N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8">admin@admin.net: El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', N'Pendiente', CAST(N'2024-01-17T14:10:12.000' AS DateTime), 1200, NULL, N'"HELPDESK" <wdevexp@outlook.com>', N'"HELPDESK" <wdevexp@outlook.com>', N'[]', NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (86, N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8">admin@admin.net: Se a creado una nueva tarea: Ejecución y resolución del caso: #1200', N'Pendiente', CAST(N'2024-01-17T14:10:19.000' AS DateTime), 1200, NULL, N'"HELPDESK" <wdevexp@outlook.com>', N'"HELPDESK" <wdevexp@outlook.com>', N'[]', NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (87, N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8">admin@admin.net: El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', N'Pendiente', CAST(N'2024-01-17T14:11:13.000' AS DateTime), 1206, NULL, N'"HELPDESK" <wdevexp@outlook.com>', N'"HELPDESK" <wdevexp@outlook.com>', N'[]', NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (88, N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8">admin@admin.net: Se a creado una nueva tarea: Ejecución y resolución del caso: #1199', N'Pendiente', CAST(N'2024-01-17T14:11:19.000' AS DateTime), 1206, NULL, N'"HELPDESK" <wdevexp@outlook.com>', N'"HELPDESK" <wdevexp@outlook.com>', N'[]', NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (89, N'Se a creado una nueva tarea: sss', N'Pendiente', CAST(N'2024-01-18T09:56:22.000' AS DateTime), 1205, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (90, N'Se a creado una nueva tarea: iiiiii', N'Pendiente', CAST(N'2024-01-18T09:56:46.000' AS DateTime), 1205, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (91, N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr">TESTTTTT</div>
', N'Pendiente', CAST(N'2024-01-18T14:04:06.000' AS DateTime), 1207, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[]', NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (92, N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', N'Pendiente', CAST(N'2024-01-29T15:49:43.000' AS DateTime), 1208, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[
  {
    "Name": "20116314@ESPECIFICACIONES TECNICAS LICENCIAMIENTO BASE DE DATOS ORACLE (1).pdf",
    "Value": "wwwroot\\Media\\Upload\\009fa1a9-3204-4f62-88b3-217b51cc80e0.unknown",
    "Type": ".unknown"
  }
]', NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (99, N'Se a creado una nueva tarea: Ejecución y resolución del caso: #1208', N'Pendiente', CAST(N'2024-01-30T13:37:19.000' AS DateTime), 1208, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (100, N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', N'Pendiente', CAST(N'2024-01-30T13:37:19.000' AS DateTime), 1208, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (101, N'Se a creado una nueva tarea: Ejecución y resolución del caso: #1207', N'Pendiente', CAST(N'2024-01-30T13:55:22.000' AS DateTime), 1207, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (102, N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', N'Pendiente', CAST(N'2024-01-30T13:55:22.000' AS DateTime), 1207, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (103, N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><p style="box-sizing:inherit;border:0px;margin:0px 0px 24px;padding:0px;vertical-align:initial;font-size:16px;line-height:1.75;font-family:rubik,helvetica,arial,sans-serif;background-color:rgb(235,242,245)"><font color="#3a3a3a">Freya vivía separada de su Familia en la cima de&nbsp;</font><a href="https://danmachi.fandom.com/es/wiki/Babel" title="Babel" style="color:rgb(58,58,58);box-sizing:inherit;border:0px;margin:0px;padding:0px;vertical-align:initial;line-height:inherit">Babel</a><font color="#3a3a3a">. El hogar de la Familia Freya era conocido como&nbsp;</font><b style="color:rgb(58,58,58);box-sizing:inherit;border:0px;margin:0px;padding:0px;vertical-align:initial">Folkvangr</b><font color="#3a3a3a">&nbsp;(</font><span style="color:rgb(58,58,58);box-sizing:inherit;border:0px;margin:0px;padding:0px;vertical-align:initial"><span style="box-sizing:inherit">????</span><span style="box-sizing:inherit">?????????</span></span><font color="#3a3a3a">), ubicado alrededor del centro del área de negocios y en el lado opuesto de </font>Orario<font color="#3a3a3a"> desde el hogar de la&nbsp;</font><a href="https://danmachi.fandom.com/es/wiki/Familia_Loki" title="Familia Loki" style="color:rgb(58,58,58);box-sizing:inherit;border:0px;margin:0px;padding:0px;vertical-align:initial;line-height:inherit">Familia Lok<i>i</i></a><i style=""><font color="#3a3a3a">. </font><font color="#8e7cc3">Folkvangr es una gran mansión que tiene una estructura solemne similar a un templo. Cubre una gran cantidad de terreno y está rodeado por cuatro grandes muros. El terreno de Folkvangr contiene un jardín lo suficientemente grande </font><font color="#3a3a3a">para que todos los miembros de la Familia se </font>reunieran<font color="#3a3a3a">. Verlo mostraba la riqueza, el</font></i><font color="#3a3a3a"> poder y el honor de la Familia Freya. Luego de que la facción fuera disuelta su hogar fue confiscado por el&nbsp;</font><a href="https://danmachi.fandom.com/es/wiki/Gremio" title="Gremio" style="color:rgb(58,58,58);box-sizing:inherit;border:0px;margin:0px;padding:0px;vertical-align:initial;line-height:inherit">Gremio</a><font color="#3a3a3a">.</font></p><p style="box-sizing:inherit;border:0px;margin:24px 0px;padding:0px;vertical-align:initial;font-size:16px;line-height:1.75;color:rgb(58,58,58);font-family:rubik,helvetica,arial,sans-serif;background-color:rgb(235,242,245)">Está conformada 157 miembros y, si se contaban los no combatientes y seguidores, el número t<b>otal era más de 5,000 antes de su disolución oficial. La mayoría de miembros son Nivel 2 o 3 y todo</b>s entrenaban diariamente peleando seriamente entre sí en el jardín del hogar de la Familia. Por lo menos cincuenta de sus miembros eran aventureros de segunda clase, entre Nivel 3 y 4, y ellos solos conformaban una fuerza equivalente a alrededor de 20 Familias de rango medio.</p></div>
', N'Pendiente', CAST(N'2024-01-31T20:43:25.000' AS DateTime), 1209, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[
  {
    "Name": "ROBOTICA EDUCATIVA (1).pdf",
    "Value": "wwwroot\\Media\\Upload\\40c5f588-151a-4d18-b6f3-5e0afc2ff593.unknown",
    "Type": ".unknown"
  }
]', NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (104, N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', N'Pendiente', CAST(N'2024-01-29T18:42:03.000' AS DateTime), 1210, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[
  {
    "Name": "FACTURA Junio DEL 2023 - NO 20.pdf",
    "Value": "wwwroot\\Media\\Upload\\dd21224c-ebbd-47e3-8a05-1f50f9218d65.unknown",
    "Type": ".unknown"
  }
]', NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (105, N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', N'Pendiente', CAST(N'2024-01-29T15:49:43.000' AS DateTime), 1211, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[
  {
    "Name": "20116314@ESPECIFICACIONES TECNICAS LICENCIAMIENTO BASE DE DATOS ORACLE (1).pdf",
    "Value": "wwwroot\\Media\\Upload\\d74b000e-ad8b-4c4f-9a5b-bfa3b647e031.unknown",
    "Type": ".unknown"
  }
]', NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (106, N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr">TESTTTTT</div>
', N'Pendiente', CAST(N'2024-01-18T14:04:06.000' AS DateTime), 1212, NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[]', NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (107, N'Se a creado una nueva tarea: Ejecución y resolución del caso: #1212', N'Pendiente', CAST(N'2024-02-13T10:27:34.790' AS DateTime), 1212, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (108, N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', N'Pendiente', CAST(N'2024-02-13T10:27:34.787' AS DateTime), 1212, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (109, N'Se a creado una nueva tarea: Ejecución y resolución del caso: #1211', N'Pendiente', CAST(N'2024-02-13T10:30:32.087' AS DateTime), 1211, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (110, N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', N'Pendiente', CAST(N'2024-02-13T10:30:32.087' AS DateTime), 1211, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (111, N'Se a creado una nueva tarea: Ejecución y resolución del caso: #1210', N'Pendiente', CAST(N'2024-02-13T10:31:52.170' AS DateTime), 1210, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (112, N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', N'Pendiente', CAST(N'2024-02-13T10:31:52.170' AS DateTime), 1210, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (113, N'test', NULL, CAST(N'2024-02-13T14:04:48.113' AS DateTime), 1212, 1, N'ADMIN', N'admin@admin.net', NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]')
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (114, N'prueba de un solo envio
', NULL, CAST(N'2024-02-13T14:05:54.547' AS DateTime), 1212, 1, N'ADMIN', N'admin@admin.net', NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]')
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (129, N'Se a creado una nueva tarea: Ejecución y resolución del caso: #1209', N'Pendiente', CAST(N'2024-02-14T14:05:22.033' AS DateTime), 1209, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (130, N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', N'Pendiente', CAST(N'2024-02-14T14:05:22.033' AS DateTime), 1209, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (131, N'test', NULL, CAST(N'2024-03-14T11:29:20.590' AS DateTime), 1212, 1, N'ADMIN', N'admin@admin.net', NULL, N'[
  "admin@admin.net",
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>",
  "wilberj1987@hotmail.com"
]')
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (132, N'Se a creado una nueva tarea: Ejecución y resolución del caso: #1201', N'Pendiente', CAST(N'2024-03-18T10:04:38.730' AS DateTime), 1201, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (133, N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', N'Pendiente', CAST(N'2024-03-18T10:04:38.730' AS DateTime), 1201, NULL, N'ADMIN (admin@admin.net)', N'admin@admin.net', NULL, NULL)
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (134, N'', NULL, CAST(N'2024-04-10T14:14:48.480' AS DateTime), 1212, 1, N'ADMIN', N'admin@admin.net', NULL, N'[
  "admin@admin.net",
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]')
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (135, N'', NULL, CAST(N'2024-04-10T14:14:51.183' AS DateTime), 1212, 1, N'ADMIN', N'admin@admin.net', NULL, N'[
  "admin@admin.net",
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]')
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (136, N'', NULL, CAST(N'2024-04-10T14:14:56.787' AS DateTime), 1212, 1, N'ADMIN', N'admin@admin.net', NULL, N'[
  "admin@admin.net",
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]')
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (137, N'', NULL, CAST(N'2024-04-10T14:18:09.950' AS DateTime), 1212, 1, N'ADMIN', N'admin@admin.net', NULL, N'[
  "admin@admin.net",
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]')
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (138, N'', NULL, CAST(N'2024-04-10T14:18:14.313' AS DateTime), 1212, 1, N'ADMIN', N'admin@admin.net', NULL, N'[
  "admin@admin.net",
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]')
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (139, N'', NULL, CAST(N'2024-04-10T14:18:17.817' AS DateTime), 1212, 1, N'ADMIN', N'admin@admin.net', NULL, N'[
  "admin@admin.net",
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]')
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (140, N'', NULL, CAST(N'2024-04-10T14:18:46.310' AS DateTime), 1212, 1, N'ADMIN', N'admin@admin.net', NULL, N'[
  "admin@admin.net",
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]')
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (141, N'', NULL, CAST(N'2024-04-10T14:19:01.463' AS DateTime), 1212, 1, N'ADMIN', N'admin@admin.net', NULL, N'[
  "admin@admin.net",
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]')
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (142, N'', NULL, CAST(N'2024-04-10T14:19:02.147' AS DateTime), 1212, 1, N'ADMIN', N'admin@admin.net', NULL, N'[
  "admin@admin.net",
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]')
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (143, N'', NULL, CAST(N'2024-04-10T14:19:03.793' AS DateTime), 1212, 1, N'ADMIN', N'admin@admin.net', NULL, N'[
  "admin@admin.net",
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]')
INSERT [helpdesk].[Tbl_Comments] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Case], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (144, N'', NULL, CAST(N'2024-04-10T14:19:07.600' AS DateTime), 1212, 1, N'ADMIN', N'admin@admin.net', NULL, N'[
  "admin@admin.net",
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]')
SET IDENTITY_INSERT [helpdesk].[Tbl_Comments] OFF
GO
SET IDENTITY_INSERT [helpdesk].[Tbl_Comments_Tasks] ON 

INSERT [helpdesk].[Tbl_Comments_Tasks] ([Id_Comentario], [Body], [Estado], [Fecha], [Id_Tarea], [Id_User], [NickName], [Mail], [Attach_Files], [Mails]) VALUES (1, N'test', NULL, CAST(N'2024-01-17T10:38:47.000' AS DateTime), 3, 1, N'ADMIN', N'admin@admin.net', NULL, NULL)
SET IDENTITY_INSERT [helpdesk].[Tbl_Comments_Tasks] OFF
GO
INSERT [helpdesk].[Tbl_Dependencias_Usuarios] ([Id_Perfil], [Id_Dependencia], [Id_Cargo]) VALUES (1, 1, NULL)
INSERT [helpdesk].[Tbl_Dependencias_Usuarios] ([Id_Perfil], [Id_Dependencia], [Id_Cargo]) VALUES (1, 2, NULL)
INSERT [helpdesk].[Tbl_Dependencias_Usuarios] ([Id_Perfil], [Id_Dependencia], [Id_Cargo]) VALUES (3049, 2, NULL)
INSERT [helpdesk].[Tbl_Dependencias_Usuarios] ([Id_Perfil], [Id_Dependencia], [Id_Cargo]) VALUES (3050, 2, NULL)
INSERT [helpdesk].[Tbl_Dependencias_Usuarios] ([Id_Perfil], [Id_Dependencia], [Id_Cargo]) VALUES (3051, 1, 3)
INSERT [helpdesk].[Tbl_Dependencias_Usuarios] ([Id_Perfil], [Id_Dependencia], [Id_Cargo]) VALUES (3051, 2, NULL)
INSERT [helpdesk].[Tbl_Dependencias_Usuarios] ([Id_Perfil], [Id_Dependencia], [Id_Cargo]) VALUES (3052, 2, NULL)
INSERT [helpdesk].[Tbl_Dependencias_Usuarios] ([Id_Perfil], [Id_Dependencia], [Id_Cargo]) VALUES (3054, 2, NULL)
INSERT [helpdesk].[Tbl_Dependencias_Usuarios] ([Id_Perfil], [Id_Dependencia], [Id_Cargo]) VALUES (3054, 3, 3)
GO
SET IDENTITY_INSERT [helpdesk].[Tbl_Mails] ON 

INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (66, 1199, N'test', N'BN7PR13MB2275D92BB2E30A4FCDE44E56B11CA@BN7PR13MB2275.namprd13.prod.outlook.com', NULL, N'"wilber jose" <wdevexp@outlook.com>', N'[]', N'[]', N'[]', N'[
  "\"wilber jose\" <wdevexp@outlook.com>"
]', CAST(N'2023-08-23T17:17:54.000' AS DateTime), N'BN7PR13MB2275D92BB2E30A4FCDE44E56B11CA@BN7PR13MB2275.namprd13.prod.outlook.com', NULL, N'RECIBIDO', N'<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
</head>
<body dir="ltr">
<div style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
test</div>
</body>
</html>
', N'[]')
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (67, 1200, N'TEST2', N'BN7PR13MB22759421F4F03C6AF945B91DB11CA@BN7PR13MB2275.namprd13.prod.outlook.com', NULL, N'"wilber jose" <wdevexp@outlook.com>', N'[]', N'[]', N'[]', N'[
  "\"wilber jose\" <wdevexp@outlook.com>"
]', CAST(N'2023-08-23T17:20:31.000' AS DateTime), N'BN7PR13MB22759421F4F03C6AF945B91DB11CA@BN7PR13MB2275.namprd13.prod.outlook.com', NULL, N'RECIBIDO', N'<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
</head>
<body dir="ltr">
<div style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
<span style="color: rgb(237, 92, 87);"><b>TEST</b></span></div>
</body>
</html>
', N'[]')
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (68, 1200, N'RE: TEST2', N'BN7PR13MB2275092616453325BED47542B11CA@BN7PR13MB2275.namprd13.prod.outlook.com', NULL, N'"wilber jose" <wdevexp@outlook.com>', N'[]', N'[]', N'[]', N'[
  "\"wilber jose\" <wdevexp@outlook.com>"
]', CAST(N'2023-08-23T17:21:44.000' AS DateTime), N'BN7PR13MB2275092616453325BED47542B11CA@BN7PR13MB2275.namprd13.prod.outlook.com', NULL, N'RECIBIDO', N'<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
</head>
<body dir="ltr">
<div style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
TEST3 <span style="color: rgb(237, 92, 87);"><b>RESPUESTA&nbsp;</b></span></div>
<div style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
<span style="color: rgb(237, 92, 87); background-color: rgb(0, 255, 0);"><b>TEST</b></span></div>
<div id="appendonsend"></div>
<hr style="display:inline-block;width:98%" tabindex="-1">
<div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" style="font-size:11pt" color="#000000"><b>De:</b> wilber jose &lt;wdevexp@outlook.com&gt;<br>
<b>Enviado:</b> miércoles, 23 de agosto de 2023 11:20<br>
<b>Para:</b> wilber jose &lt;wdevexp@outlook.com&gt;<br>
<b>Asunto:</b> TEST2</font>
<div>&nbsp;</div>
</div>
<style type="text/css" style="display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir="ltr">
<div class="x_elementToProof" style="font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<span style="color:rgb(237,92,87)"><b>TEST</b></span></div>
</div>
</body>
</html>
', N'[]')
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (69, 1201, N'PRUEBA BASICA', N'CAPjTs_CfC69Fuhsqe8f_+qvfqFHT4MRoX+2go0mm_3U2yfo6DA@mail.gmail.com', NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[]', N'[]', N'[]', N'[
  "\"HELPDESK\" <wdevexp@outlook.com>"
]', CAST(N'2023-12-28T17:47:17.000' AS DateTime), N'CAPjTs_CfC69Fuhsqe8f_+qvfqFHT4MRoX+2go0mm_3U2yfo6DA@mail.gmail.com', NULL, N'RECIBIDO', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', N'[]')
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (70, 1202, N'CASO BASIC V2', N'CAPjTs_DMa3oACCwL1uA1n5GLLAaH68qAGzsnMn_ZSmhS-gfBVA@mail.gmail.com', NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[]', N'[]', N'[]', N'[
  "\"HELPDESK\" <wdevexp@outlook.com>"
]', CAST(N'2023-12-28T21:08:01.000' AS DateTime), N'CAPjTs_DMa3oACCwL1uA1n5GLLAaH68qAGzsnMn_ZSmhS-gfBVA@mail.gmail.com', NULL, N'RECIBIDO', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', N'[]')
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (71, 1203, N'caso n2 30/10 test server', N'CAPjTs_AGmFzzDx-uKfDa19kxUhVwZaTcAZp6+GCZkWZrkGQ+fg@mail.gmail.com', NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[]', N'[]', N'[]', N'[
  "\"HELPDESK\" <wdevexp@outlook.com>"
]', CAST(N'2023-10-30T16:25:02.000' AS DateTime), N'CAPjTs_AGmFzzDx-uKfDa19kxUhVwZaTcAZp6+GCZkWZrkGQ+fg@mail.gmail.com', NULL, N'RECIBIDO', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', N'[]')
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (72, 1204, N'TEST SERVER 30/10/2023', N'CAPjTs_A1hx1WDFFjUYMHK5n59shKJFcLGB8JqHxuAmjkUw5X+g@mail.gmail.com', NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[]', N'[]', N'[]', N'[
  "\"HELPDESK\" <wdevexp@outlook.com>"
]', CAST(N'2023-10-30T15:43:26.000' AS DateTime), N'CAPjTs_A1hx1WDFFjUYMHK5n59shKJFcLGB8JqHxuAmjkUw5X+g@mail.gmail.com', NULL, N'RECIBIDO', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr">TEST</div>
', N'[]')
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (73, 1205, N'test de help', N'CAPjTs_DRgoNzGVn5JqbQ4nhGdpivX9YT6FuVvKv35m3fSG3zYw@mail.gmail.com', NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[]', N'[]', N'[]', N'[
  "\"HELPDESK\" <wdevexp@outlook.com>"
]', CAST(N'2023-10-30T12:15:05.000' AS DateTime), N'CAPjTs_DRgoNzGVn5JqbQ4nhGdpivX9YT6FuVvKv35m3fSG3zYw@mail.gmail.com', NULL, N'RECIBIDO', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', N'[]')
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (74, 1206, N'test de help', N'CAPjTs_DRgoNzGVn5JqbQ4nhGdpivX9YT6FuVvKv35m3fSG3zYw@mail.gmail.com', NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[]', N'[]', N'[]', N'[
  "\"HELPDESK\" <wdevexp@outlook.com>"
]', CAST(N'2023-10-30T12:15:05.000' AS DateTime), N'CAPjTs_DRgoNzGVn5JqbQ4nhGdpivX9YT6FuVvKv35m3fSG3zYw@mail.gmail.com', NULL, N'RECIBIDO', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', N'[]')
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (75, 1206, N'RE: TEST DE HELP', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-16T14:47:44.000' AS DateTime), NULL, NULL, N'ENVIADO', N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (76, 1205, N'RE: TEST DE HELP', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-16T14:47:44.000' AS DateTime), NULL, NULL, N'ENVIADO', N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (77, 1204, N'RE: TEST SERVER 30/10/2023', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-16T14:47:44.000' AS DateTime), NULL, NULL, N'ENVIADO', N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (78, 1203, N'RE: CASO N2 30/10 TEST SERVER', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-17T10:19:00.000' AS DateTime), NULL, NULL, N'ENVIADO', N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (79, 1202, N'RE: CASO BASIC V2', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-17T10:19:00.000' AS DateTime), NULL, NULL, N'ENVIADO', N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (80, 1202, N'RE: CASO BASIC V2', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-17T10:34:53.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: tarea 1', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (81, 1206, N'RE: TEST DE HELP', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-17T10:36:46.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: test', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (82, 1205, N'RE: TEST DE HELP', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-17T13:27:13.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: ert', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (83, 1205, N'RE: TEST DE HELP', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-17T13:28:39.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: wer', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (84, 1205, N'RE: TEST DE HELP', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-17T13:29:19.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: asd', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (85, 1205, N'RE: TEST DE HELP', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-17T13:29:41.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: sdf', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (86, 1205, N'RE: TEST DE HELP', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-17T13:30:03.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: sdf', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (87, 1205, N'RE: TEST DE HELP', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-17T13:30:32.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: wer', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (88, 1205, N'RE: TEST DE HELP', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-17T13:32:38.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: asd', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (89, 1205, N'RE: TEST DE HELP', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-17T13:33:46.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: sdf', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (90, 1205, N'RE: TEST DE HELP', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-17T13:34:17.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: asd', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (91, 1205, N'RE: TEST DE HELP', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-17T13:35:39.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: zxc', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (92, 1205, N'RE: TEST DE HELP', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-17T13:38:40.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: ads', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (93, 1205, N'RE: TEST DE HELP', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-17T13:40:16.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: wer', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (94, 1205, N'RE: TEST DE HELP', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-17T13:45:53.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: sdf', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (95, 1200, N'RE: TEST2', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"wilber jose\" <wdevexp@outlook.com>"
]', CAST(N'2024-01-17T14:09:16.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: Ejecución y resolución del caso: #1200', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (96, 1200, N'RE: TEST2', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"wilber jose\" <wdevexp@outlook.com>"
]', CAST(N'2024-01-17T14:09:17.000' AS DateTime), NULL, NULL, N'ENVIADO', N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (97, 1199, N'RE: TEST', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"wilber jose\" <wdevexp@outlook.com>"
]', CAST(N'2024-01-17T14:10:15.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: Ejecución y resolución del caso: #1199', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (98, 1199, N'RE: TEST', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"wilber jose\" <wdevexp@outlook.com>"
]', CAST(N'2024-01-17T14:10:15.000' AS DateTime), NULL, NULL, N'ENVIADO', N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (99, 1200, N'RE: TEST2', N'LV8P223MB1059F2670BA639ED831DC2D0B1722@LV8P223MB1059.NAMP223.PROD.OUTLOOK.COM', NULL, N'"HELPDESK" <wdevexp@outlook.com>', N'[]', N'[]', N'[]', N'[
  "\"wilber jose\" <wdevexp@outlook.com>"
]', CAST(N'2024-01-17T14:10:12.000' AS DateTime), N'LV8P223MB1059F2670BA639ED831DC2D0B1722@LV8P223MB1059.NAMP223.PROD.OUTLOOK.COM', NULL, N'RECIBIDO', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8">admin@admin.net: El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', N'[]')
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (100, 1200, N'RE: TEST2', N'LV8P223MB1059CA6A2AB44B37EB10AD53B1722@LV8P223MB1059.NAMP223.PROD.OUTLOOK.COM', NULL, N'"HELPDESK" <wdevexp@outlook.com>', N'[]', N'[]', N'[]', N'[
  "\"wilber jose\" <wdevexp@outlook.com>"
]', CAST(N'2024-01-17T14:10:19.000' AS DateTime), N'LV8P223MB1059CA6A2AB44B37EB10AD53B1722@LV8P223MB1059.NAMP223.PROD.OUTLOOK.COM', NULL, N'RECIBIDO', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8">admin@admin.net: Se a creado una nueva tarea: Ejecución y resolución del caso: #1200', N'[]')
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (101, 1206, N'RE: TEST', N'LV8P223MB1059A86A61381EE2DEB6C5AEB1722@LV8P223MB1059.NAMP223.PROD.OUTLOOK.COM', NULL, N'"HELPDESK" <wdevexp@outlook.com>', N'[]', N'[]', N'[]', N'[
  "\"wilber jose\" <wdevexp@outlook.com>"
]', CAST(N'2024-01-17T14:11:13.000' AS DateTime), N'LV8P223MB1059A86A61381EE2DEB6C5AEB1722@LV8P223MB1059.NAMP223.PROD.OUTLOOK.COM', NULL, N'RECIBIDO', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8">admin@admin.net: El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', N'[]')
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (102, 1206, N'RE: TEST', N'LV8P223MB1059A999FD13743FF36537A9B1722@LV8P223MB1059.NAMP223.PROD.OUTLOOK.COM', NULL, N'"HELPDESK" <wdevexp@outlook.com>', N'[]', N'[]', N'[]', N'[
  "\"wilber jose\" <wdevexp@outlook.com>"
]', CAST(N'2024-01-17T14:11:19.000' AS DateTime), N'LV8P223MB1059A999FD13743FF36537A9B1722@LV8P223MB1059.NAMP223.PROD.OUTLOOK.COM', NULL, N'RECIBIDO', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8">admin@admin.net: Se a creado una nueva tarea: Ejecución y resolución del caso: #1199', N'[]')
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (103, 1205, N'RE: TEST DE HELP', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-18T09:56:22.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: sss', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (104, 1205, N'RE: TEST DE HELP', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-18T09:56:46.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: iiiiii', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (105, 1207, N'TESTSSS', N'CAPjTs_B+hpByQERZoDSS0OMBsw9VWnY2oPuH5MsbYB75D1YjmQ@mail.gmail.com', NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[]', N'[]', N'[]', N'[
  "\"HELPDESK\" <wdevexp@outlook.com>"
]', CAST(N'2024-01-18T14:04:06.000' AS DateTime), N'CAPjTs_B+hpByQERZoDSS0OMBsw9VWnY2oPuH5MsbYB75D1YjmQ@mail.gmail.com', NULL, N'RECIBIDO', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr">TESTTTTT</div>
', N'[]')
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (106, 1208, N'TEST PDF', N'CAPjTs_AB9K5Q5py9CVWYJFanVedRR7LMMP5=CLjH6PrKrOYa5Q@mail.gmail.com', NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[]', N'[]', N'[]', N'[
  "\"HELPDESK\" <wdevexp@outlook.com>"
]', CAST(N'2024-01-29T15:49:43.000' AS DateTime), N'CAPjTs_AB9K5Q5py9CVWYJFanVedRR7LMMP5=CLjH6PrKrOYa5Q@mail.gmail.com', NULL, N'RECIBIDO', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', N'[
  {
    "Name": "20116314@ESPECIFICACIONES TECNICAS LICENCIAMIENTO BASE DE DATOS ORACLE (1).pdf",
    "Value": "wwwroot\\Media\\Upload\\009fa1a9-3204-4f62-88b3-217b51cc80e0.unknown",
    "Type": ".unknown"
  }
]')
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (107, 1208, N'RE: TEST PDF', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-30T13:37:19.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: Ejecución y resolución del caso: #1208', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (108, 1208, N'RE: TEST PDF', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-30T13:37:20.000' AS DateTime), NULL, NULL, N'ENVIADO', N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (109, 1207, N'RE: TESTSSS', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-30T13:55:22.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: Ejecución y resolución del caso: #1207', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (110, 1207, N'RE: TESTSSS', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-01-30T13:55:23.000' AS DateTime), NULL, NULL, N'ENVIADO', N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (111, 1209, N'TEST DE CASOS CON PDF', N'CAPjTs_Deao9i-=1aYr10aCtiBmZwLudr_ZD-7dg+JrnqrY80qA@mail.gmail.com', NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[]', N'[]', N'[]', N'[
  "\"HELPDESK\" <wdevexp@outlook.com>"
]', CAST(N'2024-01-31T20:43:25.000' AS DateTime), N'CAPjTs_Deao9i-=1aYr10aCtiBmZwLudr_ZD-7dg+JrnqrY80qA@mail.gmail.com', NULL, N'RECIBIDO', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><p style="box-sizing:inherit;border:0px;margin:0px 0px 24px;padding:0px;vertical-align:initial;font-size:16px;line-height:1.75;font-family:rubik,helvetica,arial,sans-serif;background-color:rgb(235,242,245)"><font color="#3a3a3a">Freya vivía separada de su Familia en la cima de&nbsp;</font><a href="https://danmachi.fandom.com/es/wiki/Babel" title="Babel" style="color:rgb(58,58,58);box-sizing:inherit;border:0px;margin:0px;padding:0px;vertical-align:initial;line-height:inherit">Babel</a><font color="#3a3a3a">. El hogar de la Familia Freya era conocido como&nbsp;</font><b style="color:rgb(58,58,58);box-sizing:inherit;border:0px;margin:0px;padding:0px;vertical-align:initial">Folkvangr</b><font color="#3a3a3a">&nbsp;(</font><span style="color:rgb(58,58,58);box-sizing:inherit;border:0px;margin:0px;padding:0px;vertical-align:initial"><span style="box-sizing:inherit">????</span><span style="box-sizing:inherit">?????????</span></span><font color="#3a3a3a">), ubicado alrededor del centro del área de negocios y en el lado opuesto de </font>Orario<font color="#3a3a3a"> desde el hogar de la&nbsp;</font><a href="https://danmachi.fandom.com/es/wiki/Familia_Loki" title="Familia Loki" style="color:rgb(58,58,58);box-sizing:inherit;border:0px;margin:0px;padding:0px;vertical-align:initial;line-height:inherit">Familia Lok<i>i</i></a><i style=""><font color="#3a3a3a">. </font><font color="#8e7cc3">Folkvangr es una gran mansión que tiene una estructura solemne similar a un templo. Cubre una gran cantidad de terreno y está rodeado por cuatro grandes muros. El terreno de Folkvangr contiene un jardín lo suficientemente grande </font><font color="#3a3a3a">para que todos los miembros de la Familia se </font>reunieran<font color="#3a3a3a">. Verlo mostraba la riqueza, el</font></i><font color="#3a3a3a"> poder y el honor de la Familia Freya. Luego de que la facción fuera disuelta su hogar fue confiscado por el&nbsp;</font><a href="https://danmachi.fandom.com/es/wiki/Gremio" title="Gremio" style="color:rgb(58,58,58);box-sizing:inherit;border:0px;margin:0px;padding:0px;vertical-align:initial;line-height:inherit">Gremio</a><font color="#3a3a3a">.</font></p><p style="box-sizing:inherit;border:0px;margin:24px 0px;padding:0px;vertical-align:initial;font-size:16px;line-height:1.75;color:rgb(58,58,58);font-family:rubik,helvetica,arial,sans-serif;background-color:rgb(235,242,245)">Está conformada 157 miembros y, si se contaban los no combatientes y seguidores, el número t<b>otal era más de 5,000 antes de su disolución oficial. La mayoría de miembros son Nivel 2 o 3 y todo</b>s entrenaban diariamente peleando seriamente entre sí en el jardín del hogar de la Familia. Por lo menos cincuenta de sus miembros eran aventureros de segunda clase, entre Nivel 3 y 4, y ellos solos conformaban una fuerza equivalente a alrededor de 20 Familias de rango medio.</p></div>
', N'[
  {
    "Name": "ROBOTICA EDUCATIVA (1).pdf",
    "Value": "wwwroot\\Media\\Upload\\40c5f588-151a-4d18-b6f3-5e0afc2ff593.unknown",
    "Type": ".unknown"
  }
]')
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (112, 1210, N'testpdf', N'CAPjTs_AossmuWeF=k6_0RfJkJA7XUAzmi6TsvDbQ0upngJ+adw@mail.gmail.com', NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[]', N'[]', N'[]', N'[
  "\"HELPDESK\" <wdevexp@outlook.com>"
]', CAST(N'2024-01-29T18:42:03.000' AS DateTime), N'CAPjTs_AossmuWeF=k6_0RfJkJA7XUAzmi6TsvDbQ0upngJ+adw@mail.gmail.com', NULL, N'RECIBIDO', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', N'[
  {
    "Name": "FACTURA Junio DEL 2023 - NO 20.pdf",
    "Value": "wwwroot\\Media\\Upload\\dd21224c-ebbd-47e3-8a05-1f50f9218d65.unknown",
    "Type": ".unknown"
  }
]')
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (113, 1211, N'TEST PDF', N'CAPjTs_AB9K5Q5py9CVWYJFanVedRR7LMMP5=CLjH6PrKrOYa5Q@mail.gmail.com', NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[]', N'[]', N'[]', N'[
  "\"HELPDESK\" <wdevexp@outlook.com>"
]', CAST(N'2024-01-29T15:49:43.000' AS DateTime), N'CAPjTs_AB9K5Q5py9CVWYJFanVedRR7LMMP5=CLjH6PrKrOYa5Q@mail.gmail.com', NULL, N'RECIBIDO', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr"><br></div>
', N'[
  {
    "Name": "20116314@ESPECIFICACIONES TECNICAS LICENCIAMIENTO BASE DE DATOS ORACLE (1).pdf",
    "Value": "wwwroot\\Media\\Upload\\d74b000e-ad8b-4c4f-9a5b-bfa3b647e031.unknown",
    "Type": ".unknown"
  }
]')
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (114, 1212, N'TESTSSS', N'CAPjTs_B+hpByQERZoDSS0OMBsw9VWnY2oPuH5MsbYB75D1YjmQ@mail.gmail.com', NULL, N'"Wilber Jose Matus Gonzalez" <wilberj1987@gmail.com>', N'[]', N'[]', N'[]', N'[
  "\"HELPDESK\" <wdevexp@outlook.com>"
]', CAST(N'2024-01-18T14:04:06.000' AS DateTime), N'CAPjTs_B+hpByQERZoDSS0OMBsw9VWnY2oPuH5MsbYB75D1YjmQ@mail.gmail.com', NULL, N'RECIBIDO', N'<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><div dir="ltr">TESTTTTT</div>
', N'[]')
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (115, 1212, N'RE: TESTSSS("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-02-13T10:27:35.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: Ejecución y resolución del caso: #1212', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (116, 1212, N'RE: TESTSSS("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-02-13T10:27:35.000' AS DateTime), NULL, NULL, N'ENVIADO', N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (117, 1211, N'RE: TEST PDF("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-02-13T10:30:32.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: Ejecución y resolución del caso: #1211', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (118, 1211, N'RE: TEST PDF("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-02-13T10:30:32.000' AS DateTime), NULL, NULL, N'ENVIADO', N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (119, 1210, N'RE: TESTPDF("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-02-13T10:31:52.000' AS DateTime), NULL, NULL, N'ENVIADO', N'Se a creado una nueva tarea: Ejecución y resolución del caso: #1210', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (120, 1210, N'RE: TESTPDF("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-02-13T10:31:52.000' AS DateTime), NULL, NULL, N'ENVIADO', N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (121, 1212, N'RE: TESTSSS("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-02-13T14:04:48.000' AS DateTime), NULL, NULL, N'ENVIADO', N'test', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (122, 1212, N'RE: TESTSSS("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-02-13T14:05:54.000' AS DateTime), NULL, NULL, N'ENVIADO', N'prueba de un solo envio
', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (123, 1209, N'RE: TEST DE CASOS CON PDF("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[]', CAST(N'2024-02-14T14:05:27.827' AS DateTime), NULL, NULL, N'PENDIENTE', N'Se a creado una nueva tarea: Ejecución y resolución del caso: #1209', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (124, 1209, N'RE: TEST DE CASOS CON PDF("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[]', CAST(N'2024-02-14T14:05:31.637' AS DateTime), NULL, NULL, N'PENDIENTE', N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (125, 1212, N'RE: TESTSSS("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>",
  "wilberj1987@hotmail.com"
]', CAST(N'2024-03-14T11:29:20.000' AS DateTime), NULL, NULL, N'ENVIADO', N'test', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (126, 1201, N'RE: PRUEBA BASICA', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-03-18T10:04:42.130' AS DateTime), NULL, NULL, N'PENDIENTE', N'Se a creado una nueva tarea: Ejecución y resolución del caso: #1201', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (127, 1201, N'RE: PRUEBA BASICA', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-03-18T10:04:42.193' AS DateTime), NULL, NULL, N'PENDIENTE', N'El caso esta en estado: Activo, para mayor información consulte con nuestro equipo', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (128, 1212, N'RE: TESTSSS("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-04-10T14:14:48.000' AS DateTime), NULL, NULL, N'ENVIADO', N'', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (129, 1212, N'RE: TESTSSS("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-04-10T14:14:51.000' AS DateTime), NULL, NULL, N'ENVIADO', N'', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (130, 1212, N'RE: TESTSSS("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-04-10T14:14:56.000' AS DateTime), NULL, NULL, N'ENVIADO', N'', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (131, 1212, N'RE: TESTSSS("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-04-10T14:18:09.000' AS DateTime), NULL, NULL, N'ENVIADO', N'', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (132, 1212, N'RE: TESTSSS("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-04-10T14:18:14.000' AS DateTime), NULL, NULL, N'ENVIADO', N'', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (133, 1212, N'RE: TESTSSS("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-04-10T14:18:17.000' AS DateTime), NULL, NULL, N'ENVIADO', N'', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (134, 1212, N'RE: TESTSSS("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-04-10T14:18:46.000' AS DateTime), NULL, NULL, N'ENVIADO', N'', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (135, 1212, N'RE: TESTSSS("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-04-10T14:19:01.000' AS DateTime), NULL, NULL, N'ENVIADO', N'', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (136, 1212, N'RE: TESTSSS("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-04-10T14:19:02.000' AS DateTime), NULL, NULL, N'ENVIADO', N'', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (137, 1212, N'RE: TESTSSS("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-04-10T14:19:03.000' AS DateTime), NULL, NULL, N'ENVIADO', N'', NULL)
INSERT [helpdesk].[Tbl_Mails] ([Id_Mail], [Id_Case], [Subject], [MessageID], [Sender], [FromAdress], [ReplyTo], [Bcc], [Cc], [ToAdress], [Date], [Uid], [Flags], [Estado], [Body], [Attach_Files]) VALUES (138, 1212, N'RE: TESTSSS("WILBER JOSE MATUS GONZALEZ" <WILBERJ1987@GMAIL.COM>)', NULL, NULL, N'admin@admin.net', NULL, NULL, NULL, N'[
  "\"Wilber Jose Matus Gonzalez\" <wilberj1987@gmail.com>"
]', CAST(N'2024-04-10T14:19:07.000' AS DateTime), NULL, NULL, N'ENVIADO', N'', NULL)
SET IDENTITY_INSERT [helpdesk].[Tbl_Mails] OFF
GO
INSERT [helpdesk].[Tbl_Participantes] ([Id_Perfil], [Id_Tarea], [Id_Tipo_Participacion]) VALUES (3051, 2, 2)
INSERT [helpdesk].[Tbl_Participantes] ([Id_Perfil], [Id_Tarea], [Id_Tipo_Participacion]) VALUES (3052, 2, 2)
INSERT [helpdesk].[Tbl_Participantes] ([Id_Perfil], [Id_Tarea], [Id_Tipo_Participacion]) VALUES (3052, 3, 2)
INSERT [helpdesk].[Tbl_Participantes] ([Id_Perfil], [Id_Tarea], [Id_Tipo_Participacion]) VALUES (3052, 4, 2)
INSERT [helpdesk].[Tbl_Participantes] ([Id_Perfil], [Id_Tarea], [Id_Tipo_Participacion]) VALUES (3052, 5, 2)
INSERT [helpdesk].[Tbl_Participantes] ([Id_Perfil], [Id_Tarea], [Id_Tipo_Participacion]) VALUES (3052, 6, 2)
INSERT [helpdesk].[Tbl_Participantes] ([Id_Perfil], [Id_Tarea], [Id_Tipo_Participacion]) VALUES (3052, 7, 2)
INSERT [helpdesk].[Tbl_Participantes] ([Id_Perfil], [Id_Tarea], [Id_Tipo_Participacion]) VALUES (3052, 8, 2)
INSERT [helpdesk].[Tbl_Participantes] ([Id_Perfil], [Id_Tarea], [Id_Tipo_Participacion]) VALUES (3052, 9, 2)
INSERT [helpdesk].[Tbl_Participantes] ([Id_Perfil], [Id_Tarea], [Id_Tipo_Participacion]) VALUES (3052, 10, 2)
INSERT [helpdesk].[Tbl_Participantes] ([Id_Perfil], [Id_Tarea], [Id_Tipo_Participacion]) VALUES (3052, 11, 2)
INSERT [helpdesk].[Tbl_Participantes] ([Id_Perfil], [Id_Tarea], [Id_Tipo_Participacion]) VALUES (3052, 12, 2)
INSERT [helpdesk].[Tbl_Participantes] ([Id_Perfil], [Id_Tarea], [Id_Tipo_Participacion]) VALUES (3052, 13, 2)
INSERT [helpdesk].[Tbl_Participantes] ([Id_Perfil], [Id_Tarea], [Id_Tipo_Participacion]) VALUES (3052, 14, 2)
INSERT [helpdesk].[Tbl_Participantes] ([Id_Perfil], [Id_Tarea], [Id_Tipo_Participacion]) VALUES (3052, 15, 2)
INSERT [helpdesk].[Tbl_Participantes] ([Id_Perfil], [Id_Tarea], [Id_Tipo_Participacion]) VALUES (3052, 16, 2)
INSERT [helpdesk].[Tbl_Participantes] ([Id_Perfil], [Id_Tarea], [Id_Tipo_Participacion]) VALUES (3052, 19, 2)
INSERT [helpdesk].[Tbl_Participantes] ([Id_Perfil], [Id_Tarea], [Id_Tipo_Participacion]) VALUES (3052, 20, 2)
INSERT [helpdesk].[Tbl_Participantes] ([Id_Perfil], [Id_Tarea], [Id_Tipo_Participacion]) VALUES (3059, 5, 2)
GO
SET IDENTITY_INSERT [helpdesk].[Tbl_Tareas] ON 

INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (2, N'Tarea', NULL, 1202, N'tarea 1', N'Activo', CAST(N'2024-01-22T08:00:00.000' AS DateTime), CAST(N'2024-01-22T09:00:00.000' AS DateTime), NULL, NULL)
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (3, N'test', NULL, 1206, N'test', N'Finalizado', CAST(N'2024-01-22T08:00:00.000' AS DateTime), CAST(N'2024-01-22T09:00:00.000' AS DateTime), CAST(N'2024-01-17T10:39:11.000' AS DateTime), CAST(N'2024-01-17T10:39:11.000' AS DateTime))
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (4, N'ert', NULL, 1205, N'ert', N'Finalizado', CAST(N'2024-01-22T08:00:00.000' AS DateTime), CAST(N'2024-01-22T08:00:00.000' AS DateTime), CAST(N'2024-01-17T13:38:20.000' AS DateTime), CAST(N'2024-01-17T13:38:20.000' AS DateTime))
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (5, N'wer', 4, 1205, N'wer', N'Proceso', CAST(N'2024-01-22T08:00:00.000' AS DateTime), CAST(N'2024-01-22T08:00:00.000' AS DateTime), NULL, NULL)
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (6, N'asd', 5, 1205, N'asd', N'Finalizado', CAST(N'2024-01-22T09:00:00.000' AS DateTime), CAST(N'2024-01-22T09:00:00.000' AS DateTime), CAST(N'2024-03-18T10:00:37.893' AS DateTime), CAST(N'2024-03-18T10:00:37.893' AS DateTime))
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (7, N'sdf', NULL, 1205, N'sdf', N'Finalizado', CAST(N'2024-01-22T09:00:00.000' AS DateTime), CAST(N'2024-01-22T09:00:00.000' AS DateTime), CAST(N'2024-01-17T13:30:43.000' AS DateTime), CAST(N'2024-01-17T13:30:43.000' AS DateTime))
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (8, N'sdf', NULL, 1205, N'sdf', N'Finalizado', CAST(N'2024-01-22T11:00:00.000' AS DateTime), CAST(N'2024-01-22T13:00:00.000' AS DateTime), CAST(N'2024-01-17T13:30:45.000' AS DateTime), CAST(N'2024-01-17T13:30:45.000' AS DateTime))
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (9, N'wer', NULL, 1205, N'wer', N'Finalizado', CAST(N'2024-01-22T11:00:00.000' AS DateTime), CAST(N'2024-01-22T11:00:00.000' AS DateTime), CAST(N'2024-01-17T13:38:19.000' AS DateTime), CAST(N'2024-01-17T13:38:19.000' AS DateTime))
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (10, N'Asd', NULL, 1205, N'asd', N'Finalizado', CAST(N'2024-01-22T10:00:00.000' AS DateTime), CAST(N'2024-01-22T10:00:00.000' AS DateTime), CAST(N'2024-01-17T13:38:17.000' AS DateTime), CAST(N'2024-01-17T13:38:17.000' AS DateTime))
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (11, N'sdf', NULL, 1205, N'sdf', N'Finalizado', CAST(N'2024-01-22T10:00:00.000' AS DateTime), CAST(N'2024-01-22T10:00:00.000' AS DateTime), CAST(N'2024-01-17T13:38:12.000' AS DateTime), CAST(N'2024-01-17T13:38:12.000' AS DateTime))
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (12, N'asd', NULL, 1205, N'asd', N'Finalizado', CAST(N'2024-01-22T09:00:00.000' AS DateTime), CAST(N'2024-01-22T11:00:00.000' AS DateTime), CAST(N'2024-01-17T13:38:22.000' AS DateTime), CAST(N'2024-01-17T13:38:22.000' AS DateTime))
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (13, N'zxc', NULL, 1205, N'zxc', N'Finalizado', CAST(N'2024-01-22T09:00:00.000' AS DateTime), CAST(N'2024-01-22T10:00:00.000' AS DateTime), CAST(N'2024-01-17T13:38:10.000' AS DateTime), CAST(N'2024-01-17T13:38:10.000' AS DateTime))
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (14, N'wds', NULL, 1205, N'ads', N'Inactivo', CAST(N'2024-01-22T08:00:00.000' AS DateTime), CAST(N'2024-01-22T08:00:00.000' AS DateTime), NULL, NULL)
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (15, N'wer', NULL, 1205, N'wer', N'Espera', CAST(N'2024-01-22T08:00:00.000' AS DateTime), CAST(N'2024-01-22T10:00:00.000' AS DateTime), NULL, NULL)
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (16, N'sdf', NULL, 1205, N'sdf', N'Activo', CAST(N'2024-01-22T08:00:00.000' AS DateTime), CAST(N'2024-01-22T10:00:00.000' AS DateTime), NULL, NULL)
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (17, N'Ejecución y resolución del caso', NULL, 1200, N'Ejecución y resolución del caso: #1200', NULL, CAST(N'2024-01-17T14:09:16.000' AS DateTime), CAST(N'2024-01-17T14:09:16.000' AS DateTime), NULL, NULL)
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (18, N'Ejecución y resolución del caso', NULL, 1199, N'Ejecución y resolución del caso: #1199', NULL, CAST(N'2024-01-17T14:10:15.000' AS DateTime), CAST(N'2024-01-17T14:10:15.000' AS DateTime), NULL, NULL)
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (19, N'sss', NULL, 1205, N'sss', N'Activo', CAST(N'2024-01-22T11:00:00.000' AS DateTime), CAST(N'2024-01-22T13:00:00.000' AS DateTime), NULL, NULL)
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (20, N'iiiii', NULL, 1205, N'iiiiii', N'Finalizado', CAST(N'2024-01-29T11:00:00.000' AS DateTime), CAST(N'2024-01-29T13:00:00.000' AS DateTime), CAST(N'2024-03-18T10:00:39.867' AS DateTime), CAST(N'2024-03-18T10:00:39.867' AS DateTime))
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (21, N'Ejecución y resolución del caso', NULL, 1208, N'Ejecución y resolución del caso: #1208', N'Proceso', CAST(N'2024-01-30T13:37:19.000' AS DateTime), CAST(N'2024-01-30T13:37:19.000' AS DateTime), NULL, NULL)
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (22, N'Ejecución y resolución del caso', NULL, 1207, N'Ejecución y resolución del caso: #1207', N'Proceso', CAST(N'2024-01-30T13:55:22.000' AS DateTime), CAST(N'2024-01-30T13:55:22.000' AS DateTime), NULL, NULL)
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (23, N'Ejecución y resolución del caso', NULL, 1212, N'Ejecución y resolución del caso: #1212', N'Finalizado', CAST(N'2024-02-13T10:27:34.000' AS DateTime), CAST(N'2024-02-13T10:27:34.000' AS DateTime), CAST(N'2024-03-18T09:59:48.440' AS DateTime), CAST(N'2024-03-18T09:59:48.440' AS DateTime))
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (24, N'Ejecución y resolución del caso', NULL, 1211, N'Ejecución y resolución del caso: #1211', N'Finalizado', CAST(N'2024-02-13T10:30:32.000' AS DateTime), CAST(N'2024-02-13T10:30:32.000' AS DateTime), CAST(N'2024-03-18T10:00:08.690' AS DateTime), CAST(N'2024-03-18T10:00:08.690' AS DateTime))
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (25, N'Ejecución y resolución del caso', NULL, 1210, N'Ejecución y resolución del caso: #1210', N'Proceso', CAST(N'2024-02-13T10:31:52.170' AS DateTime), CAST(N'2024-02-13T10:31:52.170' AS DateTime), NULL, NULL)
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (26, N'Ejecución y resolución del caso', NULL, 1209, N'Ejecución y resolución del caso: #1209', N'Proceso', CAST(N'2024-02-14T14:05:22.033' AS DateTime), CAST(N'2024-02-14T14:05:22.033' AS DateTime), NULL, NULL)
INSERT [helpdesk].[Tbl_Tareas] ([Id_Tarea], [Titulo], [Id_TareaPadre], [Id_Case], [Descripcion], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Fecha_Inicio_Proceso], [Fecha_Finalizacion_Proceso]) VALUES (27, N'Ejecución y resolución del caso', NULL, 1201, N'Ejecución y resolución del caso: #1201', N'Proceso', CAST(N'2024-03-18T10:04:38.730' AS DateTime), CAST(N'2024-03-18T10:04:38.730' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [helpdesk].[Tbl_Tareas] OFF
GO
SET IDENTITY_INSERT [helpdesk].[Cat_Cargos_Dependencias] ON 

INSERT [helpdesk].[Cat_Cargos_Dependencias] ([Id_Cargo], [Descripcion]) VALUES (1, N'Encargado')
INSERT [helpdesk].[Cat_Cargos_Dependencias] ([Id_Cargo], [Descripcion]) VALUES (2, N'Coordinador')
INSERT [helpdesk].[Cat_Cargos_Dependencias] ([Id_Cargo], [Descripcion]) VALUES (3, N'Tecnico')
SET IDENTITY_INSERT [helpdesk].[Cat_Cargos_Dependencias] OFF
GO
SET IDENTITY_INSERT [helpdesk].[Cat_Dependencias] ON 

INSERT [helpdesk].[Cat_Dependencias] ([Id_Dependencia], [Descripcion], [Id_Dependencia_Padre], [Username], [Password], [Host], [AutenticationType], [TENAT], [CLIENT], [OBJECTID], [CLIENT_SECRET], [HostService], [SMTPHOST], [default]) VALUES (1, N'DEPENDENCIA usav', NULL, N'wdevexp@outlook.com', N'%WtestDev2023%1', N'outlook.office365.com', N'BASIC', NULL, NULL, NULL, NULL, N'OUTLOOK', N'smtp-mail.outlook.com', NULL)
INSERT [helpdesk].[Cat_Dependencias] ([Id_Dependencia], [Descripcion], [Id_Dependencia_Padre], [Username], [Password], [Host], [AutenticationType], [TENAT], [CLIENT], [OBJECTID], [CLIENT_SECRET], [HostService], [SMTPHOST], [default]) VALUES (2, N'DEPENDENCIA 1', NULL, N'wdevexp@outlook.com', N'%WtestDev2023%1', N'outlook.office365.com', N'BASIC', NULL, NULL, NULL, NULL, N'OUTLOOK', N'smtp-mail.outlook.com', NULL)
INSERT [helpdesk].[Cat_Dependencias] ([Id_Dependencia], [Descripcion], [Id_Dependencia_Padre], [Username], [Password], [Host], [AutenticationType], [TENAT], [CLIENT], [OBJECTID], [CLIENT_SECRET], [HostService], [SMTPHOST], [default]) VALUES (3, N'DEPENDENCIA 3', NULL, N'test@test.test', NULL, N'test', N'BASIC', NULL, NULL, NULL, NULL, N'OUTLOOK', N'smtp-mail.outlook.com', NULL)
SET IDENTITY_INSERT [helpdesk].[Cat_Dependencias] OFF
GO
SET IDENTITY_INSERT [helpdesk].[Cat_Paises] ON 

INSERT [helpdesk].[Cat_Paises] ([Id_Pais], [Estado], [Descripcion]) VALUES (10, N'Activo', N'Honduras')
INSERT [helpdesk].[Cat_Paises] ([Id_Pais], [Estado], [Descripcion]) VALUES (11, N'ACTIVO', N'Nicaragua actualizada')
INSERT [helpdesk].[Cat_Paises] ([Id_Pais], [Estado], [Descripcion]) VALUES (12, N'ACTIVO', N'Mexico')
SET IDENTITY_INSERT [helpdesk].[Cat_Paises] OFF
GO
SET IDENTITY_INSERT [helpdesk].[Cat_Tipo_Evidencia] ON 

INSERT [helpdesk].[Cat_Tipo_Evidencia] ([IdTipo], [Descripcion], [Estado]) VALUES (1, N'IMG', NULL)
INSERT [helpdesk].[Cat_Tipo_Evidencia] ([IdTipo], [Descripcion], [Estado]) VALUES (2, N'PDF', NULL)
SET IDENTITY_INSERT [helpdesk].[Cat_Tipo_Evidencia] OFF
GO
SET IDENTITY_INSERT [helpdesk].[Cat_Tipo_Participaciones] ON 

INSERT [helpdesk].[Cat_Tipo_Participaciones] ([Id_Tipo_Participacion], [Descripcion]) VALUES (1, N'Colaborador')
INSERT [helpdesk].[Cat_Tipo_Participaciones] ([Id_Tipo_Participacion], [Descripcion]) VALUES (2, N'Coordinador')
SET IDENTITY_INSERT [helpdesk].[Cat_Tipo_Participaciones] OFF
GO
SET IDENTITY_INSERT [helpdesk].[Cat_Tipo_Servicio] ON 

INSERT [helpdesk].[Cat_Tipo_Servicio] ([Id_Tipo_Servicio], [Descripcion], [Estado], [Icon]) VALUES (1, N'Servicios de Asistencia', N'Activo', N'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')
INSERT [helpdesk].[Cat_Tipo_Servicio] ([Id_Tipo_Servicio], [Descripcion], [Estado], [Icon]) VALUES (2, N'Servicios Economicos', N'Activo', N'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')
INSERT [helpdesk].[Cat_Tipo_Servicio] ([Id_Tipo_Servicio], [Descripcion], [Estado], [Icon]) VALUES (3, N'Servicios Académicos', N'Activo', N'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAB2AAAAdgB+lymcgAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAPfSURBVHic7dtLaFxVGMDxX9LaNibFCoqmahMjpFK0KkUXihUhG0GXLtxY3LgRUXxQdVU3VnyBO12JQVy4ERSs0iBSXfmu+FhpoKC12JpWG/OgTV18d0xynUlmpvfeudPeP3ybcOac73Ve37mhoqKioqJjXJvIeUM/xvAqDuFMIkcwjnuxqWPa5cQIHsF+zFk0upGcwpfYgx3oKVzjs6RRlNuVrsiOVqPcrpQmO7KOcldkR1FRLk12lCXKhWfHnfgY8yUwIiuZT2y6I21sOk36Es9tbMVjXcQJXCamMOhNNViPC4vUqGD6hY3/sSbVYBYzuA0XFKRUUfyDZ/DJ0j82Win7hBPGcA+25alZjkyKXWsCH+LvdINmt4oR4Ywx3IWBjBTMmll8JgyewFd5DNInHPE8ftD5Ff4XvC62u44s3iN4EO+IFMvb4BmR1rvFgadU5JUdHY9yu7SbHe1GeRA3Z6R75qyWHe1GeQDP4Rss4I3sVG6NPhGBZhnFA4mMtvC7wWSsGsOWO7JjDqgp8rO4QI1hXQb9rhHTYI+47S0kY6XHLY0DlspJvC/WgStb6OtSMRXG8WedfodXGLclB6xtpXEb9OPuROBH4ZAJHBC3NCLKN1o8ed6qoGpP3g5Isy2R3ZgW06VH7Bb9BeuC4h2wlH5s7+D4+P91+Gz4w5J7do7MJWNlQpYOmMYTFud1Hszj8WSs0rJFbIMzsi1pjeOaOuMNK8k2mCYLR6xkeI0hJXVAjXYc0YzhNdZhaslvn8xW/ewYwmtWflOYS9oMtdj37XgXe7EhI31zY1QchNLG79fanaCr6RXROp3IXtnuSF3DFlzVaSUqKirOX+rduXfiMdldT8/gsHileQ9fr9J+h6gJXC3KX1nVBabxiqhDNGQ9jsvuDF9PvhUHlzQ7cTDnsaesUqZLn6vzktOiklujdiYoYuxlp8x0QaSoj4568XSiEDxV0LikbMzD4I2iVj8gSl3bcb1I++Em+5jEp/heTItJUWA9qc4Lb7fQg1vwolgU06n5G15Q4pedLNmAh3EMR/GQ1JcbRVGbAtfh8gz6WxC7yHGx4k6t0v4SEf1jq7S7OJFNiWRxcfpdTDEvy2/FPYoP8Kyo+zfLTclv9iV95KXfS/BXjgOk5XPsUn/x7RXvhF8UqM8J+KjAAWtyAFuXGL9VrPpF67GvR2xXu2R3L1+Li7AZN+CKBu1m8bbIhvs0LmX9Kk6Ph0XETmWk5yFRd8ydzXgU32k+MgfFd8mtPLeXnh7cb+VFbUoYfk6XxwbxluXfIs/hTR2IeCf/HWXA4j9M/aTkz10VFRUV5yT/AgeCSWxx2ygvAAAAAElFTkSuQmCC')
SET IDENTITY_INSERT [helpdesk].[Cat_Tipo_Servicio] OFF
GO
INSERT [helpdesk].[Tbl_Profile_CasosAsignados] ([Id_Perfil], [Id_Case], [Fecha]) VALUES (1, 1209, CAST(N'2024-02-14' AS Date))
INSERT [helpdesk].[Tbl_Profile_CasosAsignados] ([Id_Perfil], [Id_Case], [Fecha]) VALUES (1, 1210, CAST(N'2024-02-13' AS Date))
INSERT [helpdesk].[Tbl_Profile_CasosAsignados] ([Id_Perfil], [Id_Case], [Fecha]) VALUES (1, 1211, CAST(N'2024-02-13' AS Date))
INSERT [helpdesk].[Tbl_Profile_CasosAsignados] ([Id_Perfil], [Id_Case], [Fecha]) VALUES (1, 1212, CAST(N'2024-02-13' AS Date))
GO
SET IDENTITY_INSERT [helpdesk].[Tbl_Servicios] ON 

INSERT [helpdesk].[Tbl_Servicios] ([Id_Servicio], [Nombre_Servicio], [Descripcion_Servicio], [Id_Tipo_Servicio], [Visibilidad], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Id_Dependencia]) VALUES (4, N'Servicio 1', N'MANTENIMIENTO', 1, N'publica', N'Activo', CAST(N'2021-01-12' AS Date), CAST(N'2021-12-12' AS Date), 1)
INSERT [helpdesk].[Tbl_Servicios] ([Id_Servicio], [Nombre_Servicio], [Descripcion_Servicio], [Id_Tipo_Servicio], [Visibilidad], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Id_Dependencia]) VALUES (5, N'Servicio 2', N'Planeación estratégica ', 3, N'publica', N'Activo', NULL, NULL, 2)
INSERT [helpdesk].[Tbl_Servicios] ([Id_Servicio], [Nombre_Servicio], [Descripcion_Servicio], [Id_Tipo_Servicio], [Visibilidad], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Id_Dependencia]) VALUES (6, N'Servicio 3', N'Migración de sistemas ', 3, N'publica', N'Activo', NULL, NULL, 2)
INSERT [helpdesk].[Tbl_Servicios] ([Id_Servicio], [Nombre_Servicio], [Descripcion_Servicio], [Id_Tipo_Servicio], [Visibilidad], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Id_Dependencia]) VALUES (7, NULL, N'TSTE', NULL, NULL, N'Activo', NULL, NULL, 3)
SET IDENTITY_INSERT [helpdesk].[Tbl_Servicios] OFF
GO
INSERT [helpdesk].[Tbl_Servicios_Profile] ([Id_Perfil], [Id_Servicio]) VALUES (3052, 6)
INSERT [helpdesk].[Tbl_Servicios_Profile] ([Id_Perfil], [Id_Servicio]) VALUES (3054, 5)
INSERT [helpdesk].[Tbl_Servicios_Profile] ([Id_Perfil], [Id_Servicio]) VALUES (3054, 6)
GO
SET IDENTITY_INSERT [security].[Security_Permissions] ON 

INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado]) VALUES (1, N'ADMIN_ACCESS', N'Activo')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado]) VALUES (2, N'ADMINISTRAR_CASOS_DEPENDENCIA', N'Activo')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado]) VALUES (3, N'TECNICO_CASOS_DEPENDENCIA', N'Activo')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado]) VALUES (4, N'ADMINISTRAR_USUARIOS', N'Activo')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado]) VALUES (5, N'ADMINISTRAR_CATALOGOS', N'Activo')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado]) VALUES (6, N'GENERADOR_SOLICITUDES', N'Activo')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado]) VALUES (7, N'PERFIL_ACCESS', N'Activo')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado]) VALUES (8, N'PERFIL_MANAGER', N'Activo')
SET IDENTITY_INSERT [security].[Security_Permissions] OFF
GO
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (1, 1, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (1, 2, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (1, 3, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (1, 4, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (1, 5, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (1, 6, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (1, 7, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (2, 6, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (2, 7, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (3, 3, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (4, 2, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (4, 3, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (4, 6, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (5, 3, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (5, 7, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (6, 2, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (6, 3, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (6, 6, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (6, 7, N'Activo')
GO
SET IDENTITY_INSERT [security].[Security_Roles] ON 

INSERT [security].[Security_Roles] ([Id_Role], [Descripcion], [Estado]) VALUES (1, N'ADMIN', N'ACTIVO')
INSERT [security].[Security_Roles] ([Id_Role], [Descripcion], [Estado]) VALUES (2, N'SOPORTE', N'ACTIVO')
INSERT [security].[Security_Roles] ([Id_Role], [Descripcion], [Estado]) VALUES (3, N'TECNICO', N'ACTIVO')
INSERT [security].[Security_Roles] ([Id_Role], [Descripcion], [Estado]) VALUES (4, N'GESTOR DE CASOS', N'ACTIVO')
INSERT [security].[Security_Roles] ([Id_Role], [Descripcion], [Estado]) VALUES (5, N'TECNICO', N'ACTIVO')
INSERT [security].[Security_Roles] ([Id_Role], [Descripcion], [Estado]) VALUES (6, N'GESTOR DE CASOS', N'ACTIVO')
SET IDENTITY_INSERT [security].[Security_Roles] OFF
GO
SET IDENTITY_INSERT [security].[Security_Users] ON 

INSERT [security].[Security_Users] ([Id_User], [Nombres], [Estado], [Descripcion], [Password], [Mail], [Token], [Token_Date], [Token_Expiration_Date]) VALUES (1, N'ADMIN', N'ACTIVO', N'ADMIN', N'PxI/Pz8/Pz8/PwdSP2E/Pw==', N'admin@admin.net', NULL, NULL, NULL)
INSERT [security].[Security_Users] ([Id_User], [Nombres], [Estado], [Descripcion], [Password], [Mail], [Token], [Token_Date], [Token_Expiration_Date]) VALUES (2, N'Gestor prueba', N'ACTIVO', N'test', N'cGpBP2kPGzdLdgp7Pxk/Pz9CeT8/P3NwRj8PaAA/P1M=', N'gestor@gestor.net', NULL, NULL, NULL)
INSERT [security].[Security_Users] ([Id_User], [Nombres], [Estado], [Descripcion], [Password], [Mail], [Token], [Token_Date], [Token_Expiration_Date]) VALUES (3, N'Tecnico 1', N'ACTIVO', N'tecnico', N'Hj8/bGo/Pz8/Pz8/P2EnPw==', N'tecnico@tecnico.es', NULL, NULL, NULL)
INSERT [security].[Security_Users] ([Id_User], [Nombres], [Estado], [Descripcion], [Password], [Mail], [Token], [Token_Date], [Token_Expiration_Date]) VALUES (4, N'Tecnico test2', N'ACTIVO', N'tecnico 2', N'P3QyPzZ7P20/Ex8/Kj9APz1XFBBxP3s/PyQ/Q1UaPyY/Rz8/Pz9yZidiPztyPz8/', N'tecnico2@tecnico.net', NULL, NULL, NULL)
INSERT [security].[Security_Users] ([Id_User], [Nombres], [Estado], [Descripcion], [Password], [Mail], [Token], [Token_Date], [Token_Expiration_Date]) VALUES (5, N'test', N'ACTIVO', N'test', N'Ej8/Pz9pFD8/fz8/Pws/IRQ/UgQ/fz86AiQ/FT88WBY=', N'test@prop.test', NULL, NULL, NULL)
INSERT [security].[Security_Users] ([Id_User], [Nombres], [Estado], [Descripcion], [Password], [Mail], [Token], [Token_Date], [Token_Expiration_Date]) VALUES (6, N'tetet', N'ACTIVO', N'test', N'Pz8/Cz8ePz8/Rz88P1I/bys/Pz8/BBg/Vig/Pz9+Pz8/ZhA/Pz8/DD8sDD8/Pz8/XD90bz8nWxoDKD8uOHYyPz8zfQ5iP0A/Sz8/Pz9nP1kLez8+CU0+Pz8/KT8/Pz8sP0I/SD8/Pz8/Pz8VTT9KBA==', N'test@test.testmail', NULL, NULL, NULL)
INSERT [security].[Security_Users] ([Id_User], [Nombres], [Estado], [Descripcion], [Password], [Mail], [Token], [Token_Date], [Token_Expiration_Date]) VALUES (11, N'dfg', N'ACTIVO', N'dfg', N'PxAZP0U/Pz8/PxpMOT8/Pw==', N'dfgdfg@la.es', NULL, NULL, NULL)
SET IDENTITY_INSERT [security].[Security_Users] OFF
GO
INSERT [security].[Security_Users_Roles] ([Id_Role], [Id_User], [Estado]) VALUES (1, 1, NULL)
INSERT [security].[Security_Users_Roles] ([Id_Role], [Id_User], [Estado]) VALUES (6, 5, N'ACTIVO')
INSERT [security].[Security_Users_Roles] ([Id_Role], [Id_User], [Estado]) VALUES (6, 6, N'ACTIVO')
INSERT [security].[Security_Users_Roles] ([Id_Role], [Id_User], [Estado]) VALUES (6, 11, N'ACTIVO')
GO
SET IDENTITY_INSERT [security].[Tbl_Profile] ON 

INSERT [security].[Tbl_Profile] ([Id_Perfil], [Nombres], [Apellidos], [FechaNac], [IdUser], [Sexo], [Foto], [DNI], [Correo_institucional], [Id_Pais_Origen], [Estado]) VALUES (1, N'Wilber', N'Matus', CAST(N'1987-07-24' AS Date), 1, N'Masculino', N'\Media\profiles\avatar.png', N'1112dfg', N'Wilber@unaun.edu.ni', 11, N'ACTIVO')
INSERT [security].[Tbl_Profile] ([Id_Perfil], [Nombres], [Apellidos], [FechaNac], [IdUser], [Sexo], [Foto], [DNI], [Correo_institucional], [Id_Pais_Origen], [Estado]) VALUES (3049, N'Gestor 1', N'test', NULL, 2, NULL, N'\Media\profiles\avatar.png', NULL, N'test@test.es', 11, N'ACTIVO')
INSERT [security].[Tbl_Profile] ([Id_Perfil], [Nombres], [Apellidos], [FechaNac], [IdUser], [Sexo], [Foto], [DNI], [Correo_institucional], [Id_Pais_Origen], [Estado]) VALUES (3050, N'Tecnico 1', N'test', CAST(N'2023-09-14' AS Date), 3, N'Masculino', N'\Media\profiles\a46f8bfe-4465-4c9d-99a0-f6d69057458c.png', N'001', N'tecnico@tecnico.es', 10, N'ACTIVO')
INSERT [security].[Tbl_Profile] ([Id_Perfil], [Nombres], [Apellidos], [FechaNac], [IdUser], [Sexo], [Foto], [DNI], [Correo_institucional], [Id_Pais_Origen], [Estado]) VALUES (3051, N'Tecnico 2', N'test', NULL, 4, NULL, N'\Media\profiles\avatar.png', NULL, N'tecnico2@tecnico.net', 10, N'ACTIVO')
INSERT [security].[Tbl_Profile] ([Id_Perfil], [Nombres], [Apellidos], [FechaNac], [IdUser], [Sexo], [Foto], [DNI], [Correo_institucional], [Id_Pais_Origen], [Estado]) VALUES (3052, N'test', N'test', CAST(N'2024-02-06' AS Date), 5, N'Masculino', N'\Media\profiles\avatar.png', N'5dfghdfg', N'test@test.testa', 10, N'ACTIVO')
INSERT [security].[Tbl_Profile] ([Id_Perfil], [Nombres], [Apellidos], [FechaNac], [IdUser], [Sexo], [Foto], [DNI], [Correo_institucional], [Id_Pais_Origen], [Estado]) VALUES (3053, N'test', N'test', CAST(N'2024-02-01' AS Date), NULL, N'Masculino', N'iVBORw0KGgoAAAANSUhEUgAABBAAAAFnCAYAAAAferouAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAANT7SURBVHhe7J0JfBVFtv9/omwJZIUQ9oQAJrJkwioYNiE4YAQReDAqyrD4ZJ6gjozDDOKgyAyjOKPgX3yyDIoieRAQDTISEFkEWSQTdoGQsEMgK4QIuPzrVFX37Xtz783NSpbz9dOm+3R1VXV138s9p845dYfXn7b/0uLuDjD4KW0fbv5rrD5iGIZhbjcPPPAAGjRogI8//lhLGIapLtTr9AgGYgNW77umJWULfdf88ssvyMzMlH9Lg/DwcJw5c0YfMQzDAA8++CDCwsKwcuVKXLhwQUuZykCNH2/exK2ffsaPP/+C3KM7kB/3e32KYRiGYRiGuZ1c27e63IwHxJUrV5CRkVFqxgOC6rrrrrv0EcMw1Z3AwEA0btwYGzduZONBJeRO32atZ/6ceRb44Le4c/+nqHErX59iGIZhKgKtW7eGl5cXDhw4oCUMwzCVh/r16+PHH3+UG8MwTH5+Pvbt24fLly9rCVOZuKNly5alZ2JmGIZhGIZhGAsBAQFy45lGhmGYyk8N/ZdhGIZhGIZhSh3Kp0DeB76+vlrCMAzDVFbYgMAwDMMwDMOUKefPn0etWrVk3HOdOnW0lGEYhqlscAgDwzAMwzAMUy5QKIOPjw9q166NO+64Q0sZhmGYygIbEBiGYRiGYRiGYRiGKRQOYWAYhmEYhmEYhmEYplDYgMAwDMMwDMMwDMMwTKGwAYFhGIZhGIZhGIZhmEJhAwLDMAzDMAzDMAzDMIVyR7t27TiJIsMwDMMwDMMwDMMwbrkjODi4VAwIgYGByMjI0EcMwzBVH/7eY8oKercOPRSnj5iqTLvPR/H3CMMwDFNpYAMCwzBMMeHvPaasoHfr2rVr+oipytSrV4+/RxiGYZhKA+dAYBiGYRiGYRiGYRimUNiAwDAMwzAMwzAMwzBMobABgWEYhmEYhmEYhmGYQuEcCJWc1q1b6z2GqdicOHFC71Ud+HuPKSs4B0L1gXMgMAzDMJUJNiBUcsiAkJeXp4+Kh7e3d4nrYBh30DvGBgSG8Rw2IFQf2IDAMAzDVCY4hIFhGIZhGIZhGIZhmEJhAwLDMBUMbzS/JxKRUZGIaOatZQzDMAzDMAzD3G7YgFAVad8WA5Y8gsFTm6Kel5YxTEXHOxI9O/uLnYF4+qWpeHrCVMx87kF5KqJjJKq2KaE2pjZojHl+9RCpJQxTHLyb3oXh4+qifwstaHEXfjOuDvo31ccMwzAMwzAl4M4///nPM7t37w65RbVCjbMHcbYYYZdeXl7Iz8/XR0x5ERAQgFu3bukjTesWuKeLD2r7tETEAw3x85UzuHzWdaqLWrVqFazD4N4pePsvEzB8yBAMEduvvD7H1kP6nAeMfHkh/rtDOv69+5yWFJeRmLHweYzR/RhyfyjSv9yFYtc6agbe7nfDbb+o788/XrT27O5XtLHwuTEYElUHnwcPd9Jed0z550w82qbk49P9mRkYXmMrdp1VdQ70K9pzkuP7zwG4oe+x9J6bgt6xzMxMfeQE756Y8uZ0jI0dhP6dGiIgfxfGT0lD7zGR6N77CYx8qC96BZ/H17vPwMWbelsove+9uhjdrAlaIR9JV/ORpqVM9YXerZs3b+ojT6mJP7/TAr2Db+HSwR+QfEmIQmpj+LBGePABIPfTG6h6mUgqP/T9yL+fGIZhmMpCjaVLl4K2nefF0V0N0fXh36BHsDp5W5g4DwkJCXqbh/FSOB7zls9EX7lPiOP5+sz8BMTNsJ2h6+dN1Pt29MXM5Qn256gtN/UW7Ic9Lsv0m4k4B7m1rNGHvjPi7PrTd8Y8zOynD6gvZh0O9+gR2fjP77/E3gte6Ph0cb0RhDI6Kgwpiydi4kS1zYrTpzxk5asT8ew7u/RRCbl2AIt0PzZkdcDAUVpeFgjlfyA2mPc98fl58OQubPcrxu5eYANd++pKddKRe7sjDNeByIFCfS8tdmHe80V/To6U6nPzgEbDR+O+WwkY8+jb2FPTG1lH9wrpXiSfqQ3snItxs/ag1gPjMf4eVb76cgvzXvnB8p0lGHANCc+W1Kwi6v3nRSToLe6xn7W8mFCfHPtZBMY/Wwp9qJbchXrewNmd2fgwWYuS8/HKzjzAuyaCtMg57dFj0f2or48kT47AiNfb6wMXiDIDXzRqDkL4ot+jx5O0b19f/RdHILy3PvCA+i+O1/XYaPr67y1tVTBChmL60nXYtu977N++Gu/9fiia61MMwzAMU5WokZubC9qu/yiOzu7EpnO+t92IcHJtLGJjxbYWGFio4nwSl4ImWRRvF/TriwjkoVFHe1PAyYwATHLaxkmsoT7Q9mYmBjo1Irguc2nXXCWPnYLFUmKUXSMNDO7viowHkUg26hbbqFlf63NF4PpVnHhlPf7vw6P4qXUPxP6jD+65tyhRKy3gW0/vWiGvhJdHylnqhQtpe1sqy8TIl8X+MzOkfIZQ8GlmXJ2jmXGx/8zbBa6Rs99SJjZRZobY3CvU3dHY/zpyTulDWbfRl4V4+5nuWi4gLwCj7oW6XpINaAGvyAmivSni6oJ0b9hA71nQ962gPjvct9g37nfkyxPQoV4LDKT+/G2O0/a6dwnDlW+fxfYzLRBuMYbIukaJtox+G226GXcrI1+2jJ/1/mU9lrE2ryfZQLSo1wETtMz23BRe4eEI0/sFaBWO8BKGylz6cAE21+iLqQOS8d7z4zHlf0+jVZvTWPznKZj5fzcx5r/vA7YswLzD+gKmVBn/bAawLhixz6tt1McljG7bWA+xf6mDYnxrSRa/XQp9cELNu37B8H55mPV0Fmb/LhPjh1xFrZrOvbMi29yU5Z4dnYO6dWxlBt6bj7+Ka/t2/kFLKhI/4pqriezcW8X32PKYdByd8A/s/EAfljLnXvwHNryero9Kl9r166LrM79G8+hwLQHCh3XDr35b2I8Loh/+vvh1TOzbDs0DasOnWSf8esrr+NcbnlzLMAzDMJUL+19odwFntqzFnuwAaUToepsN/X2DG+HSxcJ/giavPoKIRwqq91b6Rkfg0uYFOBIYaW8I2L8aRyIecWIcsLB5JhbsaoRIp54NGk/KGGSccfvDuu+MgcBaw/BQcn7+6iC+/P167DxXX3oj9B6hTxTKSszaeAUdxjso5UTzgQj/Xs/OUxmh8KoSXugQcNSFt0ILoYQut10zUKm5I18eiAbJi5Q8LgcNnBktCKngkuI7AWEpyzHvWyUmZT0sRV8/cQOuRD6qlF9SuAdoLwCxLUpugIGkRMfNEu2fxnVq04Vnwa53luOA/0DRlkUZ//YCrjQPV8ejwsXdeMG3JR2MRLh/Cnbp/hArX12EA9dOy7af/dM0J+11R/ewKzgqxmjl96fR4m6zFYEYQ9H/5bLfoh7RDzLGSFyOuxMc7l95QohnahwvTkGYfAYk24DT0sPjWXNcrYR1fhS/mz6yoBGh1UjMmDwSHUpicBw8E8tW/hUPiO+bWgGtAe9hmL38Pbzy8nuI++d4NEct3MrJRK0uf0Dc4j8jVl/mCf59hiG2oy17gnfHgRhodxyLYX0o70IVgWb+Hb0IXMjiHvtBeR08e0MoPUpcEItnguFRYHdtvvh7zfL9qT0k7hbnTQ+CnzHzFV3HP7Mx825HmfV6Rd/HrulyVs8IfS3dj9XjQvZHtCXajDPLFqyTIGPB5Zw78belflj0qQ8a+P2EiBDX3hs/iWp9vH9GSGNVxqvOL2jT/Bbyb9whjysWd6DXRF+0qvsD0lO1yCD1JrJ9fPDrp+9CMy0qGuRZMALhL47HiP/7vdjGK28C8lB4sAV8ujyOEdrboOnrI9CUvA/+byCa+vwKDxhlrdB1sh57jwLyMDDqb+/EhmvzYlCeDqostacgrwWjXqM/6H0/Br5+v628o5dFaTBjKkaF1dYHBrXRethUTNdHDMMwDFNVsDcgNOmBsWNHomvQneKXVkM0a6jl5UyrocptfxIWYMpCLXQHKe/pA12ELhB90TfiEpIXfo2vjzgq+V9j5sJMDNShC674+iIFk7rHWqZR96kq/MAMkWiFYTIcYRiwvzDTwCVk6kBVCnMoXgiDPT6P/AodQusAQqk9laSFnkDKtlA2twdMsFemz2ywGQjijuJ0PV+hUBPXcWCDC5d9nMZ2wy2erpE7QvlubpF/uwsprnJwWEIYluNRbdRwuF4owxuSIRV7muFH8gYhUex6ZztO+zd2rXDboUIBJi7OQfRCw4CyEkfPNEBjmqEXn40DGw+gASn+9zZGg6wLHoU4mFD4QtZR1TcaC8MwIRFjGGcYGnZhV8p1NGioe+1y3AvieP8G3Q0vkPEd4OXheBz4eA4+Pt3B3oggjQfhODp/Flae1LLi0DQAtfa/jWEjx+AP/xIPb3g/tE5ZhjFjluFEk0gMRDIW/3k8xoxagCN1g9FIX1Y4ffHsf4/H078bo6/pgmdfmIIpLzwr9ohGGPO7pzH+v58txCOosiCU7QeBNVYvAlKq29U2PQs2NMjVijng3eVHJJP87dqYudwPjR4UirddKAQp+TdUGdq2/YhJ2ihgu7YuktOuIXKAFAtl/gYaHatlZyAd/2w6Io4F6T74Yeb3JMsFlut637sLA12GYNTEFKP99+og4tei3MbaOBlywzQQjG/3I47sFff6fR2MMsquAwaaBgwbefk1sHVfHVz/4Q78cOMOaSCgzRU/3LwDFzPuRKe7VS6CiJCbqHnnL+L60veOKDm/wLuO+Lf7lrMb+sX9jXpEC/Hf51j1X//AqnU5aB/bHvhgldg/jdy9H2HVhK9wVZcEDmLnf23Audz/4Mv/WoyjW7WYIIW+3VFVj9gONXjINEb0CKDyJP8cWQG+qrwT6r/4EFocE23KsquUZ4W4/oG2qfr6f2Bn5q/QwzBOhIQCH9rk7R1CI0pKp4Y+es+Bu3wQ1FXvMwzDMEwVwfwVdOjTeZg3z9g24YyW3w5kCMObe8WvNaH4S0kKMjPkjku+nrXBdWgAhS/4KAV+andvtHIIYyADxAahprgLg+gbDFOpd4W1jBnC8OhM/WPaFu6Q3DFOtuXaKNEINBFLfD1rlByLws0XLghrjC5/H4rBAxrg1t4t+L9nduNUij5XBCgmfuJG8aPcdOG/vezaK24irLuHxoDCsIZAOIRPfDsPz05chJQw5dWw8vsrCOsyEt0DcrArbpd4MxtjJIUifO/KaOKckQOF8t6cPByozYHyp7k1jKHMGDUDEwK2Kw8E8jrQ4sK5jn3L5mDhyXBlRCgt4wFx7iKuRUxCXNwyzJsoVPv4zTgRNgbLlo1B61PbxWezOcbPjcOaNc8i8qfMInwWvsbb/7sY7727TF+zF2+/Kb7f3nxb7BGXsOzd97D4f9926xFUeagplflhltwDfbv8AO+QDD0rfxHDQn5AgA7MztvrZfNy0sr33Ct5tpl+oTRH+Ij6jFn9B6/Bu8FPsrj12sX/9kOjdsoAYCrzJrcQGVIPG+zCEUj2A7o8ret9OhveAT+5NOL0fSzboVxNrN77ozZaiLoC6uDr72VRmTvBsa/OqO/1M4b2zUNu3p04drqmljrn+JlaaNLwRzQO/AnhIbdw7spd+kzF49/zM/B9vheChL5sR2ht+P38A75970ec1aKicxqHjPCBD44WOxyi/r2h8AkZaHoK9Ajxhb/ob9N2LXBum2GESMe5YzlyzxlXv00FujxulyPB/nrxtZLwH6CBNiCk7TKNGOcOef6t5yn7LufqPQd+zEX6Hr3PMAzDMFWEijiNoiCvgiMReMTwFgiMQF9DwZ8YiUbpjlrwYkzZHIBJ/QrOT8rwBSOvQuxc7HUMYxAsnrwBARMHOp/dnDgPUyMy8fVmfewMT8o4wWbMIC8J4Iy4/uvtR9BoqPPEjUWhzohuiJ1+H1p7X8DOv6/Fl+9eRknnoEwsM+bdn4lGizN6Nr3InEbONYvyTDPzrkIYLMjZ9ZRd2CW9Alog2gyxGImBkZD5EaSRwZKgUPbTqaeA9jaQSrVQiLXUKafEj9qwaISB6tkl/h+GaB2K4DnKa8IMLaBt8QE0uNcWBhLWxf5+UvbqXhdh3B3vn6DcDtcz9Q9oGYZRFK7j6CdvSiPClGdLyXhAfPFXjH/0Dey5Vg81a+QJ7XQNpj86DlOeG4dRL/4fziATmTdv4uK//4xhY2YiQV/mCVlb1iBhv6hTk7d/AzbYHSdgzZYsfVS+DPRtgQU+ddDzzlr4L78gtCLhjRsoVN/w+bFgKImGcgfELgcmCSXaCFfI22vM/qttykYpdsrXH/upmf5HtREi1w9zLdfGvu1E2f6+Fo4EkEeAUObhLT0MCqee6SkhN1f5EgZcw9QG3rpcIIzX7eu9dZTRYsANYJu6lgwNA6/oe33PD7anbE+zoB/x9PBcZF+tgaUJ9XDzlvtwhNMX75SeCJ3Cb6Ch/084fNK9weH2UhP+LibDUfOOwpdC9QmAq8tLE+mxoD0FpFdAUXMmbP0KG8R1p9uREcIWwlDa3FnrLvyQ7epNsjBrLuJSxLtoxw2cWDMXs/URwzAMw1QVKq4BQSC9CqQiTWEGRxDxgl6VYCiwwVlSwYWrcaTATyQjfEEfiroKhjEQi7H6CCxXGyEHYuuXibmmJ4EV12XMEIYE5W1gLTswfQFmkqFh4RSswTBdbioijqxWs3qbZ2LUWtjqfiEAyUVOotgQHWMb27wOxL0VHWvCPbFRPL2xosAZIFzLJ4SlYJGrlQYKRSjvcUJ5HqDbGOWLK65CGMwcCKrN5TpsYeWrlPeAQizo3EBgo47j/3YellPeA8s1Zj/jjqprXCVRNJM90mbJuUAhFkLBNzwOyCPBCzmFz+Rb2yPF3VHxl/WGobtMXHgdVwIe1W1b7ocoyrg73D8lUaQwDnOs7ibzjcFKHM2yJVF0DRkRZuHZZ0vJeKCJeHaS+KR+g/c+Esr0jHmY/dvWyMpojafnL8a833XF129+jVsDJmF8E31BZecOL8T41Ufz4Nb4c1hbPBHkBdzMxdfZ11wqvoo7kZl7zeKe/zNm9rqGk4csSi15EwgFGg1+wteX7oJ3l+vFM0Z+fycu+WTjESM8wSU18PWxHxH5rFCgrP2QKK8I+3ACx3vQOOY2EPRt9CPyrtypDgbcUEYWQhst5rUDkrVBJKzBD7h0Sf2TJj0v5J49lMNgWN/rSD5WGys2FG48IH64WQPfn6qFezv8gNy8Gjh3ueJ6IMgkiuIFCurmiycitSiyLv7crS6Qdwvu0w+mIyu3BdpZV1To1QLnDh3Ux6XD1Us58OnSu4DSn3slB03bGSs+BKFpWx3CQPkSXKwEQUkVd6b5on5v5VnQtJctv0HT2F8BVzxPuHjz2g+4lXcDDdo2Qa36deDXKgg+zQJxI9eT5RU344/jX8Q7X+7DmcwbyD27D/+e9yJ++4cizigwDMMwTCXgjuDgYCcpqNth2JT+wKZ5WOPhWvKBgYHIyCgkzoApdVq3bo28PAeVw8sbzcaG4s7NBz0yHHh7exeswx2UnG/gBTxbbKOBG6juUcByD5dNrIrQKgyNNzhJZliW417G0Dt24oSbGCDvSDw95894IOgmzhy8iEbBKRj3P7fwt2XhyLzSAl1a1ULW7gV4evaGQhTs8qVE33t31EBsHW+0uvNO3PzlJo5ev46vnS8I4AAlFswwlWnyMFArFljldbD3PZVvgGbmpwqFWkEz//WwmBIPNvLS11Gug3R0MaeebdfKHAoUOqBO4OS6YEyB9VqNLPcjNlDd+nhel1qY4rJfTu7h0nUkUL6Gt2vKJIp999azL5dWDycD7sJq7a0g74u8EwyvCEtf80RZSmI3ysFjoknDnzB+SK40JBh8+a0Xmjf6EVfz7sCnW2xmB1qFYdB91/Hhuvr45Wfg8cFX8dWeujh+piYmPnwV3x2tja+/q6NLlz70bl275sqa6hrv9jUxvNtdOLcxH5vIQtjiLvxmwF1I//IHbCo07kAnP9RH5CmgVj2gpIW9cXWCzjdA5V4Hdr5IxgV9DeU7mPAVfF4fAbyoylFSxB4hOTj4zmKcu3cEmn67SoYSULLDB7oYOQ5OY6fMY0BtPI728j3Mwbk08efQYuzECIygnAmiLUqiSHWcu9dyfdoGeY5Q7cldm5xyLsSmY4MuI3MtYJVTr4f6TQMQMfxe1PH3xi8//YzM4xdwdM1u/HSTlqkqO+rVq8e/nxiGYZhKAxsQKjlODQhF5HYbEGhZwoHmgtnk2l9IGEEVp1oaEAjvSEQ2T0by0f/CG3EPod4VICD/c4yaug6RnVvjxHfJFcp4QPD3XllABo3rOPMXbYwoY2iVhccHXcP6HXWRer7ihCcU14BQdXE0YlQd2IDAMAzDVCZMA8KNZt2R3+bXuNmoA36u44e6d9xA48zdyPru36h9tvC5YP4hfXu4LQYEhikiHhkQTLzR/J7WCKgN3Lx8AkfOVtx3k7/3ShfDW8LmVVF9YQOCDcNjweYRUbVgAwLDMAxTmZAGhNyez+F6W9erq3sdS4DPjrf0kXP4h/TtgQ0ITGWgaAaEygN/7zFlBRsQqg9sQGAYhmEqEzUKMx4QdJ7KMQzDMAzDMAzDMAxTPbkD0w4WyIHwxz4N0K+VN379r1NaovDfON1lOAPPxN0eyAOBYSoD7IHAMJ7DHgjVB/ZAYBiGYSoTBQwIbz8UjCERPsj54Sf8al6KlirqnNoGv82v6CN7+Ic0wzDVDf7eY8oKNiBUH9iAwDAMw1QmCmSpevbzi1iWlI2fnKzNQAkWGYZhGIZhGIZhGIapfhQpzTWtzsAwDMMwDMMwDMMwTPWjSAaEGj9k6z2GYRiGYRiGYRiGYaoTTpMovhoThAfD66PzfM6BwDAM4wr63mOYsoJzIFQPKAcCwzAMw1QWnBoQXMGrMDAMw9jgRHcMwzAMwzBMdaKG17EEveseKufKeMAwDMMwDMMwDMMwTNWmhs+Ot6RxwB10nsoxDMMwDMMwDMMwDFM9ubNevXoza5/5FjWvfC+OauHnOr745a46MmFi7XN7UH/v+/A+FK+Lu8bLywv5+fn6iGEYpupD33s3b97URwzDMAzDMAxTtbkjODjY4xwI7uAcCAzDVDc4BwLDMEXFL6oWhkQBB5fcxD4SiOMJ7YF9X4hj/hnFMAzDVHCKtIwjwzAMU4Hw7YmeXevog7IgCuP+8jqee0gfeoJHfSpGvR5THz3v64qyHBXPKKN+dBqHV19/Dg/KAzWOr7/+KsZ1on1DXpA6HcVzaakPyoUyesZl8s47jN1Dz+HV3woNvzCK05cW3pg5vSn6R9VCkBYhqBY6DWiKP7/sjWZa5Iyo377qMJ7Ub3r2+tAFdteJe3v9L+PElWrfdp8P4rnnXL09znDyvtm9m6VP+b/DDMMwjDMqnAFhXkIC4mb01Ud9MXN5AhLmj1dHM+KQYHfeJjM3u7LzoI4EE+fZnZcYModrlTwOM/upQ1Gb6odRbvlMITHasJcxDMOUGzduIXzgixhXZkaEJCx55UW89bk+9ASP+lSMej3mFm61HYQXf3u7jQhl1I99S/Dyi29hHe0/1Achpz/Biy++jCVyKts1P+T4o9tYodyVmwJWRs+4zN/5IlCcvoTeCX/cwPerruHfWoQvr+GTIzeA+nciVIvKjM/fwouvLBFPpwywvptlQPm/wwzDMIwzyjSEwbtjJFrsT8YRfWxHeCQizyQjOU8fa8bPT8CwwL2Y++hMfC3U/3kJw4C1sZiykJT4qejiIwrlGueVEj+1+yWsiZ2CxaT4D4XcT7HKjXrlv8wnTZk0FAxthL1vjsLM1rZrVT1avpkK6rYz1iB2srxSYO2bFjEMU60oWQjDg3ju9T5oQrt5R/HJK0mI+ksf4HQAwiOAoyuEUtj0ObzeS5YAzm/Bi285+WlepyvGvTAI2PA6luz5QQvtefC5V9EoJ1PUK+qSbV1CH932+W1ayaPZw9HhWtk9jy1aEXjwueeAt8Q+zVY2yEVmRLjqs6v+EB71SddrHQf8YLvvsOO2+mXbW/BycpTTPhakDrr+9kUMwnq8/q89olZn0AzqbxDuTfu63X1WmZAe+QQv/0uoWnb3rspe6v06+sgBdDMOnvSDZoT1M5btXemj7pXalc/EB7vkfVLf+uDSK8fRhoZuayPLWPyAG3l1UFv323ymjrQUYz22DY4vFfWd0jI7rPdvjK8rmfGu1sedNa7i0HLDiGH08y3AfMZC+ttX8ZsI3Vs9rlaZ2WfH8aBxcMSD98tat/mMxHg+F5mEt3SdVKbPlTXI7WR75rIfKN133Y4W3nj3H744O/88/rpFywS9pjXBs0HZePL31+Hws8hE9fdly7OlsRa/Qz4XYw/xrvQG0nzD1b3Iz/kSwHEcxHsjx0C8Z+Z3i/GdIB+Xuk+nz8buO+u8eBuA4+I520aGvBiMOhy/38hoYf2sW+otyndLoe8wwzAMU9aUqQdCRPTT+PM/x0P8FrYnXCjfL49Hl+b62MLi/ScBnwj0pdn/iZFoJRT+ZFLQ+/VFhE8e9q7dizzjvAN9gxvpPUfGIzIUOLl2jaitFSInarEFeW1uJlL0sae06mjxaGAYhvGQB58TCpj4Af3ii2IzZwSbIARr1IwyKQS9IBQ2XcbVD+of9mDJm+sBtzOhdRDuKxRyUc8np0Pwm9fFD3Cqc8VRBAilSjoxy9lD3dY2oLsTF+46ET7quhc/wVHf7q5dpz3qk8E6vGW0uyINIb0fFArRcZxv0kaoG4oHwwKQlixGyIM+Kn7Ann+9LtR21x4ADz73Gz17T/Up5ddetkUoNMPMezTvnfo4+nW0SaEyhYyDB/14zvKMpbJ8LlcomVHymURFhohrAtCI6u8UhZCc4zZljcZi23mpZFP/Z7wi+iKUOqrLqfGAOCXGeulxtHExixv122GW+1eK4YPPkYKq+vfiilx0N93cjXf1eXx0CAiJ1M/CsZ+EUBB/0yINn1jvU8iGyetJ9olQ4sn1XSiHjuPhDA/er6R/vazrfhFb4O4ZkadEwbErm3e9BoY/WR/+t27ibKoWaVLP3cStxj6YOupOLSkGTULMZ7UlJxx9HlLj8MmRH6SybvcdQp4Ixvvj6JHg9Nmo76wA+b4J+ee5CNBGF2cU/H7TRidDRt89vVS9hMfjXcg7zDAMw5Q9ZWpA2PvuVCw42cXeiCCNB5FIfnUKFh/VMisLk4WS742A1kLt79hK/KuaLL0F+kZHwDv3CL5eeAaXxPmIaGvAQCsMS0jA1IgjmGt4F1gxDREpyBS/zeyVfm90eUFc290bJzcrrwaXhA5T4Qoy1GExVu/KM2XWsAqGYZjCWJdyHk16OcYvn8cuY3ZUKI84ssVeEXMFKTHvfAefIRPQX4vs+QFHt6qakq5kCqVB17svCWk5Uix58DmKpxdbryao42vME9owrxPqQNLpTLnnkkL7ZINmO2W7NKPu20ioGuuw5UgA2si47QfRxjcNSdpFv7A+2iDl/Z/4zncYJgzQIgttmtjGWiHasZNRHwCfpurINmaXkJl3FFukounBOBTSj+Pnm6CPEZNO0DOBj5yJbeKbiS3bMpVy3tQHyKE53xJCCtjaTHR+/DcI1yKDpOQ0IOI3ljh7GpM6CB+tx9x8PoRtrJL+tQuZFqNHZor9W/tgWBOc32evpJKsjmhL1vs6eQCQoWRdwfFwRaHvF812q373EfdgPEdPKat33fvOO3DzpjPHz19w80e9W1zO79JeIOr7pbg4fzYOnw96T125SggKfL+RYQnG50Yg3odd57VxTFCk8XbzDjMMwzBlTxnnQMjDjvlTMfdopDIiFGY8kCxGciop+TPRPFDUkE4+AX3RN8Jb/JLrgqkJw9BKSLwjhEyWJygsYQ1OivOTnCjy0hAhjQw6BCI00pYbQfRx75uxiH1zLxoNteY9cELqGsTGirI6jOHrWaPk8RrRX+/uj1jqZBiGKQSaAXxxDfCQ+JHuicLkjjpd8cQznZH7xQfYpEVFhZT47jl6dnHFUaH2lhBP+0Sz0767VLsvbpFu0QQpswFhD4rzbaSyQWpL0fpYB12feB6dcxPwwUYtui2478e6t8S9CKVqmFDWVEI7UqDIeCIUNhzHus+PI9O3ic0Lo6SQC/iQAByIWyPUOQe0h8fxMFIcjdlhNTOvno/YHGerJULxzwlBlFASo3zTbEpiIchZcbNu5QVScDxc4Pb9otnu7shdoeqmGfgyxePP38/4cGY20r1ro5lDsoPQprXhffUa4uN+0hLnBDQo0TeFxzh7NkWiNL/fHHH3DjMMwzBlTjkkUcxD8v/+SRoRZr5SmPFAIcMYQrsIZT8PR7Z/rcMXKARBKO+kwK+1hDmYKI+Agoq8Cl/I2zVXXfvmXtEj52EM5I1Ang9FRfaXYRimyGj3aT3jbEXNBvfRSpwbSHl5YRDu+uqfWLLzqhYWnSa+dZB5RamGynW+BBShT1ENAvCDMbP+UBvbONAMp28bPBcGHNcKqed9JKX9RQy6ayP+uWQHnPWAZrrtQyDU7LdN9iD6RAC55/RhsSi8HxJS3FeIfxi1RwV5iQR06o4AOS7nkevbHd1h88IoNqR4PdkGp5a/hzUnXCvVpMRvkbPDou08x3FyzrqUTIT07gOfnKQCBgY5G22EymjO5/xQQGbiMB4FKPT9agIf70xckuMVhagWtjclQHtKqOdbordcUdTPX8+a8Ne7BahTw/U5Ab0XdazfCQ/1QXhpvBcOOH826l1QXkEC8ijQIQxk2HNu7LF8v0nPGhVWIRH1d29iPKMi4OE7zDAMw5Qd5bQKAxkRpmDUqMKNB5ITmeIKAYUsbNbhC0YuBEKedwxjII+ADTLHwTC7lRYofEEbIojNFAJhDWNQIQwJL3SBd+oaS0JELZfhCToAwwhhkKs7UBJFdT5hqGhh1+qCoRMMwzAuMF3xX6e4e8N914JQotYcCUAfWUZszpZY08pL3W+Wlsh4QKzbSjHJqq1hvpnF90AoYp+k+7vhLh1GaoqBmolvQrPwWuJZH7XSXvdrLHWjtK97i3IcGG7aytXaXkbx2sWYeTXxrB+Gm/3ro0OQpsNMKAdEplDOlMcBjQPVdqmAYm6PGi96X5wunSgVrwicW+1a8TJDScTWB+QOTwqgdUzceAVQn5sEINeZl8Tnb8mY/N9Y6qDYfKtMzVKLPhrH1vGw4tH7pUJg1GdnGHyEQiwRn6ldZpttxE8MYxwKGTtXFOfzd/YnXEMttBpaD7/WIjxQD8Nb1wKu/gSH1Aj2iHH8xPqdQPkinHqE2CO9eehz4/gdQs+Mnq2Dh4DzZyPehc9tn7/XH/JBppsQhoLfbw7X0/NdYU3A6AEevMNkMDKXtuw0Dq/qe3Nt5GAYhmGKSpmuwsAwDFOVKdkqDKVAy954MDQN674WGmZFwaM+CUXgL408Un6KTgv0flAoJ+u24vaOSkXph6JO1wfQJ38LvjzoSvGqJFSkd76YffGLroMRbX/GviU3oZwkamFCe2DfF+K4Mv+MekivlmKXW6T08OwddliZ4iFgjfieodUoKDFkWfWNYRimOsEGBIZhmGJy2w0IlRSagbQtDccwTOWGPEdoeUZjmU+GYRimKsMGBIZhmGLCBgSGYRiGYRimOlFOORAYhmEYhmEYhmEYhqnMsAGBYRiGYRiGYRiGYZhCYQMCwzAMwzAMwzAMwzCFwgYEhmEYhmEYhmEYhmEKhQ0IDMMwDMMwDMMwDMMUyh2vvPLKLzVr1sRPP/2E3Nxc7N+/HwcPHpTHRYFXYWAYprpxO1dhqN9uJO5vXx84sx1rdxzT0rLmJyyPO4uevsCJNS0x4H+1mGEYhmEYhqkW3Fm7du2Z33zzDc6fPw8yJHTs2BERERE4d+4crl+/rosVjpeXF/Lz8/URwzBM1Ye+927evKmPyo/GPcch8sa/8U16U4TWuYTvz5ST8fa/r+JNHz+E/CYQH36nZQzDMAzDMEy1oUZycrL0HDh+/Dg2bNiADz74QHoiDBkyRM6uMQzDMBWLCzuW4KtDt8fjKzf9Lr3HMAzDMAzDVDcK5EAgLwIyJNDfnj174s4779RnKggT5yEhIQ4z++njEjEe8xISEDejrz5mGIZhXDGxcfl7WzAMwzAMwzAVB6dJFCl04dtvv0WjRo3kVjZEILKjt953pLk456/3GYZhmNvLDWz89ylMRgA6zqxgRmWGYRiGYRim3HC5CsOFCxekF0Lz5s21pJRpGY7/euE9/DnG0YjgjYEz/oqpQ7uKPU9RngQJcrN5J/SdEadlCZg30f44YflMsN8BwzCMJ9TGgF+3xHxkYv/MoiXYZRiGYRiGYaoOLg0IP/zwA/Ly8lC3bl0tKWVOrcH0v62G9+NWIwIZD97DGCzD07M2IE9LC2P8/GFolboGsbGxWJPqjS4TZ6Jvv5mY1N0bJ9fGSvmUhcDXs0bJ/dg39yLPJ0KU0RUwDMMwhbLwQi29xzAMwzAMw1RHXBoQDH7++We9VwYcXYPpv49DLWlE8C+W8QDoi+aBQF56ijxKSRdX+gQgrHUAvHESyQulWGJ6ILzQRZzzRkBrfYJhGKYSQUs4Dh01Ti3j2Dxa7ndrqk8yDMMwDMMwTBnh0oDg7e0NHx+fsl/jPCMBM6URYQlG/VxU4wHxNWgFM++gMHkUFuQN5GYi5USmqKcVIidKsaAv+kZ4I2/XXOWBoKUMwzCVjauHVmJt3BK7bfc5fbKM8Qn6Ue8xDMMwDMMw1Y07goODf9H7dnTs2BFdunTBZ599hitXrmipa2jJR1oOssyZOA8JQ1vpA0iDwKhZYZiXMAxKmoe9b47CzM3K42BqdxUeQaEMyR0TMCxUHkpOrl0DDB2GRrKOr7WUYRjGM+h7r8yNrBWKn7A87ix6+gIn1rTEgP/VYoZhGIZhGKZa4NSAQD+Khw4dilOnTmHTpk1a6p5yMyAwDMNUEKqfAYFhGIZhGIapzhQIYWjatCmGDBkiEyju3LlTSxmGYRiGYRiGYRiGqc7cMXny5F8Mz4FmzZrJvAcpKSn46quvcOPGDSn3BPZAYBimusEeCAzDMAzDMEx1ogYZCUJCQtCoUSOkpqZi+fLlWL9+fZGMBwzDMEzVpX///nqPYRiGYRiGqc64TKJYVNgDgWGY6kZ18UAgA4Kn+XAYhmEYhmGYqovLZRwZhmEYhmGYqknvfg9izYR26K2PmcoNPc83O+gDpgLRHG+W+edMtPH73/DzZ8oNNiAwDMNUOgLRdtA4DB2ltm5NtbgKEPV+Kma8PweYlIgZmxIRpeXABAxaLc5tUtuYSVrsKVQf1VsYMR9j8uqPEawPKxI0NkW+bxcEv5aMya9N0Ec2XI9/0TEV1OB2+Oj3D+IlPagk/6ifjzooAP0QjsZYfWRl7PDy/YHssp90P+WseLsfs6qGUobWyM3T96Y8cf2OOiI/A3Qfw5trSWH44KUJBe/dEbvPQodoWf75KB+0iin5Z6REnzPqi0f36vkYmtDnTtZNY+R6bG4rdt8NxrOMRiufjni+pN8ZxfneKfI1NkMEvQeev7dMdYMNCAzDMJWNpt3Q7PRarI1bgrXbL6Bx9CA01qeqAtnpJ/SeARkPpqP14dmY1T9UbHHAiGQMitGnmVKl4PiXgKxcbNW7lYvmGBqVg42bc/WxjbH3dcSlXYcq6X3Z2Lp5HYYtqnj30btfRzRKEn37xydiW4fXLuoTFQTVv/1Yqo9dQQrYU9iGfyYVfIdcMXb4gwhP0fe+PA3hjzpRsoVSOMB/P9YeUPsfie/BtWKcvss9I/5+ghdIXqXxhb9PDs5WsPeCsH43mM8y8Qzy6H0u08/aGbxQas8+F1mX9S7DuIBzIDAMwxSTipEDoS26jQrDmbj1uKAlpU155kCgGfDo9NmYv6UfJk8CVj7yGC7SbHjUd5j11DRdSvxufi0ZMecisWyBMi508VXy7J3i2pcWqQPyJpjWE37qCEiJU3VQfSNaayGQtiq0QD0GRn3Ur9gwLcQJJPSPQZI+co2rvs3BmE2jEKLEun2xQ/0dKWpv0FNfo9tx6K/C1gdr38w25DVB2DsnEusT1XhN7JGOhDnpiLaOiSTXLOd0/HUp9JmOD6d0QnrCcEz9l5a5gWZfnw/Yj2HxwJu/b4kD/9gulS6SP4U0XIrqiFZU8NR2UeaMVLiGtiSBBTp3rCXWxDjOhJGyJOojBeo+4Kh/R3SWk9NaLsuoWU7ZhoB+xD9uGgTUOVJUbTIbqo/bCp6j9mKB9y3KgLzPKOvMuOrDScf7zN2Pf9J1VMejHeEty1r7Jfo0wQdZWeJe5Djk4rvlSoF2NWYukf30xyVRZyufM/guyRedRR9PJpKSYRkXo0/yIkLN7qqxtPSNZpbbZuE7Z+NM58zn49n4242ZQx/oPehwzKIMOYyXwjY27nDVjlO52zFTRdU92b/L6h03noX9eaJgGVc4XKvH1b59h/GRZciAcAodxLuz1hxHVRdOiXtpKcYqKUfcS3P752k8M+P+7Z6jgfE87d8Lu2fm+HyMd9PFe+7yc07XOPTBuHen1+h34Ox91vfFOoYOfbZ+Zuz65vAuu3jP7d4Zu/dcI98f47tBtU0GhPfRC0OvrLN7hq7apzaGis95I/E5l+dkn3Ps70NjjKe1X7Z3xeHeNXQN9cfufZR98cdG2Qcav47IEuO6NcLFdyDDCNiAUIF48uEV6HB8NKYe0oJyYMLosXggYw3exf34Q5sUvPHufmzW5yoHLTH/T/0QlroZg1ec0jJ3FLV8GRPZD18MbomUL5ZicrKWlSm+eOV39wNr1uAvpaJtUn3D0BX7bvO7o5+r2MvbuwYjE3OU2A4q0wrJf9sMrV6WmAphQGg6CEM7ZuOr9TtxVYtKm9udRDHq/WQEr4zExZFaUc7ZgYWJQRjZNA7bg6YrhVcq5kphb5BICjkp6YNwRSvGUqF2MEIoqFxnHDQMAqTEOyrOjrisyx5TGTcMGhJrH+nY0k8og0e2Nig4Xk/H7ZOM6xRkGBiJ+U7uXxya/YT9PQrsr/OQIhoQXKF+8EIrgLYfrEoZdFCiLBRQLAn9Q/yS/uFsVdZo3/UPYGrHlQGBfnz3AhIKKqgF6rT78a1+tPvvsvQlKsdUDpz2364thz6RMtM9SypqcDtmTjDHZR2yugtFIms7/pnZsWDfHYwh1McBmU7GRCp2vg4GDVHXkeaW+9flLH12Ov6WMqYyL54Z9c+moGksSp/75+kEh3ZMXLQ/7BufwseMrm17yqZ8Ob6vBc5b6rfInGJ5HvJ5h6Xhu6yO8Ld7Zwp+Pkzl2qogW97vjQFCKfUX47vLH89T3+g+Lc/dsX/O31N7bM/C1/5ddHL/CsfPVMH7KEjBsf2owX71zln6b99fyzUu+1KwXvN9oH1n77m8T/f9tZW1fL6kkcDR2OW6ffU5N74zqJxlbJ18Xq04fW5Or7Fvv0C/GcYDKngIQwQiwvVupeNxzJ2yAvF22xw8qc9WNDanZwOZOcVUAEmJHIsv/qS30RYzMSnIzuROIGOGrYyqc6X4IrceF6zjFCb/bWkBY4CsS7drq4NwUt7axz8NwyvaF5zqmB+p9vvFDMMXv+uIflTWoQ/Wcka7xrGCFNeC9UuSN2Ow6I/VeEBt2ffZwPk4y76Z9fcTKkTxsNZja9/ad2f15+Av74rxNIwHdmOpNrsxNOVGPY71W8fHco7GnkSNO2KlXXmjHvVc39jrzHDgIdR3ox2JGm/7Z1nBqN8D90fXw5HtZWc8uP1MQHCDdKHMf4zoBjuwcM4OZF85o5X77uJcLk5sMZTgRUg6nAu/puKtmNQZISnrlfHAETIS6FwKMyyeAO4ghdvIv1DQG8AZc9A+7AS2F1DQW6OB7wkcNI0A03AwxQcNjCpzdiBRn7uQXtgPugmIuscHfj2m6745eFAsiEECRsl7xCpPPCYKYctsPDG8ZMYDg7ykbfoHdQ5FOZSMXO3OLdh6JA15/j4y5nfrlRx4Rz3oIo5Xufw6/dHcoaNQHvdbfvAbuA5rcEWexdV9abxVybHFudvPEp6x1X/gFE76+Ftm8Is4Zua4CAXmm0KUV0lzdGhpad+RU7YxofAHOXYN/eF96pRNqbL02dX4927gi7yUM6ZCYzwzUEiFeCZrxT/PNJMq3fgLU7rdMLZtc5x0Emriqn0ZJ+52zIQS3F0ol3byM+KWxbjpnAGyzWPF7zPRipRIUuiF0ndWywychU/Qe0Vu8mgpFFEdv66wPUvrOPSOCIE3xeTrd7CA0cYFpKCqd9ZyTYeWaGV5L+xx9567gBRe8xqb9wpBz+3SFf1uehIadTkLeTQmjjkAqM/0WTbacfS6cPaey88cXeMq94KT74aLh/C4DC3xQedHRTtGPwpp3/adUQrfjU6xvrPivQ8r2ncawxAV24AQ3hOTps/DeI+NCPZK+7I+0VoO9OqzpAjyaEwfa9SzBNODtNhOvgJz22mxU/lHmDpvNIbPS0Aq0vCZ3J+GD+hU0B+xTJd1ZVQgb4T4sX9EL3lkvS+jPLU5B9PN/lv7KWg3x2XdHuFE8ZcKoEV5tim6WokkxfwLi2JOyt5gYDXJ/7YGewL62ZQxJ/UvWkFlOkkFsl/M/eiaudk2k9y4JQKObxbnW1kUWJuCaVW4qV+PCHVW9udvm3Gxy/1aKXVe3lDiZR+d6Z/iPn5neGckn0RKqH0fIkNPITlZGQ8ijzjWQUqoUEm/MMYnG13HaqXXHAMHo4ILJoweJsdE9VVs2giyOXGNlm1GipQQ1K6lXmrLavho79h2SzxC90j1LN0HdOlkucdT+hmqNpQ6ZK/4m+NpjqXuT+pmZRwR7UsPlwL12BR/8hygZ6A8I6j+TshcqssbBooL+zFSHK9OhfTasNXjGpvhQnkoEFajDyGPRQtvHA/D74x7iewkx7t8PEOKARkPBkfg2vaVOFZ1rQcCoXAjHRdaiy+4w+LzTH/TTyAqqjWyz+3SZYrCBAya1BPYacunkKbPuCTmY4zsAeydQ+XFtqoUcwSUGAo/0P3Sm9VDgc6npVSjH4ek0OpdHNiulFAKgaAf6h4lBHOmJCqcxr5fzJUu70oZULPW7mZuibHDhWJEs8XUN6lg6BOOBPugkd6tlBRr/CswLgxLS7/Zj0Zt6d6EUmbkJigO9C4JxX6o6Q3gg2b+6pTCiZKqkUaRJBVv36p74UnzZFn5/umtMENNh2gMbUmu9qq8J3kdPH7PTcRnL7YjYPZtO05KuTJEkNGCkkSuoVl9Z4YBR6QCL+pJAJ6i989a3uyX3lzM6tvIxWuLqOw2IFZ91q2GBNd5MShfA42buH+IZ2sYd4rcfulivrPBzeGf4qzfDOOeim1AOLoYf3rjMCI9NiIYSrtS3C9FxioFWijTz4V+j7f0uTFbtsvSruS9+oyD/x5dz4rvET5YKfIkD099R9dvCzVwJXeOUPwH342jK1TZt5KDMOThx/U5BRk1hiABw5f+HeKrCk8+fD+ydPnhm2ApH4JO/l/peoDwCJthxFMWrViqlHRS/MxZeaG83ZdhKnuroRT/zYn7LMqzL/q2ycaXTl3FFf3aC3Vt7z6l4JEyJvSy4CBSzpzXLw0R35CCPRZ/6JKN1RYvgX7tA5F58BS+Pu6HSFPxczbrTP0C9mwxrhXK717gnvbUbnFmqYUiPiwQX5ru+aeQnNrS1ofIVghLPSnvkcaygLLZuCXu8VUGBknyPuzJ8UNzUtqlsu3CaFEAZaiwjknx8UXXwJNKMSeDRh8yLIixMZX0HNeu2yZqLFUdzvs0YXQrJBv9Tc9Anm8Y+npgKJGIcQ3e+1XJwyzsDBc2A8uiI6cQFmEYVGxGoM2JX+FwGzI4iXeUjF+lMt5lQVt0k8aDJdh9TouqLCdw5Qr9SQdopj0mSP6NbUAz9Ytw8YoPWvcxzF1zENPDB9nnxCdSlM8O66xXEZiDMQ5eA7KMIPi1QQU9EHyDnCSlTMdF6c0wAYNiHD0QKAwh1WGVB9HvnNaILrDSgZK3N1ZTiPkY0WG5uOKhTUJ6V5iQxwXQZaTz1SXIayIW67HsqfVOk076BXniSWGBQhji4zH3t/q4zPBFMxcZ1hs1cD+NSTPA1tllCSmyy/fbZpklSikpkNVf/KAORxq2FvgSpJk68bPkiIMWJGdgLcpAYYqYJi9Tf/GTUuriluRMsXV23w1qdriIWe0LoGZZBxRlpQM5y9vSbJcUqVa5WVrx0ziMv/RMCGtuPgtKPOftYbJN7wBt4HWA3LAdlbqTmblOlenitu/Su+DiGRz1F2Mg3oVGju+eGwo+M5oZFv022pDvhpAZBgn5rrl+H2h2ngwJhUEeF4jq6PZdcfo5M58rGTL0ebvnLz5TjrPpbt9z559zw8tAvktyT3kLrT1FoQDKeCENIBal2+ivNFrIPQvSkLDd5s1DXjItOxZzFQdlSFh7ygf+DbXI1XeDgRw3MiTo45K0b/FI8hhn1+h39qUIf2S56rcTek37EPHxH2J6Hy1gqi0VfhWGvP3vFcmIIGfu5Yx8LEINWZsQpO5RyrgV5/Jo9A71Qmh/Xc/oKHjpM9uOfC8UkmcQ76Dwu5I7Jeg+8ePke2wVv4WJbVu+QqpfU+1pANnuc2QU+PQjLXkcHVp4odNo3Z/+1p+617Fvhyq37Uo6vPwt5w5Ng+nxUFRIKfbthD/o2eVHjIGUyrNWfkkxzlSKs3v8lNs9GQyEoukd6OemfoFUsMVzNwwPEl/0DczA10KZ3HwwBcGm4ucZMjyjmIQNHoaAb+xnua3K5wTxN0UcuyUnw+IZQPgiwOot4gmNfRFcoJ7ikmMzsJBiL36Q2dz2aca+k1DerePfEo/oZ2XnxeAOobg/kGGpQ3oO7EPAWFVPYWEB/YIoxZvFy8EutMBzqJ6UbwzjjwWrJ4nFCGQzYpHXSOnlSihtGveMlgpu42jbUo73twtUJ6siDYRCn/gY5tMM+yOR+q/KUZD0VByyTRf+UfDbOVvNwIvy21NaI1bKO+Og6TWwCOsTTyBkBMlTMRIH7T0Q7K5LVUsd2skmA4c90fZFO49Y+6brIvmCHfDT7c+QOQ90noZCSFq5QxlRZH1qicWLL83H3gYUpqDrM5ZenJSokibKPA3TsGxVOrpMsxkRLr60HmlhxnUVaUWLM1ibBOXy6zBrTbNmIJd4klsVL4s79lBsN8MSrC7XNGvpycoJLldYcBXWIJUB5TpuboXMtNvdByVss/v9bnNtphj4f3pokCgShps4zeQaYyf7TMrRdlwyx9iJgcURoZy9n+Rr6zPFb2vFzuX4H9iOtVmWZ0bx+R7c59bN+y1jXfgyfuR+bm3HnIEuTvtizMyVDwqQi60pYgxifO2USGXU0O7+BcILnLM0fjtAs+zUN1Hfd8uNmHsXnjEUP6/boNl56/i7xOGZOfbL6efswH45g67GrCWyDA8EUdfGU8Y72xIHKJRC4/49d/Y5F+/frjPKy0DIKGmozRBl741hhjIIrO0MyBTviJYb4682ygdhzLSfwQuJOba2xVboe24XWqHeGfNdcPrdQDkfVLtyCUfZvpFIsRjtE3ZjbbvG+JxRHgw1dpbPhotrjHe2c1iWE2Opa7ZdIuXFG/5FtmIwVY1Kk0TRu+MUzP1DANaNmYkELSsAue13zcJbcuae3P7b44BQouEiOaHzpIUUGjBOKA/jMFsr+QWgdoQifz35HZs3A+FUbuuHGb4wGHhfexfI82ObYq04bkX9EV+YoX7GPejz1utNHPpJbbc5aDE8lAByd4846TzJoDi3Mmgf3kUn9D24ueAMseVach3/QxdfW4JAfe3I9E4u65fXBGYL5c4PmUu1OzuFQoztZHNLBbnU25Q7uuZ3+EqHO5Drvn2SQPvzBY9t2F+rQhKE6jnYMfEeKbYkO4nIAkn5VOhAwDf6nmXfA/GlWcaxf4X3V1KgHmcY/aIyDvWazyXbXk71DgPe1d4Havz3OX/2jvdmYDxXs7+iH7/zxWrTa8ORgvU4e0bSC0Xfr3oWtvKOxwaO9diXs46P7dzqoGF4JH2NpS77cu6oGKswlD23O4miXEEgaH2hSQuZaojTJGHFxGVdpAxYE8DZcJ44zZJUsEiQV4T7RG3M7YGUtMISC5YpZChwmhCQoPezI84u4vem/HH93SARz00mfqyAOQaK9U7LRLp34/t5T2D2Fi1jqiUV3gNBEYHhT3QFdm9woZBYyD6nFO927U0PhA+OC6W8q5FPwIZz+XaczfZyHw5As/ub0uxn/AlXcivp53DJ52701jPQvfrcj1Cjz8TxaXgr9W48Z3ozpCErNwQdzHwLHkIGheLmQKBZabs4fwvJJ3GxTSc8oj0CFC3xio4bVzPHCvIWyMvZh9VSMRNK430tcTFdKHYu62+JR7pQ+MFmTCbX+mFq1plCIS4aOQTEttoaQlCAHHx9HNotn1B1Hj5oUcYd6BfTUffFDwW9I09h8tIMPGA3A67DGEZbZ65dcOEUDudYQx46oStSLGPnIbqeB4z4fAsTRP9l38hLQUqIHJzJNDwdhEI82LnngAwzOX5Kfq5IoXZtPCBofHKQ6cqwppkwuhMy17gyHhDUN73rAvIasXmh+KJ5QOHtOiMlI8fmLTLalgOBWLRlHxDUEn0DU/Q7ylRULr4UqZMBOsyyM0xpcvEQHndqiKCZeecKgnIHt8x0PhqCo+asMVNVsCXAvE1QGIhLLwnlOcLv3O3A9XeDRDy3imY8MDwWaLWVorzTT74ZL/QKNh4wikrggRCBJ+b+GT1OLcDU+TuQp6XOodl6HbpwOgn7/PxxdqmauSdvgyEt6ATsPAScyy31EKcT5Mw+5SZ4LtIIaKDEiKpuV3KFEw8C8kIwQiNyk0xvA6tHhOyXnz5nLS9Q/YR7DwTpDQGHvniOmgE2lNUc7DG8AQSkaNLSj9YZcpKpUISC3gFGPdbl9QrW/xUwbBjuOW6UUbPUXTN3YU9AMM68a5kNNmbTt/g6eCYY/dTX6upND4gCngy6PGxyax+ts9eOM+KyDw7LL9rfkyBHL21o165tLF2Vh6PcXHKSZsYtSrAh130h7JaDNOWizb3ZKu+B9ECwjY3zPirUWPjZtWlXv4HVA8HSFwNZD3mdWOWu7skyPrZ3yvJcCvRTv2+unq3lXcjbuxmH27SyvEvqnO2dM3DwQJB1h+HwFym4Z7D4u5RCMSjB4xrMu8keCAzDMAzDMEz1oYIbEJTxoM+lZZjyxoZCjAdM+UBKVyd7hZ7xABo3+1CFqgIZQpyHhFR9OISBYRiGYRiGqU5UbANC9BTM7nEUf2XjQYXAmBF2OgvNFI5ldt7q6VApsXoaGF4M6qhawQYEhikaj97XESO7FzUmj2EYpmpw68efUPOuO/VRxSFu50Gs2Hk743SYykSlSaLIMAxT0WADAsMwDMMwDFOdqCRJFBmGYRiGYRiGYRiGuZ2wAYFhGIaphszBmE2pGDNJHzIMwzAMwzCFwgYEhmGYykbTQRg6apy5dWuq5VWAqPdTMeP9OcCkRMtyjaTsV52lG+U9mktSpmLya3pR25iPMXn1x5blWMsf5+NfXCZgwbD1SJTbO/hvLQX6YfYAQ74Ks+trMcMwDMMwFR42IDAMw1Q2zq3H2rglavviCOpFD0JjfaoqkJ1+Qu+VJdOwrH8oli3Qh+VM2qpQzBLtz5qzA+gxGYNi9IkKQOmOfwpWrRmEmDXP4H+1BNiM6RtJ9jp2X9UihmEYhmEqBWxAYBiGqcz4+KF+bjaqXCrHE+nIzkmHddXT4NeS9ax9sqlwk8ycwccEDFptO6dm0Y2ZfvtrDLldCAN5ALz/sajDuMYyA0/nzLqsM/PUpiEXG83eG7ho347EzTiR44MGrfWxwOahYG1HhVwY9Rn9pnsZ85qlb9b2i9NnAyfjjz7T8WF8POb+Vh8zDMMwDFPtYAMCwzBMJaR+u5EqhCG6Ho5s34mqMpGb9FQo5r+0SCjWj2H+I4/hopYDrcV/89Ws/ap0dJlUmKu/UJJjgrB3jp7p7x+J9YnqzMWXIqUsIUUd2xHWEw0S1TUJKa0RLY0TQnmfFoTtsh5qH4g1Qg0mjUKXK3G6DbE9NY2kAtft2xHTD619T+Cg4Qnh2xOt02fLa2ztk8I/CjC8FvrHASNsBomQHkbf4pAWNkjLi9Nnd+PPMAzDMAzDBgSGYZhKydVDK3UIw1k0GzwSbat8HPkJbCfFlljwHdJ8gwoJ21iEi1d80GVaERMl5uxAolbmL6Tnqp1JnRGC1og1ZuxHWNwFaKY+bBRmFMhd4L79kBG6rmntcWJODJK0nNpfqe/TbF+03cBqZMA0HEyxeS1k74zT15/AlRy5U8w+F8KW2Xhi+HBM/Zc+ZhiGYRim2sEGBIZhmMrM1WM4m1sffj76uDoQ0xx+ju71TqDZdJphPxillOgSrbiQYpmxp82YnaeZejoWyv1IUtQtSrm79s0cCK48E0qDYvSZYRiGYRjGHRXcgBCBiHC9y1RjfPHK78ZifiQwYfRYfDG6pRJH9rPtO+LqnLtrShPRzsoYX31gwZW81KExG4ZXSiWznhr/L37XEf205LZDz/FPok9iM8ezvJ5tRaN+WzTzuYAz5/RxNSC4T3v4XTljutf7BanZ9eDXJqOLk48XKfILd+bCr6mRK6GIkMeDGRrgAqmUxzn1jChx+9KzoDXaGwaImI8RHZaLK+5yHZawz04ppxwIvaZ9iPj4DzG9jxYwDMMwDFNhqNgGhPCemDR9HsYXxYjQbg7ip6zQ2xJMDxI/RvosKSAzCfojlgn53Hb6WPDkw0ZZtalz0Zg+dg6elCWIxzF3ivXYBQXqp3qs9dv649jusj7R6oQLnPeT+mW5ltof+0dMsBsDh/MWebwo20udsR+3hx/XUlW/KTf6L8fddi90LbVhP/ZqK+y+3JGSkYO8jGx9VFERCvd9fjh80PAlNnAlr+jk4C/vLsXgd/djs5bcXtQ47lkq+vS3pRiZWNnGs+SY+Q9oG+yHI3HrC52Nr/zY3PEn3nMQC3Xc/sWX1gtFeZSSBx3EXvN1sE86OLFHuhkCYSQpjA0zQglcJDg0mYZllHdhmq0+I3GjNSHjjE2j4GeGE7huv+gswvoFO+Bnhj30RPaqwjwXitPnisG2S+ni/97wb6WOGYZhGIapONwRHBz8i94vEYGBgcjIyNBHpYd3x6fxtz/cg+TZU7D4qBa6gpTY/sBn86bhAy0iSIkdemUcph5S+8/5f4Xhn36kz81B7ytZCG9zDmO0jBTzDsdHy/JSwR7tj43zEtBsbCzOLjXqJkW6PQ44tOVIwfrJgDAO+GIcZtNvJOpz1yy8tfTv2EYXUHuDgfeNYzfY9dNE9GtseyA7C2s/FXXo+rak3o0+WIIxW7arMlNigU3i2sv27VGdA7LewZgrsZZ+UZ+fgf8eW1s0jk+Z9QnEfSxrA1zKSsBUIXM8X6C8RNUbniras5M7ombTA75ZitVBw/A7fKWURppxjsjAnoBO6EqzjqmbMXhFtiwrj01yhLL5FTDMmXwN/hLUDyuDMnCxSycIfQJ5e9dopVS1a1yT8sVSTE5W+2jcESvHhuEwXe+oudG5PjkYueKUFmgKyFti/p/6yTYVqj9n+oxFZMY+BIv+eAup0Z9+McPwB3N69RRW/22zUCuoj52A437oKs9Z5fcLebaQ06y8vldXWqbsWyAuhrZEWOo+NabYhzfePYW+xhjI8bXek7X/Rrska4XMvUZ/bO3a9d9aFz3HwdpzIIfaVIYK8jZ5JFSJbc+EUG0ky/YI++ekKOR+CfkM1Rh71m5B6Hvv2rUqt/5BAfr3749NmzbpI4bxlAlYMOxX+I/dEo5W+mH2gP8Bdo3AdGsWUPJ0mHI3vp/3BGZv0TKGYRiGYSoEFT4HQt7+9/CnNw4j0gNPhCfbhCB1k3uFnrielab3otHbPwtbD32Do37tC/cmKDJlXb8rsnAg624MtXhV2PMR1iZfR2gbw6ugIHIs9xhGjO2YvSfNbXlJ1kFkhcaWwX2qGXBS3jcnOih0oUJ9XUMz0ZuREtpK/FzVs+VfCOWUlNS/0TlSJF3JVTXeXcKQKWe0N+Nil/ul63+/mPtxz/E1uqzFeFAIE/p0wsUjVkVb4SifMLof8IWq+429OUJZ/crsT1gb4F1qd+k+oE1LGTpA92705Q2hoD9ghkK0RNfAfab8EdON31fIT2o5cE97Ow27IKF+YgxoHDsh4Bvx1zcQYdbxtIOUdlv/adxsc6stcQ++sm9XKOu/a5OCN2TZNdgT0E+GpEhjwGBgtZSLzfByiOyHR8SeUbfxTGQIizRatMQjMoShn5tnThW5QrQrDUCetcswTHEJw4hh65E47B38t5YowwHJXkQ3h+SfT74Zj3g2HjAMwzBMhaVSJFFURoQT6DJ9JmK1zBnN/K4j67LYsbjlG6EDof3VMXkfmLPdQffBP+sboSRvx9bUIHSwKNxG+fjRd+PoCsMoEYIhut74KbHQk5SucVm/FzqN1vWQx4QH3gauMPspNmsYxsktXwFdbeEIjmy7Qu4PGp8oPKfrGIIE594Al7NwXe+6Jg2z9wADPA5R2I7ZS0cX4n1QCKn7tKKYjcwcPzQvrrJn1nMKyam+CAgSCvvBFKDLMOdx9Rf2Y6RTJbUlIgP2YXUBY4MruXNSvtEKLbVjKLc0Y67j/m2eCEQO9mxRCj71OS/AV+cqsMjTs+Ed6Cf3XZKTgq/pfnI86GdjMhK4KncKX2ojj2Hw6dc+DDh+St0HKfzfnEJwEN0DjTcZA+zzNUyIaIkU09hyCqv3Qj6TRSuUYp8iPR7UfrGcwiNbSU8Lx+fnql2GYYrDIkxaMwgxcrN6IWzG9I2G3N774IMXhmP4cDYeMAzDMExFxTQg3OntAx8fH3jX1IIKRQSGP9EV2L1BKyDOOZvtBf+GYif97xgzbzQ+O63kROqm0Ri+IgnX/ZraYvwj7kZo5DNScX4u0stuhl2WF3UMn6dDDSRp+EzKaEtAqpa6wnX917FvhVFP4R4T7rD10zGU4SMcyL4bvWk8nNCrQZDNEyM3CW8Z96XDOArQ0B9eetcthw7iUuh9qNyhqznIpGcujQRCST3Syj5Znxv6xXRCsKko23Amp3wOYYO1QaBNCt514yovZ/yHdcJFi8eCSzJz3H5OKhrKKEAhJoZHAcMwDMMwDMMwFZEalKio3UNP43/Gj8XYsWMx/r+fxm/urUg+uxF4Yu6f0ePUAkydvwN5WuqMD46nIbS/m8SG6X/Hxuwo7dofjd6h6fYGgRalGWZQ1vUXzgc7vkd417v1kYWgP+KpSODoEdcz/3IsTQ+GaEzvGoLU4y6MC3Z8hLWpd2NAoe4ZhEooWZKkii5Jz7DMxFtwJTdo3BEPhGbjjHVmOnmzdI+3m8GX3gCOqxz4om+bbHP23YYzuZIVcN13izZsyGudGzMoTAIeJJmkfARfFOh/EbhwCofRCY/IMITCkR4QOhRDGkPua4mL6dbxoDCENdijvUikcSXC8PxoiUe6QN+7G1w+W8qZMNbekyT5pAzVcLz/YrVbDeD8BwzDMAzDMAxRw6frEPRvdg1Jq/8f5s37f/hkVwZ8uw0WMl3itqKMB30uLSvUeCA5NA1vJQeZYQZDWmi5hQ92JKERGRmC7kN49kHL7P9HOHA6xC6MoUQUo365qsLoKHjpkAJPFGtXIQwSaTDxMj0HvLQ3hArLsHpWOEGM5WfZRmiDSnSoPBzUKgzkUaHqc1jVQrBty1e45OORv0LZoRXcP0iXf4ui7EoeqpcFlHHxyi1eKdlUTmwUp++YFNGRyE7omnmyoEu9U3kOvj7up+P49eZ2mUQqD3QdS2UpOaK1L75aPlbG77tL+ld0tPJNSQ71GKncBULhX7MPwdqDolDPgeTNeON4mDnulFtC5ZTQ9ZtylQeCQh9Wi9Ew6sYXheU0ELh6tk45hclfZJvjZoy903ahjUWRhtGI+lxY/VULSqLIMAzDMAzDMHf0f/qvv/S6tgbvbTyjRT7o8dhY3H32EyzdQgkFPKNMVmGInoLZPY7ir29sKNx4wDDFRa7mcNJhhYGiM2H0MDTfUlDRdS4nJdS6koDjsafo1RbWeKBgM6UOr8LAMAzDMAzDVCfu6DPxr788cOcmzPvUCKBvjv4Th6HxgaX46NtcLSucslrGsaIjl4WMLDjbfj25sKUJPYO8Epx5UlDuA/ucB0yxKSUDQlGxLhdIFLZkoHPYgHA7YQNCRWECBq2ejtaHZ2P+S0UzwTGVieZ48/fRQOIneOGAFjGlT4dorIkB1v5jO5ZqEcMwDMMY3BHc7bFfxj/cBtcPbcPXyXkI6f1rdA26hE3L1uBQEab9q6sBgWGY6sttNyA0HYSh0Y1x9eBafHWo7L5/y9OAEPV+KmIRh1lJnTFjBJDQPwZJ+pzJpETMiPoOs56apgWlZUCYgzGbRiGEdnN2YOEjj+GilBcD6uOI1khbFYplC0hAdXfGQWf3UyJUnyHaORilx84cl6IzdvhvMBTbMexYywqoRFZAA0JwO3wUC7y/6BC2alFJ6d3vQTwfBXy3fB1eK/YLWAKKaECo2O8MwzAMU9rUwOlNWPF5Mn5o2R8jHx2CTt7n8fXKohkPGIZhmPKmLbpF18OFM5Y18KoI2ekn9J6nLML6R0JLwftgGpb1D8WsOTtQeCpSD8jJhV/UHH1QluTiSlGHzA15maWZR6U0OYMX/lHVvQ980DssB2sTcxAe4aNl5cyB7RhWRCNAxX1nGIZhmNJGLuOYl5GH03c1woeXmuAvt57Ahoc2In30KmT3+wtuNOsuCzIMwzAVh8Y9o1Hv4Fc4UlV/t59IR3ZOOszInJiPMXlTKmbQNqK1Fgpopl/LJ7/mkMrTcm7GpmQMilHiqPfF/mturnMCeUbY6kpElJTS7L+tXoLKmfVdWY/tGGR3XmLXr1SMmaTEdO2Y99W5ya99LOoW51d/jGB5lrwsCl5j5UJ6bgHjS69pHyI+fm7RVwC6nIW83Cyc1Ic0y/xmB32gPQHG6iOaMV/z+9/ozZDbl5Gz2sObq32atTfL/wYf9TMUZR+8NOFBvNRPlHU4Z23D1g+FXfsT2qG3lIr2xf5Lot/qnKhXDaTuizg3wTjnQZ9l34zyTvpgtuNwvS7v7BqnBDdHeNYpLBXjj7Dm+l4I+/blZvTN2o55//TMnI+lgu5VXyM21TdrG5b7IFw+MwsO7wzDMAxTNanx9MT/QYvRU7DuZnccrdsFP9dRS9XR3x9a9kLWgNnI7fmclDEMwzAVgKaD0M33CPaUYdjC7SLpKe1JkPgY5pshBEJRn9YeJ+aEYhZ5CKyyKMkLYqRs4U7HnD1C4Y4Jwl7jmv6RWJ+oTwlFqcs96Vgo5XHI7jG5oJLvAPVL1SO2VUDs++RZMA2JO4HWfQwDxBy0DzuB7RZPiKSkdMt5je6z2uKAEYZBAghpIPol7s+vR3tcmROHNN8g0IIfUe9PR4NE6zWG4YK8JtS9XXwpssReGEvjP8Hjm8VYXjyExz1yy2+OoVE5WPuPTzBMbh7MXFPdZvl1OBrWy6bci2fTOeCUWdelqI5Skd26eZ2UrXVMVSOU5+fD0vBPXd8/U0LwvKFY+3REeKa6blhiDjrH2pRrtAwBEvQ1Sb4Y4EwhtkDKuP8uVZ76hRiLQUK043/MVtdQo305k2+9xkEpd0LviBBcOnZGjNEZHEUIeus2evfrhc5Zur7l+5GHM1gbL8qRYt89y/n901iG6XPiGuixJPlLE1QoiNE/5dWRi9cW0fH2gkYAN8+s6O8MwzAMU5mpsehiI+y+KSM+XXK9bSwbEaoZdQObwj+sMwLDe/JWxhuNM403w3iGCl04sn0nql7wggsmdUZIynqLAcATFuHiFR90meZ8tj4t0TBOTMPBFB80sDg1OCP4tWRz9t/qAXFxy0Hgnn7KS0D0029nnH2OgwVxOHHPKNNAILF6Uxg5FzRmv+zulwwTQMgI59e4Y9ucJzB8+FTLksKlTQ6ycptjqHWGv1Css98PorOd7p6L774xVoWikAX3BoneDXyRl3LGVFq3HklDnr+PNhScwUZSbIkDp3DSxx+t1BFwar+ZX4CME1IBdklzdGgJtIox+hxtq4fI3Y+1OqzCrn27WXuHa5xC4QtAllwAKxdbU1BoGAMZHLx9OuJ53c7zUfblT+7SCv3FXFySEgF5OcDWZ89w98wYhmGY6kSNs4E99S7hjdeeCMPJF9tg39hgDNZSgowIHM5QPSBl1qthS9SoWVtLmLKExpnGm40IjEc0DUNj1EfE4HEYOmoc7m9fH/XbD8XQQT2ElLFieA1QckFXbv/kqRDcQO+6Qij8I3vA5s1g9YAQCv/2K+0RFQNERcHO+0CxCEmHg9DebHsCBk0S/+7unG16E6TpM+45gQRZ3tisHhW3E2PWehsQq5TLwgwJY4cLZfqUMTu/Dt+5091Li2AfNNK7xeOMxctC9dtpgsOG/vDOEso/zfLHdhQvofaAcDar7wgp9j4+6PyozRjgrcMYtl7JAVrqcIRHO+JSos2wkme2oTfyTChlbsszYxiGYSokMgeClcOHLqL/4kxktfTDC1bbgiC/za/1HlOVqePn8TQSU4rwuDMecW491sYtMbevDl6VqzCsXV+FPRIoH0JYZ1veAWsOBA8gQwKFOPg1dZLrIKYfWvuewEG5UoI70nFRKuwUGmHfvgpT+Bjt8Z3TFRYuvrQeiOqsjxTZ55ShIfi1QR54E5CXRGtEe5CrwZFi50BwQqMGatpZKpNyz4oyJKw95QP/hloEXzSTX2vN8WaM4VavMJPudehYotlsUqwNJZsYe19HrcDbI2fqT53yIDGgsz6fwYFTzQsNcyDGtm1ul1Dw0hWlaffu17FQDwTqo83gQNt202uC6j1ZIORAeTzYQhM8hLwRfDpiqCc5GSwU65n1mY4P4+Px4bReWsAwDMNUdhwMCHnYmXUnBneph1DcQtL3Wqy52aiI/9owlRL2PLg98LgzjAtoll8o0LHSfb8zDlo8AIzQgok9fODXY7rF04ASHBou/3Q+3c47wAwHkLkV9NKKRmjBtJ7w8+2JibRPuQ7s2p8MHHZY8mDBd8ju0VMof66WT5yGg2itDQWLsD7xhNn+SHHGEw+EpKcoV4O6P7mZyRXLh6XfUAy9SlY4IHO/bTbdIbneUH/DNf4M1opBVbPpHZGVZJsVt9a1pm2WR7PZlMRR1m+GEmhPhwPbsTbL5sJP7f/TnIGn0Aoll3kSCp2Zd9PneMrH4CxZo8ASQkDLGapwiFy8tuuMGfbwlHjK7j0QKHzBxzQ4KJThooP46bX0mK0uY5OJDy8ewvuUd8FR7pYzeGH5fjSy1KeuMcIUyECkx07fZ3GemWTLWaSLP94NCw/gYBiGYSoHd2DawV/0vuT+3o3xQkQ9dGr4C9bFn8CEI/qEJnjpAL1nD62HnpFRdRJ6PfnwCnQ4PhpTD2lBOdCrzxI8F+kl9tLw2bxpHsSsRmP62HHAF+Mwm/6FLiUoLr/UaNEFj0YC336+t3D3zVIjHENGhCJA7N08n4zlO84rsRu6DhiExpfX47NkLSiEVj0HoHeTmnLf0zY8IePoDr3HVAboe+/atWv6qOrSv39/bNq0SR9Vfmi1g/ZJoVhWqNeBh5DhYRKw0kz6yNx+SBluiQOF5FCoHFDSw15Agi1sglaeeD5gf5mEK5QuvTD9X8/h7u/fwhNztmkZwzAMU5kpEMLw1dYLePB/j+PjrFro2U4LNTV+KJWVsYtABCLC9e5t53HMnbIC8XbbnFJxCzXYtmUchs9LQKo+vn2QAj4IY41tQOk+BFK+zbr19mjPJvpsaXAUn61aj63nb+njUibyPvQOzMZW0cbSVcm4HHgPYlqoU2SIoPsZEqmOFdbxvA9dpawJYh6y3b/cHuoizzAMU0kwPRaCsJ2NB0yZoRIqGrkRaPPMo+I289u5iI9n4wHDMExVw8EDoTH2vVQPda7XQGOvm1gcl4qpx/UpQZ1T2+C3+RV9ZE+ZeCCEj8e86ZFInj0Fi49qmTuC/ohlg4X6mB2FTlKhM2byaab+GXSSMXvXsW+FMWNvlQOpm0Zj6mVRx+gokB+ASW4S3lr6d6h//siQ0B4H7DwEnNUvyo1tL45DEIok7JN9ov4koNnYWNFYEDo59TYoWL/NM4HQ5dvNQXx/h8jZ0wkY/ulHYofqiBXtEvb1k2fFEBjlnBMYPg5DHqqHg9JrgJTfZsjfvRGJp8VJoTyPbaMHLDsVSzfqB2OV37iMreLaQKFMt1OrgppkHrfN8pMh4V4ctpu9dzaz33XAALmMWYCo69z5fDRt4qPqwX141PsGrjVp6NTboGD9Ns8EQpY/2wSPdmuIWlom0f0/KZX8SDSVkQW3cE6OAclCkf35N9gjCwvEvQ/BN7jQkLwYkpHfIhJ1T9vfZ/u8jfKYDAxtrjvxWKDxa5iBN99ZogVMZYA9EBiGYRiGYZjqhIMHwgV0eu047vnH9/B/zd54QNQ9/m+9V04cXYw/vXEYkdPnYbynk+A+UfA/PhrD543GZ6dD0KEdKeDj4L9HyYav+B7hg/8ISudD8vDUd5RcbDJcIf3vGCOvVQYFec40HjjHVf3wEQr+nnewD1EIz0rAvtwgNAuiEyHo5P+VLP9WchCGPPw4CV2iPBNU/VR+QJ9o4NA0cSzqziWDhW5bGwWefPh+ZBky8Zu/sPoLJx/ZZDwgBbzFDT3zvh6HEKpn2oW8jeiSli/V4Qp7Nor93ZdxkxRyfc5tiECLLrjX66yqw25mv6ZQ+s9iq9C5mwbewKHzt1DPW3ks1Grih/zdVD4V15rYPAGcozwTVP1UPhRdT+/FcnF8KFsZN6z9b9XzHmkIkLLd2WgY2QWtWjRBw/wM7CGF3+JRQP2h+3V2fyd3KOMBkXHdmVdEE9Hvujh3zBMrGcMwDMMwDMMwzO2hhtexBL3rHipX++wufVR+5O1/r2hGhNwkrNV5Cz74lIwC0egd6oXQ/jrswOJdsO3I90DkM4gvkYLtun6a/T8g+5KGjVusabKE0r9DKfvUh+t+TZXBwRXkWaHDJmyeCK54HB1aeKHTaN0fBy8FGhN33gcmtRuit1SQyftAz7ZHBiLAlFu9C47iQrYP2o0YUIgC755WzfxQyy9UK+bGzL8i87JSrjOFwm/n55J9VnlGyD7URF1/KXWJEWIw1uKJ4JwmCAusiYA2urzhpeBfG9cu58r7PLQqFZk3btj3xy3haN8kH8cLeB+Eomm+cR8MwzAMwzAMwzAVkxo+O96SxgF30Hkqd7tQRoQT6DJ9JmK1rGhYZulpMzwKtLfB8OPtpbK9jGb2i4WL+j0l+5yb8tGYPjgKl7Q3xFvJ17XcHRS2YOmPJwYDR7TXwCFHpZzCFuQMvtqMmXXpbbDqsFCGSeE24vyLDoUV2OrXYRMecwv5WXrXGZH3oV1dwxtCKP9a7BoKWzD6IrbP9wLedYXcB3VxAxkt6qFe/jUpu5bnYBQogBEKYgl9kLD3AcMwDMMwDMMwlQMZwkDGAf+N02WOAyNRIv2lY5LfTuOBIgLDnxAq6e4N2KwlnrMdZ7O9EB7hxjhA4QCb0uDlb5utP5l1HY0aeGJQ8KB+NzzZMwrIKmwRr+vIukx/lbeDDdW2bc1tIg1ZuSp0wxmUA6EoHhd7jl1GvRZd1PrVWTdw0y/QjXHgPBI/T8a5G3XhZ3ginL6Ga7VrI1AfuuNkXj5qBTYpdK1sp4g+tvEzQi3cIBR+uRoEeVNIgYJCC4ywCMV5ZOfXRMNmzpI75iIfDdG7mx9QN1QmVDxYSGjGo9Y8ElbY+4BhSoEJGLQ6FZNfm6CPmYoPrSzwG3zUT+fOYRiGYRimUmDmQKDwBEqQGLRihFyqkf7S8e0IW7AnAk/M/TN6nFqAqfN3IE9Li8IHnybgEoUq6DAAQ4Gm5ISmrD/wmWWm3gxvoHNjdU4DF7iq3zW2EANKaDhmy3Yplcq9TH4YgiFmPduxNRW6/Dgg1d7Y8MHxNFv4hC4/+4skNDJkYiu+Z4Xg9F4cz2+Ie2mVBLH/7fm6aKdDGMaaIQs0u27IItEw47BFITbCG9R5+9UJHEj+BodEW0aIhEeeDEbIg1DmLxuz+1JhHySTMdZqEinO634mZyDTKN/wBs7doMKKk2ezAVlWnHtIGUz2bKQ8CVpG24BwaeSo5w0kfq48JJbTXzNnAq0uoUIvZOiDrqdrWwp/qImm3XQ95n1R7gj2PmCKQdNBGDpqnG0b1AP19anKDi2xOOP9OcCkRMzYlIgoLb+tyL6kYswkfYw5GFNGfSvN+6el/uQ6/sHt8NHvH8RLwfoE4wJa+jEaY/WRp4wd/husGd4c6BCNNcW4nmEYhmEqE3cEBwdbVmEoPmWyCoM2HvS5tAxT3thQLONBxYNWbBgHfGGsBFHxCAzvqfcqOHrlAnMliHKBjCWBuLDKMRShdMg4ukPvMZWB27YKAxkQWqZg7Y5jWlC2lOcqDKRAR6fPxvxzozBjBJDQPwZJ+txtg5T5mCBkX1mP+U9NEwIyIHTGwTLoW2nePxkQng/Yj2Hf+OCjR0NwdPk6vMZrTbqBDAgtceAf27FUSzyBDAgDMtfh8SsdsSYGWFvE6xmGYRimMuGwCkMFIzoGd1cp4wFT+TmKz47D4oVR/HwPDMO44UQ6snPScUEfGl4Ati0Zg4SyZpVbQxiCX0tWM/kmVq8BFfJgXGd6FsR8jMnvf2w5Z/EAuLIe2zFItWmFrtH1WPtA7U9+P1GdM+sspH0rjvdP9JmOD+PjMfe3+thTLubiEnJwVhsPyLBgCx2gUAKbd4L0Wvj9b/Rmm00nJfnNDvrAbqZehSKY15DHgykX9fajWXl1zmxTztQ7yAws5+zbd1GX7stLln6rfjp4E1C95CWgkV4DBepSNDPrsnht2PXLOhYWLmchLzdLhckxDMMwTBWlYhsQts/D9CpnPNiO2UsrrvdBpSL5m3L2PtBQu2aix7LxRGCYQmkebYYwdGuqZVWApKdCMf+lRUDiY5j/yGNQOq9Q/kcEYe+cUMzqH4qEFCB753ysTxSnFsRI2cKdubKkwcWX1iMtrLPNADCpM0JSvpOz+VHvT0eDRFXXrP5xwAhtjCDCeprnElJaI9pilEhKSkfrPg55Fqifsh7aZuPEPZPNuvzCxDf+nB3IlnXOxt6cIASLc+7ad37/xWPr5nUYFn9G7J3BCx7NijfH0KgcrP3HJxgmN0+uycVri4zyn+CfKSF4ymKc6BxwyqzrUlRHpdAf2K7KJtk/M1CohRgHs33xfIdaDBKdw7LwT7OuXpaQjOYIxzZ1zfL9aNTduMY5ZCQhjwHVr3U4GvagnXHErCsxB51jdV26z2rbDsTYjBNL4z/B45vFvVw8hMcXHcJWLWcYhmGYqkjFNiAwt4Wfb1mSAzDlBo874zHn1mNt3BK1fXEE9aJHom1VSYJQakzDwZTWaK9n96OiWiMtSYUftBeKfcgIwwNgFOwWu83ZgcQFavdCuoOCuyAOJ+4Z5ZCXgDwbjLqmo4uvFguyd8ap8ANLnYW2744ts/HE8OGY+i99XOrkICu3OYYWMV+CdTb/+SjrbH4uvvuGDBiEB0aMhv7wPnXKVubAKZz08TcT657cZSjnZ8QpH0sC4TPYSAo8UagS74PeYT7wjrJ5GXS2c0Cw1GVtX+aRMO4zunjJfhmGYRimCsAGBKYAP2RzkOztgMedKRZXj+Gsg55b9TiBKzk+6DJNKd2xDXZgJc3SF0LSyh3wi6IwBqG0i2tsSvwJJJheA7RFKm+GQlmEpMNBplGCiHp/FEJS4nQ95GWgT7iluO2XNYY3wTYgVinXhRoSOkRjaMszptdAAa+CMsEHzazLCxeZXHy33PAmUNsLB/QpK8E+aCRDEnzwUmxH8UIZXgvbOUyBYRiGqbawAYEpQH7GOVy/fIpnxMsJGmcabxp3hikyTbshwucarl7Vx1WRmH5ojR1YaCjcnrr2J27GiQadETWpM/wOb9bXKM8Ea2hCUaDQCER11keK7PQTamfSKDsPBOeUoP3i5kBwgneA6mjvfr0cZuAJZUhYazfLDzRqoAqOHe4wA2/G/VMIRIHKPIdyCLRsaYYG9O7XEa2c5RQIbo5wnzM44Ezpt8MXzaQBpDnejDHyH+RiawrQ+T5bPgRX9I4IgXeWKK+PL11RxhHZL7nnAfqZfTjN3VpODMMwDFN5qOCrMDB1A5uijl8watSsrSVMdYEMC+SVwIaFisvtWoWhfruRuL+9EbNwAbvj1tsn2ytlynMVBudQ0kH78AAKC1j4yGPAa8mY2MNeaU1bFYpl2tuAkhlO7AHsnWOd5aewA0vogK7rIiVEnASs1AYKunYk5qsVEaK+wyy5AgN5HaQiNoy8CGKQRNdM6wk/OpGyA3sbtAcWRCKpj752Sz9d52ZErZ4sz61PdNG+PnQJKaNTOiE9oaRhDCrBoFSCT+3Hd/6iJwnr8Bra4aNHO8JblhHk7sc/jXAAcuHX5/KS9uNSlL9erUAlS1RGiDP4LslX5hB4fDOEXCjNVK/DjcnVIRwMDScTlReA/TnybFBhDxQmMbSlkioPAqNeuhfnKyfY6hLlk3JUPgaZE8LaZ8JoxzIuhPX+KYmiNkLY339hPIm58UMQmvYZhr/wgZYxDMMwTOWFDQgVGDIeeDU0fzEx1RT2Tqi43LZlHMuZ225AoJUWLAq8MgAMwhU7owBTlSEDQodjLkINKjS9MP1fz+Hu79/CE3O2aRnDMAzDVF44hKECQ54HDMPvAVPtWfAd0sJG6aSDKvEgVrHxgKng/HYu4uPZeMAwDMNULdgDoQITGN5T7zHVnYyjO/QeU5FgDwSGYRiGYRimOlG1PBDazUH8w4/rg1KiLOosFZog5qEBiGmhD01cycuLMmq/RRc8OmIQxtL2UJfbv4RW5H2yL0Mi9THDMAzDMAzDMEwVp4IbECIQEa53qyXhGGJVlkmJLk3lWSjBj/Zsog+AVj0H2B1XHMQ4dPPD5d3rsXTVemzN8MO9Rj+1Ij92gP2L0nWANjY4KPlWueM1RSL5G9mXz5L1cWlS0YwlDMMwDMMwDMMwgoodwhA+HvOmRyJ59hQsPqpl7iBvgTZZ2OcXhU6UXfl0AoZ/+pHYicb0sc8oGa5j34pxmJ2uy/c38mBb5HblBYXU06vPEjyF73EpMgqhLssDqZtGY+ohta/aBj6bNw2u8jIHho/DkIfq4eDne9UyVqRYCmX429O10buN0TlNdiqWXg7EWGfyjbmIeUj0LKMumjapKYS5OLTqG+whA4J3KpbvOC+LkgHhXhxWx6SYG3XJOugBkHdBJJoaC0KYcoG1PG7h3O6NSDwtdp3WE44hIwKRf97oj6089aG3lAl0eZK1z9toUdbF9QPE2NH9NszA1uvN0NvrrK0vNE5tr2E5HVP7LW5gK40h7YvytnsJRfbnYhzUVU6wv9/M49pgYN6T5T4Fdn0X3DyfrMfWWo/9Nc7oOmAA/I5RGXVd3dPr8a84DmGoiHAIA8MwDMMwDFOdqNgeCEcX409vHEbk9HkY7+lkcYu7gS9GY/i8BKS2aI8nhahXn3Hw30Mysa34HuGD/wi5IvOhaUpG26Z0dOqpQhWefPgZhKe+o+VpUka4rEfgFemPA7Iu+3bNesRmGg9Kipz9Tsa5G6SMqll5qRS7kkt80JSUbJrBF4p7O7ez70JBJ6WbrhfbIYTqWfzzSPxc10vt1G2mQhVIYW8jhtOQ36CyhKt6CB80xGEp3yp07IbNmsh67g3MNssbin5YYD4uJJPRQc3Kyzrq1kMrul/z/iyc3quMB0TWDdxUe2rfLxBdab9FE9H+DbgzebXqeQ8aZiSrvojNNGCY46yPNSd3bNRlxbnsy/jWNMzcI40A8tzubDSMdO9VsGejYWA4j+x8KWIYhmEYhmEYhrntVPgcCHn73yuaEeH0V9qLIA1ZuUFoFhSN3qFeCO2/AvFTxDY6Cl6yIPE45pKMNtMTIRrN/NKwcct2fWzgrh7genKC9iT4CFO1V8G2I98Dkc84z6EgjReuvQ9MajdEb8OdvVtD1NLionML544ppfrk2WzcJAVc7NdqEmm69Juz55GBCLC0204ucK6gWXZV3uKJ4C92zqcWnMl3Uw95QRzXCjYp3nKm/vR5XBZqfe8R9yklX+KDuvkZyOjZDDi+HoeybyE/S5/ygK5tG+Laae3BQYaF3TfQhvpDnhyGZ4cLaJxA41PEUIdWPUOBY0bdZACpiYA2agxsz5C8C7TM2BzDFVp0QZu6l3GwLMIkGKaSEvxaMmZsSkSUPi4LZBurPwavf8IwDMMwDGNPpUiiqIwIJ9Bl+kzEalnRoHAD7TlA29K/gxZUevLhWDRKdvQ0CIG/QxSADef1uCT97xhD5Y63l0aHZX2i9YkicOOybUZ+92XbbHpJyb8mFVxyszdm2Leev6XOERQ+YLQrNjn7Th4CTfILeBq08q6rdpzhrB6XGB4OGWhsKNQt6qGeOBPoJbqc1QR+dfORLST1dP/dQfkO2lxPtrVJoQdkOKC+UBiInaHCCWRwoLIUKiH641F+CDFG7ZHqEKJg8QihTRourN4cVrmGvDq61cbxQowcTHWmLbqNGoehchuExlpa2Yl6PxUz3p8DTEosoaFgDsY4uz7mY0w2l4O0bWMm6fMucVGf7KeqY/JrE7SwEGQfkjEoZgIGrS7CdaVFp3fQfcZ6ubV7oJ8WEhMQouXdJ78Kw0bMMAzDMAxjUElWYYjA8CeEqrd7AzZriedsx9lsL4RHOFfeL11RngZPtjE8EMhzIQQd2tH+45hreia4r8ct5G2wKQ1e/kZdAsqBMGWODHUoHuTeXhN1/fWhiSu5DZqVx/VcfeQEq6u/Ize02z+FAOhflyfz8lErsImcPSd3fdMzwV09bjmKz1alIrN2bQRqScZ1oGm3SDREXbSjhIram8I5anafjAdGfgeCDB03M84rhTw5Fedu1IWfJ6tFUMjC8VzU8nJpWdKIdtsCBy1tGs9DhmjY4cYDgQwdZDygPBWyLMM4QsaDSGR/sQRr42hbjwv6TFUgO/2E3ivIxZciMat/DJL0cZFJfAzz+4eKOuLEt30u9s6h/VAsW6DPC2QbjzyGi/rYLQti5PULd7r5TnVKOi4m6t3yZt8z2DVrEP6zO08LDBYhTch3Ld6Dqp/Zg2EYhmGY4lAJDAgReGLun9Hj1AJMnb8Djj93POGDTxNwiUIJjHAFHVLwwfE0MyShQ1YShI4q2I7ZXyShkZTfj6xNhtx1Pa6g5IpmWUqYKBMrlh57LufaXOMtbvbO5TWFAq5k7WBLnOiU03vxLeVJMBTbEXpZRjPEQMgigcvZqjgp2IfylZySGR4y5K7qcQXNuptlQ4HjQoE+fQ3X6tYDdH6B5Z/TX50jQJeXoRd+obb6I0OlEcMankF5E07uOItrpiwSTfPPuk1maAvXEBvleNB5FZScQjj0mGrFXxpP/GwhG4Z8z8ZUS7tik8/ElQdCE3EPZKjwsY2bqIdhrNRvF4l6B7/CsataUBU5kY7snHRtGKHZf6vHgNUTQM3iu/ICUCEPdI5m/LXQJZZ2LCEM0iti0yiEoDVijfPkJVEYdt4OzrwpFuHiFSD73CJ9rHjyzXjE/2u6mWPHHbUfWIWQB15FO8Nz4DHj/smb4B3xTaIhrwPzHMMwDMMwTPG4Y+kLg3+Z9fG+YinmVspkFQZtPOhzaRmmvLGhxH2sbASG99R7JYVmu+8Rir777P8VFQpFaHy5jJZMrCRkHOVVGCoit2sVhsY9x6F5zhHUax+B+iQ4sx1rdxyT58qCirUKAyn5nXFQeyGQch+dPhvzXyIlnIwJ09EgkTwKqNwo+O3U5yjUICYdC03PAjo/CFfmRGK9oycAKf6TgJV2Xgj27TpChoqRmK/7QTiUL9C+a8iAMCRgH9767Wz3YXICMiD8qttFHJn1DHKl0eDXyF88ApfO0/6vkCnlAjIgRPwHuz62GSvo2tb4fzj0pYNvX5NX0W44cGL+y3DIFcswDMMwTDWnRvcJb2LFe89iQEMtqUhEx+Duamo8YGzQDD4Mjwqx2VZyYJjqSCDq+wKNW4jPhgxfWIsjvtHo1lSfrlZMQHCDXJzYYijFi5B0OBd+TY2Z9hPYbij0C75Dmm9Q+eWKmNTZ3mNhRGt9onA+eGE4hntgPDC4tjteGQmQgnzDA4xhGIZhGKYMqDH8tU9xMfhhTP/kcyx8bgAC9IkKwfZ5mM7Gg1KA3OUrp/eBgnIi2Fz9q7MnAsMAGbiaA1zYvxMqgiEDF05fRT0/I2MI45SY5vAzQyLKiZQ4mR/B3DzNq8AwDMMwDFNBqZG56W1MfPgZLNh1FS2GTscnH83B41He+jTDMAxT0biWcxWNW7bVR4Fo3KI+rmWXdghZZYByCPigdR/D42AOYnr4FMgpQAT3aQ+/K2dKqMAHIbjQPAoa8ngIG+RB3oWCFCUHgnuCUVfmb52AkAfDpKRE9JmOD+Pj8eG0kveMYRiGYZjKiU6ieAj/N/1RPPL7xUhCFMb/YzWWz/4vyIUImNvGz7c4+pTh94ApyNVDK7Eb0XoJx6Fodnotdp/TJ6sZSU/FIbvHdJ2oUOU8sK2oYAshmHjPQSx8apqWu8BIejitJ/x8e2Ii7ZvJEqchcSfQZZqqz5AbSRon9vCBn+6HWhJyGpatSreVF1v5Lte4CBd2AyHjKbnir5G/O0XLVe4DSrj4q27eqNftRbkf0kmcoNwHlIhxfFfU8+uKX9klZRRsOYt08ce7oVwvhmEYhmGYasgdwcHBv+h9TQAGPPd3PBvbGvWuncCn8/+Itzdl6nOuKZskitWbuoFN4dWwpT5iqivXL59CfkY11Q4rOLcriWJ5U6GSKDpNcMiUD70w/V/P4e7v38ITczzN0MAwDMMwTFXCyTKOmdj41kQ89D//hxO1WuPhyS9igD7DlC+kNJLyyDPQ1RN67mw8YBgBrWCgZ/FnTGuPEwvYeFDu/HYu4uPZeMAwDMMw1R0nHgje6PTYDEx9rDsa4wJ2fTgb01Yc0udcwx4IjCeQV0Udv2DUqFlbS5jyhgwTP2RfZMNEKcAeCAzDMAzDMEx1wvRAuNGsO7KHLETexE/xRc0ueCQ+D/3+8T2e315Pl2CYkmGEZLDx4PZC40/PgZ4HwzAMwzAMwzCMp0gDQm7PPyJrwGz8EBCKq7fukCeyf6qDi816SXluz+ekjGFKAnkeMBUHfh4MwzAMwzAMwxSFGtcfWYzrbd2vM3W9bSwbEZgSw54HFQt+HgzDMAzDMAzDFIUauT4Fs/xH9WyGwxMb6yMFGREozIEpGk8+vAJzS7weZjSmj12C6UH60EKvPksQP8XxnOvyjD1dBwzCkEh9UAJc1hN5H8aOcDzXBDEPDUBMC33oAVQ/1VOwLoZhGIZhGIZhmPKh4CoMQ0PxRU9vhNZXoQxW8tv8Wu8xJYGMCvFTbFtJDAzbtozD8HnjMJsW5y5z/NH3d29gcdwarFmpt7jFeON3fcUZTwjHEK0Ey21AuJZXLFr1HGDro9ge7dlEnykGyd9g6ar1+CxZHxcD6k87pMp6lq5KBdrch67yDBkiqI8OxogWXfCo0f+HusBcsV0bMwrIGaYqI1dwSESUPmQYhmEYhmGKzx2YdtBhFQZBdAiyut2E/z/Oa4Gixg/ZCFoxQh/ZUyFWYQj6I5YNBo5mR6GTVKjS8Nm8afhAzsg/g04+JLuOfSsMhdsqF5xOwPBPP5IKfofjozGVFp/Qdb6/9O/Y5mE9qZvEtZfFdaOj4KVEitwkvCXqaWWt34TqiBUXB6FTJF2l6284B/H9Q1QRA91P8j54TpY17lPQznn5t7Lux3P+X8nrCLr2KSzBmC3b5THd8xCoep3iPRBT541H5Pl4vP3W/2HvD/7wRxay6nTBfz33LIY3ScbiKXOxIU+Xd0Jg+DgMeageDn6+FyelMaEZ8ndvROJppST3blJTlrt5PhnLd6h3zyoXA4hDq77BHlKEG2Zg6cajQkZK9D1CUS9CPdlCGT9WD492a4haSqK4cRlbRd8gyt6Lw+a1Bl0HDIDf9Xw0baIedObx9fgsSyjrLuo5Sf1sQ2Vv4Zy+T6nES5kFsz+1cZzuj2RkBIgEvv38GtqbY6Zo1fM+hJ1NFXXRfZ9F3W62cSRkP4/RMY1NJOqeJgMGjXcgLhj1i3486p2K+UtWyWuY4nF7VmEIRNtBQxHh8Bpd2L4Eu8toYY3yXIUh6v1UxCIOs5I6Y4b45yahfwyS9LliQQYEh3qCX0vGxB5qANNWhWLZArkrKfX2i8QEhMwYjka0m70H/5n/MoxFfGs/sAq/6uYt9y+tG4S0fXKXYRiGYRimXCnogeCGn+v46b0KjE8U/IVyPnzeaHx2OgQd2pGyPA7+e5Rs+IrvET74j+glij758DMIT31HyTelqevd4Koekpv1iE0aBtL/jjFi/zOh1JFBQZ6TRgh3hKATKfmi7FvJQHhENHBomjh+B/tyyaCg69FKvvI+SIBQJW24KL9ty1dIbdEeT8pC0egdmo6N2nhQON4YNn08ItMW4+kZ6xDw9DKsWfhX/HXhGix7OgDrZjyNxWmRGD99mChZFPKRTUqvUJbv9TqrZ9iTcTnwHjWjLpTc3oHZ2Kpn3jPlNW5wVQ/JzXrERoaH03uxXOwfylaGACm3KOnOqYmmgTdUPcdzEdAw3H090vsgGecMDYAwZWRU0OV1f45n+6CxDk9o1cwP14TsZGQg6mWcl0YNw3MgEHVR1/88Ej+3GQ2s7NloyM8jO1+KCtC1oQ9qeTlooEwlIQPH1i/B2jhjW4sjuVeRnatPVwGy00/ovVJgQQxmORgBLr4UKWShSEjRAgdKtf0isQhpswZh1+I9cDRL3fhyBHaJc0fcf0kxDMMwDMOUKUUyIJAHQoUnNwlr9cz+B5+SMk/KshdC++uQAdMrIBrN/NKKoES7qkco8ke+F8ruM4h/+HEtKRyzHrsQBqH079DGgSvp8PJ38CQoER/hwOkgNKO8CEH3ITz7oPJY0NBYufQ+aDkGAxsl4+1ZG5AXNQmj2h7B7EcnYdKjs3Gk7ShMisrDhllvI7nRQIwpmFLDntoN0Vu60dOsuZoNJ2W5ll+odq+PRFOd26+Vd11kkhKtDgvFVT04fR6XQe0arv+FU6tJpK7HPoTB7E/WDdysW69UwwD2XM5FPW9qqwnCAvNxIZnGALh81gftyQCy+zJu5l8T6qOHtOiCNnUv46AMnziKg+frop2+p8aoQtpmdadpN0TkJOPYVX1cVTiRjuycdFwQu+QxMPn9REzelIoZ73+MQavFXyMsIeZjJdfb5NcmkFQwQZezlC0KlvZN+kzHh/HxmPtbfeyWCQiZ/CoaPbYe3WfQtgqN9FeJj5CFdFL7yuvgHbA5j2EYhmGYykCRDAi1Lh3Qe5UNy2y86QkQAv8i/2JzVo9AexsMP95eGgSW9YmWpd1heiWIzT6Uoez44Hi69GroFeGPo9pQ4RHBt3AkcRn26kPcuAYVqZCHa+bs+l4sSzyCW4WtDEju/XLGvibqWhInULiB8hygTc2gB3oZoQue46wemolP/JyOM9CYFOiHCo//t9bjGMpQZiRn4FpgE7Rq0QR1M1KlcSXQqy7gXw/18q/hpH9t8QrmChmQn6UucQmFQFBIhMWr4uSOjeY9fXZZ3KOoi6nsBKJtx3o4cuCYPq78JD0VivkvLQISH8P8Rx7DRS33CwO2z9mB7LCeaJA4G3tzghBMCwhRuf6h0qNgVv/ZOHHPZAySCwstwvpHSBaHwv3LbLhqv1j4dUWDK69Lz4H/7AZC+hnGDYZhGIZhmMqJcwPC9rQC+Q+Iusf/rfcqE9txNttLhQPYkYasXBXiADyOuZa8ASezrqNRAyofjemDDU8DV/VYoPCBTWl2ngO2ukqCatu/oT4sFBflDx3EpdBYDPXPwlaHpIsysaMrD4pdizFvxRm1nxSHHXn3YeYHC7Dgg5m4L28H4rRv8JkV87B4l9ovjD3HLqOeUHJJkT+Zl49apDirUyYZ12+pMAFB1wGhCJB7Asvsf6ue95ieBq7qsXEUn1EoRO3aQu1SUBtq1r9kFK0eCi2wN6AojuJCvh/at62N/LOWz1/WNVwjz4oWdYEmkWiHs05DF0woz4I1n4IjZFxoUxeXrW0wlRPyPhDvw4Wq5n3ghOydcSoMIWcHEi05C4A5GGN6IExHF18tLgu2zMYTw4dj6r/0caGk4MyXm+XejcslMkUwDMMwDMNUCGp4HUvQu+6hcrXPeqgdVjA++DQBlyjEQIcMKEV5O2Z/kYRGMpTgfmQl2+aozJCEKc/APzUJ17XceT3GUopa1h/4zBIKYKtLnBurciYQzkMYXPPB8TTbNbpdtZpDLEIRgiEWOeGsvAxjyA5Bo6xvCsnF4I4zWPz8OEz9+3t47+9TMe75xUJSDCjmP78h7qXwgORvcEjsq9AG2lSowckdh3GurgpJaHP9si0HghmSMAi9vbJtOQZc1CMVZlMWChy3KdYnz2ZLpVyes3gmuAphcIWzeihxowqlqCn0PPv6KVwhoI2q37oaxZ7L+QioewMp2kCQIV6+uv5k+FiPpZ9vlPkWVPJIY2lHMqzo+mU9TRDTglxrfMxwBaNdcynIbn64bEm6yFRWyPugMS7s34lqYD9wSdT7oxCSEmd6IOzN0ScYhmEYhmGYUueO4ODgX3J7PofrbWO1qCBkPPDZ8ZY+ck6FWIWhJNDqBW0Ous4DUCVQKz2cXapXbChnAsN76r3i4LCKQBWFjA7t8zbaln0k44dcjcHzXBBFIePoDr3HFIfbswqDpukgDO2Yja/Wl70BoTxXYXAG5UAYifmYv6UfJk8CVj6yGVGrJwMLInFxZCqi02ersAO54kIQ9s6JxPpEfbH0UOiMg05WU6AVF9on2a/C4BbKgTClE9ITPPFCoNwGv0LmrGdUxpFO76B7xH+w6+NFMgdC8yuv49CXm+V+RKsUHDHKEU1eRbvhwAnLKgwGVD7giOMqDE9ibvwQhKZ9huEv3I5vd4ZhGIZhqgsyhIGMA/4bp6POqW1mokT6S8ckL8x4wFR8lLfCM/Dfc3uMB0whUNjBCPKoOGszHhCn9+LbDD+bV4UH+RuY6gB7HxgkrdwB9JiuQhii0i0eCEZowyiEoDViaX/1x6A0LWQ4oPKxYUDICNpP1nkTyofczXuAbi/K5IrNr+zBJS2XhgNKuDi+K+r5dcWvaP8xlTeBDAdUPkJ8ATR60D4pI3ASWWR9CGhmerkxDMMwDMOUBdIDQe+XiErvgcCUOSXzQGDKAvZAKBm31QOhHLndHghM4Tz5ZjyGgD0QGIZhGIYpW4q0CgPDlISfbzk64zK3E34eDFMF0EtLsvGAYRiGYZjygA0ITLnxQzZnIa9I8PNgmCqAXhmCjQcMwzAMw5QHbEBgyo38jHO4fvkUz3zfZmj86TnQ82AYhmEYhmEYhvEUzoHAME6oG9gUdfyCUaNmbS1hKgpkACHviYpgAOEcCAzDMAzDMEx1gj0QGMYBMh54NWzJxoMKCj0Xej70nBiGYRiGYRiGKT/YgMAwDpDnAVPx4efEMAzDMAzDMOULGxAYxgH2PKgc8HNiSsYcjNmUijGT9CHDMAzDMAxTKGxAqNREY/rYJZgepA8t9OqzBPFTHM4F/RHLxv4RvfRhsSlyPdTPFYgvjbaZ0qdFFzz6UBe00oc2miDmoUEY63jOZXlXhGPICFGP3O5DVy1lSkJbdBs1DkONrWdbLa/8RL2fihnvzwEmJWLGpkREaXnRIQNBUa9XRoUZtK3+GJ74uAS/lqzKGxv1XVKc9ouDzRBijl25MgEhM9ajO22TX4XNrNcPjSZr+Yx34KOlDMMwDMNUbtiAUIF48mGhZE+xbXPb6RPFYNuWcRg+bxxmp2tBMVBGCKM/c/Cklhed7Zi9dDSGL/07tmlJRaZVzwFa2aVtAGJa6BOVhK4DjL6rbUikPlFkziPx8/VY+vlenNSSokNGiFDguKhnldiOA+0GhKtTkfepPhrHBBknzL7bj731uTzas4mWVk8a94xGvYNrsTZuidjW4ohvJNrW1yerANnpJ/ReWTINy/qHYtkCfShRsllzdiBbSzwhe+dszKLr+schLWzUbfBqyMWV8hgypyxC2qxB2LV4D+zTiW7GpflCPisel7SEYRiGYZjKT9VahYFmxgcDR7Oj0EkqHmn4bN40fCBnwJ9BJzkFch37VhiKtVUOpG4ajamHSJFfgmZZ6egUGSKk1vKPY+6UWAh1yE5uX95Wj6v67esx+qgMCB2OG2UMqI5YcXGQqN9LHOt2G85BfH/VnsnpBAz/9COp+D8ny9rXPcRBEab+rG0gyvp/Ja8j6NqnsARjrsQivmsW3nJQ+l3VM/UQ3VN7ZCU79DPdMga6f5J2c7CsQRYuRUapcbCcc2zjevI7GLNlu9hTdYWnGscu8I7Ef01+Gg91DkY9LcIPF7Hn8/fw9v8lI0+LXNF13Mton7cRnyUrpbW311ks3XhUnCFlOBJN5RTbLZzbvRGJp2nfKgcyhbJM13YdMAB+1/PRtAndvKU8KcndGqKWLJ2LQ6u+wR5D0c6oK8rXtC8vZ/BDEUC7LuVGPcqA0Piy6oMN5/Vntx2Edn6qhIHqv+WeslP1/au6nZU/6G0dJzVu9+IwlueF4lHvVCzfcV7KZT8GNEHK5dro3TADW683s7vODjIwtLiBrWTAsO7L+26GfNH/FRt26MK3h9u1CkP9diNxf4uz+Gr9Tlyt3wP3D/bDkbj1uKDPlzbluQoDzaJHp8/G/C39MFko4isfeQx4LRkjg8SXbVhr+KXswN4GPdHF9wQS+scgCRMwaPV0cayuJ2V+/kuLxB7NzHfGlZ1B6NKDPoO52DsnEusTldfARCkT35KrHI0IgpiPzbYvapGUTesJ9fobbau6RmK+btPS/5dau2xf9W0UjG9wsw/UxkhRu7w/OmNrh2b6rfdp6zfVNQhXRN1Jfez7QvSa9iGe65qOz4ZPlf8WuKXJq2jXD7gS0BUh8kZTcGTWM6LngM9j6xFwZBDS9pGcvA5+hUx9TkLXDhc9nv8y7BfqdVKWYRiGYZhKS9XzQPCJgr9QwofPG43PToegQztSisfBf4+SDV/xPcIHK1d6kpMyKuVisynuXugUKpRnkm9KRydd/smHhSIvlGVZ3iK3L5+G0DaPS6mr+p98+H5krTDqAYY8rMq7JgSdSMkX5d8SSmF4RDRwaJo4fgf7cklR13VpBVx5HyQgVR4pPvhUnF+RhOu5Saqfuj/btnyF1BbttXdBNHqHpmMjKeeXs3Dd5270dgiPcFWPIkSodkukzOyn4X0gxsURr8i79TiIvhp9aDcHQ5Ag6zDaed+dscCR8CfwxsI/o1/+Gvx57DAMe3ocxo0chsf/tAbX+vwZS+Y+gQhd1FNuXlc/e1v1vAd1T+uZ9N3ZaBip3PhJ3jAjWcnFZlPca6JpoFB65cx7PprK8kKBjvTD5d2q7NbzdW0z8vBBU1KmpRxo2EzNsncdIBR/YwZ/lWE8IDkp0Vpundl3ScH692wU1+6+jJs3Lqt+ik31X3sfHLf/ye+q/MkdZ5HpF6jDE5ogLDAfx3ecR9eGdXH5rNCLKBRCeg4IRapubQQmf+PcaOBI/jXp/dC1oQ8yTytPiFY9myFAjG1df1miWnL10Eqs3e+H+yl8QXzM9pSh8aC8SXoqVCnAiY9hvkWB9wsT3ybkGRDWEw0SZ2NvThCCY0hhn47Whw0PgNk4cc90iwdAa/HffHVuVTq6TFJhCRdfipSyhBRVqnCEkj4tCNtlG1QXEOs0xGEO2ofl4sQWQ4FvjS5B6+U1C3cCXUZSeAEZAkYBq3Rd/eOAEckYJO5FIu9PnUtIaY3o1yZIMd2nIbe/hrwmlGGC7stqPCgWrbqi7jfkOTAIR06GofkD/fQJhmEYhmGYqmhAEArnWq3QkrI79RApxV4I7a9d8UdHCXVfse3I90DkM4h3osCn7tEz74cOItXHXyh+j6NDizQcMJTlQwnYB5IrzPKkePs1lYYF5/VTPV7oNFr3x8GLwOyn2GwhDNexb4c2DlxJh5e/g+dBifgIB04HoRkZCoLuQ3j2QTVLlf53jJn3Ffx1Pz0Lp0hTxgcBGTHcegkQp7/Snh1pyMrVfXCLMka4rjcCU34/DLU3z8Skt89g4GtxiPvHXzEvLg5/G3QG8/5nJjbUHoapkws3IQS0UQovzY6r2XNSimua8rGmB4FQns9mi9OR9q74GkPpRXIGMmsLxblFEzRENlK0EUAq3nXr6ffoFs4dU0r1ybx81PJSM6R7LufKdu3d9sPR2K8mmnbT/WmjyhqY/RSbLYTBef2lw1FcyK4LP/IcoXvMz5BeFX50r/6h0sCy9fwtXMsrfA7SDFVoIz5mdkYGlUuBngnVVc+7GocxNB0kDQe745bgq9PNcP+oQWisT1VVsnfGqZn4nB1IND0GJiC4gVVhX4Skw7nwa6qUbprB324o1Au+Q5pvUPHGaVJnhKA1Yo08ByNa6xMKvx7TdQ4EMgwYXgbECSQ8NU3uXTwnv+wErdHA9wQOmvcwDQdTfNDAqNJyfxfSjc8LGSaAkBG6fYv3QmFsm/MEhnvifWCQvQcXpJcBcONKYf5aDMMwDMNUN6pJDgTLLD1thlu+VJLF8fH2Ukle1odmzJ2Qm6WUwKLisn4KLbD0x3DrF1A4gCG3D2UoOz44ni69BXpF+OOoNlQoPsJU2Zd3kNW1ZDkZPIYMMC1ilRFl9N04+kUR8iYMfhxdc9fgTwuPAKPHYeBP6zDuyUkYM24dbgwYh//CESyetgaZ3R5HrL7EFeSWL2faTeWeILd/NesuNyM3wOm9WE7HlwOl4usyPv/GDRQryIdm60X93+IeB4MAhS1Y+mNRtmX/tdw+lKHs2HM5X3o1tGpWG5elocIHdesCgd51cS3vPAK9gPwsIYP7cTi5Y6PuewYaW5IuBrTRHhf6PqnO6kkg2nZsjAvbldcBeSPsPtMYEe0C1WnGOTHN4ZeTXnxPjZQ4PfuvN4t3hC0HgpNwiFKDwhks7WuvA4ZhGIZhmPKkGhgQtuNstpd2p3cBhQNsSnM6s9+rz/0IzT4nlFiaJVchEZJ2segEDw0LdvU71FMi1L35N9SHhZF+DpekN4UDhw7iUmgshvpnYasxSWYHtaN3CVf1lAK9Iu7GJdOIYuSeMKAcCK4NPd41L+GbdR/achzcvKp3ruLmT3o370Os23kJNb31sTtO78Xx/IZoLxX288jOr2mGFTiFFP3juU5n9qXbPbnjn76Ga7X9EKZzPJhydegWUqxtM++5yL/hg8bFTpBoQfaptlBLPcRV+eQMXAsMRXuvG6aHBZGRly89ItrUBZp2C5XjWlSDHHlhIPusmfuhvRiC/Cx5qhqSgas5QD0/4wkEor4vcC37NueguS0swsUrPmjdx/A4mIOYHj7IPlfQjT+4T3v4XTljy2lQFMh7IWyQLcygRJzAlZzWaG+EWcR8jOiwwpIgkpeCLZyhKFAOhPj4uSVIgmvDu6EKZ/B5bDgayb2S8CTmxscj/s3S6BnDMAzDMOVFtfBA+ODTBFyiUAKa1aZNhxTYrTLQH/jM4glghBI8F/o93pJycp9PAIwQAypfyKoCzusX9XyRhEaWUAWrQuw8hME1HxxPs12j70ut5kBJGkMwxCJX4QpaZle/kGeHoFHWN7b7aTfH7AdtlJfA5hHhqh5nUHJFUY5CNbRngbvyFPZhHZsCS1G6IW/tPLy3WR+sWIfkpk9gyXvzsGDhE2ixfx3+T5/6+t15WOOhZ+6eY5dRr42aBd+zMRXXKFSB3Otp0yELdqs2OLjdm6EQgdnYKuVH8RnlT9ChBza5a6yrKlD5b2VIxXkkJlPfbOesng/OQxhcQeEHPmhnV14vvUihEX6hDvU4K08Ieb4P6l0/rw0EuciHznewaj2Wf648C6RHhF5toTcldJT16xUXjJUZ5EYeByoxJBlnDok3WskpJ4QtF0R15MKO7bjWfqhexnEomp1ei93n9MlqRtJTcci2hBD47Zxt8QKwhR1MvOcgFupwArncoZDFmmEBOp8AJTGk8pQs0bcnJtK+XBZxGpZRDoVp6jraJhdDmVcswvoFO+BnhCOItrLtwh6cY3+fYvNwmcnSInez+CR2e1Euy9j8yh7bygqUPJGWahzfFfX8uuJXtP8YjY2xvCMZG8IQQft2yzyeRBZFaAQ04+V9GYZhGKYSUbVWYSglnK+GUJVRKz2cXapWbLidOI59yZ6FP1pFtUD9a6eRfNzz6erA8J56r2Q4Xw2hKqNWesj+XCv9AnM1BnMVhtIl42j1XIWhvCnPVRiY6sOTb8ZjCD7D8Bdu9788DMMwDMN4yh3BYf1/GfJof4TU1RIrP+fi0LqV2JRa+HQtGxAqJ3SvtGSibYnJ2wx5PlgTS9JqD4V4epQ2bEAoOsbyjsYSljYsy0EKbp5PLlVjAhsQygc2IDClSp/p+HBKJ3insfGAYRiGYSobd/SZ+NdfovPXYeXuy1pk4e4HMLb7DXz5zmf4XotcUZUMCEz1prQMCEzZwwaE8oENCAzDMAzDMAxR4647gZ9u5SI318l2/UdR4k7cpQszTHXg51s39B5TkeHnxDAMwzAMwzDlSzVZxpFhPOeH7GLlaWfKGX5ODMMwDMMwDFO+sAGBYRzIzziH65dP8Qx3BYWeCz0fek4MwzAMwzAMw5Qfd/R/+q+/dM36BEu3OMmB0G4YpvQHNs1bg8Ly63EOBIZhqhucA4FhGIZhGIapTrAHAsMwDFMNmYMxm1IxZpI+rNRMwKDVqZj82gR9zDAMwzAMUzbUyMu/Ce+W0Rjy0JCCW2QAkH8dhS/iyDAMw5QfgWg7aByGjlJbt6ZaXAWIej8VM96fA0xKxIxNiYjS8sIIfi1ZlBfX0kbXmyhDgTqXjEExWlxaxHyMyas/RrA+LEtobMra4FHc8S8d+qHR5PXoPoO2d+CjpUTtB1Zp+XqEdNJChmEYhmHKnRppicuxLSsATYKbFNzqXMam5V8iTRdmGIZhbj+New5Fs9NrsTZuidi2A9GD0Fifqwpkp5/Qe54yBzE90pHQPxSzaHtqmpaTYWEQ/HbOVvL+kVifqE9gGpYJ2bIF+rBSswjrHwnF/JcW6eOSUfTxLy0249L8Qdg1Kx6XtMTgxpcjhHwQjpzUAoZhGIZhbgs18HMu9n++GO8tfK/gtuQzHKpM7gft5iD+4cf1QREpybXOaNwRK//UDxPQEvP/NBbzI7VcM2H0WHxhlUf2wxe/64h+8rpheMWiDRhl7cp7QL+YYVgZ46uPXEDtUbv68LZD4zC6pT4oAU7r8cUrv1NjKMe0sHZcPEO61tVzcHXO3TWlCT1zZ+24kpc6pfo+qXEvlfehShGI+r5Xcfa0kXPmGM6caYzmVcgLQXIiHdk56bigD9WMuOFJ4DAzHtMcftayFhoH+SD7nL1ibfVWKDijb/VYsJwnTwNT7uHMvJs+23lMmB4MKhShgFzXExsGhIwwzuv6LG0UCGFw0T61PeY1y/3YeWxoHMef6DMdH8bHY+5v9bFbJiBk8qto9JjhUbAKjZqoM+RN0O4B41uCvA5s5xiGYRiGqdhU8BwIEYgI17uVlmxk5uQgM10fEkLJeiBgH97421JMTtYygws5uCiuOaN/tZHi9wg2Y7AoO/hvm4HBpNAyJSUlIwd5Gdn6qDCcPMMKSUs80iUbyY7vlEt5RecUJtN7v+KUPmZs1Ief4d9dvwcimuv9KkDSU3omPfExzH/kMfF9KCDlfQRsHgargFipXGtlf1pP+Pn2xESpEKswBUNBt1O6taJ88aVIWU9Cijy0QAr8KGCVbsf0UBDtTAvC9gLtu8FlnwVCsZ94z0EsNM4Z96k9CYy2Fx5uj5FkFFgQI4+pv2lm32KQRJfocwt35soaTNy1LwjpYdxPHNLCBpmhHU7Hv7j4dUWDK69Lz4H/7BZt9uN/vRiGYRimslPj6YlPw7b9Bv1DvfWpCkB4T0yaPg/ji2REaIrpY1cgforYTI+CxzGXjuW2BNODtBjRtrL9Q7SMylrL0PEcPKmPEPRHLLM7X0wyc7BZ77pGKH5tUvCGqUCdwuq9QHPyTpCz44ZngtWooGdtxfaHLjbvAzJEGF4MRnk5Cz+2E7x9O+EP+pyapVYz9WZ5j2aAbe1a+2PXrlEP9X10R1sbcsZatzlYlAntp6+xeWJY6zG8KqTMnO02vATc1+MSOZ4elDMIso2/HDN5/ViI3/4IG6zkNo8SJ3JxyYTRor0YZ320jqVDn8izwu55W4hsheC9+4QK4oCjXPdJ1U8b1Udt9hP9McbZaNfFu0B1WJ+hwzvSl94tkhfijUDPcP5oNQbzY1S/1PO1jUEBLxpr/436SSb2XzHatYyRfM+d1OX03XQ39hWGDBzbfgT1onUOhGjg7Bl9qqrSOgh+Kd8phZlY8B3SfIPQWIchzJqzA9k5O7RCrsIUrEYCU+m2hDY4RXweW2MHEh3DGiZ1Rog4EysNFGIb0VqfcIPLPgNRUa2RJhR0Z8q5zEGg25nYw5oFoIi4aZ/I3hmnz53AlRy5UzhbZuOJ4cMx9V/6uFBScOZL9S/djcslMkUwDMMwDFNBqLFj9w7Ytkw0fnAMHhDKToXg6GL86Y3DiCyKEaHF3RDaAIbPewf7/O6Xiv6TD8cCm0gmtk3p6DT4j+glij758DMIT31Hy41MDx9hbTIQHiF+lRPt2qNRcgI+UEeec2E/Rv5ts1DacvCXd9fgL858a60kb8bgd/djs5x1pesEpPgdPyV+1GpFRyhIYfBDQJBQ6oaF4fBS8kpYijf2+uERqQCRsifUqS8Mue1X4ebENdqLQZV/QChSi1aI46X7kJejvCHonPKIoD6r48F/W4M9AZ0KUaTs2yVPCdl/odT9jgwgZj39bG70oZ0Q8I2Wi7vq21i3+YW431TD40KPG9UTuM+UHW5zv+wP3dPqzE54RNTZL6aTUJLXiP67qUffF90jXTsysZBfzW6eYVgb4F2qW7QTFiHGXpZditWp4iezMQ70PF3JZS2+6NomQ43PF9noOswwLFjH0oN3RyKewX1+OHzQ8Z4c5fbvjuqXfl5Ceb4HX0n5G3uBe9qTsu3mXbA+Q+uz9RXyI1oun62WuyAsQIwBjWOXQHwp/noH+gmp8j6wvsMKoeCPtfXfNpYCs126r5aIpP5E9rPz4LnYRb079u+m2LSRzm7sLc+kwnF1J76S+Q/Etv6YuPeryHaYgGZKmZQ4ZYQwtpLOzjtjUiJiw06YXgMFvAoYhmEYhmFuMzX2J++HbTuLvBq14OWlz1YA8va/VzQjwumvMFu6mm/H2Wwv+Dd8HB1apOHAIXkWOJSAffBHK0SjmV8aNm7Zrk/Y2Hbke8BfeSQ82SYIR49YyqT/HWPmjdNtFB05GzpMKJ8euGX3C4JQ/PyUFwIp+pk5kB63fqTopeBrrVhuTtyHlABfoej4IUDc3Wpnruo0Q6tnVq2eCa6wzc4OQ9fCijem/hRst1/7MOD4Ka3gCUX0m1MIDtKV5Rjlc3Am0xcBbjw6qB5vizeBtT+LVojaB4t7EmP0bmEGAXdIRd9TZV3oEt9oxTU9A3ly7IuHWU/ySaT4Bgp1W9zTEaFMi3tymr+CDE2GgcYKPYPMfQX770rulFP4Uo+h1cDi8l2wPMOvj+cU69kSefodyXPmPeFIZCuEpbq4H7Ndei+UoWhCREukiPFUKA8e2Z8Lp3AY5Hlj9eZoicjQU7ZQj+R92AP1TCoy9dvdj4icZBy7qgVVEYrHD+tsieEfhBAXOQ9KROIZZPv2RIxjXgSavbe4+XuEmz5fSM9FSIyLEAjzvigxZEEPBL+mTv2PClIWY1akHAjuqddAfbJqP/A/CCGbYQl58s14xMfPtXkLMgzDMAxTJlTwHAgKZUQ4gS7TZyJWy0pOCPxdeYemf4Ojfu3FD5HH0QGGQaJ0kLP+a4DfObh8OyOMZmKFUhZM4Q5BgUBGtpABmZm6gCONRVm9aw/NOnfCRT2zWnBW1wGane2SjdVydnYN9pRALy8t8vbaPCgKzMrn5FSNpUZzMpSBSBoJluJd3C8Vd0+SH07oI56vqSjbKChXSn3XscqYRLPzBfJwWCnCu3AxvQK8KB5jeFacRCQZRwoJtahwNB1kLuF4v28y1u44pk9UURIfw8qdQWYIwURacaEEHgBGmIAtP4KxvOM0LJuzA35mokIjiaKQr0pHl2k2uV3CQjP/guUaN32m8IqEK5ZrjNwEC+KwF4a8M644eCAkrdwB9Jiu21FJEY1cDxTu4KfPFdb+7ebGl//GpVbDZXLFXzU4jDQzHc0EhMiEi8PRCGGIoP3Jr6K2OOOjkzFGtAIaPWiflJE4eZn+FQhCsz7qmGEYhmGYsqFSGBAomeLwJ7oCuzfo2WxPMDwP0pCVG4IO7bS4XSw6IQsnYZU/jrlmDgRiO7amBqHDw+2B4x9pmaa0ciB4ilDKLtLs+31+QBdKqLgPfzkgZL4213By3w8jIwMlYDTkUvGzmy7WSQB90beNRS6vcTLLaiizNINtNxFO4QoOCpeezaVQAiub07Ph3aalLkeu9C0LVzKdzOjb12OF+tIJmWvW4N3jYfiddca+qJ4BYryKlAPBBZSc0ZyJt+BKbmA+Q31MkBcAGXvsrnOaA6ElIgMKeoA4lyuZo+u+W1y+CwaUpBEeJJl08u4UFfLUCC0spMYGjbsMMZE466cKGVLeH5QsU4c+EJGd0BX63isa59brJRzFVtWNBxojp4HadAJBAzcJ/ygpoONSjSSz1UWbZXlHqstyzrxWJys0NnPJRIfytBnXuOuzXR/MvluTKMZgvbjebIewa0vVZ9+G2gprn+S2eqlN6/KWbihSDoRFSJv1DEwTyL5nsOtjW5tps2i5RrF9/DIuzR+BS+cd5MY2/2XcEGdyP3aQzzKuUWy7RB/sdJzdoo4ZhmEYhikbKoEBIQJPzP0zepxagKnzdxQ+09wiVidLpLwH0/ABtmP20gSgP8nE1h/4bOnfsY3kXyShkZTfj6xNSbiuqyAojKFRC9hCH24DKRnkbq0z0b+7RsbSK4VPyJam4B49i0zu+yrRopBT3DbJx6p4cgW5mEPPOt8vwwpsnEJyqlCspIu6nu023buFbBhwOFWVdE0O/rJmH4KNJIGGgpu8GW8IxV4laByGe45TjgJ5gWusbRsKvaiHch0YiR6N+ikJYVftnk9hHBe7WJatdFZPObD5oFA3RT9kPy2Ksiu5kVjR9gzpvpTMkBcWmiHzP5ihIjacy8XzthtLsbnzhnH3LpjJN8XdfOF5+IdHSIOOCrfxluNmPEPLO05tF2KMkHkyRAl1r5Z+6vptciPXhRgt4z0eDKymHAuyrGg/0jAyUaLF8nunGIZxRy9M/1c84sU/+Z8Nn1r0fEUMwzAMwxSJO4KDg3/R+4J2GDZFaNib5mFNERXnwMBAZGQY65KXFsp40OfSMkx5Y0P5uqm3m4NlDRIwxkmOhBJDCgnlQbAmgHOGp+WYSgkZCiKPOFnKs0goL4wzQvG1zx/gQu74ThX3HeN3U0Lfe9euXdNHVZf+/ftj06ZN+ohhGIZhGIaprtTw8fGBbfPCXUL400/q5G0nOgZ3l7fxQIYorEB81yy8XxbGA+LCfnypZ4HdxreLcuSab84Wl8T1m6miqFlze+MB4UJu55khtrGdcNFI5MgwDMMwDMMwDOOGO/76179aPBCA3OSVWLql6L7IZeOBwDAMU3GpLh4IDMMwDMMwDEM4hDAUHzYgMAxT3eAQBoZhGIZhGKY6UUlWYWAYhmEYhmEYhmEY5nbCBgSGYRiGYRiGYRiGYQqFDQgMwzAVmMY9x2HoqHG4v12gligMOW3dmmphFSDq/VTMeH8OMCkRMzYlIkrLywLZ1ia1TX5NLj57G5iDMeZ9TsCg1ckYFCMPKj3BryVjxuqPERzzMSZvKu/76odGk9ej+wza3oGPlko6vaPl69HuAU5NzDAMwzBFgQ0IDMMwFZJAtB00Ds1PLcHuM1qkqd9uJLphO9bGLRHbdiB6JNrW1yerANnpJ/ReGSKU2ugGO7CwfyhmiW3+SwXXMmFKgStncFHvli+bcWn+IOyaFY9LWmKy7xkhH4T/7C7XxaEZhmEYpkrABgSGYZgKSQaOrV+C3ef0oUkgGrcAjhw4pg7rB6Ie6qNZC3sPhUrPiXRk56RDrQk0B2NWf4xBpseAZTabPBXeF+dWG+csXgty5tuJnGgdBD9nyq30fNDX0Oy5FGrPgNds50yPhWK1T/UZ8lEI0VK3WPsltjGTlJhm+ce8ZmmHvDcMHK4xxo2usXlcWL0erP0Sm3n/BHlKWM6JzW4MDLndNZrEM8hGOi4m6mPJk5gbH48Pp/XSx+7xeWwVGj3gxHOgyatoN/lV1FZHqP3AKvYqYBiGYZgyhA0IDMMwlYpA+Plcw9WrYrfpIAwd7IezB+mgapD0lPYGSHwM8x95zKbg+/ZE6/TZ0ltg1qp0dJlkUVTD2gMLlCfBwp1BiJaKrVB4pwVhu/YwmLUKiDXd6YWiO6K1uG6UVny1ck/nYtJNr4SFh9tjoqmQ+6BL0Heqrv5xyO4xymYQKEr74kzU+9PR+rC+F1FXmqykEBbE6PLqGoywGSRCehjtiLrCBmljgGh/RBD2zlHXJKQA2TvnY72dEu/IIqx/xGhD3f9IbSSIen8U/HYa438CyNmBlfSc3IzZxZciMeupaWJvGpb1j0GSlBYXb4S0zcR/Zg3CrsV7gG7D7cMSGIZhGIYpF9iAwDAMUxkh40HHbHwVt17P0ld1TmC7EWaw4Duk+QahsToCUtabijEprdIAMakzQtAascbMOBkMCDJMGEpwSpxWlpVyG9ynPfx8e2KivmZiD6uKmou9K0kZJhwU4qK0LxT79mGWe/EUO28Ge6+F7J1xui8ncCVH7hQba14I+/t3jvsxc8cHmDp8OJ6Ys00fF86lb17GDdo5fxocfMAwDMMwt4cKbkCIQES43vWUdnMQ//Dj+kDx5MMrMLedPnCEyk9xc77a0hYPjX8Gz4x/SOyVhPsw6hlRj9xGiSOGYUpGBrJzG6MbGQ/W7wT5HtTzrUIJEDwhpjn89K5bTAOB3qweDS7INmbZjU3OoBeTYrTvnAkYNKknYPbNE68FMib4oMs0pdjHNtAeA+6YlIjYsBNI0P1duDNXnwAupOfCr8d0ZVwgz4YFtnsp1TFjGIZhGKZCU7ENCOE9MWn6PIwvqhGhKByahuHzRmPqIX1cKpDSbFWWHY9LgbsfwkRTMX8Go6K1vNQ4hs8Xv4N3Fn8u9ooLGSGigP+Iet4R23+AqFHGKGgDhcWw0PbBieb9qG0iHrpblWYYxiADF05fxdXTx6TxAPV7IKL5VZw9nSHPVgfkrHfKd+5d4slLwXTn94yLWw4C1tCEkuCyfVLsW6O9zmFAoQEe5UAQZJ9TBoDg1wYVfk1MP7SGLUmko/HCL0h5RAS/NhldfOWuwpJ3Isb0JpiAqHtghkPM6h9p87go9pgVLQeCW/wCVA6EJq+idTdvKSoJvaZ9iPj4DzG9jxYwDMMwDGNyR3Bw8C96v0QEBgYiI6P0f8B6d3waf/vDPUiePQWLj2qhC6aPXYFOdt6T17FvxTic7bkCHbKS0CgyCl5CmrpJGwzI+6A//QxT5Wan0zVEtKjrGbMuszwR9EcsG303jtqVd4QMBs1w9p04fFPgmBTngWhZV57AZaFcUxJ1VSYKDZUUSfra+0Y9g2bXTsEntKX8gXQjdQMWrmsoyt6D64kL8fn38gILntezBX3Ef1tEfcpEQAq8Ooatj5eT8E6cuguF8/oRPQrP/EpJzWuEbKJvklm/NBqMuhvfx32Pu0X9Xt8b9+4MxzFkmIoHfe9du3ZNH5U+tFRjt+b6QHIVR75YiWNXaYWGoYjQ31EXtjtLtlh69O/fH5s2bdJHtwNK4GdRtHOEYmwoxJTAL+o757PedM4MHVAz5eZqCy6uowSDVjf8tFWhWLaAkgtOBhbYFGeT4rRvkaetonwGnXFQhkRQO9PtFXryYqC6Lddk79yB7B5B8poLor8jMV/fl7WfTuoyx80ynik7sLcB5XBwvOYE9u4MQmtdt+O4yJCOOWo8nI+ZPnAJGRCGIGjPWx6FMfg8th4BRwYhbR8dTUDIjF8hc9YzohfqXEQrkqcgbXcwGuD/4dCXYaLMcDQisUH2Hvxn/svAA6vwKwdDw6V1Rt2C385FfGwoUhOGY+q/tOz/t3cv0FWVd97HfwSLlUBCuBkGMomBQeUSGqEyYIChmFoGpryaMtQ7OsiqfQfXWDtreF9wLdcSunCN1i6dqV3IUMbrsGx04kh530a0QgpFwYwBRJFLYvAlhEvIkYhSL+9+nv3sc/ZJTnKScDHkfD9rnXL2s8/Zt7Oh/v/P/3k2AACwunwCwehIEsEmBf5ip0r+8xnX4A9h+H6/Sv1izUPa1GK9SRbcKf02lhCYMm21Fmq1bn0jQXR7hgmEI9EgPb5f/5p5d6n/f7uEgAnGhx60QbgJ/Av71Oh3phLAVB0USW/8mx+AZ9eZZMIZbMc7vWl2e6bKwCQ2pkkVoaRE6Ps+P/nRMvD3zu/v+qvSVSvYZMVH/6KDQ82xvOFtx09GfHagUnXZw3S84hON+tZxPRmXmIgXS2bEnx/QlZzrBEJX0TUSCEGQjXZpkdgw13Cmjrqgv2NaXn8zV0JRfSgh051MW6Kn7rlc7z92m5Z7/xcGAABiLohJFJuqfqX/9c97NWHJA5rt2jrqwFsPyfZxHGnQJ/2Gqq2iyU27vQh63N+3mEvBqn9Itz7WVvKgbXv21kmXfVd/Hy3lN67RsEEXK7fYle4HPfnOkffdMALvzydtkO4PL3i3j7cd8/notjq4nfffV52ydbkZJuD9T7a35DW1zn6mRpXN8ypFwzToklx91w09KLS7Han+ZnuDCm2i43cHPlOk8Yj9uAb11sXe2uZDGGKuUeFlEb1L8gAAOscOoQieMmFe86TfdCZ5YCzWzn2hCSG912yt7ZbJg9sfKVUpyQMAAFp1gTyF4UqV3PZt6c3f6XXXck7ZJMEPVfLBGDvB4tOmm/5sMcG7mQ/go2E2eL5rVjBFoRkO4OYKMK82eucDf1jrf/Z3J0eFkggd2c4evV8nZY/wjsEL6lX3vp9g6AwzbCG037UVg9S7j7fZzAxFGvdokPf+kyNemz7xjtAzKFuq8D/7uwMZGhW9Dqb6YJQyDlQydAGAczYeA5hqzDUL5izwX8mHFbTOPF4zvK2EQza6gX+/r0QlJSQPAABozQWQQLhStz38vzWp5gn99PHNyR/d1I4Kg3YzEyxuqFbvrNB0VWYIwz2rtWSwW07oiD45NUjDgryD6aE/5QLnQMVa/ct/H9HFfUx3fbPPd9CexmCm7I5vZ8+6dxXxjuGaoUre428rFnJV2Hz7Rz7RZ4OGNasi8B3xjm3Qt/5eo/pIucWFNoGyx3z+yLvRoRKD+lxskww+qg8AAAAAoCvq4nMg+MmDaYef1j3//Lt2Pvc5PAFiaBLFD9xEiCYB8NfSyjUPSdNW6x/GmWkVnYg/T0J8e7Vefmyx/t0ttW8OBI+ZZ6DYn7BQ+kw1bsJDM7b/u5f5rSbgj05CGPf5YLLEPdH5BFrMORCdyNDo7HZ8dn4EhSdLbL59bw/BZI9x24/tN/68zPmauQ8KdfzfEk+CGPf50ESN5lhGnWw5twPQFTEHAgAAAFJJ104gFN2j5ZPe08/anTxAV8JEiOjuSCAAAAAglfTs06fPA+79Gendu7dOnTrlls6SD7fqtc379Ce3iAvLsQ9OaujU7+q711ytq6++WuMGndDbH6TOs+rR/Zl/906fPu2Wuq/8/HwdOHDALQEtTZ0+S7+4tpcOvX1ENa4NAAB0PxfIJIq4MPlPiwgmVqQSAei4IZPv1Jx5d+o7owe4Fl/f0XNt+5zJsQlIuwPzeMD7V67wH0O4oVyFrv1ClL3sHd3/4rPKLn5Wiza8o5nFbkVnZI/WMz+ZpaXZGVq64EY9M92O03Ny9MhPbtRLJTluuavzj/eRsdL8kgvpuAEAAAkEAOiSBmjkzDuVU7Nab9a6JsckFb6t1/Tazo9dS/dyon6ve9cNHK1VnXt75hp1MNHGxubq0soKbc/K1XzXdL5tfH2drl+1SxvdcnIRNcTNLAwAAC4EJBAAoEs6pj3rV+vNj9xiyKHNq/Xarm4+HGhvvU401uuQW/QrEg64V6w33/TyL1q2wF/QAs18MVjn3i+LfS/4XOHKxO3+d4J9eC9TPeC12n2sLNci07byWfeZWHWErZposa2Q8lqdUL3qyt2yMW2Jniot1cN3uOV2i+hgg3T4aPD0HWn+yEy9t7vWa8/R2LGu0RhbpJdMZUL0ZSoY/FW259+1R6sZTJVDyWhb4eCvK4pLSJhhCtFtLRitqbbVVT/EtfnC+2i+rcD+4xE1HW90SwAAoKvrMXLkyFYmUfxCn55s0ukv3WIS5+YpDADQdZ2vSRRNxcGVjWUtkgZmGMN3Mt9R2eZzOzzo659E0QT2i6Qnxml9OAj3mOB+rh7X40tXeUvhz5n3SzTh6Fo9uHCxt26Fbt0wXjtnFEtewD974GY9ecPNqjPDCxYPVoXXXmm3GBNs+wUt0l2T6vXKinoVLZ6sE79ZrqPF/n4qpzXf/xINLL9MTz/hb6NVJoFwz1Wqf6VEP/21a+sUL4BfkKEy0/tvEgYja3R9qSlZMYF9gRqeW6dldX4wf+3xdbrl9YhNBCzUJvteMkMiZilr6/O678hoPXNTgQ6Xe+93xH/HJiMmNujR1qoMTPJhtndpW1sfd2wAAOBClTZ//nwlfv2d7izOcx8DAODrskp1RzM0YfEB3Xq3a2qXiLa9YJIHxmI9HUoSVJff7A8tsNUBMeFqgrsmxeYZOLFlrf/dxs0qjyYHFqhwVIb6TVrivrNEEzLdqmTeWK7bSs40eeAZm6v8hogftO+o0f7cZMMYMjR1eIbSC4NqglkaH55OIVKlsh3+W1MdEJg/Mkf7t3ZkiEKzioVi5jkAAKA7SHvssceU6LXhQ6nXJenuYwAAfH0qF16mB2dcpp2FfnDfsURCO91drtnD9+oVbz9mX09uiQXQrYto2wr/88ErafXBWWQCe+UGQxWKlK9gGEOjGiIZGn+TH8DPyarSSltxYES0/bnndf3PYy9TcXBWZY/WwkLF9lNO5QEAAN0BcyAAAC4YJpFgAvt+Q2NzDfQbPML+mb1sUfsrAFoTnXdhhYpDFQiJrVLlu9KEuSvccgd0eg6EsByNza1VWSgR8GhlRJcO9I47O0dXqEqPBuuiQwsi2rhPGn9NxyoCTDVC/sT4OQ6SCyZ9zNDSie3f35TFT6m09CktmeYaAABAl0ECAQC6qOARjld7sVffMXO893M1sm/sEY7fGeMt5BT5nxnqvtQtmfkLwkML6lVh5xyQ6pauV/XweX774J3adibz8T2xVts0WXfZ/YzX0XZUINQtfVzbBvr791/n8dGTZvhCpEH73aKxcXe1NDxHU+tq9Z4KdG8whMC83CSHG1/fpO1Z4QkWE09wGGaeslDWENpeMGGifbykt3xTgdIz3HrzWMa6XXq1Jkdz7OenSPvaX4Gw6XC997/pysr3lwEAQNfRIzs7O+EkiqP/xz2aoQ167D93uZa2MYkigFRzviZR/Lp9/ZMoosNaTFoYP6lil2YnmLxc7z92m5a/4doAAECXQAUCAADdjZ1QMb7KQOVdP3lw+yOlKiV5AABAl9VqBcLlf3OPrutJBQIAtIYKBAAAAKQSV4HQU+l/NlwF4wpUMCpP/XtJ7//Xv+qlbWYcIgAAAAAASHU9hk64/qu/nfltDbpE+uL0aemiXuqZJkUO/F4vr6vS8S/dJ5OgAgFAqqECAQAAAKmk5//88W0PXPzR71W29mW9tnWb3npzqyprvtSfj5+iKaMv0Yc7qnUy4SCHeL1799apU6fcEgB0f+bfvdMm8drN5efn68CBA24JAAAAqSrtmwc36D/+q0qHQv8NfFrHVfnS71WbXqAZV/d3rQAAAAAAIFWlbS/fpSb7zi5LAwo193tXKeurKm374LT6X1GgQW4VAABoboFmvnhAi5YtcMtnJnvZO7r/xWeV7ZbR9U2dPksvLRitqW4Z50KGli64Uc9Mz3DL59v52r955OqNemSsWwSALibtYJPU8y9maf7fTtKQtJ7KKRin9No/qvKYVHvosPfvZZYGuw8DAM6vIZPv1Jx5d+o7owe4FmOARs70283r6qGuuRsoXHlA969cId1drvs3lKvQtZ8Xxc9q0QZv/9HXed7/WeUnNVqeh2sPJShMwuJsJT/CookQe13f0cxit6IzskfrmZ/M0tLsrzuIvHDMLznbQagf2L5UkuOWuz6b2AkeZXpOj9tdG/sy96nfavbfXe5Vcz/ZazjWPB62SPNdO4DUk9bb+58vPlinF6vzNOdvrtDx11/Qll4z9P3RPdXr4oukL7/Q5/5nAQDnjZ8kyKlZrTdrXVNg6NUa9mGZytauVlnFIQ0pmqkhblV3cKJ+r3v3NWjcrCdnXKYHvdcr+0ZotklmJLVK62+4TI8vXeWWz0zd0nF68IabVeeWO8c/pgdnrFW1a4mJ6ITGqPBMAvr2Olp7hucR1qiDZ29jZ9XG19fp+lW7tNEtd0tjc3VpZYW2Z+V+TcFjRMtWPa9bXo+45baZ4P3e4dV69OfP63rvVaaiMwzmW9//1OkF3rXx7gG7r3Vadkb3aa3u87Zz3w632IU0HW907wCksh5/NyX7q3UfT9Ets7JU+R8va5cdz2D0UuEPfqQp2qRf/aZSyaYJ4ykMAFLN+XoKg6lCuLKxTK/tSvRv7EhdPW+4ateu1yHXcradz6cwmAqEovrlevyN6Vp0t/SCDaRX6NYN47VzRrEqzYdMdULhdj24cLG3YHrUl2hCplnh2bfWtXtMz/fiyepnF/bqFfd90zM+Vzt1YtJk5ZlVJmlg9mM+H92nx+ynuN5b97oKX1wkvVuvCZNGmDU6scU7RpMwMJ/5QbM2yzvmF3N09OhkTRhuliPatmKc1pfblfYY7prkgplg//Y858Ufk/2AuS7vKLs+wf7jzrH5MRjNrp29Xt65lO/UiMJaPe5dK/96PO59T/HXMu66DNYJjVBe5l5t2zLYO44MVf/mMj39hPe50DUIH7c9x8Hrvd9DzY7BuF0Pl35fg9/6hW5bscm1tcFUINyUpVd/XiGV3Kixe1yAZdpnSytd8G6CxoXef7fYIM/0lBYHvc4RbX/OD+ziPmPL0qdIr/jrTC/rnFz/GyaQK/P2t8Z753+nWocLC5RvVkWq9Kjdp+l5LmrWFgit8+wv94/ZbGuOt61LvW2lmxU1Fbq+1GQJ3bHsa9T4Qv+4m7yg1BxnW8ccd56hYzDnMvZ4VXQ/wbb878/S+CCWbnHcic0vmaVhf1ing9eErr/HHNu9heHAPLhu8fsJzt/+ZtdI72UVuHWx69z82KLHHDrH2Hn4Ev9m5trnakd0ux6734hu8a51/DG775h9jKxxv4UTtO3JbXX/hr3WoWvi36/u940K7sHWr3/4uKLXy7DH0aDtCa9ZG8L3Rug7cecf7N/+XcrSYe/a5WfUantlpncfZkSPw5zjtce9c9+dE/d3DkDqSRs+43qN/uQdvRyXPPD+CR87SxP/rEm73kyePAAAfE2GDteQyAl1l4dJVi50PfnlN+vxUADdqrvnacLRtbZiwL6C5IEJnBcPVkXQ/htpdqhsv9+kwV5A6697xQvyi+92K0IKC0foxLuvu2PI0ITB291+1urEpHn+sIAnim3bk1viAworc7JG1C9366UJc101gxdw3zVqZ7TSIVZtsFhPm+UVm71gvTlv/6Pq3XfM/hf5QwLMdQq2M2O59o5y7cnsfV17B45vNkQjqFrwX0++O0Zzg6ENmSO8fS3XtsYR3nVYb8+331BvnUkumCRL6Dt3uaoNW0lhfw9zXuHkQSfU7dItLvhZUxoKrFrlBWkTM72Aze99bm+vsNm2/3nvVS7NCZW9pxdmeQGpv66soUBz7PAAv7f4+ueq/PmkokyQWORds2B7Fd61ipW253vbetW2r/OCwqLQUIMMje/vBazuOyZh0WZvvwn6JjZEe9kf3Zene0PHnD/cC/Si25ri9u/3pPv78L+zMGnPfI7GZlVro3cN1+ypVf5Itw9v/wsLG73A1GzLOxfvr8H+cv93MgmHrK3BfuLPX7kF0XVlNTm61u3ffOeKfUFPfqi3f0eFXX60suXfs4S/ma2WqPKTAsGwAu+8D2dlaKp3LnOix2xeLhA/0uB+Qz/AN8c6dWCm3+veyv5NIG62bxIY+cVuCIPZv71f/c+bhIO/n+AebP3620oWr62sxi7Gy82TXnHf8YL74Jq1ytwb3r8FLc7Tuybhyoy4eybD+3Or+R1zvPuwyh7/pQP9/ZjrbH8Pc24kD4CUllbZlKMZt83VrKJJKhhX4L0m6bqbf6T50y9V45u/1YYP3ScBAF1L30n6TlEf7a7Yoo9dU8rZW68Tw+e1nHTw7vHK0wjNDuYzCHrInRNb1kYDWpO0sD3phhf03+W+M1trQ735EW17IUhOtDcg3qsK9/26j+rtn4ZJTFR7gX874tk4se8s1s59GRpoT8lUGLhz3BCqHkhqla2GKGo294Gdg8JtL1ohYTRuVrm9RuHr4MUo08aoX+iaxX2nTf+un5aUtK/6oFMiOtjgBeM3dWwegCAgtK9oz62vyQSk7n3yJEamsjJqtSP6Ge99TYay3KzUsW1FtHFfLEgzy9v/EPSAm+SEC/paMfXKPKVnFOhed8zxlQBeML81CPTi9296k4PzbP6dhLyAPL/BO1bzfkeN9ucmG8aQY74SC6pDlRhWpEpl7trsPx4E5eY7tXq1We9+Mol+MxP4Hz4ql0QyAXF4+EujGrwAeU5oroIok2DIzlGWeeuu1eGjrR9POOA3PfU2UA9XMLSiw9ffqKmKJsHMfptXQTRn7g2F7tmATYrsq40mADburlaTTax4or9L+D4EgHhpm55do5e2HlHPy67SX037K/3VlKs07KsD+v1zT+r5P56rglgAwBkxyYO/vlInK17QnpTNHniCHngvuJ1rgthwIsEMZ3A94/Z1QzuCdlOCH3w+Ws3Q1SxQ9kD/XeHKecqLnqepEPDb2+WJ7Toxanps/oy7yzV7uBnq4Z9/wqqKBMywieg1Nq8uct2CnukdI/1ALWkiwfamK1a1UH5+Aqj8/u1NuiQW6+F2r4QBbIaGZUXUcMR7O7ZIc7xAPeiZTtSr39x8U3GQG/Tmm2SAF+yb61kXsSXvc2z7LI1vqAglVmL78F/tqwLpkFZ+s/z+8s41U1kyVRPmzwbtjyZBggqATdJs/7htIsGcS0aW8gdlSVurJO+c/e3YTZ49nbj+ANCVpOnLiGrfelnP/Opf9dhjj+mxf/lX/dtz/1dVR79wHwEAdC0jdbVNHqzWmx+5pm5vsLJtaf4K3dqsmsCyiYS1qs4c7AfEXnBcPXzmmc38f44cqo8or7hZxURHFE/XiMy92umqJqKTTprhHO2uQDAWq/zdwRoTftRSY72bS2OFittRTVD3xk4pGM7RIWYOhFI9tXiKWz4DJugzf9pgsuUxm0RCuBTbSO/vX6ip06fExqJbQU+1GQIRX4HQMX4vtw2yDe/Yrs11AXwc0+se0Xu7kweRiY7Z9B4r2TAHIztHV2SEeuEjXkBt35hy/vhr5vfoh3vn/cqAcDIgej1NUG7mcAjWRZMXpuIhNjShffxr1rHvGC1/s/12sj9vezLVGQW61PxZnNmsV91PJJRFKzPM/jM1dmSDduzw3mcV6FpTinCGgt8tThvXvzNa/mbevXG0UekJ7g3bPjwn+sjR+dcUKD2oLumkKYufUmnpU1oyzTUA6NbS3J8AgC4meITj1d5/E/cdM8d7P1cj+5r2IhskDymKPcox/jGP3Y0X6Jo5BBabMvmZOrol9pQG+6hAVz5//4Z56hcdmrBYT/+m3n3Hf52zRxV62zal+/0mLbHvb00wn0KYmRvAzLsQlP1HqybMfAJm2UyKGAwLCD0FIu8H7vOLx2jvCn8IReULm70A3t/v/YX1oQqEYGiDmZTRDeVoPszDU/dGvfoNdwHME2u1TcFxjfeuczt6Rstv1gtbBseGinivZOd/VtXt0qteoGp7wG/K0nvR3tzwY/VMmXhjtDR+4+tV2u960+/tX23H7Vvhbf3ETGbYjgoEM87cfN5MmBcMJbDjyb3g9JUqXRqU8HvrD5fHeuDTC4OyezNPQvKe+baOeWVlpjtm/xWutIgOIbgpT+8954ZD7KjSdhtYm3W5akjWA26SBNGA12cTFyYItcMZgsoE93Lj6deUmnkXQsMLFoyOBq2JmYA+/jvBUxOCYQqm3D+4dvY8W/3NMpU1KKg0WKdb3J/2Oge/mXvNyYqV7ZthL/lZ8s7VDC3xfieXdGl1/0mEf7dogN/G9Q+GNsTmVEgwzKK9dlTIzJUQuzfcoxe9djOHRzDsxZz/o+0YdtGWTYfNEK10ZcWNUwHQXfXIzs7+yr0/IzyFAUCqOV9PYfi6nc+nMCAxMzfBmMrQXA24YJlgNPZEhQtbi3Mxwbl7WkZbczecc13lOFLFtCV66p7L9f5jt2n5G64NQLdFBQIAAAA6zB9CEasYiKt0+DqZJwWYJzIEx+W92lMxgI67/ZFSlZI8AFIKFQgA0ElUIAAAACCVUIEAAAAAAACSIoEAAAAAAACSIoEAAAAAAACSIoEAAAAAAACSIoEAALgw3F2u+zeUq9AtAgAA4PziKQwA0Enn4ykMQybfqatzpI93lum1Xe7f2KEzNadoiP/ec6hitd78yC2cA+fzKQyFKw9ottbqwcrxuv8H0iszilXp1tkEQvO2OAs088VF0hPjtL5cyl72ju4atVNPPiHNXTxGe1f47Z1inytvHlG3SZo9S1fsW2effd/uZ/qPLdJLI2t0fWmt21aB0t2qpkp/W5b5XLH3gxs1Ff7nrRw98pMi5dv3EW1/bp2W1dmFTjHHfW9hRrN9JBE+7kiVHl21Swq2E2a2uSc3dh4B952N3ttO7d8TfG9/+fO6b4drNOKuaa3Kfl6hNQmO1+zbmF9yo+bk+u9bbCsB8/mxe1p+LnoeYe08p7jvJv1O+Pf3RD/fWrsvOM+4e8xo9T47mzK0dMEsjbenGH/PduzcO6DF37OWf2cBAGeGCgQA6JIGaOTMO5VTs1pvNv9v64/Wq2ztav/1293qUzRTsXTChe9E/V73rpknivVgq8mDVhyt1RnE2c006uAZb8wLqmYX6LAXtF7/c/Oq0OHCAs03q0zAUywv+PXXlalIz0w3QZYJxIqk4DvPVeuK2aM11XynE0xQaZIej1Z2IJiywViWXnXHdr0Lxje+vs6dh/8y22w63ijt8ILCUPv15d5N3BCx3+nU/g3vGBYWNmp/jVsOmX9N/DVdYwJrGzz6bY/uy9O9JX7AbILXOQqOr0IqnqWl2XZVh7V6/knlaI53LsFvnSyAnl9SpEsrg32t0/asAnfMtbov2IZtL9IjY027uWf8pEdZ8+vV6n12ds0v8YN2e2zmnr2pyL/PvSD/3uHVejS0f/+Yz4Wz8XcWABBGAgEAuqRj2rO+HZUFGf3UN3JC57YO4muwt14nGut1yC6YyoIDun+DebUcwmCqFvx1SzQh0zWGecHrCdWrLlx9MG2Jniot1cN3uOV2i+hgg3T4aDj4Nb3AN+ol83JBqmUCtaA92hvvfz9/pFsem6v8SIP2e2+nXpknVVZ5wa+RoWFZUvrwHE1VprIyarUj6P2uq9V7ytNUE0CG9+G94gLBuHUuePOsKX2+wz2xfoBuAvO2+EHxqy227QWzEzO1/Q9+kNyZ/dtt2MRLhVoWC5hrFVHDEbdomOtaUxXt8c7v712X3FzvGmRo6nBFj0XZGbrUa7viynYE0ANj1zNxwN3s/E1vePT63xgfJJv9ut+9PfYfj7h7wZOdoysyEgXG5j4JrkNEy1Ylrqxo/T7zkzuxY47dM23eZ+HzXBAktnK8n6A2di0GZSndtHnXYOrATDXtq41Wg6zZUxv7+2B+5wUJ9tPe+7x51YuV6O8sAKCzSCAAwAWo7+i5mjPvTs0p6qPdFVv0sWu/0FUuvEyPL13lBf036/EbbnbVA6u0/obL9OCMtaq2yzFmmIId8jDDrF+ubaHO37ql4/TgwsXeu8V6uqOVC83V7dIttmfbD4DDgVl6YZZ22N7UcA9wfA+47YF3zPcfPV7gBzym3Nr15psg1w9yTEJilrL2VanJfsPI1LCgl3xsgSsL99jjcvvw9v/e8CmuZ9rsP1QxUC7NiQZ3HeUC9IGxQDFRAD11eoEujQamIeZ4G2LBfGdMnT7F20ZFi4DYD3hNmXyGxt8UOzYbpNpKAD8gvfZ4lQvWTZDtgm8T+HrX6L12VkLkD5dW2utpqkaC6xzT4vzjqjBMpYMJyF2yyQytyCjQvfZ6Jq+AsJUOW7P8z882xxFK5kQDaFOlsCnpdW7rPjP3ZvSYzT0TJMRau8/Mvic2RKsJopUeoQSJqfh4yfvM9lAlRHr/INNnkkuxoD+uasF7RRNNbd7nif+etfV3FgDQeSQQAOAC9PGuF9wQhoMa9tdzNbKvW5FSFqhwlLTtBZMk6KA3luu2khL99Ndu+Qw0RYPGiDbui+jSgV5w3awHPMyO/3Yl3KZ8O9Zra5igrkANXkB0327XZMrUyxujAfJLI71gLBrzuoDUBaLRxILZv7duTrAuYc9sS3E90NHjMkG3F6D3r3EBXKIA2vS+S+/tbh6M+wHi/j1tl+gHbLAZ7D/oAfeCVDN0oSxBmb8f8K7zrocZY+8HkbHqhkw7Bj9ra4KKB5M8sIFvRbQn3Ei4f2f/1mAOhVrtqMlQ1iC74CQ4/7he82CeAjfk4DkvaDfzMtjrGT83QML9m+N1ww5skB5eFw2uTWA9K2Fyp6VE91mz/cfdM4nvM1PNEEuE3NhiPoh8c6/3r7JJsoOubePrm2yizd/WFGlf8Ls2q1qI08Z93srfMwDAuUECAQAuZB/v0cFIX/VrT8yAcy7Wu9saP9Dc/oofjK4p9YJfFWjOWL9MPb/YBHUuoLRl3064N7s0Eu1FN2Pj880kdC6AjCUWPNF29wpNItiauB7o6Ocb1WAC9KDsP0EAbXrfEwZypvpAVSprZ+9v/JwCfu+xDVLNdXMBpJkUML/Yex8eLtLMxqONSi8ssskD2/NshyoY5ly8bZnkQajyI5Bo/y21HDLR8vz9IReKzltQ0a7hCon375IwbgiJ+UxZTY6ubZEo8BNYsd79xFq9z2yixrs3E/Tmt3WfmQkaY8fsvUyipy6iwxnefW2SBzbx4w+V8PnDK4JtbVRQLdK6Nu9zAMB5RQIBAC5kfUdqWMYh1Z7DpzB0XatUdzRDI6YtsEvZyxYlngMhkU7PgdAW04PqAssjDWqyY+799keivbkmgA0H37Fx6xt3V6spUq2NNgj1g8bwWPGAP6FerFQ+GnyFhzbsqNH+3GCivTNlxpCH5wkInaflkiLRBEPABb7RnvvOiQ+q/UkBzZMT2px40Jy/SXS4xIWZwyG9psa7Zn6QHb2uXtB8rXcuLSsn2tBiDoLWzj827t4mGOy7zvDH8NvKFssPxlsmqsz8DhlJqz3avs+C8/LbwxLdZ2ZbCiYBjWOSTN7vFByL/U5oHo+Aqy7xqw785E7LxIgv4X3e6t8zAMC5wmMcAaCTzvVjHINHOMZ8rN2/fUGH/nyuvjMmGLNwSG+uXe8mGzw3zudjHBNboVs3zFOeW7IaN+vJG25WXfGzWrR4svp5TSe2rNXeUTOjj3Fsk0kg3HOV6l85s2EMdjhCqGw7/EhAMxzAf1RgrcrMePJWHuMY/k7c9kKPtwu3xz2SL7ytmiptz/Ku0iuuZ9mWvcduoOB7zY/ZSP4oQy+gjD6SL8ExR3uaQ4JhAs0qHzq3/xhzXeMfqWiObUrsvAPh8497jGPr59Ka2G9pJHgkYWvn7/ZvhrkctnNluKoC87uZuQzaURXiMyX8scc1Ru+BNu6l+GM2Yscd9xuE7rPYd7zPVjb6w1aa37PN7rPmv2fsGMLHHL5m4Xb3yE373mjHeTbbf6t/zwAA5wQJBADopHOdQOgqvv4EAgAAALoChjAAAAAAAICkSCAAAAAAAICk0n50149kX9dd7poAAAAAAADipTV+2Us9Pzus/9fwiWsCAAAAAACI12PGj3721bcbnteaN0IPNO4EJlEEkGpSZRLFSy65xL0DAABAKiOBAACdlEoJhFOnTrklAAAApComUQQAAAAAAEmRQACALuz2R0pVWlqqpxZPcS0hdzzc+rqz7KFf1qj6/9So6oEvXAsAAABSjU0gfPMb37QLAICuYoqW/LpUY3eW6OVq1xTndj08e7AOVDe55XPrn36cq7x/Hij95Uk95NoAAACQWtI+qD6kXlf8pQp7uRYAQBewScvvKNFPf+0Wm7n9ke9r8FtPquzMpq/pmA0Xqd69BQAAQOpJO/3ff9SuU0N01ZQc1wQA6NLueFjf7/+2nlyxyTWcLxepvvG0cma4RQAAAKSUNKlWm7YfUvqVVCEAQNfnD114e81yne/0gdRTN83rLy2sUfUvP3NtAAAASBV2DoRoFcJUqhAAoEu7Y6wuU7quusefXPEfvp2u9G//g0p/vUTnfirFL/Tc2uPSylzl/fhi1wYAAIBUkVYwrkAF47IUqW9SupkLId2tAQB0Pb/+qUpKSqKvX7zVpKa3fqGSO85HRcLnGpzZS7Ub3CIAAABSStrkqyfLvMZnf0NfaIiumkQVAgB0BcEjHL+fJ7/KoPQpLZnmVgIAAADnWY/s7Oyv3HvpL2bpR9dl6Z1nn9GWBtfWTgMGDNCxY8fcEgB0f+bfvZMnT7ql7uuSSy7RqVOnpBlNqvrHz7X+e5n6J7cOAAAAqcPOgRD1wRa909Bf4/5yuGsAAEB66Jc1qv7Ho9If+5A8AAAASFHxCQQd15Y390nDJ2lSlmsCAKS8f/pxrvK+l6uCB3q6FgAAAKQaN4li6NU7osOf99flo/q7jwAAAAAAgFTX44H7H4jNgeD8qekDVZRt0PtNrqEdmAMBQKpJpTkQAAAAgPhJFM8ACQQAqSZVEggAAACA0WwOBAAAAAAAgJZIIAAAAAAAgKRIIAAAAAAAgKRIIAAAAAAAgKRIIAAAAAAAgKRIIAAAAAAAgKRIIAAAAAAAgKRIIAAAAAAAgKRIIAAAAAAAgKRIIAAAAAAAgKRIIAAAAAAAgKRIIAAAAAAAgKRIIAAAAAAAgKRIIAAAAAAAgKRIIAAAAAAAgKRIIAAAAAAAgKRIIAAAAAAAgKRIIAAAAAAAgKRIIAAAAAAAgKRIIAAAAAAAgKRIIAAAAAAAgKRIIAAAAAAAgKRIIAAAAAAAgKRaTSBkZGRo4sSJGjZsmGsBAAAAAACpqkUCwSQN5s+fb1/GwYMH7Z8AAAAAACB1pZlKA8P8ecMNN9gEgnlvEgdbt2616wAAAAAAQGrr8bOf/ewr9z7KJA9efPFFt9Q+AwYM0LFjx9wSAHR/5t+9kydPuiUAAACge0s4B4KpQGDuAwAAAAAAEOgxYcKEaAVC3759beLA/GmSCKYKIRKJuLVtowIBQKqhAgEAAACppEd2dnaLIQyGSSBceeWV2r17d7uSCCQQAKQaEggAAABIJa0+xtEkDcwkiu2tQAAAAAAAAN1XqwkEAAAAAACAAAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQFAkEAAAAAACQVI/s7Oyv7JsePZSZmakxY8ZoyJAhOnXqlKqqqnTw4EF9+eWX9sNtGTBggI4dO+aWAKD7M//unTx50i0BAAAA3Vu0AsEkD2bMmKFvfetbNoGQn59vl4cPH+4+AQAAAAAAUlXaN77xDfsmLy/PJg7S0mKjGvr27auJEye6JQAAAAAAkKrSgoSBSRaYYQzNZWRkuHcAAAAAACBVpX322Wf2zccff6yvvrLTIcRpbGx07wAAAAAAQKqKjlf48MMPdeTIkbgJE5uamrRt2za3BAAAAAAAUlXPPn36PGDefPrppzp8+LA+//xzmaoE8/7tt9/W/v37E1YmNNe7d2/75AYASBXm373Tp0+7JQAAAKB763H55Zd/9ac//cnOf2DmQzBDGTqDxzgCSDU8xhEAAACpJO26667TmDFjNHv2bOXm5rpmAAAAAACAmDQz7GDkyJF27gMzD4LRq1cv9e/fXxdffLFdBgAAAAAAqS2tqqpK3/zmN1VZWRkdvjBs2DD98Ic/VF5enl0GAAAAAACpLc1UHtTX1+vQoUPRyRJ79uypiy66yM6JAAAAAAAAkFZbW6uXX37ZPrIxYJIHhplcEQAAAAAAIM1UG4SZ5X79+tk5EcJJBQAAAAAAkLrS0tPT3Vtf37597dwHDQ0N9gUAAAAAAGATCKbiYMiQIRo3bpy+973vybRt3rxZn376qfsYAAAAAABIXdL/B+NVPKloUEX0AAAAAElFTkSuQmCC', N'11111', NULL, 10, N'ACTIVO')
INSERT [security].[Tbl_Profile] ([Id_Perfil], [Nombres], [Apellidos], [FechaNac], [IdUser], [Sexo], [Foto], [DNI], [Correo_institucional], [Id_Pais_Origen], [Estado]) VALUES (3054, N'test', N'test', CAST(N'2024-02-06' AS Date), 6, N'Masculino', N'\Media\profiles\6206ca71-b3a5-4f5a-a51a-6ec204c847ed.png', N'cgh', NULL, 10, N'ACTIVO')
INSERT [security].[Tbl_Profile] ([Id_Perfil], [Nombres], [Apellidos], [FechaNac], [IdUser], [Sexo], [Foto], [DNI], [Correo_institucional], [Id_Pais_Origen], [Estado]) VALUES (3059, N'test', N'test', CAST(N'2024-02-07' AS Date), NULL, N'Masculino', N'\Media\profiles\73d391bc-1bc4-4d6c-9f77-d9f49e641323.png', N'dfgttt', NULL, 10, N'ACTIVO')
INSERT [security].[Tbl_Profile] ([Id_Perfil], [Nombres], [Apellidos], [FechaNac], [IdUser], [Sexo], [Foto], [DNI], [Correo_institucional], [Id_Pais_Origen], [Estado]) VALUES (3060, N'Juan Doe', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 12, NULL)
INSERT [security].[Tbl_Profile] ([Id_Perfil], [Nombres], [Apellidos], [FechaNac], [IdUser], [Sexo], [Foto], [DNI], [Correo_institucional], [Id_Pais_Origen], [Estado]) VALUES (3061, N'Juan Doe 2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11, NULL)
SET IDENTITY_INSERT [security].[Tbl_Profile] OFF
GO
ALTER TABLE [helpdesk].[Tbl_Agenda]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Agenda_Tbl_InvestigatorProfile] FOREIGN KEY([Id_Perfil])
REFERENCES [security].[Tbl_Profile] ([Id_Perfil])
GO
ALTER TABLE [helpdesk].[Tbl_Agenda] CHECK CONSTRAINT [FK_Tbl_Agenda_Tbl_InvestigatorProfile]
GO
ALTER TABLE [helpdesk].[Tbl_Agenda]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Agendas_Cat_Dependencias] FOREIGN KEY([Id_Dependencia])
REFERENCES [helpdesk].[Cat_Dependencias] ([Id_Dependencia])
GO
ALTER TABLE [helpdesk].[Tbl_Agenda] CHECK CONSTRAINT [FK_Tbl_Agendas_Cat_Dependencias]
GO
ALTER TABLE [helpdesk].[Tbl_Calendario]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Calendario_Tbl_Tareas] FOREIGN KEY([Id_Tarea])
REFERENCES [helpdesk].[Tbl_Tareas] ([Id_Tarea])
GO
ALTER TABLE [helpdesk].[Tbl_Calendario] CHECK CONSTRAINT [FK_Tbl_Calendario_Tbl_Tareas]
GO
ALTER TABLE [helpdesk].[Tbl_Calendario]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Calendario_Cat_Dependencias] FOREIGN KEY([Id_Dependencia])
REFERENCES [helpdesk].[Cat_Dependencias] ([Id_Dependencia])
GO
ALTER TABLE [helpdesk].[Tbl_Calendario] CHECK CONSTRAINT [FK_Tbl_Calendario_Cat_Dependencias]
GO
ALTER TABLE [helpdesk].[Tbl_Case]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Case_Tbl_VinculateCase] FOREIGN KEY([Id_Vinculate])
REFERENCES [helpdesk].[Tbl_VinculateCase] ([Id_Vinculate])
GO
ALTER TABLE [helpdesk].[Tbl_Case] CHECK CONSTRAINT [FK_Tbl_Case_Tbl_VinculateCase]
GO
ALTER TABLE [helpdesk].[Tbl_Case]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Case_Cat_Dependencias] FOREIGN KEY([Id_Dependencia])
REFERENCES [helpdesk].[Cat_Dependencias] ([Id_Dependencia])
GO
ALTER TABLE [helpdesk].[Tbl_Case] CHECK CONSTRAINT [FK_Tbl_Case_Cat_Dependencias]
GO
ALTER TABLE [helpdesk].[Tbl_Case]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Case_Tbl_InvestigatorProfile] FOREIGN KEY([Id_Perfil])
REFERENCES [security].[Tbl_Profile] ([Id_Perfil])
GO
ALTER TABLE [helpdesk].[Tbl_Case] CHECK CONSTRAINT [FK_Tbl_Case_Tbl_InvestigatorProfile]
GO
ALTER TABLE [helpdesk].[Tbl_Case]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Case_Tbl_Servicios] FOREIGN KEY([Id_Servicio])
REFERENCES [helpdesk].[Tbl_Servicios] ([Id_Servicio])
GO
ALTER TABLE [helpdesk].[Tbl_Case] CHECK CONSTRAINT [FK_Tbl_Case_Tbl_Servicios]
GO
ALTER TABLE [helpdesk].[Tbl_Comments]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Coments_Tbl_Case] FOREIGN KEY([Id_Case])
REFERENCES [helpdesk].[Tbl_Case] ([Id_Case])
GO
ALTER TABLE [helpdesk].[Tbl_Comments] CHECK CONSTRAINT [FK_Tbl_Coments_Tbl_Case]
GO
ALTER TABLE [helpdesk].[Tbl_Dependencias_Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Dependencias_Usuarios_Cat_Cargos_Dependencias] FOREIGN KEY([Id_Cargo])
REFERENCES [helpdesk].[Cat_Cargos_Dependencias] ([Id_Cargo])
GO
ALTER TABLE [helpdesk].[Tbl_Dependencias_Usuarios] CHECK CONSTRAINT [FK_Tbl_Dependencias_Usuarios_Cat_Cargos_Dependencias]
GO
ALTER TABLE [helpdesk].[Tbl_Dependencias_Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Dependencias_Usuarios_Cat_Dependencias] FOREIGN KEY([Id_Dependencia])
REFERENCES [helpdesk].[Cat_Dependencias] ([Id_Dependencia])
GO
ALTER TABLE [helpdesk].[Tbl_Dependencias_Usuarios] CHECK CONSTRAINT [FK_Tbl_Dependencias_Usuarios_Cat_Dependencias]
GO
ALTER TABLE [helpdesk].[Tbl_Dependencias_Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Dependencias_Usuarios_Tbl_InvestigatorProfile] FOREIGN KEY([Id_Perfil])
REFERENCES [security].[Tbl_Profile] ([Id_Perfil])
GO
ALTER TABLE [helpdesk].[Tbl_Dependencias_Usuarios] CHECK CONSTRAINT [FK_Tbl_Dependencias_Usuarios_Tbl_InvestigatorProfile]
GO
ALTER TABLE [helpdesk].[Tbl_Evidencias]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Evidencias_Tbl_Tareas] FOREIGN KEY([Id_Tarea])
REFERENCES [helpdesk].[Tbl_Tareas] ([Id_Tarea])
GO
ALTER TABLE [helpdesk].[Tbl_Evidencias] CHECK CONSTRAINT [FK_Tbl_Evidencias_Tbl_Tareas]
GO
ALTER TABLE [helpdesk].[Tbl_Evidencias]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Evidencias_Cat_Tipo_Evidencia] FOREIGN KEY([IdTipo])
REFERENCES [helpdesk].[Cat_Tipo_Evidencia] ([IdTipo])
GO
ALTER TABLE [helpdesk].[Tbl_Evidencias] CHECK CONSTRAINT [FK_Tbl_Evidencias_Cat_Tipo_Evidencia]
GO
ALTER TABLE [helpdesk].[Tbl_Mails]  WITH CHECK ADD  CONSTRAINT [FK_Mail_Case] FOREIGN KEY([Id_Case])
REFERENCES [helpdesk].[Tbl_Case] ([Id_Case])
GO
ALTER TABLE [helpdesk].[Tbl_Mails] CHECK CONSTRAINT [FK_Mail_Case]
GO
ALTER TABLE [helpdesk].[Tbl_Participantes]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Participantes_Tbl_Tareas] FOREIGN KEY([Id_Tarea])
REFERENCES [helpdesk].[Tbl_Tareas] ([Id_Tarea])
GO
ALTER TABLE [helpdesk].[Tbl_Participantes] CHECK CONSTRAINT [FK_Tbl_Participantes_Tbl_Tareas]
GO
ALTER TABLE [helpdesk].[Tbl_Participantes]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Participantes_Cat_Tipo_Participaciones] FOREIGN KEY([Id_Tipo_Participacion])
REFERENCES [helpdesk].[Cat_Tipo_Participaciones] ([Id_Tipo_Participacion])
GO
ALTER TABLE [helpdesk].[Tbl_Participantes] CHECK CONSTRAINT [FK_Tbl_Participantes_Cat_Tipo_Participaciones]
GO
ALTER TABLE [helpdesk].[Tbl_Participantes]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Participantes_Tbl_InvestigatorProfile] FOREIGN KEY([Id_Perfil])
REFERENCES [security].[Tbl_Profile] ([Id_Perfil])
GO
ALTER TABLE [helpdesk].[Tbl_Participantes] CHECK CONSTRAINT [FK_Tbl_Participantes_Tbl_InvestigatorProfile]
GO
ALTER TABLE [helpdesk].[Tbl_Tareas]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Tareas_Tbl_Case] FOREIGN KEY([Id_Case])
REFERENCES [helpdesk].[Tbl_Case] ([Id_Case])
GO
ALTER TABLE [helpdesk].[Tbl_Tareas] CHECK CONSTRAINT [FK_Tbl_Tareas_Tbl_Case]
GO
ALTER TABLE [helpdesk].[Tbl_Tareas]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Tareas_Tbl_Tareas] FOREIGN KEY([Id_TareaPadre])
REFERENCES [helpdesk].[Tbl_Tareas] ([Id_Tarea])
GO
ALTER TABLE [helpdesk].[Tbl_Tareas] CHECK CONSTRAINT [FK_Tbl_Tareas_Tbl_Tareas]
GO
ALTER TABLE [helpdesk].[Cat_Dependencias]  WITH CHECK ADD  CONSTRAINT [FK_Cat_Dependencias_Cat_Dependencias] FOREIGN KEY([Id_Dependencia_Padre])
REFERENCES [helpdesk].[Cat_Dependencias] ([Id_Dependencia])
GO
ALTER TABLE [helpdesk].[Cat_Dependencias] CHECK CONSTRAINT [FK_Cat_Dependencias_Cat_Dependencias]
GO
ALTER TABLE [helpdesk].[Tbl_Profile_CasosAsignados]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Profile_CasosAsignados_Tbl_Case] FOREIGN KEY([Id_Case])
REFERENCES [helpdesk].[Tbl_Case] ([Id_Case])
GO
ALTER TABLE [helpdesk].[Tbl_Profile_CasosAsignados] CHECK CONSTRAINT [FK_Tbl_Profile_CasosAsignados_Tbl_Case]
GO
ALTER TABLE [helpdesk].[Tbl_Profile_CasosAsignados]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Profile_CasosAsignados_Tbl_Profile] FOREIGN KEY([Id_Perfil])
REFERENCES [security].[Tbl_Profile] ([Id_Perfil])
GO
ALTER TABLE [helpdesk].[Tbl_Profile_CasosAsignados] CHECK CONSTRAINT [FK_Tbl_Profile_CasosAsignados_Tbl_Profile]
GO
ALTER TABLE [helpdesk].[Tbl_Servicios]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Servicios_Cat_Dependencias] FOREIGN KEY([Id_Dependencia])
REFERENCES [helpdesk].[Cat_Dependencias] ([Id_Dependencia])
GO
ALTER TABLE [helpdesk].[Tbl_Servicios] CHECK CONSTRAINT [FK_Tbl_Servicios_Cat_Dependencias]
GO
ALTER TABLE [helpdesk].[Tbl_Servicios]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Servicios_Cat_Tipo_Servicio] FOREIGN KEY([Id_Tipo_Servicio])
REFERENCES [helpdesk].[Cat_Tipo_Servicio] ([Id_Tipo_Servicio])
GO
ALTER TABLE [helpdesk].[Tbl_Servicios] CHECK CONSTRAINT [FK_Tbl_Servicios_Cat_Tipo_Servicio]
GO
ALTER TABLE [helpdesk].[Tbl_Servicios_Profile]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Servicios_Profile_Tbl_Profile] FOREIGN KEY([Id_Perfil])
REFERENCES [security].[Tbl_Profile] ([Id_Perfil])
GO
ALTER TABLE [helpdesk].[Tbl_Servicios_Profile] CHECK CONSTRAINT [FK_Tbl_Servicios_Profile_Tbl_Profile]
GO
ALTER TABLE [helpdesk].[Tbl_Servicios_Profile]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Servicios_Profile_Tbl_Servicios] FOREIGN KEY([Id_Servicio])
REFERENCES [helpdesk].[Tbl_Servicios] ([Id_Servicio])
GO
ALTER TABLE [helpdesk].[Tbl_Servicios_Profile] CHECK CONSTRAINT [FK_Tbl_Servicios_Profile_Tbl_Servicios]
GO
ALTER TABLE [security].[Security_Permissions_Roles]  WITH CHECK ADD  CONSTRAINT [FK_Security_Permissions_Roles_Security_Permissions] FOREIGN KEY([Id_Permission])
REFERENCES [security].[Security_Permissions] ([Id_Permission])
GO
ALTER TABLE [security].[Security_Permissions_Roles] CHECK CONSTRAINT [FK_Security_Permissions_Roles_Security_Permissions]
GO
ALTER TABLE [security].[Security_Permissions_Roles]  WITH CHECK ADD  CONSTRAINT [FK_Security_Permissions_Roles_Security_Roles] FOREIGN KEY([Id_Role])
REFERENCES [security].[Security_Roles] ([Id_Role])
GO
ALTER TABLE [security].[Security_Permissions_Roles] CHECK CONSTRAINT [FK_Security_Permissions_Roles_Security_Roles]
GO
ALTER TABLE [security].[Security_Users_Roles]  WITH CHECK ADD  CONSTRAINT [FK_Security_Users_Roles_Security_Roles] FOREIGN KEY([Id_Role])
REFERENCES [security].[Security_Roles] ([Id_Role])
GO
ALTER TABLE [security].[Security_Users_Roles] CHECK CONSTRAINT [FK_Security_Users_Roles_Security_Roles]
GO
ALTER TABLE [security].[Security_Users_Roles]  WITH CHECK ADD  CONSTRAINT [FK_Security_Users_Roles_Security_Users] FOREIGN KEY([Id_User])
REFERENCES [security].[Security_Users] ([Id_User])
GO
ALTER TABLE [security].[Security_Users_Roles] CHECK CONSTRAINT [FK_Security_Users_Roles_Security_Users]
GO
ALTER TABLE [security].[Tbl_Profile]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_InvestigatorProfile_Cat_Nacionalidad] FOREIGN KEY([Id_Pais_Origen])
REFERENCES [helpdesk].[Cat_Paises] ([Id_Pais])
GO
ALTER TABLE [security].[Tbl_Profile] CHECK CONSTRAINT [FK_Tbl_InvestigatorProfile_Cat_Nacionalidad]
GO
ALTER TABLE [security].[Tbl_Profile]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_InvestigatorProfile_Security_Users] FOREIGN KEY([IdUser])
REFERENCES [security].[Security_Users] ([Id_User])
GO
ALTER TABLE [security].[Tbl_Profile] CHECK CONSTRAINT [FK_Tbl_InvestigatorProfile_Security_Users]
GO
/****** Object:  StoredProcedure [dbo].[sptest]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sptest]  
   @param1 INT,  
   @param2 INT  
AS  
   SELECT 'hellow' as column1 
GO
/****** Object:  StoredProcedure [dbo].[sptest2]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sptest2] as SELECT 'hellow' as column1 
GO
/****** Object:  StoredProcedure [dbo].[sptest3]    Script Date: 10/4/2024 16:28:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sptest3] 
   @param1 INT,  
   @param2 INT  
AS  
  INSERT INTO  log (body) values ('procedure');
  
GO
USE [master]
GO
ALTER DATABASE [HELPDESK] SET  READ_WRITE 
GO
