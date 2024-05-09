using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class Tbl_Servicios : EntityClass {
       [PrimaryKey(Identity = true)]
       public int? Id_Servicio { get; set; }
       public string? Nombre_Servicio { get; set; }
       public string? Descripcion_Servicio { get; set; }
       public int? Id_Tipo_Servicio { get; set; }
       public string? Visibilidad { get; set; }
       public string? Estado { get; set; }
       public DateTime? Fecha_Inicio { get; set; }
       public DateTime? Fecha_Finalizacion { get; set; }
       public int? Id_Dependencia { get; set; }
       [ManyToOne(TableName = "Cat_Dependencias", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
       public Cat_Dependencias? Cat_Dependencias { get; set; }
       [ManyToOne(TableName = "Cat_Tipo_Servicio", KeyColumn = "Id_Tipo_Servicio", ForeignKeyColumn = "Id_Tipo_Servicio")]
       public Cat_Tipo_Servicio? Cat_Tipo_Servicio { get; set; }
       [OneToMany(TableName = "CaseTable_Case", KeyColumn = "Id_Servicio", ForeignKeyColumn = "Id_Servicio")]
       public List<CaseTable_Case>? CaseTable_Case { get; set; }
       [OneToMany(TableName = "Tbl_Servicios_Profile", KeyColumn = "Id_Servicio", ForeignKeyColumn = "Id_Servicio")]
       public List<Tbl_Servicios_Profile>? Tbl_Servicios_Profile { get; set; }
   }
}
