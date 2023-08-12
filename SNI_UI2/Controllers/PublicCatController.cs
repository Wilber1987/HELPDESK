using CAPA_NEGOCIO.MAPEO;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class PublicCatController : ControllerBase
    {
        [HttpPost]
        [AnonymousAuth]
        //Get
        
        public object GetInstitucion()
        {
            var inst = new Cat_instituciones();
            inst.Estado = "Activo";
            return inst.Get<Cat_instituciones>();
        }
        
        
        public object GetPaises()
        {
            var inst = new Cat_Paises();
            inst.Estado = "Activo";
            return inst.Get<Cat_Paises>();
        }
      
        public object GetRedesSociales()
        {
            var inst = new CatRedesSociales();
            inst.Estado = "Activo";
            return inst.Get<CatRedesSociales>();
        }
        
        public object GetTipoInvestigaciones()
        {
            var inst = new Cat_Tipo_Investigacion();
            inst.Estado = "Activo";
            return inst.Get<Cat_Tipo_Investigacion>();
        }
        
       
        public object GetInvestigadores()
        {
            var inst = new Tbl_Profile();
            inst.Estado = "Activo";
            return inst.Get<Tbl_Profile>();
        }
        //Postularse
        public object Register(Tbl_Profile postulante)
        {
            return postulante.Postularse();
        }

    }
}
