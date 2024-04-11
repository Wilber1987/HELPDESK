using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class CaseTable_Evidencias : EntityClass {
       [PrimaryKey(Identity = true)]
       public int? IdEvidencia { get; set; }
       public int? IdTipo { get; set; }
       public string? Data { get; set; }
       public int? Id_Tarea { get; set; }
       [ManyToOne(TableName = "CaseTable_Tareas", KeyColumn = "Id_Tarea", ForeignKeyColumn = "Id_Tarea")]
       public CaseTable_Tareas? CaseTable_Tareas { get; set; }
       [ManyToOne(TableName = "Cat_Tipo_Evidencia", KeyColumn = "IdTipo", ForeignKeyColumn = "IdTipo")]
       public Cat_Tipo_Evidencia? Cat_Tipo_Evidencia { get; set; }
   }
}
