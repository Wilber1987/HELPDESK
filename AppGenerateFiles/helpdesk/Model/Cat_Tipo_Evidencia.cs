using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class Cat_Tipo_Evidencia : EntityClass {
       [PrimaryKey(Identity = true)]
       public int? IdTipo { get; set; }
       public string? Descripcion { get; set; }
       public string? Estado { get; set; }
       [OneToMany(TableName = "CaseTable_Evidencias", KeyColumn = "IdTipo", ForeignKeyColumn = "IdTipo")]
       public List<CaseTable_Evidencias>? CaseTable_Evidencias { get; set; }
   }
}
