using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class Tbl_Profile : EntityClass {
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
       public string? Estado { get; set; }
       [ManyToOne(TableName = "Cat_Paises", KeyColumn = "Id_Pais", ForeignKeyColumn = "Id_Pais_Origen")]
       public Cat_Paises? Cat_Paises { get; set; }
       [ManyToOne(TableName = "Security_Users", KeyColumn = "Id_User", ForeignKeyColumn = "IdUser")]
       public Security_Users? Security_Users { get; set; }
       [OneToMany(TableName = "CaseTable_Agenda", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
       public List<CaseTable_Agenda>? CaseTable_Agenda { get; set; }
       [OneToMany(TableName = "CaseTable_Case", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
       public List<CaseTable_Case>? CaseTable_Case { get; set; }
       [OneToMany(TableName = "CaseTable_Dependencias_Usuarios", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
       public List<CaseTable_Dependencias_Usuarios>? CaseTable_Dependencias_Usuarios { get; set; }
       [OneToMany(TableName = "CaseTable_Participantes", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
       public List<CaseTable_Participantes>? CaseTable_Participantes { get; set; }
       [OneToMany(TableName = "Tbl_Profile_CasosAsignados", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
       public List<Tbl_Profile_CasosAsignados>? Tbl_Profile_CasosAsignados { get; set; }
       [OneToMany(TableName = "Tbl_Servicios_Profile", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
       public List<Tbl_Servicios_Profile>? Tbl_Servicios_Profile { get; set; }
   }
}
