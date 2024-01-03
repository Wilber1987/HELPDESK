using CAPA_DATOS;
using API.Controllers;
using CAPA_DATOS.Services;
using MimeKit;

namespace CAPA_NEGOCIO.MAPEO
{

    public enum CommetsState
    {
        Leido, Pendiente
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

        public object? SaveComment(string identity, Boolean withMail = true )
        {
            try
            {
                BeginGlobalTransaction();
                UserModel user = AuthNetCore.User(identity);
                Fecha = DateTime.Now;
                Id_User = user.UserId;
                NickName = user.UserData?.Nombres;
                Mail = user.mail;
                foreach (var file in Attach_Files ?? new List<ModelFiles>())
                {
                    ModelFiles Response = (ModelFiles)FileService.upload("Attach\\", file).body;
                    file.Value = Response.Value;
                    file.Type = Response.Type;
                }
                Save();
                if (withMail)
                {
                       CreateMailForComment(user);
                }

             

                CommitGlobalTransaction();
                return this;
            }
            catch (System.Exception)
            {
                RollBackGlobalTransaction();
                throw;
            }

        }

        public void CreateMailForComment(UserModel user)
        {
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
                FromAdress = user.mail,
                Estado = MailState.PENDIENTE.ToString(),
                Date = DateTime.Now,
                Attach_Files = Attach_Files,
                ToAdress = toMails.Where(m => m != null && m != user.mail).ToList().Distinct().ToList()
            }.Save();
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
        internal List<CaseTable_Comments> GetOwComments(List<CaseTable_Case> caseTables)
        {
            return new CaseTable_Comments().Get_WhereIN<CaseTable_Comments>(
                "Id_Case", caseTables.Select(c => c.Id_Case.ToString()).ToArray());

        }
    }

    public class CaseTable_Comments_Tasks : CaseTable_Comments
    {
        public int? Id_Tarea { get; set; }
        internal List<CaseTable_Comments_Tasks> GetOwComments(List<CaseTable_Tareas> caseTables)
        {
            return new CaseTable_Comments_Tasks().Get_WhereIN<CaseTable_Comments_Tasks>(
                "Id_Tarea", caseTables.Select(c => c.Id_Tarea.ToString()).ToArray());
        }
        internal new List<CaseTable_Comments_Tasks> GetComments()
        {
            return Get<CaseTable_Comments_Tasks>();
        }
    }

    public enum Case_Estate
    {
        Solicitado, Pendiente, Activo, Finalizado, Espera, Rechazado, Vinculado
    }

    public class CaseTable_Mails : EntityClass
    {
        public CaseTable_Mails() { }
        public CaseTable_Mails(MimeMessage mail)
        {
            Subject = mail.Subject;
            MessageID = mail.MessageId;
            Sender = mail.Sender?.Address;
            FromAdress = mail.From.ToString();
            ReplyTo = mail.ReplyTo?.Select(r => r.ToString()).ToList();
            Bcc = mail.Bcc?.Select(r => r.ToString()).ToList();
            Cc = mail.Cc?.Select(r => r.ToString()).ToList();
            ToAdress = mail.To?.Select(r => r.ToString()).ToList();
            Date = mail.Date.DateTime;
            Uid = mail.MessageId;
            Body = mail.HtmlBody;
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
        public string? FromAdress { get; set; }
        [JsonProp]
        public List<String>? ReplyTo { get; set; }
        [JsonProp]
        public List<String>? Bcc { get; set; }
        [JsonProp]
        public List<String>? Cc { get; set; }
        [JsonProp]
        public List<String>? ToAdress { get; set; }
        [JsonProp]
        public List<ModelFiles>? Attach_Files { get; set; }
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
        public DateTime? Fecha_Inicio { get; set; }
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
        public DateTime? Fecha_Finalizacion_Proceso { get; private set; }
        public DateTime? Fecha_Inicio_Proceso { get; private set; }

        public List<CaseTable_Tareas> GetOwParticipations(string identity)
        {


            Tbl_Profile? profile = new Tbl_Profile() { IdUser = AuthNetCore.User(identity).UserId }.Find<Tbl_Profile>();
            CaseTable_Participantes Inst = new CaseTable_Participantes() { Id_Perfil = profile?.Id_Perfil };
            return new CaseTable_Tareas().Get_WhereIN<CaseTable_Tareas>(
                "Id_Tarea", Inst.Get<CaseTable_Participantes>().Select(p => p.Id_Tarea.ToString()).ToArray()
            );
        }

        public object? UpdateTarea()
        {
            //"Activo", "Proceso", "Finalizado", "Espera", "Inactivo"
            if (Estado == TareasState.Proceso.ToString() && Fecha_Inicio == null)
            {
                Fecha_Inicio_Proceso = DateTime.Now;
            }
            if (Estado == TareasState.Finalizado.ToString())
            {
                if (Fecha_Inicio_Proceso == null)
                {
                    Fecha_Inicio_Proceso = DateTime.Now;
                }
                Fecha_Finalizacion_Proceso = DateTime.Now;
            }
            return Update();
        }

        internal void NotificarTecnicos(CaseTable_Case caseTable_Case, UserModel user)
        {
            foreach (var participante in CaseTable_Participantes)
            {
                List<String?>? toMails = new List<string?>();
                toMails.Add(participante.Tbl_Profile.Correo_institucional);
                new CaseTable_Mails()
                {
                    Id_Case = caseTable_Case?.Id_Case,
                    Subject = $"TAREA ASIGNADA: - {Titulo} ",
                    Body = $"TAREA ASIGNADA: {Titulo} - ROL: {participante.Cat_Tipo_Participaciones.Descripcion} - CASO:  {caseTable_Case?.Titulo?.ToUpper()}" + Descripcion,
                    FromAdress = user.mail,
                    Estado = MailState.PENDIENTE.ToString(),
                    Date = DateTime.Now,
                    Attach_Files = null,
                    ToAdress = toMails.Where(m => m != null && m != user.mail).ToList().Distinct().ToList()
                }.Save();
            }
        }

        internal object? SaveTarea(string identity)
        {
            try
            {
                var user = AuthNetCore.User(identity);
                BeginGlobalTransaction();
                List<DateTime?> fechasIniciales = this.CaseTable_Calendario.Select(c => c.Fecha_Inicio).ToList();
                List<DateTime?> fechasFinales = this.CaseTable_Calendario.Select(c => c.Fecha_Inicio).ToList();
                Fecha_Inicio = fechasIniciales.Min();
                Fecha_Finalizacion = fechasFinales.Max();
                var comment = new CaseTable_Comments()
                {
                    Id_Case = this.Id_Case,
                    Body = $"Se a creado una nueva tarea: {this.Descripcion}",
                    NickName = $"{user.UserData.Nombres} ({user.mail})",
                    Fecha = DateTime.Now,
                    Estado = CommetsState.Pendiente.ToString(),
                    Mail = user.mail
                };
                comment.Save();
                comment.CreateMailForComment(user);
                var response = this.Save();
                CommitGlobalTransaction();
                return response;
            }
            catch (System.Exception)
            {
                RollBackGlobalTransaction();
                throw;
            }

        }
    }
    enum TareasState
    {
        Activo, Proceso, Finalizado, Espera, Inactivo
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
