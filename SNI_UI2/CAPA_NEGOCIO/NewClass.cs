using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CAPA_DATOS;

namespace SNI_UI2.CAPA_NEGOCIO
{
    class Customer : EntityClass
    {
        public string? Id { get; set; }
        public string? Description { get; set; }
        public int? agency_id { get; set; }


    }
    class Structure_agency : EntityClass
    {
        public int? Id { get; set; }
        public string? Name { get; set; }
        [OneToMany(TableName = "Customer", KeyColumn = "id", ForeignKeyColumn = "agency_id")]
        public List<Customer>? Customer { get; set; }
    }
}