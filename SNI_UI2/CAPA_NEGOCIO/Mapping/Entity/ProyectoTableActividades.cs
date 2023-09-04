using CAPA_DATOS;
using CAPA_NEGOCIO.MAPEO;
using CAPA_NEGOCIO.Security;
using CAPA_NEGOCIO.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using API.Controllers;
using AE.Net.Mail;
using System.Text.Json.Serialization;
using System.Net;
using System.Collections.Generic;
using System.Collections;

namespace CAPA_NEGOCIO.MAPEO
{
    public class CaseTable_Case : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? Id_Case { get; set; }
        public string? Titulo { get; set; }
        public string? Descripcion { get; set; }
        public string? Mail { get; set; }
        public int? Id_Perfil { get; set; }
        public string? Estado { get; set; }
        public int? Id_Dependencia { get; set; }
        public DateTime? Fecha_Inicial { get; set; }
        public DateTime? Fecha_Final { get; set; }
        public int? Id_Servicio { get; set; }
        public int? Id_Vinculate { get; set; }

        [ManyToOne(TableName = "Tbl_Profile", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
        public Tbl_Profile? Tbl_Profile { get; set; }
        [ManyToOne(TableName = "Cat_Dependencias", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
        public Cat_Dependencias? Cat_Dependencias { get; set; }
        [ManyToOne(TableName = "Tbl_Servicios", KeyColumn = "Id_Servicio", ForeignKeyColumn = "Id_Servicio")]
        public Tbl_Servicios? Tbl_Servicios { get; set; }
        [OneToMany(TableName = "CaseTable_Tareas", KeyColumn = "Id_Case", ForeignKeyColumn = "Id_Case")]
        public List<CaseTable_Tareas>? CaseTable_Tareas { get; set; }

        //[OneToMany(TableName = "CaseTable_Comments", KeyColumn = "Id_Case", ForeignKeyColumn = "Id_Case")]
        public List<CaseTable_Comments>? CaseTable_Comments { get; set; }

        public bool CreateAutomaticCase(MailMessage mail, Cat_Dependencias dependencia)
        {
            try
            {
                BeginGlobalTransaction();

                if (mail.Subject.ToUpper().Contains("RE:"))
                {
                    char[] MyChar = { 'R', 'E', ':', ' ' };
                    CaseTable_Case? findCase = new CaseTable_Case()
                    {
                        Titulo = mail.Subject.ToUpper().TrimStart(MyChar)
                    }.Find<CaseTable_Case>();
                    if (findCase != null)
                    {
                        new CaseTable_Mails(mail) { Id_Case = findCase.Id_Case }.Save();
                        new CaseTable_Comments()
                        {
                            Id_Case = findCase.Id_Case,
                            Body = mail.Body,
                            NickName = $"{mail.From.DisplayName} ({mail.From.Address})",
                            Fecha = mail.Date,
                            Estado = CommetsState.Pendiente.ToString(),
                            Mail = mail.From.Address
                        }.Save();
                    }
                }
                else
                {
                    Titulo = mail.Subject.ToUpper();
                    Descripcion = mail.Body;
                    Estado = Case_Estate.Solicitado.ToString();
                    Fecha_Inicial = mail.Date;
                    Id_Dependencia = dependencia.Id_Dependencia;
                    Mail = mail.From.Address;
                    Save();
                    new CaseTable_Mails(mail) { Id_Case = this.Id_Case }.Save();
                }
                CommitGlobalTransaction();
                return true;
            }
            catch (Exception)
            {
                Console.Write("error al guardar");
                RollBackGlobalTransaction();
                throw;
            }

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
             && AuthNetCore.HavePermission(PermissionsEnum.TECNICO_CASOS_DEPENDENCIA.ToString(), identity))
            {
                return getCaseByDependencia(identity, null)
                .Where(c => c.Estado != Case_Estate.Rechazado.ToString()
                && c.Estado != Case_Estate.Solicitado.ToString()
                && c.Estado != Case_Estate.Finalizado.ToString()).ToList();
            }
            throw new Exception("no tienes permisos para gestionar casos");
        }

        public List<CaseTable_Case> GetOwSolicitudes(string? identity, Case_Estate case_Estate)
        {
            return new CaseTable_Case()
            {
                Id_Perfil = AuthNetCore.User(identity).UserId,
                Estado = case_Estate.ToString()
            }.Get<CaseTable_Case>();
        }

        public List<CaseTable_Case> GetSolicitudesPendientesAprobar(string? identity, Case_Estate case_Estate)
        {
            if (AuthNetCore.HavePermission(PermissionsEnum.ADMINISTRAR_CASOS_DEPENDENCIA.ToString(), identity))
            {
                return getCaseByDependencia(identity, case_Estate);
            }
            throw new Exception("no tienes permisos para aprobar casos");
        }

        private static List<CaseTable_Case> getCaseByDependencia(string? identity, Case_Estate? case_Estate)
        {
            return new CaseTable_Case()
            {
                Estado = case_Estate?.ToString()
            }.Get_WhereIN<CaseTable_Case>("Id_Dependencia",
           new CaseTable_Dependencias_Usuarios() { Id_Perfil = AuthNetCore.User(identity).UserId }
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
            BeginGlobalTransaction();

            var response = Update();
            new CaseTable_Comments()
            {
                Id_Case = this.Id_Case,
                Body = $"El caso esta en estado: {this.Estado}, para mayor información consulte con nuestro equipo",
                NickName = $"{user.UserData.Nombres} ({user.mail})",
                Fecha = DateTime.Now,
                Estado = CommetsState.Pendiente.ToString(),
                Mail = user.mail
            }.Save();
            CommitGlobalTransaction();
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
    }

    public enum CommetsState
    {
        Leido, Pendiente
    }

    public class ModelFiles
    {
        public string? Name { get; set; }
        public string? Value { get; set; }
        public string? Type { get; set; }
    }

    public class CaseTable_Comments : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? Id_Comentario { get; set; }
        public string? Estado { get; set; }
        public string? NickName { get; set; }
        public string? Mail { get; set; }
        public string? Body { get; set; }
        [JsonProp]
        public List<ModelFiles>? Attach_Files { get; set; }
        public int? Id_Case { get; set; }
        public int? Id_User { get; set; }
        public DateTime? Fecha { get; set; }

        public object? SaveComment(string identity)
        {
            try
            {
                BeginGlobalTransaction();
                UserModel user = AuthNetCore.User(identity);
                Fecha = DateTime.Now;
                Id_User = user.UserId;
                NickName = user.UserData?.Nombres;
                Mail = user.mail;
                foreach (var file in Attach_Files)
                {
                    ModelFiles Response = (ModelFiles)FileService.upload("Attach\\", file).body;
                    file.Value = Response.Value;
                    file.Type = Response.Type;
                }
                Save();
                List<String?>? toMails = new List<string?>();
                CaseTable_Case? caseTable_Case = new CaseTable_Case() { Id_Case = Id_Case }.Find<CaseTable_Case>();
                if (caseTable_Case?.CaseTable_Comments != null)
                {
                    toMails.AddRange(caseTable_Case?.CaseTable_Comments?.Select(c => c.Mail).ToList());
                }
                toMails.Add(caseTable_Case?.Mail);
                new CaseTable_Mails()
                {
                    Id_Case = caseTable_Case?.Id_Case,
                    Subject = $"RE: " + caseTable_Case?.Titulo?.ToUpper(),
                    Body = Body,
                    From = user.mail,
                    Estado = MailState.PENDIENTE.ToString(),
                    Date = DateTime.Now,
                    ToAdress = toMails.Where(m => m != null && m != user.mail).ToList().Distinct().ToList()
                }.Save();

                CommitGlobalTransaction();
                return this;
            }
            catch (System.Exception)
            {
                RollBackGlobalTransaction();
                throw;
            }

        }

        internal List<CaseTable_Comments> GetComments()
        {
            CaseTable_Case caseTable_Case = new CaseTable_Case() { Id_Case = Id_Case }.Find<CaseTable_Case>();
            if (caseTable_Case?.Id_Vinculate != null)
            {
                return new CaseTable_Comments().Get_WhereIN<CaseTable_Comments>(
                    "Id_Case",
                    new CaseTable_Case() { Id_Vinculate = caseTable_Case.Id_Vinculate }
                    .Get<CaseTable_Case>().Select(c => c.Id_Case.ToString()).ToArray());
            }
            else
            {
                return Get<CaseTable_Comments>();
            }

        }
    }

    public enum Case_Estate
    {
        Solicitado, Pendiente, Activo, Finalizado, Espera, Rechazado
    }

    public class CaseTable_Mails : EntityClass
    {
        public CaseTable_Mails() { }
        public CaseTable_Mails(MailMessage mail)
        {
            Subject = mail.Subject;
            MessageID = mail.MessageID;
            Sender = mail.Sender?.Address;
            From = mail.From?.Address;
            ReplyTo = mail.ReplyTo?.Select(r => r.Address).ToList();
            Bcc = mail.Bcc?.Select(r => r.Address).ToList();
            Cc = mail.Cc?.Select(r => r.Address).ToList();
            ToAdress = mail.To?.Select(r => r.Address).ToList();
            Date = mail.Date;
            Uid = mail.Uid;
            Body = mail.Body;
            Estado = MailState.RECIBIDO.ToString();
            Flags = Flags?.ToString();
        }
        [PrimaryKey(Identity = true)]
        public int? Id_Mail { get; set; }
        public string? Subject { get; set; }
        public int? Id_Case { get; set; }
        public string? MessageID { get; set; }
        public string? Estado { get; set; }
        public string? Sender { get; set; }
        public string? Body { get; set; }
        public string? From { get; set; }
        [JsonProp]
        public List<String>? ReplyTo { get; set; }
        [JsonProp]
        public List<String>? Bcc { get; set; }
        [JsonProp]
        public List<String>? Cc { get; set; }
        [JsonProp]
        public List<String>? ToAdress { get; set; }
        [JsonProp]
        public List<ModelFiles> Attach_Files { get; set; }
        //public int? Size { get; set; }
        public String? Flags { get; set; }
        //public string[] RawFlags { get; set; }
        public DateTime? Date { get; set; }
        public string? Uid { get; set; }
        // [OneToOne(TableName = "CaseTable_Comments", KeyColumn = "Id_Mail", ForeignKeyColumn = "Id_Mail")]
        // public CaseTable_Comments? CaseTable_Comments  { get; set; }
    }

    public enum MailState
    {
        ENVIADO, PENDIENTE, RECIBIDO
    }
    public class Cat_Cargos_Dependencias : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? Id_Cargo { get; set; }
        public string? Descripcion { get; set; }
        [OneToMany(TableName = "CaseTable_Dependencias_Usuarios", KeyColumn = "Id_Cargo", ForeignKeyColumn = "Id_Cargo")]
        public List<CaseTable_Dependencias_Usuarios>? CaseTable_Dependencias_Usuarios { get; set; }
    }
    public class Cat_Dependencias : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? Id_Dependencia { get; set; }
        public string? Descripcion { get; set; }
        public string? Username { get; set; }
        public string? Password { get; set; }
        public string? Host { get; set; }
        public int? Id_Dependencia_Padre { get; set; }
        public int? Id_Institucion { get; set; }
        [ManyToOne(TableName = "Cat_Dependencias", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia_Padre")]
        public Cat_Dependencias? Cat_Dependencia { get; set; }
        [OneToMany(TableName = "Cat_Dependencias", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia_Padre")]
        public List<Cat_Dependencias>? Cat_Dependencias_Hijas { get; set; }
        //[OneToMany(TableName = "CaseTable_Case", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
        // public List<CaseTable_Case>? CaseTable_Case { get; set; }
        [OneToMany(TableName = "CaseTable_Agenda", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
        public List<CaseTable_Agenda>? CaseTable_Agenda { get; set; }
        [OneToMany(TableName = "CaseTable_Dependencias_Usuarios", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
        public List<CaseTable_Dependencias_Usuarios>? CaseTable_Dependencias_Usuarios { get; set; }
        public List<Cat_Dependencias> GetOwDependencies(string identity)
        {
            if (AuthNetCore.User(identity).isAdmin)
            {
                return new Cat_Dependencias().Get<Cat_Dependencias>();
            }
            CaseTable_Dependencias_Usuarios Inst = new CaseTable_Dependencias_Usuarios()
            {
                Id_Perfil = AuthNetCore.User(identity).UserId
            };
            return new Cat_Dependencias().Get_WhereIN<Cat_Dependencias>(
                "Id_Dependencia", Inst.Get<CaseTable_Dependencias_Usuarios>().Select(p => p.Id_Dependencia.ToString()).ToArray()
            );
        }

        internal List<Cat_Dependencias> GetDependencias<T>()
        {
            return new Cat_Dependencias().Get<Cat_Dependencias>().Select(m =>
            {
                m.Password = "PROTECTED";
                return m;
            }).ToList();
        }
    }
    public class Cat_Tipo_Participaciones : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? Id_Tipo_Participacion { get; set; }
        public string? Descripcion { get; set; }
        [OneToMany(TableName = "CaseTable_Participantes", KeyColumn = "Id_Tipo_Participacion", ForeignKeyColumn = "Id_Tipo_Participacion")]
        public List<CaseTable_Participantes>? CaseTable_Participantes { get; set; }
    }
    public class CaseTable_Agenda : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? IdAgenda { get; set; }
        public int? Id_Perfil { get; set; }
        public int? Id_Dependencia { get; set; }
        public string? Dia { get; set; }
        public string? Hora_Inicial { get; set; }
        public string? Hora_Final { get; set; }
        public DateTime? Fecha_Caducidad { get; set; }
        [ManyToOne(TableName = "Tbl_Profile", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
        public Tbl_Profile? Tbl_Profile { get; set; }
        [ManyToOne(TableName = "Cat_Dependencias", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
        public Cat_Dependencias? Cat_Dependencias { get; set; }
    }
    public class CaseTable_Dependencias_Usuarios : EntityClass
    {
        [PrimaryKey(Identity = false)]
        public int? Id_Perfil { get; set; }
        [PrimaryKey(Identity = false)]
        public int? Id_Dependencia { get; set; }
        public int? Id_Cargo { get; set; }
        [ManyToOne(TableName = "Tbl_Profile", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
        public Tbl_Profile? Tbl_Profile { get; set; }
        [ManyToOne(TableName = "Cat_Dependencias", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
        public Cat_Dependencias? Cat_Dependencias { get; set; }
        [ManyToOne(TableName = "Cat_Cargos_Dependencias", KeyColumn = "Id_Cargo", ForeignKeyColumn = "Id_Cargo")]
        public Cat_Cargos_Dependencias? Cat_Cargos_Dependencias { get; set; }
    }
    public class CaseTable_Evidencias : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? IdEvidencia { get; set; }
        public int? IdTipo { get; set; }
        public string? Data { get; set; }
        public int? Id_Tarea { get; set; }
        [ManyToOne(TableName = "CaseTable_Tareas", KeyColumn = "Id_Tarea", ForeignKeyColumn = "Id_Tarea")]
        public CaseTable_Tareas? CaseTable_Tareas { get; set; }
        [ManyToOne(TableName = "Cat_Tipo_Evidencia", KeyColumn = "IdTipo", ForeignKeyColumn = "IdTipo")]
        public Cat_Tipo_Evidencia? Cat_Tipo_Evidencia { get; set; }

    }


    public class CaseTable_Calendario : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? IdCalendario { get; set; }
        public int? Id_Tarea { get; set; }
        public int? Id_Dependencia { get; set; }
        public string? Estado { get; set; }
        public DateTime? Fecha_Inicial { get; set; }
        public DateTime? Fecha_Final { get; set; }
        [ManyToOne(TableName = "CaseTable_Tareas", KeyColumn = "Id_Tarea", ForeignKeyColumn = "Id_Tarea")]
        public CaseTable_Tareas? CaseTable_Tareas { get; set; }
        [ManyToOne(TableName = "Cat_Dependencias", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
        public Cat_Dependencias? Cat_Dependencias { get; set; }

    }
    public class CaseTable_Tareas : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? Id_Tarea { get; set; }
        public string? Titulo { get; set; }
        public int? Id_TareaPadre { get; set; }
        public int? Id_Case { get; set; }
        public string? Descripcion { get; set; }
        public DateTime? Fecha_Inicio { get; set; }
        public DateTime? Fecha_Finalizacion { get; set; }
        public string? Estado { get; set; }
        [ManyToOne(TableName = "CaseTable_Tareas", KeyColumn = "Id_Tarea", ForeignKeyColumn = "Id_TareaPadre")]
        public CaseTable_Tareas? CaseTable_Tarea { get; set; }
        [ManyToOne(TableName = "CaseTable_Case", KeyColumn = "Id_Case", ForeignKeyColumn = "Id_Case")]
        public CaseTable_Case? CaseTable_Case { get; set; }
        [OneToMany(TableName = "CaseTable_Calendario", KeyColumn = "Id_Tarea", ForeignKeyColumn = "Id_Tarea")]
        public List<CaseTable_Calendario>? CaseTable_Calendario { get; set; }
        [OneToMany(TableName = "CaseTable_Evidencias", KeyColumn = "Id_Tarea", ForeignKeyColumn = "Id_Tarea")]
        public List<CaseTable_Evidencias>? CaseTable_Evidencias { get; set; }
        [OneToMany(TableName = "CaseTable_Participantes", KeyColumn = "Id_Tarea", ForeignKeyColumn = "Id_Tarea")]
        public List<CaseTable_Participantes>? CaseTable_Participantes { get; set; }
        [OneToMany(TableName = "CaseTable_Tareas", KeyColumn = "Id_Tarea", ForeignKeyColumn = "Id_TareaPadre")]
        public List<CaseTable_Tareas>? CaseTable_TareasHijas { get; set; }
        public List<CaseTable_Tareas> GetOwParticipations(string identity)
        {
            CaseTable_Participantes Inst = new CaseTable_Participantes();
            Inst.Id_Perfil = AuthNetCore.User(identity).UserId;
            return new CaseTable_Tareas().Get_WhereIN<CaseTable_Tareas>(
                "Id_Tarea", Inst.Get<CaseTable_Participantes>().Select(p => p.Id_Tarea.ToString()).ToArray()
            );
        }

        public object? UpdateTarea()
        {
            //"Activo", "Proceso", "Finalizado", "Espera", "Inactivo"
            if (Estado == "Proceso" && Fecha_Inicio == null)
            {
                Fecha_Inicio = DateTime.Now;
            }
            if (Estado == "Finalizado")
            {
                if (Fecha_Inicio == null)
                {
                    Fecha_Inicio = DateTime.Now;
                }
                Fecha_Finalizacion = DateTime.Now;
            }
            return Update();
        }

        internal object? SaveTarea()
        {
            List<DateTime?> fechasIniciales = this.CaseTable_Calendario.Select(c => c.Fecha_Inicial).ToList();
            List<DateTime?> fechasFinales = this.CaseTable_Calendario.Select(c => c.Fecha_Inicial).ToList();
            Fecha_Inicio = fechasIniciales.Min();
            Fecha_Finalizacion = fechasFinales.Max();
            return this.Save();
        }
    }
    public class CaseTable_Participantes : EntityClass
    {
        [PrimaryKey(Identity = false)]
        public int? Id_Perfil { get; set; }
        [PrimaryKey(Identity = false)]
        public int? Id_Tarea { get; set; }
        public int? Id_Tipo_Participacion { get; set; }
        [ManyToOne(TableName = "Tbl_Profile", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
        public Tbl_Profile? Tbl_Profile { get; set; }
        [ManyToOne(TableName = "CaseTable_Tareas", KeyColumn = "Id_Tarea", ForeignKeyColumn = "Id_Tarea")]
        public CaseTable_Tareas? CaseTable_Tareas { get; set; }
        [ManyToOne(TableName = "Cat_Tipo_Participaciones", KeyColumn = "Id_Tipo_Participacion", ForeignKeyColumn = "Id_Tipo_Participacion")]
        public Cat_Tipo_Participaciones? Cat_Tipo_Participaciones { get; set; }
    }
}
