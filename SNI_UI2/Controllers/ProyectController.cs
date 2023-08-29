using CAPA_DATOS;
using CAPA_NEGOCIO.MAPEO;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class ProyectController : ControllerBase
    {
        [HttpPost]
        public object TakeProyect(Tbl_Servicios Inst)
        {
            return Inst.Get<Tbl_Servicios>();
        }
        public object TakeProyects(Tbl_Servicios Inst)
        {
            return Inst.Get<Tbl_Servicios>();
        }
        public object TakeTypeProyects(Cat_Tipo_Servicio Inst)
        {
            return Inst.Get<Cat_Tipo_Servicio>();
        }
        public List<CaseTable_Tareas> GetOwParticipations()
        {
            return new CaseTable_Tareas().GetOwParticipations(HttpContext.Session.GetString("seassonKey"));
        }
        public List<CaseTable_Case> GetOwCase(CaseTable_Case inst)
        {
            return inst.GetOwCase(HttpContext.Session.GetString("seassonKey"));
        }
        public List<Cat_Dependencias> GetOwDependencies()
        {
            return new Cat_Dependencias().GetOwDependencies(HttpContext.Session.GetString("seassonKey"));
        }
        //Pendiente, Solicitado, Activo, Finalizado, Espera
        public List<CaseTable_Case> GetOwSolicitudesPendientesAprobar()
        {
            return new CaseTable_Case()
            .GetOwSolicitudes(HttpContext.Session.GetString("seassonKey"), Case_Estate.Solicitado);
        }

        public List<CaseTable_Case> GetOwSolicitudesPendientes()
        {
            return new CaseTable_Case()
            .GetOwSolicitudes(HttpContext.Session.GetString("seassonKey"), Case_Estate.Pendiente);
        }
        public List<CaseTable_Case> GetSolicitudesPendientesAprobar()
        {
            return new CaseTable_Case()
            .GetSolicitudesPendientesAprobar(HttpContext.Session.GetString("seassonKey"), Case_Estate.Solicitado);
        }
        public List<CaseTable_Case> GetOwSolicitudesProceso()
        {
            return new CaseTable_Case()
            .GetOwSolicitudes(HttpContext.Session.GetString("seassonKey"), Case_Estate.Activo);
        }
        public List<CaseTable_Case> GetOwSolicitudesEspera()
        {
            return new CaseTable_Case()
            .GetOwSolicitudes(HttpContext.Session.GetString("seassonKey"), Case_Estate.Espera);
        }
        public object RechazarSolicitud(CaseTable_Case caseTable_Case)
        {
            return caseTable_Case.RechazarSolicitud(HttpContext.Session.GetString("seassonKey"));            
        }
        public object AprobarSolicitud(CaseTable_Case caseTable_Case)
        {
            return caseTable_Case.AprobarSolicitud(HttpContext.Session.GetString("seassonKey"));            
        }


        //CASOS VINCULADOS      
        public object VincularCaso(CaseTable_VinculateCase inst)
        {
            return inst.VincularCaso();
        }
         public object DesvincularCaso(CaseTable_VinculateCase inst)
        {
            return inst.DesvincularCaso();            
        }
         public List<CaseTable_Case> GetCasosToVinculate(CaseTable_Case Inst)
        {
            return new CaseTable_Case()
            .GetCasosToVinculate(HttpContext.Session.GetString("seassonKey"), Inst);
        }

    }
}
