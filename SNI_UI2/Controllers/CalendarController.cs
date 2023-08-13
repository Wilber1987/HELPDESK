using Microsoft.AspNetCore.Mvc;
using CAPA_NEGOCIO.Security;
using CAPA_NEGOCIO.Views;
using CAPA_NEGOCIO.MAPEO;

namespace API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class CalendarController : ControllerBase
    {
        [HttpPost]
        public Object TakeData()
        {
            List<object> data = new List<object>();
            Cat_Dependencias Dep = new Cat_Dependencias();
            data.Add(Dep.Get<Cat_Dependencias>());
            Tbl_Profile Users = new Tbl_Profile();
            data.Add(Users.Get<Tbl_Profile>());
            Users.Id_Perfil = AuthNetCore.User(HttpContext.Session.GetString("seassonKey")).UserId;
            data.Add(Users.TakeDepCoordinaciones());
            return data;
        }
        public Object TakeCalendar(Calendar cal)
        {
            cal.TakeActividades();
            cal.TakeAgenda();
            cal.TakeCalendario();
            return cal;
        }
        public Object TakeActividades(CaseTable_Case Inst)
        {            
            return Inst.Get<CaseTable_Case>();
        }
        public Object TakeActividad(CaseTable_Case Inst)
        {
            return Inst.GetActividad();
        }
        public Object SaveActividad(CaseTable_Case Act)
        {            
            return true;
        }
        public Object? SaveTarea(CaseTable_Tareas Act)
        {
            return Act.Save();
        }
        public Object SolicitarActividad(CaseTable_Case Act)
        {
            return Act.SolicitarActividades(HttpContext.Session.GetString("seassonKey"));
        }
        //Agenda por usuario
        public Object AgendaUsuarioDependencia(Cat_Dependencias Act)
        {
            CaseTable_Agenda ag = new CaseTable_Agenda();
            ag.Id_Dependencia = Act.Id_Dependencia;
            ag.Id_Perfil = AuthNetCore.User(HttpContext.Session.GetString("seassonKey")).UserId;
            return ag.Get<CaseTable_Agenda>();
        }
        public Object? SaveAgendaUsuarioDependencia(CaseTable_Agenda Act)
        {
            if (Act.IdAgenda != null)
            {
                return Act.Update("IdAgenda");
            }
            return Act.Save();
        }
    }
    public class Calendar
    {
        public int Id_Dependencia { get; set; }
        public int IdUsuario { get; set; }
        public Object? Actividades { get; set; }
        public Object? Agenda { get; set; }
        public Object? Calendario { get; set; }

        public void TakeAgenda()
        {
            CaseTable_Agenda ag = new CaseTable_Agenda();
            ag.Id_Dependencia = this.Id_Dependencia;
            this.Agenda = ag.Get<CaseTable_Agenda>();
        }
        public void TakeActividades()
        {
            CaseTable_Case ag = new CaseTable_Case();
            this.Actividades = ag.Get<CaseTable_Case>();
        }
        public void TakeCalendario()
        {
            ViewCalendarioByDependencia ag = new ViewCalendarioByDependencia();
            ag.Id_Dependencia = this.Id_Dependencia;
            this.Calendario = ag.Get<ViewCalendarioByDependencia>();
        }
    }
}
