using Microsoft.AspNetCore.Mvc;
using CAPA_NEGOCIO.Security;
using CAPA_NEGOCIO.Services;

namespace API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class TestController : ControllerBase
    {
        [HttpGet]
        public object getMailData(){
            return new POPServices().getData();
        }
        [HttpGet]
        public object getMailData2(){
            return true;
        }
     
    }
}
