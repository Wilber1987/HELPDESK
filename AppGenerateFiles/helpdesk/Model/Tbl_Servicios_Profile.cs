using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class Tbl_Servicios_Profile : EntityClass {
       [PrimaryKey(Identity = false)]
       public int? Id_Perfil { get; set; }
       [PrimaryKey(Identity = false)]
       public int? Id_Servicio { get; set; }
       [ManyToOne(TableName = "Tbl_Profile", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
       public Tbl_Profile? Tbl_Profile { get; set; }
       [ManyToOne(TableName = "Tbl_Servicios", KeyColumn = "Id_Servicio", ForeignKeyColumn = "Id_Servicio")]
       public Tbl_Servicios? Tbl_Servicios { get; set; }
   }
}
