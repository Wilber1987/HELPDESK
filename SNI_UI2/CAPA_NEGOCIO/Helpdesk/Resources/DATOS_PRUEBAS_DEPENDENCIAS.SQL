delete from helpdesk.Tbl_Comments_Tasks 
delete from helpdesk.Tbl_Comments
delete from helpdesk.Tbl_Mails  
delete from helpdesk.Tbl_Calendario 
delete from helpdesk.Tbl_Participantes  
delete from helpdesk.Tbl_Tareas 
delete from helpdesk.Tbl_Profile_CasosAsignados  
delete from helpdesk.Tbl_Case


delete from helpdesk.Tbl_Agenda 
delete from helpdesk.Cat_Tipo_Servicio 
delete from helpdesk.Cat_Dependencias 

DBCC CHECKIDENT ('helpdesk.Cat_Dependencias', RESEED, 0);

--DATOS BASICOS DE PRUEBA
INSERT INTO PROYECT_MANAGER_BD.helpdesk.Cat_Dependencias
(Descripcion, Id_Dependencia_Padre, Username, Password, Host, AutenticationType, TENAT, CLIENT, OBJECTID, CLIENT_SECRET, HostService, SMTPHOST, [default])
VALUES(N'DEPENDENCIA usav', NULL, N'wdevexp@outlook.com', N'%WtestDev2023%1', N'outlook.office365.com', N'BASIC', NULL, NULL, NULL, NULL, N'OUTLOOK', N'smtp-mail.outlook.com', NULL);

--servicios de prueba

INSERT INTO PROYECT_MANAGER_BD.helpdesk.Tbl_Servicios
(Nombre_Servicio, Descripcion_Servicio, Id_Tipo_Servicio, Visibilidad, Estado, Fecha_Inicio, Fecha_Finalizacion, Id_Dependencia)
VALUES(N'Servicio 1', N'MANTENIMIENTO', 1, N'publica', N'Activo', '2021-01-12', '2021-12-12', 1);
INSERT INTO PROYECT_MANAGER_BD.helpdesk.Tbl_Servicios
(Nombre_Servicio, Descripcion_Servicio, Id_Tipo_Servicio, Visibilidad, Estado, Fecha_Inicio, Fecha_Finalizacion, Id_Dependencia)
VALUES(N'Servicio 2', N'Planeación estratégica ', 3, N'publica', N'Activo', NULL, NULL, 1);
INSERT INTO PROYECT_MANAGER_BD.helpdesk.Tbl_Servicios
(Nombre_Servicio, Descripcion_Servicio, Id_Tipo_Servicio, Visibilidad, Estado, Fecha_Inicio, Fecha_Finalizacion, Id_Dependencia)
VALUES(N'Servicio 3', N'Migración de sistemas ', 3, N'publica', N'Activo', NULL, NULL, 1);

--Agenda dependencia


INSERT INTO PROYECT_MANAGER_BD.helpdesk.Tbl_Agenda
(Id_Perfil, Id_Dependencia, Dia, Hora_Inicial, Hora_Final, Fecha_Caducidad)
VALUES(NULL, 1, N'Lunes', N'08:00', N'17:00', '2024-06-07 00:00:00.000');
INSERT INTO PROYECT_MANAGER_BD.helpdesk.Tbl_Agenda
(Id_Perfil, Id_Dependencia, Dia, Hora_Inicial, Hora_Final, Fecha_Caducidad)
VALUES(NULL, 1, N'Martes', N'08:00', N'17:00', '2024-06-07 00:00:00.000');
INSERT INTO PROYECT_MANAGER_BD.helpdesk.Tbl_Agenda
(Id_Perfil, Id_Dependencia, Dia, Hora_Inicial, Hora_Final, Fecha_Caducidad)
VALUES(NULL, 1, N'Miércoles', N'08:00', N'17:00', '2024-06-07 00:00:00.000');
INSERT INTO PROYECT_MANAGER_BD.helpdesk.Tbl_Agenda
(Id_Perfil, Id_Dependencia, Dia, Hora_Inicial, Hora_Final, Fecha_Caducidad)
VALUES(NULL, 1, N'Jueves', N'08:00', N'17:00', '2024-06-07 00:00:00.000');
INSERT INTO PROYECT_MANAGER_BD.helpdesk.Tbl_Agenda
(Id_Perfil, Id_Dependencia, Dia, Hora_Inicial, Hora_Final, Fecha_Caducidad)
VALUES(NULL, 1, N'Viernes', N'08:00', N'17:00', '2024-06-07 00:00:00.000');
