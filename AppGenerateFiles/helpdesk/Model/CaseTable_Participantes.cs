using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class CaseTable_Participantes : EntityClass {
       [PrimaryKey(Identity = false)]
       public int? Id_Perfil { get; set; }
       [PrimaryKey(Identity = false)]
       public int? Id_Tarea { get; set; }
       public int? Id_Tipo_Participacion { get; set; }
       [ManyToOne(TableName = "CaseTable_Tareas", KeyColumn = "Id_Tarea", ForeignKeyColumn = "Id_Tarea")]
       public CaseTable_Tareas? CaseTable_Tareas { get; set; }
       [ManyToOne(TableName = "Cat_Tipo_Participaciones", KeyColumn = "Id_Tipo_Participacion", ForeignKeyColumn = "Id_Tipo_Participacion")]
       public Cat_Tipo_Participaciones? Cat_Tipo_Participaciones { get; set; }
       [ManyToOne(TableName = "Tbl_Profile", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
       public Tbl_Profile? Tbl_Profile { get; set; }
   }
}
