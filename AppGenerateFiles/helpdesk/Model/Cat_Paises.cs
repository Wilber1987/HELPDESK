using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class Cat_Paises : EntityClass {
       [PrimaryKey(Identity = true)]
       public int? Id_Pais { get; set; }
       public string? Estado { get; set; }
       public string? Descripcion { get; set; }
       [OneToMany(TableName = "Tbl_Profile", KeyColumn = "Id_Pais", ForeignKeyColumn = "Id_Pais_Origen")]
       public List<Tbl_Profile>? Tbl_Profile { get; set; }
   }
}
