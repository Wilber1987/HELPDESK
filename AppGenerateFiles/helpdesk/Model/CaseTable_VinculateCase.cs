using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class CaseTable_VinculateCase : EntityClass {
       [PrimaryKey(Identity = true)]
       public int? Id_Vinculate { get; set; }
       public string? Descripcion { get; set; }
       public DateTime? Fecha { get; set; }
       [OneToMany(TableName = "CaseTable_Case", KeyColumn = "Id_Vinculate", ForeignKeyColumn = "Id_Vinculate")]
       public List<CaseTable_Case>? CaseTable_Case { get; set; }
   }
}
