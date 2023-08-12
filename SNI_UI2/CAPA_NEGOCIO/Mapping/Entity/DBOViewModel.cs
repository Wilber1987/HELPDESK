using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {

   public class ViewParticipantesProyectos : EntityClass {
       public int? Id_Investigador { get; set; }
       public int? Id_Proyecto { get; set; }
       public DateTime? Fecha_Ingreso { get; set; }
       public string? Estado_Participante { get; set; }
       public string? DescripcionProyecto { get; set; }
       public DateTime? Fecha_Inicio { get; set; }
       public DateTime? Fecha_Finalizacion { get; set; }
       public string? Visibilidad { get; set; }
       public string? Cargo { get; set; }
       public string? Descripcion_Tipo_Proyecto { get; set; }
       public string? Estado_Tipo_Proyecto { get; set; }
       public string? Nombre_Proyecto { get; set; }
       public string? Estado_Proyecto { get; set; }
   }
   
   public class ViewCalendarioByDependencia : EntityClass {
       public int? IdActividad { get; set; }
       public int? IdTareaPadre { get; set; }
       public DateTime? Fecha_Inicial { get; set; }
       public DateTime? Fecha_Final { get; set; }
       public string? Estado { get; set; }
       public int? IdCalendario { get; set; }
       public int? IdTarea { get; set; }
       public int? Id_Dependencia { get; set; }
   }
   public class ViewActividadesParticipantes : EntityClass {
       public int? IdActividad { get; set; }
       public string? Titulo { get; set; }
       public string? Descripcion { get; set; }
       public string? Estado { get; set; }
       public int? Id_Investigador { get; set; }
   }
}
