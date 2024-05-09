using DataBaseModel;
using Security;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
namespace API.Controllers {
   [Route("api/[controller]/[action]")]
   [ApiController]
   public class  ApiEntityHelpdeskController : ControllerBase {
       //CaseTable_Comments_Tasks
       [HttpPost]
       [AuthController]
       public List<CaseTable_Comments_Tasks> getCaseTable_Comments_Tasks(CaseTable_Comments_Tasks Inst) {
           return Inst.Get<CaseTable_Comments_Tasks>();
       }
       [HttpPost]
       [AuthController]
       public CaseTable_Comments_Tasks findCaseTable_Comments_Tasks(CaseTable_Comments_Tasks Inst) {
           return Inst.Find<CaseTable_Comments_Tasks>();
       }
       [HttpPost]
       [AuthController]
       public object saveCaseTable_Comments_Tasks(CaseTable_Comments_Tasks inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateCaseTable_Comments_Tasks(CaseTable_Comments_Tasks inst) {
           return inst.Update();
       }
       //Tbl_Servicios_Profile
       [HttpPost]
       [AuthController]
       public List<Tbl_Servicios_Profile> getTbl_Servicios_Profile(Tbl_Servicios_Profile Inst) {
           return Inst.Get<Tbl_Servicios_Profile>();
       }
       [HttpPost]
       [AuthController]
       public Tbl_Servicios_Profile findTbl_Servicios_Profile(Tbl_Servicios_Profile Inst) {
           return Inst.Find<Tbl_Servicios_Profile>();
       }
       [HttpPost]
       [AuthController]
       public object saveTbl_Servicios_Profile(Tbl_Servicios_Profile inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateTbl_Servicios_Profile(Tbl_Servicios_Profile inst) {
           return inst.Update();
       }
       //Tbl_Profile_CasosAsignados
       [HttpPost]
       [AuthController]
       public List<Tbl_Profile_CasosAsignados> getTbl_Profile_CasosAsignados(Tbl_Profile_CasosAsignados Inst) {
           return Inst.Get<Tbl_Profile_CasosAsignados>();
       }
       [HttpPost]
       [AuthController]
       public Tbl_Profile_CasosAsignados findTbl_Profile_CasosAsignados(Tbl_Profile_CasosAsignados Inst) {
           return Inst.Find<Tbl_Profile_CasosAsignados>();
       }
       [HttpPost]
       [AuthController]
       public object saveTbl_Profile_CasosAsignados(Tbl_Profile_CasosAsignados inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateTbl_Profile_CasosAsignados(Tbl_Profile_CasosAsignados inst) {
           return inst.Update();
       }
       //CaseTable_Case
       [HttpPost]
       [AuthController]
       public List<CaseTable_Case> getCaseTable_Case(CaseTable_Case Inst) {
           return Inst.Get<CaseTable_Case>();
       }
       [HttpPost]
       [AuthController]
       public CaseTable_Case findCaseTable_Case(CaseTable_Case Inst) {
           return Inst.Find<CaseTable_Case>();
       }
       [HttpPost]
       [AuthController]
       public object saveCaseTable_Case(CaseTable_Case inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateCaseTable_Case(CaseTable_Case inst) {
           return inst.Update();
       }
       //CaseTable_Calendario
       [HttpPost]
       [AuthController]
       public List<CaseTable_Calendario> getCaseTable_Calendario(CaseTable_Calendario Inst) {
           return Inst.Get<CaseTable_Calendario>();
       }
       [HttpPost]
       [AuthController]
       public CaseTable_Calendario findCaseTable_Calendario(CaseTable_Calendario Inst) {
           return Inst.Find<CaseTable_Calendario>();
       }
       [HttpPost]
       [AuthController]
       public object saveCaseTable_Calendario(CaseTable_Calendario inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateCaseTable_Calendario(CaseTable_Calendario inst) {
           return inst.Update();
       }
       //CaseTable_Tareas
       [HttpPost]
       [AuthController]
       public List<CaseTable_Tareas> getCaseTable_Tareas(CaseTable_Tareas Inst) {
           return Inst.Get<CaseTable_Tareas>();
       }
       [HttpPost]
       [AuthController]
       public CaseTable_Tareas findCaseTable_Tareas(CaseTable_Tareas Inst) {
           return Inst.Find<CaseTable_Tareas>();
       }
       [HttpPost]
       [AuthController]
       public object saveCaseTable_Tareas(CaseTable_Tareas inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateCaseTable_Tareas(CaseTable_Tareas inst) {
           return inst.Update();
       }
       //CaseTable_Participantes
       [HttpPost]
       [AuthController]
       public List<CaseTable_Participantes> getCaseTable_Participantes(CaseTable_Participantes Inst) {
           return Inst.Get<CaseTable_Participantes>();
       }
       [HttpPost]
       [AuthController]
       public CaseTable_Participantes findCaseTable_Participantes(CaseTable_Participantes Inst) {
           return Inst.Find<CaseTable_Participantes>();
       }
       [HttpPost]
       [AuthController]
       public object saveCaseTable_Participantes(CaseTable_Participantes inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateCaseTable_Participantes(CaseTable_Participantes inst) {
           return inst.Update();
       }
       //CaseTable_Agenda
       [HttpPost]
       [AuthController]
       public List<CaseTable_Agenda> getCaseTable_Agenda(CaseTable_Agenda Inst) {
           return Inst.Get<CaseTable_Agenda>();
       }
       [HttpPost]
       [AuthController]
       public CaseTable_Agenda findCaseTable_Agenda(CaseTable_Agenda Inst) {
           return Inst.Find<CaseTable_Agenda>();
       }
       [HttpPost]
       [AuthController]
       public object saveCaseTable_Agenda(CaseTable_Agenda inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateCaseTable_Agenda(CaseTable_Agenda inst) {
           return inst.Update();
       }
       //CaseTable_Comments
       [HttpPost]
       [AuthController]
       public List<CaseTable_Comments> getCaseTable_Comments(CaseTable_Comments Inst) {
           return Inst.Get<CaseTable_Comments>();
       }
       [HttpPost]
       [AuthController]
       public CaseTable_Comments findCaseTable_Comments(CaseTable_Comments Inst) {
           return Inst.Find<CaseTable_Comments>();
       }
       [HttpPost]
       [AuthController]
       public object saveCaseTable_Comments(CaseTable_Comments inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateCaseTable_Comments(CaseTable_Comments inst) {
           return inst.Update();
       }
       //CaseTable_Dependencias_Usuarios
       [HttpPost]
       [AuthController]
       public List<CaseTable_Dependencias_Usuarios> getCaseTable_Dependencias_Usuarios(CaseTable_Dependencias_Usuarios Inst) {
           return Inst.Get<CaseTable_Dependencias_Usuarios>();
       }
       [HttpPost]
       [AuthController]
       public CaseTable_Dependencias_Usuarios findCaseTable_Dependencias_Usuarios(CaseTable_Dependencias_Usuarios Inst) {
           return Inst.Find<CaseTable_Dependencias_Usuarios>();
       }
       [HttpPost]
       [AuthController]
       public object saveCaseTable_Dependencias_Usuarios(CaseTable_Dependencias_Usuarios inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateCaseTable_Dependencias_Usuarios(CaseTable_Dependencias_Usuarios inst) {
           return inst.Update();
       }
       //CaseTable_Evidencias
       [HttpPost]
       [AuthController]
       public List<CaseTable_Evidencias> getCaseTable_Evidencias(CaseTable_Evidencias Inst) {
           return Inst.Get<CaseTable_Evidencias>();
       }
       [HttpPost]
       [AuthController]
       public CaseTable_Evidencias findCaseTable_Evidencias(CaseTable_Evidencias Inst) {
           return Inst.Find<CaseTable_Evidencias>();
       }
       [HttpPost]
       [AuthController]
       public object saveCaseTable_Evidencias(CaseTable_Evidencias inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateCaseTable_Evidencias(CaseTable_Evidencias inst) {
           return inst.Update();
       }
       //CaseTable_Mails
       [HttpPost]
       [AuthController]
       public List<CaseTable_Mails> getCaseTable_Mails(CaseTable_Mails Inst) {
           return Inst.Get<CaseTable_Mails>();
       }
       [HttpPost]
       [AuthController]
       public CaseTable_Mails findCaseTable_Mails(CaseTable_Mails Inst) {
           return Inst.Find<CaseTable_Mails>();
       }
       [HttpPost]
       [AuthController]
       public object saveCaseTable_Mails(CaseTable_Mails inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateCaseTable_Mails(CaseTable_Mails inst) {
           return inst.Update();
       }
       //CaseTable_VinculateCase
       [HttpPost]
       [AuthController]
       public List<CaseTable_VinculateCase> getCaseTable_VinculateCase(CaseTable_VinculateCase Inst) {
           return Inst.Get<CaseTable_VinculateCase>();
       }
       [HttpPost]
       [AuthController]
       public CaseTable_VinculateCase findCaseTable_VinculateCase(CaseTable_VinculateCase Inst) {
           return Inst.Find<CaseTable_VinculateCase>();
       }
       [HttpPost]
       [AuthController]
       public object saveCaseTable_VinculateCase(CaseTable_VinculateCase inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateCaseTable_VinculateCase(CaseTable_VinculateCase inst) {
           return inst.Update();
       }
       //Cat_Cargos_Dependencias
       [HttpPost]
       [AuthController]
       public List<Cat_Cargos_Dependencias> getCat_Cargos_Dependencias(Cat_Cargos_Dependencias Inst) {
           return Inst.Get<Cat_Cargos_Dependencias>();
       }
       [HttpPost]
       [AuthController]
       public Cat_Cargos_Dependencias findCat_Cargos_Dependencias(Cat_Cargos_Dependencias Inst) {
           return Inst.Find<Cat_Cargos_Dependencias>();
       }
       [HttpPost]
       [AuthController]
       public object saveCat_Cargos_Dependencias(Cat_Cargos_Dependencias inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateCat_Cargos_Dependencias(Cat_Cargos_Dependencias inst) {
           return inst.Update();
       }
       //Cat_Dependencias
       [HttpPost]
       [AuthController]
       public List<Cat_Dependencias> getCat_Dependencias(Cat_Dependencias Inst) {
           return Inst.Get<Cat_Dependencias>();
       }
       [HttpPost]
       [AuthController]
       public Cat_Dependencias findCat_Dependencias(Cat_Dependencias Inst) {
           return Inst.Find<Cat_Dependencias>();
       }
       [HttpPost]
       [AuthController]
       public object saveCat_Dependencias(Cat_Dependencias inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateCat_Dependencias(Cat_Dependencias inst) {
           return inst.Update();
       }
       //Cat_Paises
       [HttpPost]
       [AuthController]
       public List<Cat_Paises> getCat_Paises(Cat_Paises Inst) {
           return Inst.Get<Cat_Paises>();
       }
       [HttpPost]
       [AuthController]
       public Cat_Paises findCat_Paises(Cat_Paises Inst) {
           return Inst.Find<Cat_Paises>();
       }
       [HttpPost]
       [AuthController]
       public object saveCat_Paises(Cat_Paises inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateCat_Paises(Cat_Paises inst) {
           return inst.Update();
       }
       //Cat_Tipo_Evidencia
       [HttpPost]
       [AuthController]
       public List<Cat_Tipo_Evidencia> getCat_Tipo_Evidencia(Cat_Tipo_Evidencia Inst) {
           return Inst.Get<Cat_Tipo_Evidencia>();
       }
       [HttpPost]
       [AuthController]
       public Cat_Tipo_Evidencia findCat_Tipo_Evidencia(Cat_Tipo_Evidencia Inst) {
           return Inst.Find<Cat_Tipo_Evidencia>();
       }
       [HttpPost]
       [AuthController]
       public object saveCat_Tipo_Evidencia(Cat_Tipo_Evidencia inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateCat_Tipo_Evidencia(Cat_Tipo_Evidencia inst) {
           return inst.Update();
       }
       //Cat_Tipo_Participaciones
       [HttpPost]
       [AuthController]
       public List<Cat_Tipo_Participaciones> getCat_Tipo_Participaciones(Cat_Tipo_Participaciones Inst) {
           return Inst.Get<Cat_Tipo_Participaciones>();
       }
       [HttpPost]
       [AuthController]
       public Cat_Tipo_Participaciones findCat_Tipo_Participaciones(Cat_Tipo_Participaciones Inst) {
           return Inst.Find<Cat_Tipo_Participaciones>();
       }
       [HttpPost]
       [AuthController]
       public object saveCat_Tipo_Participaciones(Cat_Tipo_Participaciones inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateCat_Tipo_Participaciones(Cat_Tipo_Participaciones inst) {
           return inst.Update();
       }
       //Cat_Tipo_Servicio
       [HttpPost]
       [AuthController]
       public List<Cat_Tipo_Servicio> getCat_Tipo_Servicio(Cat_Tipo_Servicio Inst) {
           return Inst.Get<Cat_Tipo_Servicio>();
       }
       [HttpPost]
       [AuthController]
       public Cat_Tipo_Servicio findCat_Tipo_Servicio(Cat_Tipo_Servicio Inst) {
           return Inst.Find<Cat_Tipo_Servicio>();
       }
       [HttpPost]
       [AuthController]
       public object saveCat_Tipo_Servicio(Cat_Tipo_Servicio inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateCat_Tipo_Servicio(Cat_Tipo_Servicio inst) {
           return inst.Update();
       }
       //Tbl_Servicios
       [HttpPost]
       [AuthController]
       public List<Tbl_Servicios> getTbl_Servicios(Tbl_Servicios Inst) {
           return Inst.Get<Tbl_Servicios>();
       }
       [HttpPost]
       [AuthController]
       public Tbl_Servicios findTbl_Servicios(Tbl_Servicios Inst) {
           return Inst.Find<Tbl_Servicios>();
       }
       [HttpPost]
       [AuthController]
       public object saveTbl_Servicios(Tbl_Servicios inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateTbl_Servicios(Tbl_Servicios inst) {
           return inst.Update();
       }
   }
}
