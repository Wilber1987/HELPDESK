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

    public class Tbl_Profile : EntityClass
    {
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
        //[OneToMany(TableName = "CaseTable_Dependencias_Usuarios", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
        public List<CaseTable_Dependencias_Usuarios>? CaseTable_Dependencias_Usuarios { get; set; }
        //[OneToMany(TableName = "CaseTable_Participantes", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
        public List<CaseTable_Participantes>? CaseTable_Participantes { get; set; }

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
                this.Id_Perfil = (Int32?)this.Save();
            }
            else
            {
                Correo_institucional = null;
                IdUser = null;
                this.Update("Id_Perfil");
            }

            return this;
        }
        public Object AdmitirPostulante()
        {
            try
            {
                new Security_Users()
                {
                    Mail = this.Correo_institucional,
                    Nombres = this.Nombres + " " + this.Apellidos,
                    Estado = "Activo",
                    Descripcion = "Investigador postulado",
                    Password = Guid.NewGuid().ToString(),
                    Token = Guid.NewGuid().ToString(),
                    Token_Date = DateTime.Now,
                    Token_Expiration_Date = DateTime.Now.AddMonths(6),
                    Security_Users_Roles = new List<Security_Users_Roles>(){
                        new Security_Users_Roles() { Id_Role = 2 }
                    }
                }.SaveUser();
                this.Estado = "ACTIVO";
                this.Update("Id_Perfil");
                //MailServices.SendMail(this.Correo_institucional);
                return true;
            }
            catch (Exception) { return false; }
        }
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
