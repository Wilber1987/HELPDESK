ALTER TABLE helpdesk.Tbl_Tareas ALTER COLUMN Titulo nvarchar(500) COLLATE Latin1_General_CI_AI NULL;
ALTER TABLE helpdesk.Tbl_Tareas ALTER COLUMN Descripcion nvarchar(MAX) COLLATE Latin1_General_CI_AI NULL;

INSERT INTO PROYECT_MANAGER_BD.[security].Security_Permissions
( Descripcion, Estado, Detalles)
VALUES( N'GESTOR_TAREAS', N'Activo', N'PUEDE GESTIONAR TAREAS CREARLAS EDITARLAS');

ALTER TABLE PROYECT_MANAGER_BD.helpdesk.Tbl_Grupo ALTER COLUMN Descripcion nvarchar(MAX) COLLATE Latin1_General_CI_AI NULL;
ALTER TABLE PROYECT_MANAGER_BD.helpdesk.Tbl_Grupo ALTER COLUMN Nombre nvarchar(500) COLLATE Latin1_General_CI_AI NULL;
ALTER TABLE PROYECT_MANAGER_BD.helpdesk.Tbl_Grupo ADD Color nvarchar(100) NULL;
