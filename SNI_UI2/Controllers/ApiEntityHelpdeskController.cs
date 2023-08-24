using DataBaseModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using CAPA_NEGOCIO.MAPEO;
using API.Controllers;
using System.Collections.Generic;

namespace API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class ApiEntityHelpdeskController : ControllerBase
    {
        [HttpPost]
        [AuthController]
        public List<CaseTable_Comments> getCaseTable_Comments(CaseTable_Comments Inst)
        {
            return Inst.Get<CaseTable_Comments>();
        }
        [HttpPost]
        [AuthController]
        public object? saveCaseTable_Comments(CaseTable_Comments inst)
        {
                      
            return inst.SaveComment(HttpContext.Session.GetString("seassonKey"));
        }
        [HttpPost]
        [AuthController]
        public object? updateCaseTable_Comments(CaseTable_Comments inst)
        {
            return inst.Update();
        }
        //Cat_Tipo_Evento

        [HttpPost]
        [AuthController]
        public List<Cat_Tipo_Evidencia> getCat_Tipo_Evidencia(Cat_Tipo_Evidencia Inst)
        {
            return Inst.Get<Cat_Tipo_Evidencia>();
        }
        [HttpPost]
        [AuthController]
        public object? saveCat_Tipo_Evidencia(Cat_Tipo_Evidencia inst)
        {
            return inst.Save();
        }
        [HttpPost]
        [AuthController]
        public object? updateCat_Tipo_Evidencia(Cat_Tipo_Evidencia inst)
        {
            return inst.Update();
        }
        //Cat_Cargos_Dependencias
        [HttpPost]
        [AuthController]
        public List<Cat_Cargos_Dependencias> getCat_Cargos_Dependencias(Cat_Cargos_Dependencias Inst)
        {
            return Inst.Get<Cat_Cargos_Dependencias>();
        }
        [HttpPost]
        [AuthController]
        public object? saveCat_Cargos_Dependencias(Cat_Cargos_Dependencias inst)
        {
            return inst.Save();
        }
        [HttpPost]
        [AuthController]
        public object? updateCat_Cargos_Dependencias(Cat_Cargos_Dependencias inst)
        {
            return inst.Update();
        }
        //Cat_Dependencias
        [HttpPost]
        [AuthController]
        public List<Cat_Dependencias> getCat_Dependencias(Cat_Dependencias Inst)
        {
            return Inst.Get<Cat_Dependencias>();
        }
        [HttpPost]
        [AuthController]
        public object? saveCat_Dependencias(Cat_Dependencias inst)
        {
            return inst.Save();
        }
        [HttpPost]
        [AuthController]
        public object? updateCat_Dependencias(Cat_Dependencias inst)
        {
            return inst.Update();
        }
        //Cat_Tipo_Participaciones
        [HttpPost]
        [AuthController]
        public List<Cat_Tipo_Participaciones> getCat_Tipo_Participaciones(Cat_Tipo_Participaciones Inst)
        {
            return Inst.Get<Cat_Tipo_Participaciones>();
        }
        [HttpPost]
        [AuthController]
        public object? saveCat_Tipo_Participaciones(Cat_Tipo_Participaciones inst)
        {
            return inst.Save();
        }
        [HttpPost]
        [AuthController]
        public object? updateCat_Tipo_Participaciones(Cat_Tipo_Participaciones inst)
        {
            return inst.Update();
        }
        //CaseTable_Agenda
        [HttpPost]
        [AuthController]
        public List<CaseTable_Agenda> getCaseTable_Agenda(CaseTable_Agenda Inst)
        {
            return Inst.Get<CaseTable_Agenda>();
        }
        [HttpPost]
        [AuthController]
        public object? saveCaseTable_Agenda(CaseTable_Agenda inst)
        {
            return inst.Save();
        }
        [HttpPost]
        [AuthController]
        public object? updateCaseTable_Agenda(CaseTable_Agenda inst)
        {
            return inst.Update();
        }
        //CaseTable_Dependencias_Usuarios
        [HttpPost]
        [AuthController]
        public List<CaseTable_Dependencias_Usuarios> getCaseTable_Dependencias_Usuarios(CaseTable_Dependencias_Usuarios Inst)
        {
            return Inst.Get<CaseTable_Dependencias_Usuarios>();
        }
        [HttpPost]
        [AuthController]
        public object? saveCaseTable_Dependencias_Usuarios(CaseTable_Dependencias_Usuarios inst)
        {
            return inst.Save();
        }
        [HttpPost]
        [AuthController]
        public object? updateCaseTable_Dependencias_Usuarios(CaseTable_Dependencias_Usuarios inst)
        {
            return inst.Update();
        }
        //CaseTable_Evidencias
        [HttpPost]
        [AuthController]
        public List<CaseTable_Evidencias> getCaseTable_Evidencias(CaseTable_Evidencias Inst)
        {
            return Inst.Get<CaseTable_Evidencias>();
        }
        [HttpPost]
        [AuthController]
        public object? saveCaseTable_Evidencias(CaseTable_Evidencias inst)
        {
            return inst.Save();
        }
        [HttpPost]
        [AuthController]
        public object? updateCaseTable_Evidencias(CaseTable_Evidencias inst)
        {
            return inst.Update();
        }
        //Tbl_Datos_Laborales
        //Cat_Paises
        [HttpPost]
        [AuthController]
        public List<Cat_Paises> getCat_Paises(Cat_Paises Inst)
        {
            return Inst.Get<Cat_Paises>();
        }
        [HttpPost]
        [AuthController]
        public object? saveCat_Paises(Cat_Paises inst)
        {
            return inst.Save();
        }
        [HttpPost]
        [AuthController]
        public object? updateCat_Paises(Cat_Paises inst)
        {
            return inst.Update();
        }
        //Cat_TipoLocalidad


        //Tbl_Profile
        [HttpPost]
        [AuthController]
        public List<Tbl_Profile> getTbl_Profile(Tbl_Profile Inst)
        {
            return Inst.Get<Tbl_Profile>();
        }
        [HttpPost]
        [AuthController]
        public object? saveTbl_Profile(Tbl_Profile inst)
        {
            return inst.Save();
        }
        [HttpPost]
        [AuthController]
        public object? updateTbl_Profile(Tbl_Profile inst)
        {
            return inst.Update();
        }

        //Cat_Tipo_Servicio
        [HttpPost]
        [AuthController]
        public List<Cat_Tipo_Servicio> getCat_Tipo_Servicio(Cat_Tipo_Servicio Inst)
        {
            return Inst.Get<Cat_Tipo_Servicio>();
        }
        [HttpPost]
        [AuthController]
        public object? saveCat_Tipo_Servicio(Cat_Tipo_Servicio inst)
        {
            return inst.Save();
        }
        [HttpPost]
        [AuthController]
        public object? updateCat_Tipo_Servicio(Cat_Tipo_Servicio inst)
        {
            return inst.Update();
        }
        //Tbl_Servicios
        [HttpPost]
        [AuthController]
        public List<Tbl_Servicios> getTbl_Servicios(Tbl_Servicios Inst)
        {
            return Inst.Get<Tbl_Servicios>();
        }
        [HttpPost]
        [AuthController]
        public object? saveTbl_Servicios(Tbl_Servicios inst)
        {
            return inst.Save();
        }
        [HttpPost]
        [AuthController]
        public object? updateTbl_Servicios(Tbl_Servicios inst)
        {
            return inst.Update();
        }

        //CaseTable_Case
        [HttpPost]
        [AuthController]
        public List<CaseTable_Case> getCaseTable_Case(CaseTable_Case Inst)
        {
            return Inst.Get<CaseTable_Case>();
        }
        [HttpPost]
        [AuthController]
        public object? saveCaseTable_Case(CaseTable_Case inst)
        {
            inst.Estado ??= Case_Estate.Solicitado.ToString();
            inst.Id_Perfil = AuthNetCore.User(HttpContext.Session.GetString("seassonKey")).UserId;
            inst.Mail =  AuthNetCore.User(HttpContext.Session.GetString("seassonKey")).mail;
            inst.Titulo = inst?.Titulo?.ToUpper();
            return inst.Save();
        }
        [HttpPost]
        [AuthController]
        public object? updateCaseTable_Case(CaseTable_Case inst)
        {
            return inst.Update();
        }
        //CaseTable_Calendario
        [HttpPost]
        [AuthController]
        public List<ViewCalendarioByDependencia> getCaseTable_Calendario(ViewCalendarioByDependencia Inst)
        {
            return Inst.Get<ViewCalendarioByDependencia>();
        }
        [HttpPost]
        [AuthController]
        public object? saveCaseTable_Calendario(CaseTable_Calendario inst)
        {
            return inst.Save();
        }
        [HttpPost]
        [AuthController]
        public object? updateCaseTable_Calendario(CaseTable_Calendario inst)
        {
            return inst.Update();
        }
        //CaseTable_Tareas
        [HttpPost]
        [AuthController]
        public List<CaseTable_Tareas> getCaseTable_Tareas(CaseTable_Tareas Inst)
        {
            return Inst.Get<CaseTable_Tareas>();
        }
        [HttpPost]
        [AuthController]
        public object? saveCaseTable_Tareas(CaseTable_Tareas inst)
        {
            return inst.Save();
        }
        [HttpPost]
        [AuthController]
        public object? updateCaseTable_Tareas(CaseTable_Tareas inst)
        {
            return inst.UpdateTarea();
        }
        //CaseTable_Participantes
        [HttpPost]
        [AuthController]
        public List<CaseTable_Participantes> getCaseTable_Participantes(CaseTable_Participantes Inst)
        {
            return Inst.Get<CaseTable_Participantes>();
        }
        [HttpPost]
        [AuthController]
        public object? saveCaseTable_Participantes(CaseTable_Participantes inst)
        {
            return inst.Save();
        }
        [HttpPost]
        [AuthController]
        public object? updateCaseTable_Participantes(CaseTable_Participantes inst)
        {
            return inst.Update();
        }
        //Cat_Cargos
        [HttpPost]
        [AuthController]
        public List<CaseTable_VinculateCase> getCaseTable_VinculateCase(CaseTable_VinculateCase inst)
        {
            return inst.Get<CaseTable_VinculateCase>();
        }
          [HttpPost]
        [AuthController]
        public object? saveCaseTable_VinculateCase(CaseTable_VinculateCase inst)
        {
            return inst.Save();
        }
        [HttpPost]
        [AuthController]
        public object? updateCaseTable_VinculateCase(CaseTable_VinculateCase inst)
        {
            return inst.Update();
        }

    }
}
