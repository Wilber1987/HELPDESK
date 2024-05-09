using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class Cat_Cargos_Dependencias : EntityClass {
       [PrimaryKey(Identity = true)]
       public int? Id_Cargo { get; set; }
       public string? Descripcion { get; set; }
       [OneToMany(TableName = "CaseTable_Dependencias_Usuarios", KeyColumn = "Id_Cargo", ForeignKeyColumn = "Id_Cargo")]
       public List<CaseTable_Dependencias_Usuarios>? CaseTable_Dependencias_Usuarios { get; set; }
   }
}
