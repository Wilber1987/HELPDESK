using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class CaseTable_Tareas : EntityClass {
       [PrimaryKey(Identity = true)]
       public int? Id_Tarea { get; set; }
       public string? Titulo { get; set; }
       public int? Id_TareaPadre { get; set; }
       public int? Id_Case { get; set; }
       public string? Descripcion { get; set; }
       public string? Estado { get; set; }
       public DateTime? Fecha_Inicio { get; set; }
       public DateTime? Fecha_Finalizacion { get; set; }
       public DateTime? Fecha_Inicio_Proceso { get; set; }
       public DateTime? Fecha_Finalizacion_Proceso { get; set; }
       [ManyToOne(TableName = "CaseTable_Case", KeyColumn = "Id_Case", ForeignKeyColumn = "Id_Case")]
       public CaseTable_Case? CaseTable_Case { get; set; }
       [ManyToOne(TableName = "CaseTable_Tareas", KeyColumn = "Id_Tarea", ForeignKeyColumn = "Id_TareaPadre")]
       public CaseTable_Tareas? CaseTable_Tareas { get; set; }
       [OneToMany(TableName = "CaseTable_Calendario", KeyColumn = "Id_Tarea", ForeignKeyColumn = "Id_Tarea")]
       public List<CaseTable_Calendario>? CaseTable_Calendario { get; set; }
       [OneToMany(TableName = "CaseTable_Evidencias", KeyColumn = "Id_Tarea", ForeignKeyColumn = "Id_Tarea")]
       public List<CaseTable_Evidencias>? CaseTable_Evidencias { get; set; }
       [OneToMany(TableName = "CaseTable_Participantes", KeyColumn = "Id_Tarea", ForeignKeyColumn = "Id_Tarea")]
       public List<CaseTable_Participantes>? CaseTable_Participantes { get; set; }
       [OneToMany(TableName = "CaseTable_Tareas", KeyColumn = "Id_Tarea", ForeignKeyColumn = "Id_TareaPadre")]
       public List<CaseTable_Tareas>? CaseTable_Tareas { get; set; }
   }
}
