using CAPA_DATOS;
using CAPA_NEGOCIO.Security;
using CAPA_NEGOCIO.Services;
using API.Controllers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace CAPA_NEGOCIO.MAPEO
{
   
    public class CatalogoTipoEvidencia : EntityClass
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
        //[OneToMany(TableName = "Cat_Localidad", KeyColumn = "Id_Pais", ForeignKeyColumn = "Id_Pais")]
        // [OneToMany(TableName = "Tbl_Evento", KeyColumn = "Id_Pais", ForeignKeyColumn = "Id_Pais")]
        // public List<Tbl_Evento>? Tbl_Evento { get; set; }
        // [OneToMany(TableName = "Tbl_Profile", KeyColumn = "Id_Pais", ForeignKeyColumn = "Id_Pais_Origen")]
        // public List<Tbl_Profile>? Tbl_Profile { get; set; }
    }
   
    public class Cat_instituciones : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? Id_Institucion { get; set; }
        public string? Nombre { get; set; }
        public string? Direccion { get; set; }
        public string? Estado { get; set; }
        public string? Logo { get; set; }
    }
    public class Cat_Tipo_Investigacion : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? Id_Tipo_Investigacion { get; set; }
        public string? Descripcion { get; set; }
        public string? Estado { get; set; }
        // [OneToMany(TableName = "Tbl_Investigaciones", KeyColumn = "Id_Tipo_Investigacion", ForeignKeyColumn = "Id_Tipo_Investigacion")]
        // public List<Tbl_Investigaciones>? Tbl_Investigaciones { get; set; }
    }
    public class Tbl_Profile : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? Id_Investigador { get; set; }
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
        [ManyToOne(TableName = "Security_Users", KeyColumn = "Id_User", ForeignKeyColumn = "IdUser")]
        public Security_Users? Security_Users { get; set; }
        [ManyToOne(TableName = "Cat_Paises", KeyColumn = "Id_Pais", ForeignKeyColumn = "Id_Pais_Origen")]
        public Cat_Paises? Cat_Paises { get; set; }
        [ManyToOne(TableName = "Cat_instituciones", KeyColumn = "Id_Institucion", ForeignKeyColumn = "Id_Institucion")]
        public Cat_instituciones? Cat_instituciones { get; set; }
        [OneToMany(TableName = "ProyectoTableActividades", KeyColumn = "Id_Investigador", ForeignKeyColumn = "Id_Investigador")]
        public List<ProyectoTableActividades>? ProyectoTableActividades { get; set; }
        [OneToMany(TableName = "ProyectoTableAgenda", KeyColumn = "Id_Investigador", ForeignKeyColumn = "Id_Investigador")]
        public List<ProyectoTableAgenda>? ProyectoTableAgenda { get; set; }
        [OneToMany(TableName = "ProyectoTableDependencias_Usuarios", KeyColumn = "Id_Investigador", ForeignKeyColumn = "Id_Investigador")]
        public List<ProyectoTableDependencias_Usuarios>? ProyectoTableDependencias_Usuarios { get; set; }
        [OneToMany(TableName = "ProyectoTableParticipantes", KeyColumn = "Id_Investigador", ForeignKeyColumn = "Id_Investigador")]
        public List<ProyectoTableParticipantes>? ProyectoTableParticipantes { get; set; }
        
        public List<Tbl_Participantes_Proyectos>? Tbl_Participantes_Proyectos { get; set; }

        public List<ProyectoTableDependencias_Usuarios> TakeDepCoordinaciones()
        {
            ProyectoTableDependencias_Usuarios DU = new ProyectoTableDependencias_Usuarios();
            DU.Id_Investigador = this.Id_Investigador;
            return DU.Get_WhereIN<ProyectoTableDependencias_Usuarios>("Id_Cargo", new string[] { "1", "2" });
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
            if (this.Id_Investigador == null)
            {
                this.Id_Investigador = (Int32?)this.Save();
            }
            else
            {
                this.Update("Id_Investigador");
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
                this.Update("Id_Investigador");
                //MailServices.SendMail(this.Correo_institucional);
                return true;
            }
            catch (Exception) { return false; }
        }
    }
    public class Cat_Tipo_Asociacion : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? Id_Tipo_Asociacion { get; set; }
        public string? Descripcion { get; set; }
        public string? Estado { get; set; }
        //[OneToMany(TableName = "Tbl_Instituciones_Asociadas", KeyColumn = "Id_Tipo_Asociacion", ForeignKeyColumn = "Id_Tipo_Asociacion")]
        public List<Tbl_Instituciones_Asociadas>? Tbl_Instituciones_Asociadas { get; set; }
    }
    public class Tbl_Instituciones_Asociadas : EntityClass
    {
        [PrimaryKey(Identity = false)]
        public int? Id_Institucion { get; set; }
        [PrimaryKey(Identity = false)]
        public int? Id_Proyecto { get; set; }
        public int? Id_Tipo_Asociacion { get; set; }
        public DateTime? Fecha_Ingreso { get; set; }
        public string? Estado { get; set; }
        [ManyToOne(TableName = "Cat_instituciones", KeyColumn = "Id_Institucion", ForeignKeyColumn = "Id_Institucion")]
        public Cat_instituciones? Cat_instituciones { get; set; }
        [ManyToOne(TableName = "Tbl_Proyectos", KeyColumn = "Id_Proyecto", ForeignKeyColumn = "Id_Proyecto")]
        public Tbl_Proyectos? Tbl_Proyectos { get; set; }
        [ManyToOne(TableName = "Cat_Tipo_Asociacion", KeyColumn = "Id_Tipo_Asociacion", ForeignKeyColumn = "Id_Tipo_Asociacion")]
        public Cat_Tipo_Asociacion? Cat_Tipo_Asociacion { get; set; }
    }

    public class Cat_Tipo_Proyecto : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? Id_Tipo_Proyecto { get; set; }
        public string? Descripcion_Tipo_Proyecto { get; set; }
        public string? Estado_Tipo_Proyecto { get; set; }
        public string? Icon { get; set; }
        //[OneToMany(TableName = "Tbl_Proyectos", KeyColumn = "Id_Tipo_Proyecto", ForeignKeyColumn = "Id_Tipo_Proyecto")]
        public List<Tbl_Proyectos>? Tbl_Proyectos { get; set; }
    }
    public class Tbl_Proyectos : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? Id_Proyecto { get; set; }
        public string? Nombre_Proyecto { get; set; }
        public string? DescripcionProyecto { get; set; }
        public int? Id_Tipo_Proyecto { get; set; }
        public string? Visibilidad { get; set; }
        public string? Estado_Proyecto { get; set; }
        public DateTime? Fecha_Inicio { get; set; }
        public DateTime? Fecha_Finalizacion { get; set; }
        [ManyToOne(TableName = "Cat_Tipo_Proyecto", KeyColumn = "Id_Tipo_Proyecto", ForeignKeyColumn = "Id_Tipo_Proyecto")]
        public Cat_Tipo_Proyecto? Cat_Tipo_Proyecto { get; set; }
        [OneToMany(TableName = "ProyectoTableActividades", KeyColumn = "Id_Proyecto", ForeignKeyColumn = "Id_Proyecto")]
        public List<ProyectoTableActividades>? ProyectoTableActividades { get; set; }
        [OneToMany(TableName = "Tbl_Instituciones_Asociadas", KeyColumn = "Id_Proyecto", ForeignKeyColumn = "Id_Proyecto")]
        public List<Tbl_Instituciones_Asociadas>? Tbl_Instituciones_Asociadas { get; set; }
        [OneToMany(TableName = "Tbl_Participantes_Proyectos", KeyColumn = "Id_Proyecto", ForeignKeyColumn = "Id_Proyecto")]
        public List<Tbl_Participantes_Proyectos>? Tbl_Participantes_Proyectos { get; set; }
    }
    public class Cat_Cargo_Proyecto : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? Id_Cargo_Proyecto { get; set; }
        public string? Descripcion { get; set; }
        public string? Estado { get; set; }
        //[OneToMany(TableName = "Tbl_Participantes_Proyectos", KeyColumn = "Id_Cargo_Proyecto", ForeignKeyColumn = "Id_Cargo_Proyecto")]
        public List<Tbl_Participantes_Proyectos>? Tbl_Participantes_Proyectos { get; set; }
    }
    public class Tbl_Participantes_Proyectos : EntityClass
    {
        [PrimaryKey(Identity = false)]
        public int? Id_Proyecto { get; set; }
        [PrimaryKey(Identity = false)]
        public int? Id_Investigador { get; set; }
        public int? Id_Cargo_Proyecto { get; set; }
        public DateTime? Fecha_Ingreso { get; set; }
        public string? Estado_Participante { get; set; }
        [ManyToOne(TableName = "Tbl_Proyectos", KeyColumn = "Id_Proyecto", ForeignKeyColumn = "Id_Proyecto")]
        public Tbl_Proyectos? Tbl_Proyectos { get; set; }
        [ManyToOne(TableName = "Tbl_Profile", KeyColumn = "Id_Investigador", ForeignKeyColumn = "Id_Investigador")]
        public Tbl_Profile? Tbl_Profile { get; set; }
        [ManyToOne(TableName = "Cat_Cargo_Proyecto", KeyColumn = "Id_Cargo_Proyecto", ForeignKeyColumn = "Id_Cargo_Proyecto")]
        public Cat_Cargo_Proyecto? Cat_Cargo_Proyecto { get; set; }
    }
    public class CatRedesSociales : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? Id_RedSocial { get; set; }
        public string? Descripcion { get; set; }
        public string? url { get; set; }
        public string? Icon { get; set; }
        public string? Estado { get; set; }
        //[OneToMany(TableName = "Tbl_Invest_RedS", KeyColumn = "Id_RedSocial", ForeignKeyColumn = "Id_RedSocial")]
        public List<Tbl_Invest_RedS>? Tbl_Invest_RedS { get; set; }
    }
    public class Tbl_Invest_RedS : EntityClass
    {
        [PrimaryKey(Identity = false)]
        public int? Id_Investigador { get; set; }
        [PrimaryKey(Identity = false)]
        public int? Id_RedSocial { get; set; }
        public string? url_red_inv { get; set; }
        [ManyToOne(TableName = "Tbl_Profile", KeyColumn = "Id_Investigador", ForeignKeyColumn = "Id_Investigador")]
        public Tbl_Profile? Tbl_Profile { get; set; }
        [ManyToOne(TableName = "CatRedesSociales", KeyColumn = "Id_RedSocial", ForeignKeyColumn = "Id_RedSocial")]
        public CatRedesSociales? CatRedesSociales { get; set; }
    }
}
