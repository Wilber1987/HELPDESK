using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class Tbl_Profile_CasosAsignados : EntityClass {
       [PrimaryKey(Identity = false)]
       public int? Id_Perfil { get; set; }
       [PrimaryKey(Identity = false)]
       public int? Id_Case { get; set; }
       public DateTime? Fecha { get; set; }
       [ManyToOne(TableName = "CaseTable_Case", KeyColumn = "Id_Case", ForeignKeyColumn = "Id_Case")]
       public CaseTable_Case? CaseTable_Case { get; set; }
       [ManyToOne(TableName = "Tbl_Profile", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
       public Tbl_Profile? Tbl_Profile { get; set; }
   }
}
