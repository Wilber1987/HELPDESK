using Microsoft.AspNetCore.Mvc;
using CAPA_DATOS.Security; 
using CAPA_NEGOCIO.Services;
using CAPA_DATOS.Services;

namespace API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class TestController : ControllerBase
    {
        [HttpGet]
        public object getMailData(){
            return new IMAPServices().GetData2();
        }
        [HttpGet]
        public object getMailData2(){
            return true;
        }
     
    }
}
