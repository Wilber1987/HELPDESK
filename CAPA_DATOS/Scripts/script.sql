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

ALTER TABLE HELPDESK.helpdesk.CaseTable_Tareas ADD Fecha_Inicio_Proceso datetime NULL;
ALTER TABLE HELPDESK.helpdesk.CaseTable_Tareas ADD Fecha_Finalizacion_Proceso datetime NULL;
