using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class CaseTable_Calendario : EntityClass {
       [PrimaryKey(Identity = true)]
       public int? IdCalendario { get; set; }
       public int? Id_Tarea { get; set; }
       public string? Estado { get; set; }
       public DateTime? Fecha_Inicio { get; set; }
       public DateTime? Fecha_Final { get; set; }
       public int? Id_Dependencia { get; set; }
       [ManyToOne(TableName = "CaseTable_Tareas", KeyColumn = "Id_Tarea", ForeignKeyColumn = "Id_Tarea")]
       public CaseTable_Tareas? CaseTable_Tareas { get; set; }
       [ManyToOne(TableName = "Cat_Dependencias", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
       public Cat_Dependencias? Cat_Dependencias { get; set; }
   }
}
