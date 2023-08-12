using DataBaseModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using API.Controllers;

namespace API.Controllers {
   [Route("api/[controller]/[action]")]
   [ApiController]
   public class  ApiViewDBOController : ControllerBase {
       //ViewInvestigacionesDisciplinas
       
       //ViewParticipantesProyectos
       [HttpPost]
       [AuthController]
       public List<ViewParticipantesProyectos> getViewParticipantesProyectos(ViewParticipantesProyectos Inst) {
           return Inst.Get<ViewParticipantesProyectos>();
       }
       //ViewCalendarioByDependencia
       [HttpPost]
       [AuthController]
       public List<ViewCalendarioByDependencia> getViewCalendarioByDependencia(ViewCalendarioByDependencia Inst) {
           return Inst.Get<ViewCalendarioByDependencia>();
       }
       //ViewActividadesParticipantes
       [HttpPost]
       [AuthController]
       public List<ViewActividadesParticipantes> getViewActividadesParticipantes(ViewActividadesParticipantes Inst) {
           return Inst.Get<ViewActividadesParticipantes>();
       }
   }
}
