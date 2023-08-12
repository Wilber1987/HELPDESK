using DataBaseModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using CAPA_NEGOCIO.MAPEO;
using API.Controllers;
using System.Collections.Generic;

namespace API.Controllers {
   [Route("api/[controller]/[action]")]
   [ApiController]
   public class  ApiEntityDBOController : ControllerBase {
       //Cat_Tipo_Evento

        [HttpPost]
        [AuthController]
        public List<CatalogoTipoEvidencia> getCatalogoTipoEvidencia(CatalogoTipoEvidencia Inst)
        {
            return Inst.Get<CatalogoTipoEvidencia>();
        }
        [HttpPost]
        [AuthController]
        public object? saveCatalogoTipoEvidencia(CatalogoTipoEvidencia inst)
        {
            return inst.Save();
        }
        [HttpPost]
        [AuthController]
        public object? updateCatalogoTipoEvidencia(CatalogoTipoEvidencia inst)
        {
            return inst.Update();
        }
       //ProyectoCatCargosDependencias
       [HttpPost]
       [AuthController]
       public List<ProyectoCatCargosDependencias> getProyectoCatCargosDependencias(ProyectoCatCargosDependencias Inst) {
           return Inst.Get<ProyectoCatCargosDependencias>();
       }
       [HttpPost]
       [AuthController]
       public object? saveProyectoCatCargosDependencias(ProyectoCatCargosDependencias inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateProyectoCatCargosDependencias(ProyectoCatCargosDependencias inst) {
           return inst.Update();
       }
       //ProyectoCatDependencias
       [HttpPost]
       [AuthController]
       public List<ProyectoCatDependencias> getProyectoCatDependencias(ProyectoCatDependencias Inst) {
           return Inst.Get<ProyectoCatDependencias>();
       }
       [HttpPost]
       [AuthController]
       public object? saveProyectoCatDependencias(ProyectoCatDependencias inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateProyectoCatDependencias(ProyectoCatDependencias inst) {
           return inst.Update();
       }
       //ProyectoCatTipoParticipaciones
       [HttpPost]
       [AuthController]
       public List<ProyectoCatTipoParticipaciones> getProyectoCatTipoParticipaciones(ProyectoCatTipoParticipaciones Inst) {
           return Inst.Get<ProyectoCatTipoParticipaciones>();
       }
       [HttpPost]
       [AuthController]
       public object? saveProyectoCatTipoParticipaciones(ProyectoCatTipoParticipaciones inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateProyectoCatTipoParticipaciones(ProyectoCatTipoParticipaciones inst) {
           return inst.Update();
       }
       //ProyectoTableAgenda
       [HttpPost]
       [AuthController]
       public List<ProyectoTableAgenda> getProyectoTableAgenda(ProyectoTableAgenda Inst) {
           return Inst.Get<ProyectoTableAgenda>();
       }
       [HttpPost]
       [AuthController]
       public object? saveProyectoTableAgenda(ProyectoTableAgenda inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateProyectoTableAgenda(ProyectoTableAgenda inst) {
           return inst.Update();
       }
       //ProyectoTableDependencias_Usuarios
       [HttpPost]
       [AuthController]
       public List<ProyectoTableDependencias_Usuarios> getProyectoTableDependencias_Usuarios(ProyectoTableDependencias_Usuarios Inst) {
           return Inst.Get<ProyectoTableDependencias_Usuarios>();
       }
       [HttpPost]
       [AuthController]
       public object? saveProyectoTableDependencias_Usuarios(ProyectoTableDependencias_Usuarios inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateProyectoTableDependencias_Usuarios(ProyectoTableDependencias_Usuarios inst) {
           return inst.Update();
       }
       //ProyectoTableEvidencias
       [HttpPost]
       [AuthController]
       public List<ProyectoTableEvidencias> getProyectoTableEvidencias(ProyectoTableEvidencias Inst) {
           return Inst.Get<ProyectoTableEvidencias>();
       }
       [HttpPost]
       [AuthController]
       public object? saveProyectoTableEvidencias(ProyectoTableEvidencias inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateProyectoTableEvidencias(ProyectoTableEvidencias inst) {
           return inst.Update();
       }
       //Tbl_Datos_Laborales
       //Cat_Paises
       [HttpPost]
       [AuthController]
       public List<Cat_Paises> getCat_Paises(Cat_Paises Inst) {
           return Inst.Get<Cat_Paises>();
       }
       [HttpPost]
       [AuthController]
       public object? saveCat_Paises(Cat_Paises inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateCat_Paises(Cat_Paises inst) {
           return inst.Update();
       }
       //Cat_TipoLocalidad
       //Cat_instituciones
       [HttpPost]
       [AuthController]
       public List<Cat_instituciones> getCat_instituciones(Cat_instituciones Inst) {
           return Inst.Get<Cat_instituciones>();
       }
       [HttpPost]
       [AuthController]
       public object? saveCat_instituciones(Cat_instituciones inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateCat_instituciones(Cat_instituciones inst) {
           return inst.Update();
       }
       //Cat_Tipo_Investigacion
       [HttpPost]
       [AuthController]
       public List<Cat_Tipo_Investigacion> getCat_Tipo_Investigacion(Cat_Tipo_Investigacion Inst) {
           return Inst.Get<Cat_Tipo_Investigacion>();
       }
       [HttpPost]
       [AuthController]
       public object? saveCat_Tipo_Investigacion(Cat_Tipo_Investigacion inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateCat_Tipo_Investigacion(Cat_Tipo_Investigacion inst) {
           return inst.Update();
       }
       //Tbl_Profile
       [HttpPost]
       [AuthController]
       public List<Tbl_Profile> getTbl_Profile(Tbl_Profile Inst) {
           return Inst.Get<Tbl_Profile>();
       }
       [HttpPost]
       [AuthController]
       public object? saveTbl_Profile(Tbl_Profile inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateTbl_Profile(Tbl_Profile inst) {
           return inst.Update();
       }
       //Cat_Tipo_Asociacion
       [HttpPost]
       [AuthController]
       public List<Cat_Tipo_Asociacion> getCat_Tipo_Asociacion(Cat_Tipo_Asociacion Inst) {
           return Inst.Get<Cat_Tipo_Asociacion>();
       }
       [HttpPost]
       [AuthController]
       public object? saveCat_Tipo_Asociacion(Cat_Tipo_Asociacion inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateCat_Tipo_Asociacion(Cat_Tipo_Asociacion inst) {
           return inst.Update();
       }
       //Tbl_Instituciones_Asociadas
       [HttpPost]
       [AuthController]
       public List<Tbl_Instituciones_Asociadas> getTbl_Instituciones_Asociadas(Tbl_Instituciones_Asociadas Inst) {
           return Inst.Get<Tbl_Instituciones_Asociadas>();
       }
       [HttpPost]
       [AuthController]
       public object? saveTbl_Instituciones_Asociadas(Tbl_Instituciones_Asociadas inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateTbl_Instituciones_Asociadas(Tbl_Instituciones_Asociadas inst) {
           return inst.Update();
       }
 
       //Cat_Tipo_Proyecto
       [HttpPost]
       [AuthController]
       public List<Cat_Tipo_Proyecto> getCat_Tipo_Proyecto(Cat_Tipo_Proyecto Inst) {
           return Inst.Get<Cat_Tipo_Proyecto>();
       }
       [HttpPost]
       [AuthController]
       public object? saveCat_Tipo_Proyecto(Cat_Tipo_Proyecto inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateCat_Tipo_Proyecto(Cat_Tipo_Proyecto inst) {
           return inst.Update();
       }
       //Tbl_Proyectos
       [HttpPost]
       [AuthController]
       public List<Tbl_Proyectos> getTbl_Proyectos(Tbl_Proyectos Inst) {
           return Inst.Get<Tbl_Proyectos>();
       }
       [HttpPost]
       [AuthController]
       public object? saveTbl_Proyectos(Tbl_Proyectos inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateTbl_Proyectos(Tbl_Proyectos inst) {
           return inst.Update();
       }
       //Cat_Cargo_Proyecto
       [HttpPost]
       [AuthController]
       public List<Cat_Cargo_Proyecto> getCat_Cargo_Proyecto(Cat_Cargo_Proyecto Inst) {
           return Inst.Get<Cat_Cargo_Proyecto>();
       }
       [HttpPost]
       [AuthController]
       public object? saveCat_Cargo_Proyecto(Cat_Cargo_Proyecto inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateCat_Cargo_Proyecto(Cat_Cargo_Proyecto inst) {
           return inst.Update();
       }
       //Tbl_Participantes_Proyectos
       [HttpPost]
       [AuthController]
       public List<Tbl_Participantes_Proyectos> getTbl_Participantes_Proyectos(Tbl_Participantes_Proyectos Inst) {
           return Inst.Get<Tbl_Participantes_Proyectos>();
       }
       [HttpPost]
       [AuthController]
       public object? saveTbl_Participantes_Proyectos(Tbl_Participantes_Proyectos inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateTbl_Participantes_Proyectos(Tbl_Participantes_Proyectos inst) {
           return inst.Update();
       }
       //CatRedesSociales
       [HttpPost]
       [AuthController]
       public List<CatRedesSociales> getCatRedesSociales(CatRedesSociales Inst) {
           return Inst.Get<CatRedesSociales>();
       }
       [HttpPost]
       [AuthController]
       public object? saveCatRedesSociales(CatRedesSociales inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateCatRedesSociales(CatRedesSociales inst) {
           return inst.Update();
       }
       //Tbl_Invest_RedS
       [HttpPost]
       [AuthController]
       public List<Tbl_Invest_RedS> getTbl_Invest_RedS(Tbl_Invest_RedS Inst) {
           return Inst.Get<Tbl_Invest_RedS>();
       }
       [HttpPost]
       [AuthController]
       public object? saveTbl_Invest_RedS(Tbl_Invest_RedS inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateTbl_Invest_RedS(Tbl_Invest_RedS inst) {
           return inst.Update();
       }

       //ProyectoTableActividades
       [HttpPost]
       [AuthController]
       public List<ProyectoTableActividades> getProyectoTableActividades(ProyectoTableActividades Inst) {
           return Inst.Get<ProyectoTableActividades>();
       }
       [HttpPost]
       [AuthController]
       public object? saveProyectoTableActividades(ProyectoTableActividades inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateProyectoTableActividades(ProyectoTableActividades inst) {
           return inst.Update();
       }
       //ProyectoTableCalendario
       [HttpPost]
       [AuthController]
       public List<ViewCalendarioByDependencia> getProyectoTableCalendario(ViewCalendarioByDependencia Inst) {
           return Inst.Get<ViewCalendarioByDependencia>();
       }
       [HttpPost]
       [AuthController]
       public object? saveProyectoTableCalendario(ProyectoTableCalendario inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateProyectoTableCalendario(ProyectoTableCalendario inst) {
           return inst.Update();
       }
       //ProyectoTableTareas
       [HttpPost]
       [AuthController]
       public List<ProyectoTableTareas> getProyectoTableTareas(ProyectoTableTareas Inst) {
           return Inst.Get<ProyectoTableTareas>();
       }
       [HttpPost]
       [AuthController]
       public object? saveProyectoTableTareas(ProyectoTableTareas inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateProyectoTableTareas(ProyectoTableTareas inst) {
           return inst.Update();
       }
       //ProyectoTableParticipantes
       [HttpPost]
       [AuthController]
       public List<ProyectoTableParticipantes> getProyectoTableParticipantes(ProyectoTableParticipantes Inst) {
           return Inst.Get<ProyectoTableParticipantes>();
       }
       [HttpPost]
       [AuthController]
       public object? saveProyectoTableParticipantes(ProyectoTableParticipantes inst) {
           return inst.Save();
       }
       [HttpPost]
       [AuthController]
       public object? updateProyectoTableParticipantes(ProyectoTableParticipantes inst) {
           return inst.Update();
       }
       //Cat_Cargos
      
   }
}
