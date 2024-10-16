USE [master]
GO
/****** Object:  Database [PROYECT_MANAGER_BD]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Schema [administrative_access]    Script Date: 10/10/2024 4:40:09 PM ******/
CREATE SCHEMA [administrative_access]
GO
/****** Object:  Schema [helpdesk]    Script Date: 10/10/2024 4:40:09 PM ******/
CREATE SCHEMA [helpdesk]
GO
/****** Object:  Schema [notificaciones_mensajeria]    Script Date: 10/10/2024 4:40:09 PM ******/
CREATE SCHEMA [notificaciones_mensajeria]
GO
/****** Object:  Schema [questionnaires]    Script Date: 10/10/2024 4:40:09 PM ******/
CREATE SCHEMA [questionnaires]
GO
/****** Object:  Schema [security]    Script Date: 10/10/2024 4:40:09 PM ******/
CREATE SCHEMA [security]
GO
/****** Object:  Table [helpdesk].[Tbl_Case]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Calendario]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Tareas]    Script Date: 10/10/2024 4:40:09 PM ******/
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
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [helpdesk].[ViewCalendarioByDependencia]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Participantes]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  View [helpdesk].[ViewActividadesParticipantes]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [administrative_access].[Transactional_Configuraciones]    Script Date: 10/10/2024 4:40:09 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [helpdesk].[Cat_Cargos_Dependencias]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [helpdesk].[Cat_Dependencias]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [helpdesk].[Cat_Paises]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [helpdesk].[Cat_Tipo_Evidencia]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [helpdesk].[Cat_Tipo_Grupo]    Script Date: 10/10/2024 4:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Cat_Tipo_Grupo](
	[Id_Tipo_Grupo] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Estado] [nvarchar](50) NULL,
 CONSTRAINT [PK_Cat_Tipo_Grupo] PRIMARY KEY CLUSTERED 
