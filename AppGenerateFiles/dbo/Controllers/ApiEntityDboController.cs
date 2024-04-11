using DataBaseModel;
using Security;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
namespace API.Controllers {
   [Route("api/[controller]/[action]")]
   [ApiController]
   public class  ApiEntityDboController : ControllerBase {
       //Log
       [HttpPost]
       [AuthController]
       public List<Log> getLog(Log Inst) {
           return Inst.Get<Log>();
       }
       [HttpPost]
       [AuthController]
       public Log findLog(Log Inst) {
           return Inst.Find<Log>();
       }
       [HttpPost]
       [AuthController]
       public object saveLog(Log inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateLog(Log inst) {
           return inst.Update();
       }
   }
}
