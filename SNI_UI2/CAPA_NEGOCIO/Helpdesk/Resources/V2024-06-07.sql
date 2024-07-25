ALTER TABLE helpdesk.Tbl_Case ADD MimeMessageCaseData nvarchar(MAX) NULL;

ALTER TABLE helpdesk.Tbl_Profile_CasosAsignados ADD Id_Tipo_Participacion int NULL;
ALTER TABLE helpdesk.Tbl_Profile_CasosAsignados ADD 
CONSTRAINT Tbl_Profile_CasosAsignados_Cat_Tipo_Participaciones_FK 
FOREIGN KEY (Id_Tipo_Participacion) REFERENCES helpdesk.Cat_Tipo_Participaciones(Id_Tipo_Participacion);

INSERT INTO helpdesk.Cat_Tipo_Participaciones
(Descripcion)
VALUES(N'Autor');

ALTER TABLE [security].Tbl_Profile ALTER COLUMN Nombres nvarchar(300) COLLATE Modern_Spanish_CI_AS NULL;
ALTER TABLE [security].Tbl_Profile ALTER COLUMN Apellidos nvarchar(300) COLLATE Modern_Spanish_CI_AS NULL;
ALTER TABLE [security].Tbl_Profile ALTER COLUMN Correo_institucional nvarchar(300) COLLATE Modern_Spanish_CI_AS NULL;


