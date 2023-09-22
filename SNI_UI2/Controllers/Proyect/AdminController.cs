using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using CAPA_NEGOCIO;
using CAPA_DATOS.Security; 
using CAPA_NEGOCIO.Views;
using CAPA_NEGOCIO.MAPEO;

namespace API.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class AdminController : ControllerBase
    {
        [HttpPost]
        #region INVESTIGADOR
        public Object TakePostulantes(Tbl_Profile inv)
        {
            inv.Estado = "POSTULANTE";
            return inv.Get<Tbl_Profile>();
        }
        public Object AdmitirPostulante(Tbl_Profile inv)
        {
            inv.Estado = "ACTIVO";
            //TODO enviar correo
            //CrearUser
            return inv.AdmitirPostulante();
        }
        public Object RechazarPostulante(Tbl_Profile inv)
        {
            inv.Estado = "RECHAZADO";
            //TODO enviar correo
            return inv.Update("Id_Perfil");
        }
        public Object TakeInvestigadores(Tbl_Profile inv)
        {
            inv.Estado = "ACTIVO";
            return inv.Get<Tbl_Profile>();
        }
        public Object TakeRechazados(Tbl_Profile inv)
        {
            inv.Estado = "RECHAZADO";
            return inv.Get<Tbl_Profile>();
        }
        #endregion
        #region CATALOGOS
        public Object TakeCat_Paises(Cat_Paises inv) { return inv.Get<Cat_Paises>(); }
     


        public Object TakeCat_Tipo_Servicio(Cat_Tipo_Servicio inv) { return inv.Get<Cat_Tipo_Servicio>(); }

        public Object? SaveCat_Paises(Cat_Paises inv) { return inv.Save(); }
        
       
       

        public Object? SaveCat_Tipo_Servicio(Cat_Tipo_Servicio inv) { return inv.Save(); }
       
        //UPDATES
        public Object UpdateCat_Paises(Cat_Paises inv) { return inv.Update("Id_Pais"); }
    
       

        public Object UpdateCat_Tipo_Servicio(Cat_Tipo_Servicio inv) { return inv.Update("Id_Tipo_Servicio"); }
        #endregion
       
    }
}
