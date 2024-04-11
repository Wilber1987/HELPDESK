using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class CaseTable_Case : EntityClass {
       [PrimaryKey(Identity = true)]
       public int? Id_Case { get; set; }
       public string? Titulo { get; set; }
       public string? Descripcion { get; set; }
       public int? Id_Perfil { get; set; }
       public string? Estado { get; set; }
       public int? Id_Dependencia { get; set; }
       public DateTime? Fecha_Inicio { get; set; }
       public DateTime? Fecha_Final { get; set; }
       public int? Id_Servicio { get; set; }
       public int? Id_Vinculate { get; set; }
       public string? Mail { get; set; }
       public string? Case_Priority { get; set; }
       [ManyToOne(TableName = "CaseTable_VinculateCase", KeyColumn = "Id_Vinculate", ForeignKeyColumn = "Id_Vinculate")]
       public CaseTable_VinculateCase? CaseTable_VinculateCase { get; set; }
       [ManyToOne(TableName = "Cat_Dependencias", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
       public Cat_Dependencias? Cat_Dependencias { get; set; }
       [ManyToOne(TableName = "Tbl_Profile", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
       public Tbl_Profile? Tbl_Profile { get; set; }
       [ManyToOne(TableName = "Tbl_Servicios", KeyColumn = "Id_Servicio", ForeignKeyColumn = "Id_Servicio")]
       public Tbl_Servicios? Tbl_Servicios { get; set; }
       [OneToMany(TableName = "CaseTable_Comments", KeyColumn = "Id_Case", ForeignKeyColumn = "Id_Case")]
       public List<CaseTable_Comments>? CaseTable_Comments { get; set; }
       [OneToMany(TableName = "CaseTable_Mails", KeyColumn = "Id_Case", ForeignKeyColumn = "Id_Case")]
       public List<CaseTable_Mails>? CaseTable_Mails { get; set; }
       [OneToMany(TableName = "CaseTable_Tareas", KeyColumn = "Id_Case", ForeignKeyColumn = "Id_Case")]
       public List<CaseTable_Tareas>? CaseTable_Tareas { get; set; }
       [OneToMany(TableName = "Tbl_Profile_CasosAsignados", KeyColumn = "Id_Case", ForeignKeyColumn = "Id_Case")]
       public List<Tbl_Profile_CasosAsignados>? Tbl_Profile_CasosAsignados { get; set; }
   }
}
