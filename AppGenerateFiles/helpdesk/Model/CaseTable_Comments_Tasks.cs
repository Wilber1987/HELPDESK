using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class CaseTable_Comments_Tasks : EntityClass {
       [PrimaryKey(Identity = true)]
       public int? Id_Comentario { get; set; }
       public string? Body { get; set; }
       public string? Estado { get; set; }
       public DateTime? Fecha { get; set; }
       public int? Id_Tarea { get; set; }
       public int? Id_User { get; set; }
       public string? NickName { get; set; }
       public string? Mail { get; set; }
       public string? Attach_Files { get; set; }
       public string? Mails { get; set; }
   }
}
