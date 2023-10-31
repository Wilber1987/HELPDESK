using Microsoft.AspNetCore.Mvc;
using CAPA_DATOS.Security;
using CAPA_DATOS;

namespace API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class ApiLogController : ControllerBase
    {
        [HttpPost]
         [AuthController]
        public object getLogError(LogError Inst)
        {           
            return Inst.Get<LogError>();
        }

    }
}
