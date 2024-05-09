using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class CaseTable_Agenda : EntityClass {
       [PrimaryKey(Identity = true)]
       public int? IdAgenda { get; set; }
       public int? Id_Perfil { get; set; }
       public int? Id_Dependencia { get; set; }
       public string? Dia { get; set; }
       public string? Hora_Inicial { get; set; }
       public string? Hora_Final { get; set; }
       public DateTime? Fecha_Caducidad { get; set; }
       [ManyToOne(TableName = "Cat_Dependencias", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
       public Cat_Dependencias? Cat_Dependencias { get; set; }
       [ManyToOne(TableName = "Tbl_Profile", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
       public Tbl_Profile? Tbl_Profile { get; set; }
   }
}
