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
            ProyectoCatDependencias Dep = new ProyectoCatDependencias();
            data.Add(Dep.Get<ProyectoCatDependencias>());
            Tbl_Profile Users = new Tbl_Profile();
            data.Add(Users.Get<Tbl_Profile>());
            Users.Id_Investigador = AuthNetCore.User(HttpContext.Session.GetString("seassonKey")).UserId;
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
        public Object TakeActividades(ProyectoTableActividades Inst)
        {            
            return Inst.Get<ProyectoTableActividades>();
        }
        public Object TakeActividad(ProyectoTableActividades Inst)
        {
            return Inst.GetActividad();
        }
        public Object SaveActividad(ProyectoTableActividades Act)
        {            
            return true;
        }
        public Object? SaveTarea(ProyectoTableTareas Act)
        {
            return Act.Save();
        }
        public Object SolicitarActividad(ProyectoTableActividades Act)
        {
            return Act.SolicitarActividades(HttpContext.Session.GetString("seassonKey"));
        }
        //Agenda por usuario
        public Object AgendaUsuarioDependencia(ProyectoCatDependencias Act)
        {
            ProyectoTableAgenda ag = new ProyectoTableAgenda();
            ag.Id_Dependencia = Act.Id_Dependencia;
            ag.Id_Investigador = AuthNetCore.User(HttpContext.Session.GetString("seassonKey")).UserId;
            return ag.Get<ProyectoTableAgenda>();
        }
        public Object? SaveAgendaUsuarioDependencia(ProyectoTableAgenda Act)
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
            ProyectoTableAgenda ag = new ProyectoTableAgenda();
            ag.Id_Dependencia = this.Id_Dependencia;
            this.Agenda = ag.Get<ProyectoTableAgenda>();
        }
        public void TakeActividades()
        {
            ProyectoTableActividades ag = new ProyectoTableActividades();
            this.Actividades = ag.Get<ProyectoTableActividades>();
        }
        public void TakeCalendario()
        {
            ViewCalendarioByDependencia ag = new ViewCalendarioByDependencia();
            ag.Id_Dependencia = this.Id_Dependencia;
            this.Calendario = ag.Get<ViewCalendarioByDependencia>();
        }
    }
}
