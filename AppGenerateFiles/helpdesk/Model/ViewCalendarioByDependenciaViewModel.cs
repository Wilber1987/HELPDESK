using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class ViewCalendarioByDependencia : EntityClass {
       public int? Id_Case { get; set; }
       public int? Id_TareaPadre { get; set; }
       public DateTime? Fecha_Inicio { get; set; }
       public string? Estado { get; set; }
       public int? IdCalendario { get; set; }
       public int? Id_Tarea { get; set; }
       public int? Id_Dependencia { get; set; }
   }
}
