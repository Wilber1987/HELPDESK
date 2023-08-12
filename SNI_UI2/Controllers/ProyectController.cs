using CAPA_NEGOCIO.MAPEO;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class ProyectController : ControllerBase
    {        
        [HttpPost]
        public object TakeProyect(Tbl_Proyectos Inst)
        {
            return Inst.Get<Tbl_Proyectos>();
        }
        public object TakeProyects(Tbl_Proyectos Inst)
        {
            return Inst.Get<Tbl_Proyectos>();
        }
        public object TakeTypeProyects(Cat_Tipo_Proyecto Inst)
        {
            return Inst.Get<Cat_Tipo_Proyecto>();
        }
        public List<ProyectoTableTareas> GetOwParticipations()
        {           
            return new ProyectoTableTareas().GetOwParticipations(HttpContext.Session.GetString("seassonKey"));
        }     
        public List<ProyectoTableActividades> GetOwActivities()
        {            
            return new ProyectoTableActividades().GetOwActivities(HttpContext.Session.GetString("seassonKey"));
        }
        public List<ProyectoCatDependencias> GetOwDependencies()
        {            
            return new ProyectoCatDependencias().GetOwDependencies(HttpContext.Session.GetString("seassonKey"));
        }

    }
}
