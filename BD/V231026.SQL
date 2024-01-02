EXEC HELPDESK.sys.sp_rename N'HELPDESK.helpdesk.CaseTable_Case.Fecha_Inicial',
N'Fecha_Inicio',
'COLUMN';
CREATE TABLE HELPDESK.helpdesk.CaseTable_Mails (
    Id_Mail int IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    Id_Case int,
    Subject nvarchar(MAX),
    MessageID nvarchar(MAX),
    Sender nvarchar(MAX),
    FromAdress nvarchar(MAX),
    ReplyTo nvarchar(MAX),
    Bcc nvarchar(MAX),
    Cc nvarchar(MAX),
    ToAdress nvarchar(MAX),
    Date datetime,
    Uid nvarchar(MAX),
    Flags nvarchar(MAX),
    CONSTRAINT FK_Mail_Case FOREIGN KEY (Id_Case) REFERENCES HELPDESK.helpdesk.CaseTable_Case(Id_Case)
)
ALTER TABLE HELPDESK.helpdesk.CaseTable_Tareas
ADD Fecha_Inicio_Proceso datetime NULL;
ALTER TABLE HELPDESK.helpdesk.CaseTable_Tareas
ADD Fecha_Finalizacion_Proceso datetime NULL;
ALTER TABLE HELPDESK.helpdesk.CaseTable_Mails
ADD Attach_Files varchar(MAX) NULL;
ALTER TABLE HELPDESK.helpdesk.CaseTable_Case
ADD Case_Priority varchar(50) NULL;
--  HOST
ALTER TABLE HELPDESK.helpdesk.Cat_Dependencias
ADD AutenticationType varchar(MAX) NULL;
ALTER TABLE HELPDESK.helpdesk.Cat_Dependencias
ADD TENAT varchar(MAX) NULL;
ALTER TABLE HELPDESK.helpdesk.Cat_Dependencias
ADD CLIENT varchar(MAX) NULL;
ALTER TABLE HELPDESK.helpdesk.Cat_Dependencias
ADD OBJECTID varchar(MAX) NULL;
ALTER TABLE HELPDESK.helpdesk.Cat_Dependencias
ADD CLIENT_SECRET varchar(MAX) NULL;
ALTER TABLE HELPDESK.helpdesk.Cat_Dependencias
ADD HostService varchar(MAX) NULL;
ALTER TABLE HELPDESK.helpdesk.Cat_Dependencias
ADD default bit;


-- comments
ALTER TABLE HELPDESK.helpdesk.CaseTable_Comments
ALTER COLUMN NickName nvarchar(MAX) COLLATE Modern_Spanish_CI_AS NULL;
ALTER TABLE HELPDESK.helpdesk.CaseTable_Comments
ALTER COLUMN Mail nvarchar(MAX) COLLATE Modern_Spanish_CI_AS NULL;
ALTER TABLE HELPDESK.helpdesk.CaseTable_Case
ALTER COLUMN Mail nvarchar(MAX) COLLATE Modern_Spanish_CI_AS NULL;

ALTER TABLE HELPDESK.helpdesk.Cat_Dependencias ADD SMTPHOST varchar(500) NULL;

EXEC HELPDESK.sys.sp_rename N'HELPDESK.dbo.LogError', N'Log', 'OBJECT';


CREATE TABLE HELPDESK.helpdesk.CaseTable_Comments_Tasks (
	Id_Comentario int IDENTITY(1,1) NOT NULL,
	Body nvarchar(MAX) COLLATE Modern_Spanish_CI_AS NULL,
	Estado nvarchar(50) COLLATE Modern_Spanish_CI_AS NULL,
	Fecha datetime NULL,
	Id_Tarea int NULL,
	Id_User int NULL,
	NickName nvarchar(MAX) COLLATE Modern_Spanish_CI_AS NULL,
	Mail nvarchar(MAX) COLLATE Modern_Spanish_CI_AS NULL,
	Attach_Files nvarchar(MAX) COLLATE Modern_Spanish_CI_AS NULL,
	CONSTRAINT PK_CaseTable_Coments_Tasks PRIMARY KEY (Id_Comentario)
);

EXEC HELPDESK.sys.sp_rename N'HELPDESK.helpdesk.CaseTable_Calendario.Fecha_Inicial' , N'Fecha_Inicio', 'COLUMN';
