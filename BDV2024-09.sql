USE [master]
GO
/****** Object:  Database [PROYECT_MANAGER_BD]    Script Date: 9/29/2024 12:42:00 PM ******/
CREATE DATABASE [PROYECT_MANAGER_BD]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PROYECT_MANAGER_BD', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\PROYECT_MANAGER_BD.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PROYECT_MANAGER_BD_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\PROYECT_MANAGER_BD_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PROYECT_MANAGER_BD].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET ARITHABORT OFF 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET RECOVERY FULL 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET  MULTI_USER 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PROYECT_MANAGER_BD', N'ON'
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET QUERY_STORE = ON
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PROYECT_MANAGER_BD]
GO
/****** Object:  Schema [administrative_access]    Script Date: 9/29/2024 12:42:00 PM ******/
CREATE SCHEMA [administrative_access]
GO
/****** Object:  Schema [helpdesk]    Script Date: 9/29/2024 12:42:00 PM ******/
CREATE SCHEMA [helpdesk]
GO
/****** Object:  Schema [notificaciones_mensajeria]    Script Date: 9/29/2024 12:42:00 PM ******/
CREATE SCHEMA [notificaciones_mensajeria]
GO
/****** Object:  Schema [questionnaires]    Script Date: 9/29/2024 12:42:00 PM ******/
CREATE SCHEMA [questionnaires]
GO
/****** Object:  Schema [security]    Script Date: 9/29/2024 12:42:00 PM ******/
CREATE SCHEMA [security]
GO
/****** Object:  Table [helpdesk].[Tbl_Case]    Script Date: 9/29/2024 12:42:00 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Calendario]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Tareas]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  View [helpdesk].[ViewCalendarioByDependencia]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Participantes]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  View [helpdesk].[ViewActividadesParticipantes]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [administrative_access].[Transactional_Configuraciones]    Script Date: 9/29/2024 12:42:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [administrative_access].[Transactional_Configuraciones](
	[Id_Configuracion] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Descripcion] [nvarchar](250) NULL,
	[Valor] [nvarchar](max) NULL,
	[Tipo_Configuracion] [varchar](100) NULL,
 CONSTRAINT [PK_Transactional_Configuraciones] PRIMARY KEY CLUSTERED 
(
	[Id_Configuracion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [Transactional_Configuraciones_UN] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [helpdesk].[Cat_Cargos_Dependencias]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [helpdesk].[Cat_Dependencias]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [helpdesk].[Cat_Paises]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [helpdesk].[Cat_Tipo_Evidencia]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [helpdesk].[Cat_Tipo_Participaciones]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [helpdesk].[Cat_Tipo_Servicio]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Agenda]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Comments]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Comments_Tasks]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Dependencias_Usuarios]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Evidencias]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Grupo]    Script Date: 9/29/2024 12:42:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Tbl_Grupo](
	[Id_Grupo] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](150) NULL,
	[Estado] [nvarchar](50) NULL,
 CONSTRAINT [PK_Tbl_Grupo] PRIMARY KEY CLUSTERED 
(
	[Id_Grupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Tbl_Mails]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Profile_CasosAsignados]    Script Date: 9/29/2024 12:42:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Tbl_Profile_CasosAsignados](
	[Id_Perfil] [int] NOT NULL,
	[Id_Case] [int] NOT NULL,
	[Fecha] [date] NULL,
	[Id_Tipo_Participacion] [int] NULL,
 CONSTRAINT [PK_Tbl_Profile_CasosAsignados] PRIMARY KEY CLUSTERED 
(
	[Id_Perfil] ASC,
	[Id_Case] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Tbl_Servicios]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Servicios_Profile]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_VinculateCase]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [notificaciones_mensajeria].[conversacion]    Script Date: 9/29/2024 12:42:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [notificaciones_mensajeria].[conversacion](
	[id_conversacion] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_conversacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [notificaciones_mensajeria].[conversacion_usuarios]    Script Date: 9/29/2024 12:42:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [notificaciones_mensajeria].[conversacion_usuarios](
	[id_conversacion] [int] NOT NULL,
	[id_usuario] [int] NOT NULL,
	[avatar] [nvarchar](250) NULL,
	[name] [nvarchar](250) NULL,
 CONSTRAINT [conversacion_usuarios_PK] PRIMARY KEY CLUSTERED 
(
	[id_conversacion] ASC,
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [notificaciones_mensajeria].[mensaje_adjuntos]    Script Date: 9/29/2024 12:42:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [notificaciones_mensajeria].[mensaje_adjuntos](
	[id] [int] NOT NULL,
	[mensaje_id] [int] NULL,
	[archivo] [nvarchar](255) NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [notificaciones_mensajeria].[mensajes]    Script Date: 9/29/2024 12:42:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [notificaciones_mensajeria].[mensajes](
	[id_mensaje] [int] IDENTITY(1,1) NOT NULL,
	[remitente] [nvarchar](255) NULL,
	[usuario_id] [int] NULL,
	[destinatarios] [nvarchar](max) NULL,
	[asunto] [nvarchar](255) NULL,
	[body] [nvarchar](max) NULL,
	[id_conversacion] [int] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
	[enviado] [bit] NULL,
	[leido] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_mensaje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [notificaciones_mensajeria].[notificaciones]    Script Date: 9/29/2024 12:42:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [notificaciones_mensajeria].[notificaciones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_User] [int] NULL,
	[Titulo] [nvarchar](max) NULL,
	[Mensaje] [nvarchar](max) NULL,
	[Fecha] [datetime] NULL,
	[Media] [nvarchar](max) NULL,
	[Tipo] [nvarchar](50) NULL,
	[Estado] [nvarchar](50) NULL,
	[Enviado] [bit] NULL,
	[Leido] [bit] NULL,
	[Telefono] [nvarchar](20) NULL,
	[Email] [nvarchar](50) NULL,
 CONSTRAINT [PK_notificaciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [questionnaires].[Cat_Categorias_Test]    Script Date: 9/29/2024 12:42:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [questionnaires].[Cat_Categorias_Test](
	[Id_categoria] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [nvarchar](max) NULL,
	[imagen] [nvarchar](max) NULL,
	[estado] [nvarchar](50) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
 CONSTRAINT [PK__Cat_Cate__4A033A9332C9187A] PRIMARY KEY CLUSTERED 
(
	[Id_categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [questionnaires].[Cat_Tipo_Preguntas]    Script Date: 9/29/2024 12:42:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [questionnaires].[Cat_Tipo_Preguntas](
	[id_tipo_pregunta] [int] IDENTITY(1,1) NOT NULL,
	[tipo_pregunta] [nvarchar](max) NULL,
	[descripcion] [nvarchar](max) NULL,
	[estado] [nvarchar](50) NULL,
	[fecha_crea] [datetime] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[editable] [bit] NULL,
	[descripcion_general] [nvarchar](max) NULL,
 CONSTRAINT [PK__Cat_Tipo__81F6D7D5551EB4EE] PRIMARY KEY CLUSTERED 
(
	[id_tipo_pregunta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [questionnaires].[Cat_Valor_Preguntas]    Script Date: 9/29/2024 12:42:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [questionnaires].[Cat_Valor_Preguntas](
	[id_valor_pregunta] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [nvarchar](max) NULL,
	[id_tipo_pregunta] [int] NULL,
	[estado] [nvarchar](50) NULL,
	[valor] [int] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
 CONSTRAINT [PK__Cat_Valo__014E3C78AB16626B] PRIMARY KEY CLUSTERED 
(
	[id_valor_pregunta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [questionnaires].[Pregunta_Tests]    Script Date: 9/29/2024 12:42:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [questionnaires].[Pregunta_Tests](
	[id_pregunta_test] [int] IDENTITY(1,1) NOT NULL,
	[estado] [nvarchar](50) NULL,
	[descripcion_pregunta] [nvarchar](max) NULL,
	[id_test] [int] NULL,
	[id_tipo_pregunta] [int] NULL,
	[fecha] [datetime] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[seccion] [nvarchar](max) NULL,
	[descripcion_general] [nvarchar](max) NULL,
 CONSTRAINT [PK__Pregunta__0F5B35929CDB72CF] PRIMARY KEY CLUSTERED 
(
	[id_pregunta_test] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [questionnaires].[Resultados_Pregunta_Tests]    Script Date: 9/29/2024 12:42:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [questionnaires].[Resultados_Pregunta_Tests](
	[Id_Perfil] [int] NOT NULL,
	[id_pregunta_test] [int] NOT NULL,
	[resultado] [int] NULL,
	[respuesta] [nvarchar](max) NULL,
	[estado] [nvarchar](50) NULL,
	[id_valor_pregunta] [int] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[fecha] [datetime] NOT NULL,
	[Id_Resultado] [int] NULL,
 CONSTRAINT [PK_Resultados_Pregunta_Tests] PRIMARY KEY CLUSTERED 
(
	[Id_Perfil] ASC,
	[id_pregunta_test] ASC,
	[fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [questionnaires].[Resultados_Tests]    Script Date: 9/29/2024 12:42:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [questionnaires].[Resultados_Tests](
	[Id_Perfil] [int] NOT NULL,
	[id_test] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[seccion] [nvarchar](max) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[valor] [nvarchar](max) NULL,
	[categoria_valor] [nvarchar](max) NULL,
	[tipo] [nvarchar](50) NULL,
	[Id_Resultado] [int] IDENTITY(0,1) NOT NULL,
 CONSTRAINT [Resultados_Tests_PK] PRIMARY KEY CLUSTERED 
(
	[Id_Resultado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [questionnaires].[Tests]    Script Date: 9/29/2024 12:42:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [questionnaires].[Tests](
	[id_test] [int] IDENTITY(1,1) NOT NULL,
	[titulo] [nvarchar](max) NULL,
	[descripcion] [nvarchar](max) NULL,
	[grado] [int] NULL,
	[tipo_test] [nvarchar](100) NULL,
	[estado] [nvarchar](50) NULL,
	[id_categoria] [int] NULL,
	[fecha_publicacion] [datetime] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[referencias] [nvarchar](max) NULL,
	[tiempo] [int] NULL,
	[caducidad] [int] NULL,
	[color] [nvarchar](50) NULL,
	[image] [nvarchar](max) NULL,
 CONSTRAINT [PK__Tests__C6D3284B10E522BD] PRIMARY KEY CLUSTERED 
(
	[id_test] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [security].[Security_Permissions]    Script Date: 9/29/2024 12:42:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [security].[Security_Permissions](
	[Id_Permission] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](100) NULL,
	[Estado] [nvarchar](50) NULL,
	[Detalles] [nvarchar](500) NULL,
 CONSTRAINT [PK_Security_Permissions] PRIMARY KEY CLUSTERED 
(
	[Id_Permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [security].[Security_Permissions_Roles]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [security].[Security_Roles]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [security].[Security_Users]    Script Date: 9/29/2024 12:42:01 PM ******/
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
	[Nombres_Completo] [nvarchar](500) NULL,
 CONSTRAINT [PK_Security_Users] PRIMARY KEY CLUSTERED 