(
	[Id_Tipo_Grupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Cat_Tipo_Participaciones]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [helpdesk].[Cat_Tipo_Servicio]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Agenda]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Comments]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Comments_Tasks]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Dependencias_Usuarios]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Evidencias]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Grupo]    Script Date: 10/10/2024 4:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Tbl_Grupo](
	[Id_Grupo] [int] IDENTITY(1,1) NOT NULL,
	[Id_Perfil_Crea] [int] NULL,
	[Id_Tipo_Grupo] [int] NULL,
	[Fecha_Creacion] [date] NULL,
	[Estado] [nvarchar](50) NULL,
	[Descripcion] [nvarchar](max) NULL,
	[Nombre] [nvarchar](500) NULL,
	[Color] [nvarchar](100) NULL,
 CONSTRAINT [PK_Tbl_Grupo] PRIMARY KEY CLUSTERED 
(
	[Id_Grupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Tbl_Grupos_Profile]    Script Date: 10/10/2024 4:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [helpdesk].[Tbl_Grupos_Profile](
	[Id_Grupo] [int] NOT NULL,
	[Id_Perfil] [int] NOT NULL,
	[Fecha_Incorporacion] [date] NULL,
	[Estado] [nvarchar](50) NULL,
	[Id_TipoMiembro] [int] NULL,
 CONSTRAINT [PK_Tbl_Grupos_Profile] PRIMARY KEY CLUSTERED 
(
	[Id_Grupo] ASC,
	[Id_Perfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [helpdesk].[Tbl_Mails]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Profile_CasosAsignados]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Servicios]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_Servicios_Profile]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [helpdesk].[Tbl_VinculateCase]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [notificaciones_mensajeria].[conversacion]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [notificaciones_mensajeria].[conversacion_usuarios]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [notificaciones_mensajeria].[mensaje_adjuntos]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [notificaciones_mensajeria].[mensajes]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [notificaciones_mensajeria].[notificaciones]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [questionnaires].[Cat_Categorias_Test]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [questionnaires].[Cat_Tipo_Preguntas]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [questionnaires].[Cat_Valor_Preguntas]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [questionnaires].[Pregunta_Tests]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [questionnaires].[Resultados_Pregunta_Tests]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [questionnaires].[Resultados_Tests]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [questionnaires].[Tests]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [security].[Security_Permissions]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [security].[Security_Permissions_Roles]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [security].[Security_Roles]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [security].[Security_Users]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [security].[Security_Users_Roles]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  Table [security].[Tbl_Profile]    Script Date: 10/10/2024 4:40:09 PM ******/
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
 CONSTRAINT [PK_Tbl_InvestigatorProfile] PRIMARY KEY CLUSTERED 
(
	[Id_Perfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [administrative_access].[Transactional_Configuraciones] ON 

INSERT [administrative_access].[Transactional_Configuraciones] ([Id_Configuracion], [Nombre], [Descripcion], [Valor], [Tipo_Configuracion]) VALUES (1, N'TITULO', N'Encabezado de página', N'SIASMOP', N'THEME')
INSERT [administrative_access].[Transactional_Configuraciones] ([Id_Configuracion], [Nombre], [Descripcion], [Valor], [Tipo_Configuracion]) VALUES (2, N'SUB_TITULO', N'Subtitulo que se muestra en el encabezado', N'Sistema Automatizado para el Seguimiento y Monitoreo de Proyectos', N'THEME')
INSERT [administrative_access].[Transactional_Configuraciones] ([Id_Configuracion], [Nombre], [Descripcion], [Valor], [Tipo_Configuracion]) VALUES (3, N'NOMBRE_EMPRESA', N'nombre de la empresa', N'SIASMOP. test', N'THEME')
INSERT [administrative_access].[Transactional_Configuraciones] ([Id_Configuracion], [Nombre], [Descripcion], [Valor], [Tipo_Configuracion]) VALUES (4, N'LOGO_PRINCIPAL', N'Logo que se muestra en los encabezados', N'logo.png', N'THEME')
INSERT [administrative_access].[Transactional_Configuraciones] ([Id_Configuracion], [Nombre], [Descripcion], [Valor], [Tipo_Configuracion]) VALUES (5, N'MEDIA_IMG_PATH', N'Ruta de recursos', N'/media/img/', N'THEME')
INSERT [administrative_access].[Transactional_Configuraciones] ([Id_Configuracion], [Nombre], [Descripcion], [Valor], [Tipo_Configuracion]) VALUES (6, N'VERSION', N'Versión de la aplicación', N'2024.07', N'NUMBER')
SET IDENTITY_INSERT [administrative_access].[Transactional_Configuraciones] OFF
GO

SET IDENTITY_INSERT [helpdesk].[Cat_Cargos_Dependencias] ON 

INSERT [helpdesk].[Cat_Cargos_Dependencias] ([Id_Cargo], [Descripcion]) VALUES (1, N'Encargado')
INSERT [helpdesk].[Cat_Cargos_Dependencias] ([Id_Cargo], [Descripcion]) VALUES (2, N'Coordinador')
INSERT [helpdesk].[Cat_Cargos_Dependencias] ([Id_Cargo], [Descripcion]) VALUES (3, N'Tecnico')
SET IDENTITY_INSERT [helpdesk].[Cat_Cargos_Dependencias] OFF
GO
SET IDENTITY_INSERT [helpdesk].[Cat_Dependencias] ON 

INSERT [helpdesk].[Cat_Dependencias] ([Id_Dependencia], [Descripcion], [Id_Dependencia_Padre], [Username], [Password], [Host], [AutenticationType], [TENAT], [CLIENT], [OBJECTID], [CLIENT_SECRET], [HostService], [SMTPHOST], [default]) VALUES (1, N'DEVEXP', NULL, N'wdevexp@outlook.com', N'%WtestDev2023%1', N'outlook.office365.com', N'BASIC', NULL, NULL, NULL, NULL, N'OUTLOOK', N'smtp-mail.outlook.com', NULL)
INSERT [helpdesk].[Cat_Dependencias] ([Id_Dependencia], [Descripcion], [Id_Dependencia_Padre], [Username], [Password], [Host], [AutenticationType], [TENAT], [CLIENT], [OBJECTID], [CLIENT_SECRET], [HostService], [SMTPHOST], [default]) VALUES (2, N'ON_DEVEXP', NULL, N'wilbermatusgonzalez@wexpdev.onmicrosoft.com', N'-', N'outlook.office365.com', N'AUTH2', N'8097a003-1162-40cb-ba74-f198eda4d6e9', N'b3161d3c-f437-47b7-aa3b-6a0ed3532f5b', N'1c56f54e-0255-44fd-a5ea-8be46debd21c', N'RrH8Q~O6hHqDetZWbNOYLQrdRgn.WupFPlSpBatO', N'OUTLOOK', N'smtp-mail.outlook.com', 1)
INSERT [helpdesk].[Cat_Dependencias] ([Id_Dependencia], [Descripcion], [Id_Dependencia_Padre], [Username], [Password], [Host], [AutenticationType], [TENAT], [CLIENT], [OBJECTID], [CLIENT_SECRET], [HostService], [SMTPHOST], [default]) VALUES (3, N'CTS', NULL, N'cts.curcarazo@unan.edu.ni', N'PROTECTED', N'outlook.office365.com', N'AUTH2', NULL, NULL, NULL, NULL, N'OUTLOOK', NULL, NULL)
INSERT [helpdesk].[Cat_Dependencias] ([Id_Dependencia], [Descripcion], [Id_Dependencia_Padre], [Username], [Password], [Host], [AutenticationType], [TENAT], [CLIENT], [OBJECTID], [CLIENT_SECRET], [HostService], [SMTPHOST], [default]) VALUES (4, N'Ciencias Ecónomicas', NULL, N'economicas.curcarazo@unan.edu.ni', NULL, N'outlook.office365.com', N'AUTH2', NULL, NULL, NULL, NULL, N'OUTLOOK', NULL, NULL)
INSERT [helpdesk].[Cat_Dependencias] ([Id_Dependencia], [Descripcion], [Id_Dependencia_Padre], [Username], [Password], [Host], [AutenticationType], [TENAT], [CLIENT], [OBJECTID], [CLIENT_SECRET], [HostService], [SMTPHOST], [default]) VALUES (5, N'Humanidades', NULL, N'humanidades.curcarazo@unan.edu.ni', NULL, N'outlook.office365.com', N'AUTH2', NULL, NULL, NULL, NULL, N'OUTLOOK', NULL, NULL)
INSERT [helpdesk].[Cat_Dependencias] ([Id_Dependencia], [Descripcion], [Id_Dependencia_Padre], [Username], [Password], [Host], [AutenticationType], [TENAT], [CLIENT], [OBJECTID], [CLIENT_SECRET], [HostService], [SMTPHOST], [default]) VALUES (6, N'TIC', NULL, N'david.torres@unan.edu.ni', NULL, N'outlook.office365.com', N'AUTH2', NULL, NULL, NULL, NULL, N'OUTLOOK', NULL, NULL)
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
INSERT [helpdesk].[Cat_Tipo_Participaciones] ([Id_Tipo_Participacion], [Descripcion]) VALUES (3, N'Autor')
SET IDENTITY_INSERT [helpdesk].[Cat_Tipo_Participaciones] OFF
GO
SET IDENTITY_INSERT [helpdesk].[Cat_Tipo_Servicio] ON 

INSERT [helpdesk].[Cat_Tipo_Servicio] ([Id_Tipo_Servicio], [Descripcion], [Estado], [Icon]) VALUES (1, N'Servicios de Asistencia', N'Activo', N'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')
INSERT [helpdesk].[Cat_Tipo_Servicio] ([Id_Tipo_Servicio], [Descripcion], [Estado], [Icon]) VALUES (2, N'Servicios Economicos', N'Activo', N'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALLAAACywBrWgDXAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAfBSURBVHiczZt7jB9VFcc/Z3e7tE0pLX0gj7KrG0BSbaSoiRo3IlEpBihiVrBWVyPx0YTyh0GjaSTxQfERFVHAxFIV5aFN0AgITVEINNhUui52gSJioa0UZekKtum6cPzjzJjZ2Xtn7syd2fJNbnZ/d+4959zv3Hvu64yoKm1BRE4GvgtcqarDrSmKQMc0yL8QGBKRX4rI0pb1VUbbBKQQ4IPAsIjcLCKvnya9pZguArL6LgZ2ishNInLqNOt3GtQmZhToXQWMiMhGEelr2Q4/VLXRBHQBK4CfAS8CGpD+C/wY6G3anlJ7G2x4H3At8Fxgo11pHLgBWJyROx9zpItelQQAi5OGj0c0PE2PAZcAHTkdC4Fh4EfAaa8KAoA5wJUVunlRegJYDXTmdJwOXAOM5XrJ14CZR4wA4E3AXxto+JPAYLbhiQ+5CNhSUncXcNa0EwBcChyq0KVd+X8HPgl0OeQPAjsqkPi9/JBphQBgNvDTAINGge8nvaQ39+xp4FPAjAB9fcAVCVllOm8HZrVGADAT+H2JES8BX8yOzQwBe4A1QHeNHted1N1Xov8hYGHjBGCLmTtKlN8MnOSouxi4jAYcFjArIbhotnkcWNAYAUAncFuBwjHgvNjGVSTibclQ8tl0X5WeVqbs+gJFj9HwnFyBhAXAnQW2bYwmAFhZoGALMPdIND7XO39VYOPnaxOArbz2ewT/CZgTYfgqYCiTfhAhqxu4y2PnOPCGugT4mP0bcFzkm7s8J/N3kfJmAfd77H0AkKL6U7bDIjKArcTy+A9wjqrudzw7YlDVQ8AA8Lzj8TuwBVehgCybAozgZvPyhsZuvgdsBY5vQO6Ax+5R4NigIQBc4BHyRyKWm4nsPmwef8KjYwzYhi1tl9fUcYtH9hWhBGx1VJ4gwJkUGHUCcI/HsKJ0VQ1di4CDDllP+V5gtvI7PYZsimj8e6h/QPLhmjqv9cg7v4yAjZ6K/TUN6cH2B3Ua/wo1ZxvgtUmvzcu8p4yAPY5KD0e8/aKV2qPAjcB64OfY2B/NPB+uqzfR7fIFE8DRTgKA0zyGrol4+77GfwvP3IydAH0HWBdJgM+Zr/ARsMZT4dSaBpzvkfcSMD+mcYH6j/EMg/X5sulC6GymYo+q7nLkh+AUT343Nr5bhaqOAdsdj96Vz0gJeKOj8L0RNviImwH8RkReEyE7FFsceWeKSGc2IyXgOEfhHRHKtxU86wd2i8iGli9LRxx5XdhW+v/oEJHZwNGOwv+qq1ltv3B3QZFu4OPAIyJyp4i8u66uAvj2LAuzPzpwv32IICDBxwqMSCHYNdoWEdkuIgMi0tR9ZTQBrt1VMJJesBI7vgrBmcCtwG9FZF6M7gTBBBzlKXg41gJVfQhYhl2UhmIFsF1EeiLVv+zJn5n90YGfqSbeAqo6pqofBZZi9wVjAdX6sNCaGPgIPJD9UUTA/EgDJkFVR1T1Mmx3uBbYW1JlpYj0R6js9eRPJkBVXwA2AzflCjZKQApVPaiq12Bv+bMUO8qY2SG4BwD8WlVXA1/Cloxg+4PWoKqHVfU64L1YgIQLp1eRKSLLRGRu8rPXU2ySc08JuCsx6utYMNNB7AKidaiFzz3qeXxMRXGXAE+KyFrAFX+0T/Nnmp7NxHLsmmnK7W2FDclZBER1YKuz7FY4m66uqPOHHjlpus23GcqT8jC2cZjreh6I64E9SVjcOSJyfPahiHSKyBnY3O/zN64NTRHKesyDU3JyDC4DrsNxcFDxTZyI+w28iF2s/IHyyJJhAq7Rc3rLLnHfPqVOTkBvUnA38L4IAj5SYkhZehl4aw29D5TIfRq4sIiAebkKG4B5NQzZENH4UWBlTeIfCdRxB/A6FwEd2IFFtvA+PCeqBYasJSyyI582AydH9Lyia/N8+jMwxyXk354Kv6BCBAa20zsb88z34T8eH8FCYXrqNjzA9myaAL5JElLjEvJMQeXngIEIA49NmM/KHIxteEHvzae/kPMtrmnwgCMvxSLgVhHZVOdYS1VHsQizNjAX63UuTABfxa7cJp1WuQgI2a19AIv4Xl3JxHbh270OAW9R1XWqOp5/WJcAsO58qYgsCSzfCkQkXUTlF0HjwDqs8UO++l2OvKIhkOIgsEpVbw+ycjI+hAU1pPhHDRkAiMggsAT4CpMJ2AZ8QlV3lgpxOJOy9XSaNhG5Yox0eunOdTD5fR72Yj5HLua4UI5D8FWBBKRTWK3bo4iGd2LL9dSG/iR/OXBKZXkOBV/INXIHFh7jI+EAtvQtjMVpqPH9mFPL6l8SJdOh5NOJ4BeAz2CO8s3AsyW9YQg4t6WGL8F943uY2MgVh7KLgZ+Q+Wojye8BdgYMi/uxU57aZwkZnWcA3yjogY8n5WY3SYDXgWBz7b2B/uH5hMgLqBDJnfS29YR9j/AMcDURy2hJlAZDRGYA38YONDtLiqc4hMUY7sU2V3uxZfUC4KQknZj8DT0GewUj6suqOhFq/xREdM+l2P1f6IzRZNpNA1+LOIdADSLej//LkKbTU9gHF5W/O2iNgISELmz2eJDyHVmdtAu7TY52rNE+oAwicgL2nd9F2Lwd6ieyUOzs8O4kbVVV311fFBonYJJwkUXYoUgP5uSyaTG2iNqPrTGeTf7fAWxW1X+2ZlgG/wNa7rgMGQpW4QAAAABJRU5ErkJggg==')
INSERT [helpdesk].[Cat_Tipo_Servicio] ([Id_Tipo_Servicio], [Descripcion], [Estado], [Icon]) VALUES (3, N'Servicios Académicos', N'Activo', N'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAB2AAAAdgB+lymcgAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAPfSURBVHic7dtLaFxVGMDxX9LaNibFCoqmahMjpFK0KkUXihUhG0GXLtxY3LgRUXxQdVU3VnyBO12JQVy4ERSs0iBSXfmu+FhpoKC12JpWG/OgTV18d0xynUlmpvfeudPeP3ybcOac73Ve37mhoqKioqJjXJvIeUM/xvAqDuFMIkcwjnuxqWPa5cQIHsF+zFk0upGcwpfYgx3oKVzjs6RRlNuVrsiOVqPcrpQmO7KOcldkR1FRLk12lCXKhWfHnfgY8yUwIiuZT2y6I21sOk36Es9tbMVjXcQJXCamMOhNNViPC4vUqGD6hY3/sSbVYBYzuA0XFKRUUfyDZ/DJ0j82Win7hBPGcA+25alZjkyKXWsCH+LvdINmt4oR4Ywx3IWBjBTMmll8JgyewFd5DNInHPE8ftD5Ff4XvC62u44s3iN4EO+IFMvb4BmR1rvFgadU5JUdHY9yu7SbHe1GeRA3Z6R75qyWHe1GeQDP4Rss4I3sVG6NPhGBZhnFA4mMtvC7wWSsGsOWO7JjDqgp8rO4QI1hXQb9rhHTYI+47S0kY6XHLY0DlspJvC/WgStb6OtSMRXG8WedfodXGLclB6xtpXEb9OPuROBH4ZAJHBC3NCLKN1o8ed6qoGpP3g5Isy2R3ZgW06VH7Bb9BeuC4h2wlH5s7+D4+P91+Gz4w5J7do7MJWNlQpYOmMYTFud1Hszj8WSs0rJFbIMzsi1pjeOaOuMNK8k2mCYLR6xkeI0hJXVAjXYc0YzhNdZhaslvn8xW/ewYwmtWflOYS9oMtdj37XgXe7EhI31zY1QchNLG79fanaCr6RXROp3IXtnuSF3DFlzVaSUqKirOX+rduXfiMdldT8/gsHileQ9fr9J+h6gJXC3KX1nVBabxiqhDNGQ9jsvuDF9PvhUHlzQ7cTDnsaesUqZLn6vzktOiklujdiYoYuxlp8x0QaSoj4568XSiEDxV0LikbMzD4I2iVj8gSl3bcb1I++Em+5jEp/heTItJUWA9qc4Lb7fQg1vwolgU06n5G15Q4pedLNmAh3EMR/GQ1JcbRVGbAtfh8gz6WxC7yHGx4k6t0v4SEf1jq7S7OJFNiWRxcfpdTDEvy2/FPYoP8Kyo+zfLTclv9iV95KXfS/BXjgOk5XPsUn/x7RXvhF8UqM8J+KjAAWtyAFuXGL9VrPpF67GvR2xXu2R3L1+Li7AZN+CKBu1m8bbIhvs0LmX9Kk6Ph0XETmWk5yFRd8ydzXgU32k+MgfFd8mtPLeXnh7cb+VFbUoYfk6XxwbxluXfIs/hTR2IeCf/HWXA4j9M/aTkz10VFRUV5yT/AgeCSWxx2ygvAAAAAElFTkSuQmCC')
SET IDENTITY_INSERT [helpdesk].[Cat_Tipo_Servicio] OFF
GO
SET IDENTITY_INSERT [helpdesk].[Tbl_Agenda] ON 

INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (72, NULL, 1, N'Lunes', N'08:00', N'17:00', CAST(N'2024-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (73, NULL, 1, N'Martes', N'08:00', N'17:00', CAST(N'2024-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (74, NULL, 1, N'Miércoles', N'08:00', N'17:00', CAST(N'2024-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (75, NULL, 1, N'Jueves', N'08:00', N'17:00', CAST(N'2024-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (76, NULL, 1, N'Viernes', N'08:00', N'17:00', CAST(N'2024-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (77, NULL, 2, N'Lunes', N'08:00', N'17:00', CAST(N'2024-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (78, NULL, 2, N'Martes', N'08:00', N'17:00', CAST(N'2024-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (79, NULL, 2, N'Miércoles', N'08:00', N'17:00', CAST(N'2024-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (80, NULL, 2, N'Jueves', N'08:00', N'17:00', CAST(N'2024-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (81, NULL, 2, N'Viernes', N'08:00', N'17:00', CAST(N'2024-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (87, NULL, 3, N'Lunes', N'08:00', N'17:00', CAST(N'2026-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (88, NULL, 3, N'Martes', N'08:00', N'17:00', CAST(N'2026-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (89, NULL, 3, N'Miércoles', N'08:00', N'17:00', CAST(N'2026-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (90, NULL, 3, N'Jueves', N'08:00', N'17:00', CAST(N'2026-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (91, NULL, 3, N'Viernes', N'08:00', N'17:00', CAST(N'2026-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (92, NULL, 4, N'Lunes', N'08:00', N'17:00', CAST(N'2026-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (93, NULL, 4, N'Martes', N'08:00', N'17:00', CAST(N'2026-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (94, NULL, 4, N'Miércoles', N'08:00', N'17:00', CAST(N'2026-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (95, NULL, 4, N'Jueves', N'08:00', N'17:00', CAST(N'2026-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (96, NULL, 4, N'Viernes', N'08:00', N'17:00', CAST(N'2026-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (97, NULL, 5, N'Lunes', N'08:00', N'17:00', CAST(N'2026-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (98, NULL, 5, N'Martes', N'08:00', N'17:00', CAST(N'2026-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (99, NULL, 5, N'Miércoles', N'08:00', N'17:00', CAST(N'2026-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (100, NULL, 5, N'Jueves', N'08:00', N'17:00', CAST(N'2026-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (101, NULL, 5, N'Viernes', N'08:00', N'17:00', CAST(N'2026-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (102, NULL, 6, N'Lunes', N'08:00', N'17:00', CAST(N'2026-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (103, NULL, 6, N'Martes', N'08:00', N'17:00', CAST(N'2026-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (104, NULL, 6, N'Miércoles', N'08:00', N'17:00', CAST(N'2026-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (105, NULL, 6, N'Jueves', N'08:00', N'17:00', CAST(N'2026-06-07T00:00:00.000' AS DateTime))
INSERT [helpdesk].[Tbl_Agenda] ([IdAgenda], [Id_Perfil], [Id_Dependencia], [Dia], [Hora_Inicial], [Hora_Final], [Fecha_Caducidad]) VALUES (106, NULL, 6, N'Viernes', N'08:00', N'17:00', CAST(N'2026-06-07T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [helpdesk].[Tbl_Agenda] OFF
GO
INSERT [helpdesk].[Tbl_Dependencias_Usuarios] ([Id_Perfil], [Id_Dependencia], [Id_Cargo]) VALUES (1, 1, NULL)
INSERT [helpdesk].[Tbl_Dependencias_Usuarios] ([Id_Perfil], [Id_Dependencia], [Id_Cargo]) VALUES (2, 6, NULL)
INSERT [helpdesk].[Tbl_Dependencias_Usuarios] ([Id_Perfil], [Id_Dependencia], [Id_Cargo]) VALUES (3, 1, NULL)
GO
SET IDENTITY_INSERT [helpdesk].[Tbl_Grupo] ON 

INSERT [helpdesk].[Tbl_Grupo] ([Id_Grupo], [Id_Perfil_Crea], [Id_Tipo_Grupo], [Fecha_Creacion], [Estado], [Descripcion], [Nombre], [Color]) VALUES (7, 3, NULL, NULL, N'ACTIVO', N'test de grupo', N'GRUPO DE PRUEBAS 2', N'#b79f06')
SET IDENTITY_INSERT [helpdesk].[Tbl_Grupo] OFF
GO
SET IDENTITY_INSERT [helpdesk].[Tbl_Servicios] ON 

INSERT [helpdesk].[Tbl_Servicios] ([Id_Servicio], [Nombre_Servicio], [Descripcion_Servicio], [Id_Tipo_Servicio], [Visibilidad], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Id_Dependencia]) VALUES (1, N'Servicio Atención', N'Atención', 1, N'publica', N'Activo', CAST(N'2021-01-12' AS Date), CAST(N'2021-12-12' AS Date), 1)
INSERT [helpdesk].[Tbl_Servicios] ([Id_Servicio], [Nombre_Servicio], [Descripcion_Servicio], [Id_Tipo_Servicio], [Visibilidad], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Id_Dependencia]) VALUES (2, N'Servicio Atención 2', N'Atención 2', 1, N'publica', N'Activo', CAST(N'2021-01-12' AS Date), CAST(N'2021-12-12' AS Date), 1)
INSERT [helpdesk].[Tbl_Servicios] ([Id_Servicio], [Nombre_Servicio], [Descripcion_Servicio], [Id_Tipo_Servicio], [Visibilidad], [Estado], [Fecha_Inicio], [Fecha_Finalizacion], [Id_Dependencia]) VALUES (3, N'Servicio Atención', N'Atención', 3, N'publica', N'Activo', NULL, NULL, 2)
SET IDENTITY_INSERT [helpdesk].[Tbl_Servicios] OFF
GO
INSERT [helpdesk].[Tbl_Servicios_Profile] ([Id_Perfil], [Id_Servicio]) VALUES (3, 1)
INSERT [helpdesk].[Tbl_Servicios_Profile] ([Id_Perfil], [Id_Servicio]) VALUES (3, 2)
GO
SET IDENTITY_INSERT [security].[Security_Permissions] ON 

INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado], [Detalles]) VALUES (1, N'ADMIN_ACCESS', N'Activo', N'ACCESO TOTAL DEL SISTEMA')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado], [Detalles]) VALUES (22, N'ADMINISTRAR_CASOS_DEPENDENCIA', N'Activo', N'PUEDE VER LOS CASOS DE TODA LA DEPENDENCIA A LA QUE PERTENECE, APROBARLOS, RECHAZARLOS, CERRARLOS')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado], [Detalles]) VALUES (23, N'TECNICO_CASOS_DEPENDENCIA', N'Activo', N'PUEDE VER LOS CASOS ASIGNADOS Y CERRARLOS')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado], [Detalles]) VALUES (24, N'GENERADOR_SOLICITUDES', N'Activo', N'PERMITE REALIZAR SOLICITUDES DE CASOS DENTRO DE LA PLATAFORMA')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado], [Detalles]) VALUES (25, N'ADMINISTRAR_CASOS_PROPIOS', N'Activo', N'PUEDE VER LOS CASOS PROPIOS')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado], [Detalles]) VALUES (26, N'PERFIL_ACCESS', N'Activo', N'PERMITE ACCEDER AL PERFIL DEL USUARIO')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado], [Detalles]) VALUES (27, N'PERFIL_MANAGER', N'Activo', N'PERMITE MANIPULAR PERFILES DE LOS USUARIO')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado], [Detalles]) VALUES (28, N'ADMINISTRAR_USUARIOS', N'Activo', N'PERMITE MANIPULAR PERFILES DE TODOS LOS USUARIO')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado], [Detalles]) VALUES (29, N'SEND_MESSAGE', N'Activo', N'PUEDE ENVIAR MENSAJES A LOS USUARIOS')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado], [Detalles]) VALUES (30, N'NOTIFICACIONES_READER', N'Activo', N'PUEDE LEER NOTIFICACIONES')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado], [Detalles]) VALUES (31, N'NOTIFICACIONES_MANAGER', N'Activo', N'PUEDE CREAR NOTIFICACIONES')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado], [Detalles]) VALUES (32, N'QUESTIONNAIRES_MANAGER', N'Activo', N'PUEDE CREAR QUESTIONARIOS')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado], [Detalles]) VALUES (33, N'QUESTIONNAIRES_GESTOR', N'Activo', N'PUEDE GESTIONAR QUESTIONARIOS')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado], [Detalles]) VALUES (34, N'QUESTIONNAIRES_USER', N'Activo', N'PUEDE RESOLVER QUESTIONARIOS')
INSERT [security].[Security_Permissions] ([Id_Permission], [Descripcion], [Estado], [Detalles]) VALUES (35, N'GESTOR_TAREAS', N'Activo', N'PUEDE GESTIONAR TAREAS CREARLAS EDITARLAS')
SET IDENTITY_INSERT [security].[Security_Permissions] OFF
GO
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (1, 1, N'ACTIVO')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (4, 25, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (4, 26, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (4, 27, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (4, 29, N'Activo')
INSERT [security].[Security_Permissions_Roles] ([Id_Role], [Id_Permission], [Estado]) VALUES (4, 35, N'Activo')
GO
SET IDENTITY_INSERT [security].[Security_Roles] ON 

INSERT [security].[Security_Roles] ([Id_Role], [Descripcion], [Estado]) VALUES (1, N'ADMIN', N'ACTIVO')
INSERT [security].[Security_Roles] ([Id_Role], [Descripcion], [Estado]) VALUES (4, N'DOCENTE/INVESTIGADOR', N'ACTIVO')
SET IDENTITY_INSERT [security].[Security_Roles] OFF
GO
SET IDENTITY_INSERT [security].[Security_Users] ON 

INSERT [security].[Security_Users] ([Id_User], [Nombres], [Estado], [Descripcion], [Password], [Mail], [Token], [Token_Date], [Token_Expiration_Date], [Nombres_Completo]) VALUES (1, N'ADMIN', N'ACTIVO', N'ADMIN', N'PxI/Pz8/Pz8/PwdSP2E/Pw==', N'admin@admin.net', NULL, NULL, NULL, NULL)
INSERT [security].[Security_Users] ([Id_User], [Nombres], [Estado], [Descripcion], [Password], [Mail], [Token], [Token_Date], [Token_Expiration_Date], [Nombres_Completo]) VALUES (2, N'TECNICO', N'ACTIVO', N'TECNICO', N'PxI/Pz8/Pz8/PwdSP2E/Pw==', N'tecnico@tecnico.net', NULL, NULL, NULL, NULL)
INSERT [security].[Security_Users] ([Id_User], [Nombres], [Estado], [Descripcion], [Password], [Mail], [Token], [Token_Date], [Token_Expiration_Date], [Nombres_Completo]) VALUES (3, N'GESTOR', N'ACTIVO', N'GESTOR', N'PxI/Pz8/Pz8/PwdSP2E/Pw==', N'GESTOR@GESTOR.net', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [security].[Security_Users] OFF
GO
INSERT [security].[Security_Users_Roles] ([Id_Role], [Id_User], [Estado]) VALUES (1, 1, N'ACTIVO')
INSERT [security].[Security_Users_Roles] ([Id_Role], [Id_User], [Estado]) VALUES (4, 2, N'ACTIVO')
INSERT [security].[Security_Users_Roles] ([Id_Role], [Id_User], [Estado]) VALUES (4, 3, N'ACTIVO')
GO
SET IDENTITY_INSERT [security].[Tbl_Profile] ON 

INSERT [security].[Tbl_Profile] ([Id_Perfil], [Nombres], [Apellidos], [FechaNac], [IdUser], [Sexo], [Foto], [DNI], [Correo_institucional], [Id_Pais_Origen], [Estado], [ORCID]) VALUES (1, N'ADMIN manuel perez', N'ADMIN', CAST(N'1900-01-01' AS Date), 1, N'Masculino', N'\Media\profiles\avatar.png', N'1112dfg', N'admin@admin.net', NULL, N'ACTIVO', NULL)
INSERT [security].[Tbl_Profile] ([Id_Perfil], [Nombres], [Apellidos], [FechaNac], [IdUser], [Sexo], [Foto], [DNI], [Correo_institucional], [Id_Pais_Origen], [Estado], [ORCID]) VALUES (2, N'TECNICO', N'TECNICO', CAST(N'1899-12-30' AS Date), 2, N'Masculino', N'\Media\profiles\avatar.png', N'1112dfg', N'tecnico@tecnico.net', NULL, N'ACTIVO', NULL)
INSERT [security].[Tbl_Profile] ([Id_Perfil], [Nombres], [Apellidos], [FechaNac], [IdUser], [Sexo], [Foto], [DNI], [Correo_institucional], [Id_Pais_Origen], [Estado], [ORCID]) VALUES (3, N'GESTOR', N'GESTOR', CAST(N'1900-01-01' AS Date), 3, N'Masculino', N'\Media\profiles\f32e5048-78e8-4176-87d1-bc982120fa35.png', N'1112dfg', N'GESTOR@GESTOR.net', NULL, N'ACTIVO', NULL)
INSERT [security].[Tbl_Profile] ([Id_Perfil], [Nombres], [Apellidos], [FechaNac], [IdUser], [Sexo], [Foto], [DNI], [Correo_institucional], [Id_Pais_Origen], [Estado], [ORCID]) VALUES (4, N'Microsoft Outlook', N'Microsoft Outlook', NULL, NULL, N'Masculino', N'\Media\profiles\avatar.png', NULL, N'MicrosoftExchange329e71ec88ae4615bbc36ab6ce41109e@sct-15-20-7719-20-msonline-outlook-92255.templateTenant', NULL, N'ACTIVO', NULL)
SET IDENTITY_INSERT [security].[Tbl_Profile] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Transactional_Configuraciones_UN]    Script Date: 10/10/2024 4:40:09 PM ******/
ALTER TABLE [administrative_access].[Transactional_Configuraciones] ADD  CONSTRAINT [Transactional_Configuraciones_UN] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [index_mensaje_adjuntos_on_mensaje_id]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sptest]    Script Date: 10/10/2024 4:40:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sptest2]    Script Date: 10/10/2024 4:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sptest2] as SELECT 'hellow' as column1 
GO
/****** Object:  StoredProcedure [dbo].[sptest3]    Script Date: 10/10/2024 4:40:09 PM ******/
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
