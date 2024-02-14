using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CAPA_DATOS;

namespace SNI_UI2
{
    public class sptest: StoreProcedureClass
    {
        public string column1 { get; set; }
    }

    public class sptest2: StoreProcedureClass
    {
        public string? column1 { get; set; }
    }
    public class sptest3: StoreProcedureClass
    {
        
    }
}