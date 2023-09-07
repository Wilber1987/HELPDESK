using CAPA_NEGOCIO.MAPEO;
using CAPA_DATOS.Security; 
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class ProfileController : ControllerBase
    {
        [HttpPost]
        [AuthController]
        //Save
        public object? SaveProfile(Tbl_Profile Inst)
        {
            Inst.Id_Perfil = AuthNetCore.User(HttpContext.Session.GetString("seassonKey")).UserId;
            return Inst.SaveProfile();
        }
        [HttpPost]
        [AuthController]
        //Save
        public object? TakeProfile(Tbl_Profile Inst)
        {
            Inst.Id_Perfil = AuthNetCore.User(HttpContext.Session.GetString("seassonKey")).UserId;
            return Inst.TakeProfile();
        }

         [HttpGet]
        [AuthController]
        //Save
        public object? TakeProfile2()
        {
            Tbl_Profile Inst = new()
            {
                Id_Perfil = AuthNetCore.User(HttpContext.Session.GetString("seassonKey")).UserId
            };
            return Inst.TakeProfile();
        }

    }
}
