using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class CaseTable_Dependencias_Usuarios : EntityClass {
       [PrimaryKey(Identity = false)]
       public int? Id_Perfil { get; set; }
       [PrimaryKey(Identity = false)]
       public int? Id_Dependencia { get; set; }
       public int? Id_Cargo { get; set; }
       [ManyToOne(TableName = "Cat_Cargos_Dependencias", KeyColumn = "Id_Cargo", ForeignKeyColumn = "Id_Cargo")]
       public Cat_Cargos_Dependencias? Cat_Cargos_Dependencias { get; set; }
       [ManyToOne(TableName = "Cat_Dependencias", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
       public Cat_Dependencias? Cat_Dependencias { get; set; }
       [ManyToOne(TableName = "Tbl_Profile", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
       public Tbl_Profile? Tbl_Profile { get; set; }
   }
}
