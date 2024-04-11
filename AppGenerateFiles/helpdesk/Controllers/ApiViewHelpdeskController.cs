using DataBaseModel;
using Security;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
namespace API.Controllers {
   [Route("api/[controller]/[action]")]
   [ApiController]
   public class  ApiViewHelpdeskController : ControllerBase {
       //ViewCalendarioByDependencia
       [HttpPost]
       [AuthController]
       public List<ViewCalendarioByDependencia> getViewCalendarioByDependencia(ViewCalendarioByDependencia Inst) {
           return Inst.Get<ViewCalendarioByDependencia>();
       }
       [HttpPost]
       [AuthController]
       public ViewCalendarioByDependencia findViewCalendarioByDependencia(ViewCalendarioByDependencia Inst) {
           return Inst.Find<ViewCalendarioByDependencia>();
       }
       //ViewActividadesParticipantes
       [HttpPost]
       [AuthController]
       public List<ViewActividadesParticipantes> getViewActividadesParticipantes(ViewActividadesParticipantes Inst) {
           return Inst.Get<ViewActividadesParticipantes>();
       }
       [HttpPost]
       [AuthController]
       public ViewActividadesParticipantes findViewActividadesParticipantes(ViewActividadesParticipantes Inst) {
           return Inst.Find<ViewActividadesParticipantes>();
       }
   }
}
