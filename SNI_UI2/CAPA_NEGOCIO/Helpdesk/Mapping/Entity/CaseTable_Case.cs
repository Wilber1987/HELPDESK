using CAPA_DATOS;
using CAPA_DATOS.Security;
using API.Controllers;
using CAPA_DATOS.Services;
using MimeKit;

namespace CAPA_NEGOCIO.MAPEO
{
    enum Case_Priority
    {
        Alta, Media, Baja
    }
    public class CaseTable_Case : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? Id_Case { get; set; }
        public string? Titulo { get; set; }
        public string? Descripcion { get; set; }
        public string? Case_Priority { get; set; }
        public string? Mail { get; set; }
        public int? Id_Perfil { get; set; }
        public string? Estado { get; set; }
        public int? Id_Dependencia { get; set; }
        public DateTime? Fecha_Inicio { get; set; }
        public DateTime? Fecha_Final { get; set; }
        public int? Id_Servicio { get; set; }
        public int? Id_Vinculate { get; set; }

        // [ManyToOne(TableName = "Tbl_Profile", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
        public Tbl_Profile? Tbl_Profile { get; set; }
        [ManyToOne(TableName = "Cat_Dependencias", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
        public Cat_Dependencias? Cat_Dependencias { get; set; }
        [ManyToOne(TableName = "Tbl_Servicios", KeyColumn = "Id_Servicio", ForeignKeyColumn = "Id_Servicio")]
        public Tbl_Servicios? Tbl_Servicios { get; set; }
        [OneToMany(TableName = "CaseTable_Tareas", KeyColumn = "Id_Case", ForeignKeyColumn = "Id_Case")]
        public List<CaseTable_Tareas>? CaseTable_Tareas { get; set; }

        //[OneToMany(TableName = "CaseTable_Comments", KeyColumn = "Id_Case", ForeignKeyColumn = "Id_Case")]
        public List<CaseTable_Comments>? CaseTable_Comments { get; set; }

        public bool CreateAutomaticCase(MimeMessage mail, Cat_Dependencias dependencia)
        {
            try
            {
                BeginGlobalTransaction();
                List<ModelFiles> Attach = new List<ModelFiles>();

                if (mail.Subject.ToUpper().Contains("RE:"))
                {
                    char[] MyChar = { 'R', 'E', ':', ' ' };
                    CaseTable_Case? findCase = new CaseTable_Case()
                    {
                        Titulo = mail.Subject.ToUpper().TrimStart(MyChar)
                    }.Find<CaseTable_Case>();
                    if (findCase != null)
                    {
                        if (mail?.Attachments != null)
                        {
                            foreach (MimeEntity attach in mail.Attachments)
                            {
                                ModelFiles Response = FileService.ReceiveFiles("Upload\\", attach);
                                Attach.Add(Response);
                            }
                        }
                        //new CaseTable_Mails(mail) { Id_Case = findCase.Id_Case }.Save();
                        new CaseTable_Mails(mail) { Id_Case = findCase.Id_Case, Attach_Files = Attach }.Save();
                        saveMessage(mail, Attach, findCase);
                    }
                }
                else if (mail.Subject.ToUpper().Contains("TAREA ASIGNADA:")) { }
                else
                {
                    Titulo = mail.Subject.ToUpper();
                    Descripcion = mail.HtmlBody;
                    Estado = Case_Estate.Solicitado.ToString();
                    Fecha_Inicio = mail.Date.DateTime;
                    Id_Dependencia = dependencia.Id_Dependencia;
                    Mail = mail.From.ToString();
                    Save();
                    //new CaseTable_Mails(mail) { Id_Case = this.Id_Case }.Save();
                    if (mail?.Attachments != null)
                    {
                        foreach (MimeEntity attach in mail.Attachments)
                        {
                            ModelFiles Response = FileService.ReceiveFiles("Upload\\", attach);
                            Attach.Add(Response);
                        }
                        new CaseTable_Mails(mail) { Id_Case = this.Id_Case, Attach_Files = Attach }.Save();
                        saveMessage(mail, Attach, this);
                    }
                    else
                    {
                        new CaseTable_Mails(mail) { Id_Case = this.Id_Case }.Save();
                    }
                }
                CommitGlobalTransaction();
                return true;
            }
            catch (Exception ex)
            {
                Console.Write("error al guardar");
                RollBackGlobalTransaction();
                LoggerServices.AddMessageError($"error al crear el caso de: {mail.From}, {mail.Subject}", ex);
                return false;
            }

        }

        private static void saveMessage(MimeMessage mail, List<ModelFiles> Attach, CaseTable_Case? findCase)
        {
            new CaseTable_Comments()
            {
                Id_Case = findCase?.Id_Case,
                Body = mail.HtmlBody,
                NickName = $"{mail.From}",
                Fecha = mail.Date.DateTime,
                Estado = CommetsState.Pendiente.ToString(),
                Mail = mail.From.ToString(),
                Attach_Files = Attach

            }.Save();
        }

        public bool SaveActividades(string identity)
        {
            this.Id_Perfil = AuthNetCore.User(identity).UserId;
            if (this.CheckCanSaveAct())
            {
                this.Estado = "Activa";
                this.Id_Case = (Int32?)SqlADOConexion.SQLM?.InsertObject(this);
                foreach (CaseTable_Tareas obj in this.CaseTable_Tareas ?? new List<CaseTable_Tareas>())
                {
                    obj.Id_Case = this.Id_Case;
                    obj.Save();
                }
                return true;
            }
            return false;
        }
        public bool CheckCanSaveAct()
        {
            CaseTable_Dependencias_Usuarios DU = new()
            {
                Id_Perfil = this.Id_Perfil,
                Id_Dependencia = this.Id_Dependencia
            };
            if (DU.Get_WhereIN<CaseTable_Dependencias_Usuarios>("Id_Cargo", new string[] { "1", "2" }).Count == 0)
            {
                return false;
            }
            return true;
        }
        public bool SolicitarActividades(string identity)
        {
            this.Id_Perfil = AuthNetCore.User(identity).UserId;
            this.Estado = Case_Estate.Pendiente.ToString();
            this.Id_Case = (Int32?)SqlADOConexion.SQLM?.InsertObject(this);
            foreach (CaseTable_Tareas obj in this.CaseTable_Tareas ?? new List<CaseTable_Tareas>())
            {
                obj.Id_Case = this.Id_Case;
                obj.Save();
            }
            return true;
        }
        public CaseTable_Case GetActividad()
        {
            this.CaseTable_Tareas = new CaseTable_Tareas().Get<CaseTable_Tareas>("Id_Case = " + this.Id_Case.ToString());
            foreach (CaseTable_Tareas tarea in this.CaseTable_Tareas ?? new List<CaseTable_Tareas>())
            {
                tarea.CaseTable_Calendario = new CaseTable_Calendario().Get<CaseTable_Calendario>("Id_Tarea = " + tarea.Id_Tarea.ToString());
            }
            return this;
        }
        public List<CaseTable_Case> GetOwCase(string identity)
        {
            if (AuthNetCore.HavePermission(PermissionsEnum.ADMINISTRAR_CASOS_DEPENDENCIA.ToString(), identity)
             || AuthNetCore.HavePermission(PermissionsEnum.TECNICO_CASOS_DEPENDENCIA.ToString(), identity))
            {
                return getCaseByDependencia(identity, null)
                .Where(c => c.Estado != Case_Estate.Rechazado.ToString()
                && c.Estado != Case_Estate.Solicitado.ToString()
                && c.Estado != Case_Estate.Finalizado.ToString()).ToList();
            }
            throw new Exception("no tienes permisos para gestionar casos");
        }
        public List<CaseTable_Case> GetOwCloseCase(string identity)
        {
            if (AuthNetCore.HavePermission(PermissionsEnum.ADMINISTRAR_CASOS_DEPENDENCIA.ToString(), identity)
             || AuthNetCore.HavePermission(PermissionsEnum.TECNICO_CASOS_DEPENDENCIA.ToString(), identity))
            {
                return getCaseByDependencia(identity, null)
                .Where(c => c.Estado == Case_Estate.Finalizado.ToString()).ToList();
            }
            throw new Exception("no tienes permisos para gestionar casos");
        }


        public List<CaseTable_Case> GetOwSolicitudes(string? identity, Case_Estate case_Estate)
        {

            Id_Perfil = AuthNetCore.User(identity).UserId;
            Estado = case_Estate.ToString();
            return Get<CaseTable_Case>();
        }

        public List<CaseTable_Case> GetSolicitudesPendientesAprobar(string? identity, Case_Estate case_Estate)
        {
            if (AuthNetCore.HavePermission(PermissionsEnum.ADMINISTRAR_CASOS_DEPENDENCIA.ToString(), identity))
            {
                return getCaseByDependencia(identity, case_Estate);
            }
            throw new Exception("no tienes permisos para aprobar casos");
        }

        private List<CaseTable_Case> getCaseByDependencia(string? identity, Case_Estate? case_Estate)
        {
            Estado = case_Estate?.ToString();
            return Get_WhereIN<CaseTable_Case>("Id_Dependencia", new CaseTable_Dependencias_Usuarios()
            { Id_Perfil = AuthNetCore.User(identity).UserId }
               .Get<CaseTable_Dependencias_Usuarios>().Select(p => p.Id_Dependencia.ToString()).ToArray());
        }
        internal object AprobarSolicitud(string identity)
        {
            var user = AuthNetCore.User(identity);
            if (!AuthNetCore.HavePermission(PermissionsEnum.ADMINISTRAR_CASOS_DEPENDENCIA.ToString(), identity))
            {
                throw new Exception("no tienes permisos para rechazar casos");
            }
            if (Estado.Equals(Case_Estate.Rechazado.ToString()))
            {
                throw new Exception("no puedes rechazar este caso en este proceso caso");
            }
            //BeginGlobalTransaction();
            Estado = Case_Estate.Activo.ToString();

            var response = Update();
            var comment = new CaseTable_Comments()
            {
                Id_Case = this.Id_Case,
                Body = $"El caso esta en estado: {this.Estado}, para mayor información consulte con nuestro equipo",
                NickName = $"{user.UserData.Nombres} ({user.mail})",
                Fecha = DateTime.Now,
                Estado = CommetsState.Pendiente.ToString(),
                Mail = user.mail
            };
            if (CaseTable_Tareas != null)
            {
                foreach (var task in CaseTable_Tareas)
                {
                    task.NotificarTecnicos(this, user);
                }
            }

            comment.Save();
            comment.CreateMailForComment(user);
            //CommitGlobalTransaction();
            return response;
        }

        internal object RechazarSolicitud(string identity)
        {
            if (AuthNetCore.HavePermission(PermissionsEnum.ADMINISTRAR_CASOS_DEPENDENCIA.ToString(), identity))
            {
                Estado = Case_Estate.Rechazado.ToString();
                return Update() ?? new ResponseService()
                {
                    status = 500,
                    message = "error desconocido"
                };
            }
            throw new Exception("no tienes permisos para rechazar casos");
        }
        internal object CerrarCaso(string identity)
        {
            if (AuthNetCore.HavePermission(PermissionsEnum.ADMINISTRAR_CASOS_DEPENDENCIA.ToString(), identity))
            {
                List<CaseTable_Tareas> caseTable_Tareas =
                new CaseTable_Tareas() { Id_Case = this.Id_Case }.Get<CaseTable_Tareas>();
                int tareasRequeridas = caseTable_Tareas.Where(c => c.Estado != TareasState.Inactivo.ToString()).ToList().Count;
                int tareasFinalizadas = caseTable_Tareas.Where(c => c.Estado == TareasState.Finalizado.ToString()).ToList().Count;
                if (tareasRequeridas != tareasFinalizadas)
                {
                    return new ResponseService()
                    {
                        status = 500,
                        message = "Debe finalizar todas las tareas activas antes de cerrar el caso"
                    };
                }
                Estado = Case_Estate.Finalizado.ToString();
                return Update() ?? new ResponseService()
                {
                    status = 500,
                    message = "error desconocido"
                };
            }
            throw new Exception("no tienes permisos para cerrar casos");
        }
        internal List<CaseTable_Case> GetCasosToVinculate(string? identity, CaseTable_Case inst)
        {
            this.Id_Dependencia = inst.Id_Dependencia;
            if (AuthNetCore.HavePermission(PermissionsEnum.ADMINISTRAR_CASOS_DEPENDENCIA.ToString(), identity)
             && AuthNetCore.HavePermission(PermissionsEnum.TECNICO_CASOS_DEPENDENCIA.ToString(), identity))
            {
                if (inst.Id_Vinculate != null)
                {
                    return this.Get_WhereNotIN<CaseTable_Case>("Id_Vinculate",
                     new string[] { inst.Id_Vinculate.ToString() })
                     .Where(c => c.Estado != Case_Estate.Solicitado.ToString()
                     && c.Estado != Case_Estate.Rechazado.ToString()
                     && c.Estado != Case_Estate.Finalizado.ToString()).ToList();
                }
                else
                {
                    return this.Get_WhereNotIN<CaseTable_Case>("Id_Case",
                     new string[] { inst.Id_Case.ToString() })
                     .Where(c => c.Estado != Case_Estate.Solicitado.ToString()
                     && c.Estado != Case_Estate.Rechazado.ToString()
                     && c.Estado != Case_Estate.Finalizado.ToString()).ToList();
                }
            }
            throw new Exception("no tienes permisos para vincular casos");
        }
        internal List<CaseTable_Case> GetVinculateCase(string? identity)
        {
            if (Id_Vinculate != null)
            {
                return GetOwCase(identity);
            }
            else
            {
                return new List<CaseTable_Case>();
            }
        }
        internal List<CaseTable_Case> GetSolicitudesPendientesAprobarAdmin(string? identity)
        {
            if (AuthNetCore.HavePermission(PermissionsEnum.ADMIN_ACCESS.ToString(), identity))
            {
                Estado = Case_Estate.Solicitado.ToString();
                return Get<CaseTable_Case>();
            }
            throw new Exception("no tienes permisos para aprobar casos");
        }
    }
}