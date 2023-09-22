using DataBaseModel;
using Security;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
namespace API.Controllers {
   [Route("api/[controller]/[action]")]
   [ApiController]
   public class  ApiEntityQuestionnairesController : ControllerBase {
       //Cat_Categorias_Test
       [HttpPost]
       [AuthController]
       public List<Cat_Categorias_Test> getCat_Categorias_Test(Cat_Categorias_Test Inst) {
           return Inst.Get<Cat_Categorias_Test>();
       }
       [HttpPost]
       [AuthController]
       public object saveCat_Categorias_Test(Cat_Categorias_Test inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateCat_Categorias_Test(Cat_Categorias_Test inst) {
           return inst.Update();
       }
       //Cat_Tipo_Preguntas
       [HttpPost]
       [AuthController]
       public List<Cat_Tipo_Preguntas> getCat_Tipo_Preguntas(Cat_Tipo_Preguntas Inst) {
           return Inst.Get<Cat_Tipo_Preguntas>();
       }
       [HttpPost]
       [AuthController]
       public object saveCat_Tipo_Preguntas(Cat_Tipo_Preguntas inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateCat_Tipo_Preguntas(Cat_Tipo_Preguntas inst) {
           return inst.Update();
       }
       //Cat_Valor_Preguntas
       [HttpPost]
       [AuthController]
       public List<Cat_Valor_Preguntas> getCat_Valor_Preguntas(Cat_Valor_Preguntas Inst) {
           return Inst.Get<Cat_Valor_Preguntas>();
       }
       [HttpPost]
       [AuthController]
       public object saveCat_Valor_Preguntas(Cat_Valor_Preguntas inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateCat_Valor_Preguntas(Cat_Valor_Preguntas inst) {
           return inst.Update();
       }
       //Pregunta_Tests
       [HttpPost]
       [AuthController]
       public List<Pregunta_Tests> getPregunta_Tests(Pregunta_Tests Inst) {
           return Inst.Get<Pregunta_Tests>();
       }
       [HttpPost]
       [AuthController]
       public object savePregunta_Tests(Pregunta_Tests inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updatePregunta_Tests(Pregunta_Tests inst) {
           return inst.Update();
       }
       //Resultados_Pregunta_Tests
       [HttpPost]
       [AuthController]
       public List<Resultados_Pregunta_Tests> getResultados_Pregunta_Tests(Resultados_Pregunta_Tests Inst) {
           return Inst.Get<Resultados_Pregunta_Tests>();
       }
       [HttpPost]
       [AuthController]
       public object saveResultados_Pregunta_Tests(Resultados_Pregunta_Tests inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateResultados_Pregunta_Tests(Resultados_Pregunta_Tests inst) {
           return inst.Update();
       }
       //Resultados_Tests
       [HttpPost]
       [AuthController]
       public List<Resultados_Tests> getResultados_Tests(Resultados_Tests Inst) {
           return Inst.Get<Resultados_Tests>();
       }
       [HttpPost]
       [AuthController]
       public object saveResultados_Tests(Resultados_Tests inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateResultados_Tests(Resultados_Tests inst) {
           return inst.Update();
       }
       //Tests
       [HttpPost]
       [AuthController]
       public List<Tests> getTests(Tests Inst) {
           return Inst.Get<Tests>();
       }
       [HttpPost]
       [AuthController]
       public object saveTests(Tests inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object updateTests(Tests inst) {
           return inst.Update();
       }
   }
}
