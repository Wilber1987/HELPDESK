using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class Cat_Dependencias : EntityClass {
       [PrimaryKey(Identity = true)]
       public int? Id_Dependencia { get; set; }
       public string? Descripcion { get; set; }
       public int? Id_Dependencia_Padre { get; set; }
       public string? Username { get; set; }
       public string? Password { get; set; }
       public string? Host { get; set; }
       public string? AutenticationType { get; set; }
       public string? TENAT { get; set; }
       public string? CLIENT { get; set; }
       public string? OBJECTID { get; set; }
       public string? CLIENT_SECRET { get; set; }
       public string? HostService { get; set; }
       public string? SMTPHOST { get; set; }
       public bool? Default { get; set; }
       [ManyToOne(TableName = "Cat_Dependencias", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia_Padre")]
       public Cat_Dependencias? Cat_Dependencias { get; set; }
       [OneToMany(TableName = "CaseTable_Agenda", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
       public List<CaseTable_Agenda>? CaseTable_Agenda { get; set; }
       [OneToMany(TableName = "CaseTable_Calendario", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
       public List<CaseTable_Calendario>? CaseTable_Calendario { get; set; }
       [OneToMany(TableName = "CaseTable_Case", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
       public List<CaseTable_Case>? CaseTable_Case { get; set; }
       [OneToMany(TableName = "CaseTable_Dependencias_Usuarios", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
       public List<CaseTable_Dependencias_Usuarios>? CaseTable_Dependencias_Usuarios { get; set; }
       [OneToMany(TableName = "Cat_Dependencias", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia_Padre")]
       public List<Cat_Dependencias>? Cat_Dependencias { get; set; }
       [OneToMany(TableName = "Tbl_Servicios", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
       public List<Tbl_Servicios>? Tbl_Servicios { get; set; }
   }
}
