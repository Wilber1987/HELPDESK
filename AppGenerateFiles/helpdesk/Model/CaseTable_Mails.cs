using CAPA_DATOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel {
   public class CaseTable_Mails : EntityClass {
       [PrimaryKey(Identity = true)]
       public int? Id_Mail { get; set; }
       public int? Id_Case { get; set; }
       public string? Subject { get; set; }
       public string? MessageID { get; set; }
       public string? Sender { get; set; }
       public string? FromAdress { get; set; }
       public string? ReplyTo { get; set; }
       public string? Bcc { get; set; }
       public string? Cc { get; set; }
       public string? ToAdress { get; set; }
       public DateTime? Date { get; set; }
       public string? Uid { get; set; }
       public string? Flags { get; set; }
       public string? Estado { get; set; }
       public string? Body { get; set; }
       public string? Attach_Files { get; set; }
       [ManyToOne(TableName = "CaseTable_Case", KeyColumn = "Id_Case", ForeignKeyColumn = "Id_Case")]
       public CaseTable_Case? CaseTable_Case { get; set; }
   }
}