(
	[Id_User] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [security].[Security_Users_Roles]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  Table [security].[Tbl_Profile]    Script Date: 9/29/2024 12:42:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [security].[Tbl_Profile](
	[Id_Perfil] [int] IDENTITY(1,1) NOT NULL,
	[Nombres] [nvarchar](300) NULL,
	[Apellidos] [nvarchar](300) NULL,
	[FechaNac] [date] NULL,
	[IdUser] [int] NULL,
	[Sexo] [nvarchar](50) NULL,
	[Foto] [nvarchar](max) NULL,
	[DNI] [nvarchar](50) NULL,
	[Correo_institucional] [nvarchar](300) NULL,
	[Id_Pais_Origen] [int] NULL,
	[Estado] [nvarchar](50) NULL,
	[ORCID] [nvarchar](500) NULL,
	[Id_Grupo] [int] NULL,
 CONSTRAINT [PK_Tbl_InvestigatorProfile] PRIMARY KEY CLUSTERED 
(
	[Id_Perfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [index_mensaje_adjuntos_on_mensaje_id]    Script Date: 9/29/2024 12:42:01 PM ******/
CREATE NONCLUSTERED INDEX [index_mensaje_adjuntos_on_mensaje_id] ON [notificaciones_mensajeria].[mensaje_adjuntos]
(
	[mensaje_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [helpdesk].[Cat_Dependencias]  WITH CHECK ADD  CONSTRAINT [FK_Cat_Dependencias_Cat_Dependencias] FOREIGN KEY([Id_Dependencia_Padre])
REFERENCES [helpdesk].[Cat_Dependencias] ([Id_Dependencia])
GO
ALTER TABLE [helpdesk].[Cat_Dependencias] CHECK CONSTRAINT [FK_Cat_Dependencias_Cat_Dependencias]
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
ALTER TABLE [helpdesk].[Tbl_Calendario]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Calendario_Cat_Dependencias] FOREIGN KEY([Id_Dependencia])
REFERENCES [helpdesk].[Cat_Dependencias] ([Id_Dependencia])
GO
ALTER TABLE [helpdesk].[Tbl_Calendario] CHECK CONSTRAINT [FK_Tbl_Calendario_Cat_Dependencias]
GO
ALTER TABLE [helpdesk].[Tbl_Calendario]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Calendario_Tbl_Tareas] FOREIGN KEY([Id_Tarea])
REFERENCES [helpdesk].[Tbl_Tareas] ([Id_Tarea])
GO
ALTER TABLE [helpdesk].[Tbl_Calendario] CHECK CONSTRAINT [FK_Tbl_Calendario_Tbl_Tareas]
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
ALTER TABLE [helpdesk].[Tbl_Case]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Case_Tbl_VinculateCase] FOREIGN KEY([Id_Vinculate])
REFERENCES [helpdesk].[Tbl_VinculateCase] ([Id_Vinculate])
GO
ALTER TABLE [helpdesk].[Tbl_Case] CHECK CONSTRAINT [FK_Tbl_Case_Tbl_VinculateCase]
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
ALTER TABLE [helpdesk].[Tbl_Evidencias]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Evidencias_Cat_Tipo_Evidencia] FOREIGN KEY([IdTipo])
REFERENCES [helpdesk].[Cat_Tipo_Evidencia] ([IdTipo])
GO
ALTER TABLE [helpdesk].[Tbl_Evidencias] CHECK CONSTRAINT [FK_Tbl_Evidencias_Cat_Tipo_Evidencia]
GO
ALTER TABLE [helpdesk].[Tbl_Evidencias]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Evidencias_Tbl_Tareas] FOREIGN KEY([Id_Tarea])
REFERENCES [helpdesk].[Tbl_Tareas] ([Id_Tarea])
GO
ALTER TABLE [helpdesk].[Tbl_Evidencias] CHECK CONSTRAINT [FK_Tbl_Evidencias_Tbl_Tareas]
GO
ALTER TABLE [helpdesk].[Tbl_Mails]  WITH CHECK ADD  CONSTRAINT [FK_Mail_Case] FOREIGN KEY([Id_Case])
REFERENCES [helpdesk].[Tbl_Case] ([Id_Case])
GO
ALTER TABLE [helpdesk].[Tbl_Mails] CHECK CONSTRAINT [FK_Mail_Case]
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
ALTER TABLE [helpdesk].[Tbl_Participantes]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Participantes_Tbl_Tareas] FOREIGN KEY([Id_Tarea])
REFERENCES [helpdesk].[Tbl_Tareas] ([Id_Tarea])
GO
ALTER TABLE [helpdesk].[Tbl_Participantes] CHECK CONSTRAINT [FK_Tbl_Participantes_Tbl_Tareas]
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
ALTER TABLE [helpdesk].[Tbl_Profile_CasosAsignados]  WITH CHECK ADD  CONSTRAINT [Tbl_Profile_CasosAsignados_Cat_Tipo_Participaciones_FK] FOREIGN KEY([Id_Tipo_Participacion])
REFERENCES [helpdesk].[Cat_Tipo_Participaciones] ([Id_Tipo_Participacion])
GO
ALTER TABLE [helpdesk].[Tbl_Profile_CasosAsignados] CHECK CONSTRAINT [Tbl_Profile_CasosAsignados_Cat_Tipo_Participaciones_FK]
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
ALTER TABLE [notificaciones_mensajeria].[conversacion_usuarios]  WITH CHECK ADD  CONSTRAINT [conversacion_usuarios_FK] FOREIGN KEY([id_conversacion])
REFERENCES [notificaciones_mensajeria].[conversacion] ([id_conversacion])
GO
ALTER TABLE [notificaciones_mensajeria].[conversacion_usuarios] CHECK CONSTRAINT [conversacion_usuarios_FK]
GO
ALTER TABLE [notificaciones_mensajeria].[mensaje_adjuntos]  WITH CHECK ADD  CONSTRAINT [FK_mensaje_adjuntos_mensajes] FOREIGN KEY([mensaje_id])
REFERENCES [notificaciones_mensajeria].[mensajes] ([id_mensaje])
GO
ALTER TABLE [notificaciones_mensajeria].[mensaje_adjuntos] CHECK CONSTRAINT [FK_mensaje_adjuntos_mensajes]
GO
ALTER TABLE [notificaciones_mensajeria].[mensajes]  WITH CHECK ADD  CONSTRAINT [FK_mensajes_conversacion] FOREIGN KEY([id_conversacion])
REFERENCES [notificaciones_mensajeria].[conversacion] ([id_conversacion])
GO
ALTER TABLE [notificaciones_mensajeria].[mensajes] CHECK CONSTRAINT [FK_mensajes_conversacion]
GO
ALTER TABLE [questionnaires].[Cat_Valor_Preguntas]  WITH CHECK ADD  CONSTRAINT [FK_Cat_Valor_Preguntas_Cat_Tipo_Preguntas] FOREIGN KEY([id_tipo_pregunta])
REFERENCES [questionnaires].[Cat_Tipo_Preguntas] ([id_tipo_pregunta])
GO
ALTER TABLE [questionnaires].[Cat_Valor_Preguntas] CHECK CONSTRAINT [FK_Cat_Valor_Preguntas_Cat_Tipo_Preguntas]
GO
ALTER TABLE [questionnaires].[Pregunta_Tests]  WITH CHECK ADD  CONSTRAINT [FK_Pregunta_Tests_Cat_Tipo_Preguntas] FOREIGN KEY([id_tipo_pregunta])
REFERENCES [questionnaires].[Cat_Tipo_Preguntas] ([id_tipo_pregunta])
GO
ALTER TABLE [questionnaires].[Pregunta_Tests] CHECK CONSTRAINT [FK_Pregunta_Tests_Cat_Tipo_Preguntas]
GO
ALTER TABLE [questionnaires].[Pregunta_Tests]  WITH CHECK ADD  CONSTRAINT [FK_Pregunta_Tests_Tests] FOREIGN KEY([id_test])
REFERENCES [questionnaires].[Tests] ([id_test])
GO
ALTER TABLE [questionnaires].[Pregunta_Tests] CHECK CONSTRAINT [FK_Pregunta_Tests_Tests]
GO
ALTER TABLE [questionnaires].[Resultados_Pregunta_Tests]  WITH CHECK ADD  CONSTRAINT [FK_Resultados_Pregunta_Tests_Cat_Valor_Preguntas] FOREIGN KEY([id_valor_pregunta])
REFERENCES [questionnaires].[Cat_Valor_Preguntas] ([id_valor_pregunta])
GO
ALTER TABLE [questionnaires].[Resultados_Pregunta_Tests] CHECK CONSTRAINT [FK_Resultados_Pregunta_Tests_Cat_Valor_Preguntas]
GO
ALTER TABLE [questionnaires].[Resultados_Pregunta_Tests]  WITH CHECK ADD  CONSTRAINT [FK_Resultados_Pregunta_Tests_Pregunta_Tests] FOREIGN KEY([id_pregunta_test])
REFERENCES [questionnaires].[Pregunta_Tests] ([id_pregunta_test])
GO
ALTER TABLE [questionnaires].[Resultados_Pregunta_Tests] CHECK CONSTRAINT [FK_Resultados_Pregunta_Tests_Pregunta_Tests]
GO
ALTER TABLE [questionnaires].[Resultados_Pregunta_Tests]  WITH CHECK ADD  CONSTRAINT [Resultados_Pregunta_Tests_FK] FOREIGN KEY([Id_Resultado])
REFERENCES [questionnaires].[Resultados_Tests] ([Id_Resultado])
GO
ALTER TABLE [questionnaires].[Resultados_Pregunta_Tests] CHECK CONSTRAINT [Resultados_Pregunta_Tests_FK]
GO
ALTER TABLE [questionnaires].[Resultados_Tests]  WITH CHECK ADD  CONSTRAINT [FK_Resultados_Tests_Tests] FOREIGN KEY([id_test])
REFERENCES [questionnaires].[Tests] ([id_test])
GO
ALTER TABLE [questionnaires].[Resultados_Tests] CHECK CONSTRAINT [FK_Resultados_Tests_Tests]
GO
ALTER TABLE [questionnaires].[Tests]  WITH CHECK ADD  CONSTRAINT [FK_Tests_Cat_Categorias_Test] FOREIGN KEY([id_categoria])
REFERENCES [questionnaires].[Cat_Categorias_Test] ([Id_categoria])
GO
ALTER TABLE [questionnaires].[Tests] CHECK CONSTRAINT [FK_Tests_Cat_Categorias_Test]
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
ALTER TABLE [security].[Tbl_Profile]  WITH CHECK ADD  CONSTRAINT [Tbl_Profile_FK] FOREIGN KEY([Id_Grupo])
REFERENCES [helpdesk].[Tbl_Grupo] ([Id_Grupo])
GO
ALTER TABLE [security].[Tbl_Profile] CHECK CONSTRAINT [Tbl_Profile_FK]
GO
/****** Object:  StoredProcedure [dbo].[sptest]    Script Date: 9/29/2024 12:42:01 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sptest2]    Script Date: 9/29/2024 12:42:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sptest2] as SELECT 'hellow' as column1 
GO
/****** Object:  StoredProcedure [dbo].[sptest3]    Script Date: 9/29/2024 12:42:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sptest3] 
   @param1 INT,  
   @param2 INT  
AS  
  INSERT INTO  log (body) values ('procedure')
GO
USE [master]
GO
ALTER DATABASE [PROYECT_MANAGER_BD] SET  READ_WRITE 
GO
