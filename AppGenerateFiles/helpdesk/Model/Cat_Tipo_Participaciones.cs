using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class Cat_Tipo_Participaciones : EntityClass {
       [PrimaryKey(Identity = true)]
       public int? Id_Tipo_Participacion { get; set; }
       public string? Descripcion { get; set; }
       [OneToMany(TableName = "CaseTable_Participantes", KeyColumn = "Id_Tipo_Participacion", ForeignKeyColumn = "Id_Tipo_Participacion")]
       public List<CaseTable_Participantes>? CaseTable_Participantes { get; set; }
   }
}
