using CAPA_DATOS;
using CAPA_NEGOCIO.Services;
using API.Controllers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CAPA_DATOS.Security;
using CAPA_DATOS.Services;

namespace CAPA_NEGOCIO.MAPEO
{

    public class Cat_Tipo_Evidencia : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? IdTipo { get; set; }
        public string? Descripcion { get; set; }
        public string? Estado { get; set; }

    }


    public class Cat_Paises : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? Id_Pais { get; set; }
        public string? Estado { get; set; }
        public string? Descripcion { get; set; }
    }
    public class Security_Users : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? Id_User { get; set; }
        public string? Nombres { get; set; }
        public string? Estado { get; set; }
        public string? Descripcion { get; set; }
        public string? Password { get; set; }
        public string? Mail { get; set; }
        public string? Token { get; set; }
        public DateTime? Token_Date { get; set; }
        public DateTime? Token_Expiration_Date { get; set; }
        [OneToMany(TableName = "Security_Users_Roles", KeyColumn = "Id_User", ForeignKeyColumn = "Id_User")]
        public List<Security_Users_Roles>? Security_Users_Roles { get; set; }
        [ManyToOne(TableName = "Tbl_Profile", KeyColumn = "IdUser", ForeignKeyColumn = "Id_User")]
        public Tbl_Profile? Tbl_Profile { get; set; }

        public Security_Users? GetUserData()
        {
            Security_Users? user = this.Find<Security_Users>();
            if (user != null && user.Estado == "ACTIVO")
            {
                user.Security_Users_Roles = new Security_Users_Roles()
                {
                    Id_User = user.Id_User
                }.Get<Security_Users_Roles>();
                foreach (Security_Users_Roles role in user.Security_Users_Roles ?? new List<Security_Users_Roles>())
                {
                    role.Security_Role?.GetRolData();
                }
                return user;
            }
            if (user?.Estado == "INACTIVO")
            {
                throw new Exception("usuario inactivo");
            }
            return null;
        }

        public new object SaveUser(string identity)
        {
            if (!AuthNetCore.HavePermission(PermissionsEnum.ADMINISTRAR_USUARIOS.ToString(), identity))
            {
                throw new Exception("no tiene permisos");
            }
            try
            {
                this.BeginGlobalTransaction();
                if (this.Password != null)
                {
                    this.Password = EncrypterServices.Encrypt(this.Password);
                }
                if (this.Id_User == null)
                {
                    if (new Security_Users() { Mail = this.Mail }.Exists<Security_Users>())
                    {
                        throw new Exception("Correo en uso");
                    }
                    Save();
                    if (Tbl_Profile != null)
                    {
                        var pic = (ModelFiles)FileService.upload("profiles\\", new ModelFiles
                        {
                            Value = Tbl_Profile.Foto,
                            Type = "png",
                            Name = "profile"
                        }).body;
                        Tbl_Profile.Foto = pic?.Value?.Replace("wwwroot", "");
                        Tbl_Profile.IdUser = Id_User;
                        //Tbl_Profile.Save();
                        Tbl_Profile?.SaveDependenciesAndservices();
                    }
                    else
                    {
                        Tbl_Profile = new Tbl_Profile()
                        {
                            Nombres = this.Nombres,
                            Estado = this.Estado,
                            Correo_institucional = this.Mail,
                            Foto = "\\Media\\profiles\\avatar.png",
                            IdUser = Id_User
                        };
                        Tbl_Profile.Save();
                    }

                }
                else
                {
                    if (this.Estado == null)
                    {
                        this.Estado = "ACTIVO";
                    }
                    if (Tbl_Profile != null)
                    {
                        if (Tbl_Profile.Id_Perfil == null)
                        {
                            Tbl_Profile.IdUser = Id_User;
                            Tbl_Profile.Save();
                        }
                        else
                        {
                            Tbl_Profile.Update();
                        }
                        Tbl_Profile?.SaveDependenciesAndservices();
                    }
                    this.Update("Id_User");
                }
                if (this.Security_Users_Roles != null)
                {
                    Security_Users_Roles IdI = new Security_Users_Roles();
                    IdI.Id_User = this.Id_User;
                    IdI.Delete();
                    foreach (Security_Users_Roles obj in this.Security_Users_Roles)
                    {
                        obj.Id_User = this.Id_User;
                        obj.Save();
                    }
                }
                this.CommitGlobalTransaction();
                return this;
            }
            catch (System.Exception)
            {
                this.RollBackGlobalTransaction();
                throw;
            }

        }


        public object GetUsers()
        {
            var Security_Users_List = this.Get<Security_Users>();
            foreach (Security_Users User in Security_Users_List)
            {
                User.Password = null;
                User.Tbl_Profile = User.Tbl_Profile?.Find<Tbl_Profile>();
            }
            return Security_Users_List;
        }
        internal bool IsAdmin()
        {
            return Security_Users_Roles?.Find(r => r.Security_Role?.Security_Permissions_Roles?.Find(p =>
             p.Security_Permissions.Descripcion.Equals(PermissionsEnum.ADMIN_ACCESS.ToString())
            ) != null) != null;
        }
        internal object RecoveryPassword()
        {
            Security_Users? user = this.Find<Security_Users>();
            if (user != null && user.Estado == "ACTIVO")
            {
                string password = Guid.NewGuid().ToString();
                user.Password = EncrypterServices.Encrypt(password);
                user.Update();
                _ = SMTPMailServices.SendMail("heldesk@password.recovery",
                 new List<string> { user.Mail },
                 "Recuperación de contraseña",
                 $"nueva contraseña: {password}", null, null);
                return user;
            }
            if (user?.Estado == "INACTIVO")
            {
                throw new Exception("usuario inactivo");
            }
            return null;
        }

        public object? changePassword(string? identfy)
        {
            var security_User = AuthNetCore.User(identfy).UserData;
            Password = EncrypterServices.Encrypt(Password);
            Id_User = security_User?.Id_User;
            return Update();
        }
    }

    public class Tbl_Profile : EntityClass
    {
        public static Tbl_Profile? GetUserProfile(string identity){
             return new Tbl_Profile() { IdUser = AuthNetCore.User(identity).UserId }.Find<Tbl_Profile>();
        }
        [PrimaryKey(Identity = true)]
        public int? Id_Perfil { get; set; }
        public string? Nombres { get; set; }
        public string? Apellidos { get; set; }
        public DateTime? FechaNac { get; set; }
        public int? IdUser { get; set; }
        public string? Sexo { get; set; }
        public string? Foto { get; set; }
        public string? DNI { get; set; }
        public string? Correo_institucional { get; set; }
        public int? Id_Pais_Origen { get; set; }
        public int? Id_Institucion { get; set; }
        public string? Indice_H { get; set; }
        public string? Estado { get; set; }
        //[ManyToOne(TableName = "Security_Users", KeyColumn = "Id_User", ForeignKeyColumn = "IdUser")]
        public Security_Users? Security_Users { get; set; }
        //[ManyToOne(TableName = "Cat_Paises", KeyColumn = "Id_Pais", ForeignKeyColumn = "Id_Pais_Origen")]
        public Cat_Paises? Cat_Paises { get; set; }
        //[OneToMany(TableName = "CaseTable_Case", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
        public List<CaseTable_Case>? CaseTable_Case { get; set; }
        //[OneToMany(TableName = "CaseTable_Agenda", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
        public List<CaseTable_Agenda>? CaseTable_Agenda { get; set; }
        [OneToMany(TableName = "CaseTable_Dependencias_Usuarios", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
        public List<CaseTable_Dependencias_Usuarios>? CaseTable_Dependencias_Usuarios { get; set; }

        [OneToMany(TableName = "Tbl_Servicios_Profile", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
        public List<Tbl_Servicios_Profile>? Tbl_Servicios_Profile { get; set; }
        //[OneToMany(TableName = "CaseTable_Participantes", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
        public List<CaseTable_Participantes>? CaseTable_Participantes { get; set; }
        public void SaveDependenciesAndservices()
        {
            if (this.Id_Perfil != null && this.CaseTable_Dependencias_Usuarios?.Count > 0
             && this.Tbl_Servicios_Profile?.Count > 0)
            {
                new CaseTable_Dependencias_Usuarios { Id_Perfil = this.Id_Perfil }.Delete();
                new Tbl_Servicios_Profile { Id_Perfil = this.Id_Perfil }.Delete();
            }
            this.CaseTable_Dependencias_Usuarios?.ForEach(du =>
            {
                du.Id_Perfil = this.Id_Perfil;
                du.Save();
            });
            this.Tbl_Servicios_Profile?.ForEach(du =>
            {
                du.Id_Perfil = this.Id_Perfil;
                du.Save();
            });
        }

        public List<CaseTable_Dependencias_Usuarios> TakeDepCoordinaciones()
        {
            CaseTable_Dependencias_Usuarios DU = new CaseTable_Dependencias_Usuarios();
            DU.Id_Perfil = this.Id_Perfil;
            return DU.Get_WhereIN<CaseTable_Dependencias_Usuarios>("Id_Cargo", new string[] { "1", "2" });
        }
        public Object? TakeProfile()
        {
            try
            {
                return this.Find<Tbl_Profile>();
            }
            catch (Exception)
            {

                throw;
            }
        }
        public Object Postularse()
        {
            try
            {
                this.Estado = "POSTULANTE";
                SaveProfile();
                return true;
            }
            catch (Exception) { return false; }

        }
        public Object SaveProfile()
        {
            try
            {
                BeginGlobalTransaction();
                if (Foto != null)
                {
                    var pic = (ModelFiles)FileService.upload("profiles\\", new ModelFiles
                    {
                        Value = Foto,
                        Type = "png",
                        Name = "profile"
                    }).body;
                    Foto = pic.Value.Replace("wwwroot", "");

                }
                if (this.Id_Perfil == null)
                {
                    this.Save();
                }
                else
                {
                    Correo_institucional = null;
                    IdUser = null;
                    if (CaseTable_Dependencias_Usuarios != null)
                    {
                        new CaseTable_Dependencias_Usuarios() { Id_Perfil = Id_Perfil }.Delete();
                        // foreach (var item in CaseTable_Dependencias_Usuarios)
                        // {
                        //     item.Id_Perfil = Id_Perfil;
                        //     item.Save();
                        // }

                    }
                    this.Update();
                }
                SaveDependenciesAndservices();
                CommitGlobalTransaction();
                return this;

            }
            catch (System.Exception)
            {
                RollBackGlobalTransaction();
                throw;
            }


        }
        public Object AdmitirPostulante()
        {
            try
            {
                // new Security_Users()
                // {
                //     Mail = this.Correo_institucional,
                //     Nombres = this.Nombres + " " + this.Apellidos,
                //     Estado = "Activo",
                //     Descripcion = "Investigador postulado",
                //     Password = Guid.NewGuid().ToString(),
                //     Token = Guid.NewGuid().ToString(),
                //     Token_Date = DateTime.Now,
                //     Token_Expiration_Date = DateTime.Now.AddMonths(6),
                //     Security_Users_Roles = new List<Security_Users_Roles>(){
                //         new Security_Users_Roles() { Id_Role = 2 }
                //     }
                // }.SaveUser();
                // this.Estado = "ACTIVO";
                // this.Update("Id_Perfil");
                //MailServices.SendMail(this.Correo_institucional);
                return true;
            }
            catch (Exception) { return false; }
        }

        internal List<Tbl_Profile> GetProfiles()
        {
            var profiles = Get<Tbl_Profile>();
            foreach (var profile in profiles)
            {
                foreach (var dep in profile.CaseTable_Dependencias_Usuarios ?? new List<CaseTable_Dependencias_Usuarios>())
                {
                    dep.Cat_Dependencias.Password = "PROTECTED";
                }
            }
            return profiles;
        }
    }

    public class Tbl_Servicios_Profile : EntityClass
    {
        [PrimaryKey(Identity = false)]
        public int? Id_Perfil { get; set; }

        [PrimaryKey(Identity = false)]
        public int? Id_Servicio { get; set; }

        [ManyToOne(TableName = "Tbl_Profile", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
        public Tbl_Profile? Tbl_Profile { get; set; }

        [ManyToOne(TableName = "Tbl_Servicios", KeyColumn = "Id_Servicio", ForeignKeyColumn = "Id_Servicio")]
        public Tbl_Servicios? Tbl_Servicios { get; set; }
    }
    public class Tbl_Profile_CasosAsignados : EntityClass
    {
        [PrimaryKey(Identity = false)]
        public int? Id_Perfil { get; set; }

        [PrimaryKey(Identity = false)]
        public int? Id_Case { get; set; }
        public DateTime? Fecha { get; set; }

        [ManyToOne(TableName = "Tbl_Profile", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
        public Tbl_Profile? Tbl_Profile { get; set; }

        [ManyToOne(TableName = "CaseTable_Case", KeyColumn = "Id_Case", ForeignKeyColumn = "Id_Case")]
        public CaseTable_Case? CaseTable_Case { get; set; }
    }

    public class Cat_Tipo_Servicio : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? Id_Tipo_Servicio { get; set; }
        public string? Descripcion { get; set; }
        public string? Estado { get; set; }
        public string? Icon { get; set; }
        //[OneToMany(TableName = "Tbl_Servicios", KeyColumn = "Id_Tipo_Servicio", ForeignKeyColumn = "Id_Tipo_Servicio")]
        public List<Tbl_Servicios>? Tbl_Servicios { get; set; }
    }
    public class Tbl_Servicios : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? Id_Servicio { get; set; }
        public string? Nombre_Proyecto { get; set; }
        public string? Descripcion_Servicio { get; set; }
        public int? Id_Tipo_Servicio { get; set; }
        public string? Visibilidad { get; set; }
        public string? Estado { get; set; }
        public DateTime? Fecha_Inicio { get; set; }
        public int? Id_Dependencia { get; set; }
        public DateTime? Fecha_Finalizacion { get; set; }
        [ManyToOne(TableName = "Cat_Tipo_Servicio", KeyColumn = "Id_Tipo_Servicio", ForeignKeyColumn = "Id_Tipo_Servicio")]
        public Cat_Tipo_Servicio? Cat_Tipo_Servicio { get; set; }
        [ManyToOne(TableName = "Cat_Dependencias", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
        public Cat_Dependencias? Cat_Dependencias { get; set; }

    }

    public class CaseTable_VinculateCase : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? Id_Vinculate { get; set; }
        public string? Descripcion { get; set; }
        public DateTime? Fecha { get; set; }
        [OneToMany(TableName = "CaseTable_Case", KeyColumn = "Id_Vinculate", ForeignKeyColumn = "Id_Vinculate")]
        public List<CaseTable_Case>? Casos_Vinculados { get; set; }

        internal object DesvincularCaso(CaseTable_Case caseDV)
        {
            try
            {
                BeginGlobalTransaction();
                List<CaseTable_Case> caseTable_Cases = new CaseTable_Case()
                { Id_Vinculate = caseDV.Id_Vinculate }.Get<CaseTable_Case>();
                if (caseTable_Cases.Count == 2)
                {
                    foreach (var item in caseTable_Cases)
                    {
                        if (item.Id_Case != caseDV.Id_Case)
                        {
                            desvicular(item);
                        }
                    }
                    this.Id_Vinculate = caseDV.Id_Vinculate;
                    Delete();
                }
                object? response = desvicular(caseDV);
                CommitGlobalTransaction();
                return response;
            }
            catch (System.Exception)
            {
                RollBackGlobalTransaction();
                throw;
            }
        }

        private static object? desvicular(CaseTable_Case caseDV)
        {
            caseDV.Id_Vinculate = null;
            caseDV.Estado = Case_Estate.Activo.ToString();
            var response = caseDV.Update();
            return response;
        }

        internal object? VincularCaso()
        {
            try
            {
                BeginGlobalTransaction();
                Fecha = DateTime.Now;
                CaseTable_Case caseV = Casos_Vinculados.FirstOrDefault(c => c.Id_Vinculate != null);
                if (caseV != null)
                {
                    Id_Vinculate = caseV.Id_Vinculate;
                    List<CaseTable_Case> oldCase = new CaseTable_Case() { Id_Vinculate = caseV.Id_Vinculate }.Get<CaseTable_Case>();
                    foreach (var c in oldCase)
                    {
                        CaseTable_Case caseSelected = Casos_Vinculados.FirstOrDefault(cv => cv.Id_Case == c.Id_Case);
                        if (caseSelected == null)
                        {
                            Casos_Vinculados.Add(c);
                        }
                    }
                    foreach (var c in Casos_Vinculados)
                    {
                        c.Id_Vinculate = Id_Vinculate;
                    }

                }
                Descripcion = $"Vinculación de casos: {string.Join(", ", Casos_Vinculados.Select(c => "#" + c.Id_Case).ToList())}";
                int? caseFatherId = Casos_Vinculados.Where(x => x.Id_Case != null).ToList().Select(x => x.Id_Case).ToList().Min();
                foreach (var caseIten in Casos_Vinculados)
                {
                    if (caseIten.Id_Case != caseFatherId)
                    {
                        caseIten.Estado = Case_Estate.Vinculado.ToString();
                    }

                }
                if (caseV != null)
                {
                    var response = Update();
                    CommitGlobalTransaction();
                    return response;
                }
                else
                {
                    var response = Save();
                    CommitGlobalTransaction();
                    return response;
                }
            }
            catch (System.Exception)
            {
                RollBackGlobalTransaction();
                throw;
            }

        }
    }
}
