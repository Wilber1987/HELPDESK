using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class ViewActividadesParticipantes : EntityClass {
       public int? Id_Case { get; set; }
       public string? Titulo { get; set; }
       public string? Descripcion { get; set; }
       public string? Estado { get; set; }
       public int? Id_Perfil { get; set; }
   }
}
