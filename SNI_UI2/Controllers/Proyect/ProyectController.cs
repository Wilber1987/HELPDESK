using CAPA_DATOS;
using CAPA_NEGOCIO.MAPEO;
using CAPA_NEGOCIO.Services;
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
        public List<CaseTable_Case> GetOwCloseCase(CaseTable_Case inst)
        {
            return inst.GetOwCloseCase(HttpContext.Session.GetString("seassonKey"));
        }
        public List<CaseTable_Case> GetVinculateCase(CaseTable_Case inst)
        {
            return inst.GetVinculateCase(HttpContext.Session.GetString("seassonKey"));
        }
        public List<Cat_Dependencias> GetOwDependencies()
        {
            return new Cat_Dependencias().GetOwDependencies(HttpContext.Session.GetString("seassonKey"));
        }
        //Pendiente, Solicitado, Activo, Finalizado, Espera
        public List<CaseTable_Case> GetOwSolicitudesPendientesAprobar(CaseTable_Case inst)
        {
            return inst.GetOwSolicitudes(HttpContext.Session.GetString("seassonKey"), Case_Estate.Solicitado);
        }

        public List<CaseTable_Case> GetOwSolicitudesPendientes(CaseTable_Case inst)
        {
            return inst.GetOwSolicitudes(HttpContext.Session.GetString("seassonKey"), Case_Estate.Pendiente);
        }
        public List<CaseTable_Case> GetSolicitudesPendientesAprobar(CaseTable_Case inst)
        {
            return inst.GetSolicitudesPendientesAprobar(HttpContext.Session.GetString("seassonKey"), Case_Estate.Solicitado);
        }
        public List<CaseTable_Case> GetSolicitudesPendientesAprobarAdmin(CaseTable_Case inst)
        {
            return inst.GetSolicitudesPendientesAprobarAdmin(HttpContext.Session.GetString("seassonKey"));
        }
        public List<CaseTable_Case> GetOwSolicitudesProceso(CaseTable_Case inst)
        {
            return inst.GetOwSolicitudes(HttpContext.Session.GetString("seassonKey"), Case_Estate.Activo);
        }
        public List<CaseTable_Case> GetOwSolicitudesEspera(CaseTable_Case inst)
        {
            return inst.GetOwSolicitudes(HttpContext.Session.GetString("seassonKey"), Case_Estate.Espera);
        }
        public object RechazarSolicitud(CaseTable_Case caseTable_Case)
        {
            return caseTable_Case.RechazarSolicitud(HttpContext.Session.GetString("seassonKey"));
        }

        public object AprobarSolicitud(CaseTable_Case caseTable_Case)
        {
            return caseTable_Case.AprobarSolicitud(HttpContext.Session.GetString("seassonKey"));
        }
        public object CerrarCaso(CaseTable_Case caseTable_Case)
        {
            return caseTable_Case.CerrarCaso(HttpContext.Session.GetString("seassonKey"));
        }
        //CASOS VINCULADOS      
        public object VincularCaso(CaseTable_VinculateCase inst)
        {
            return inst.VincularCaso();
        }
        public object DesvincularCaso(CaseTable_VinculateCase inst)
        {
            return inst.DesvincularCaso(inst.Casos_Vinculados.FirstOrDefault());
        }
        public List<CaseTable_Case> GetCasosToVinculate(CaseTable_Case Inst)
        {
            return new CaseTable_Case()
            .GetCasosToVinculate(HttpContext.Session.GetString("seassonKey"), Inst);
        }
        public object AprobarCaseList(CaseBlock Inst)
        {
            return Inst.AprobarSolicitudes(HttpContext.Session.GetString("seassonKey"));
        }
        public object RechazarCaseList(CaseBlock Inst)
        {
            return Inst.RechazarSolicitudes(HttpContext.Session.GetString("seassonKey"));
        }
        public object RemitirCasos(CaseBlock Inst)
        {
            return Inst.RemitirCasos(HttpContext.Session.GetString("seassonKey"));
        }
        public object AsignarDependencias(ProfileTransaction Inst)
        {
            return Inst.AsignarDependencias(HttpContext.Session.GetString("seassonKey"));
        }
        public object getDashboard(ProfileTransaction Inst)
        {
            string? token = HttpContext.Session.GetString("seassonKey");
            var caseTable = new CaseTable_Case().GetOwParticipantCase(token);
            return new
            {
                dependencies = new Cat_Dependencias().GetOwDependenciesConsolidados(token),
                caseTickets = caseTable,
                task = new CaseTable_Tareas().GetOwActiveParticipations(token),
                comments = new CaseTable_Comments().GetOwComments(caseTable)
            };
        }
        [HttpPost]
        public object getDashboardgET(DateFilter dateFilter)
        {
            string? token = HttpContext.Session.GetString("seassonKey");
            var caseTable = new CaseTable_Case
            {
                filterData = new List<FilterData> { FilterData.Between("Fecha_Inicio", dateFilter.Desde, dateFilter.Hasta) }
            }.GetOwParticipantCase(token);
            return new
            {
                dependencies = new Cat_Dependencias().GetOwDependenciesConsolidados(token),
                caseTickets = caseTable,
                task = new CaseTable_Tareas()
                {
                    filterData = new List<FilterData> { FilterData.Between("Fecha_Inicio", dateFilter.Desde, dateFilter.Hasta) }
                }.GetOwActiveParticipations(token),
                comments = new CaseTable_Comments()
                {
                    filterData = new List<FilterData> { FilterData.Between("Fecha", dateFilter.Desde, dateFilter.Hasta) }
                }.GetOwComments(caseTable)
            };
        }

    }
    public class DateFilter
    {
        public DateTime Desde { get; set; }
        public DateTime Hasta { get; set; }
    }
}
