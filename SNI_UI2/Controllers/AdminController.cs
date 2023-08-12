using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using CAPA_NEGOCIO;
using CAPA_NEGOCIO.Security; 
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
            return inv.Update("Id_Investigador");
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
        public Object TakeCat_instituciones(Cat_instituciones inv) { return inv.Get<Cat_instituciones>(); }
        public Object TakeCat_Paises(Cat_Paises inv) { return inv.Get<Cat_Paises>(); }
     
        public Object TakeCatRedesSociales(CatRedesSociales inv) { return inv.Get<CatRedesSociales>(); }
      
        public Object TakeCat_Tipo_Investigacion(Cat_Tipo_Investigacion inv) { return inv.Get<Cat_Tipo_Investigacion>(); }

        public Object TakeCat_Cargo_Proyecto(Cat_Cargo_Proyecto inv) { return inv.Get<Cat_Cargo_Proyecto>(); }
        public Object TakeCat_Tipo_Asociacion(Cat_Tipo_Asociacion inv) { return inv.Get<Cat_Tipo_Asociacion>(); }
        public Object TakeCat_Tipo_Proyecto(Cat_Tipo_Proyecto inv) { return inv.Get<Cat_Tipo_Proyecto>(); }

        public Object? SaveCat_instituciones(Cat_instituciones inv) { return inv.Save(); }
        public Object? SaveCat_Paises(Cat_Paises inv) { return inv.Save(); }
        
        public Object? SaveCatRedesSociales(CatRedesSociales inv) { return inv.Save(); }
       
        public Object? SaveCat_Tipo_Investigacion(Cat_Tipo_Investigacion inv) { return inv.Save(); }
       
        public Object? SaveCat_Cargo_Proyecto(Cat_Cargo_Proyecto inv) { return inv.Save(); }
        public Object? SaveCat_Tipo_Asociacion(Cat_Tipo_Asociacion inv) { return inv.Save(); }
        public Object? SaveCat_Tipo_Proyecto(Cat_Tipo_Proyecto inv) { return inv.Save(); }
       
        //UPDATES
        public Object UpdateCat_instituciones(Cat_instituciones inv) { return inv.Update("Id_Institucion"); }
        public Object UpdateCat_Paises(Cat_Paises inv) { return inv.Update("Id_Pais"); }
    
        public Object UpdateCatRedesSociales(CatRedesSociales inv) { return inv.Update("Id_RedSocial"); }
        public Object UpdateCat_Tipo_Investigacion(Cat_Tipo_Investigacion inv) { return inv.Update("Id_Tipo_Investigacion"); }
       
        public Object UpdateCat_Cargo_Proyecto(Cat_Cargo_Proyecto inv) { return inv.Update("Id_Cargo_Proyecto"); }
        public Object UpdateCat_Tipo_Asociacion(Cat_Tipo_Asociacion inv) { return inv.Update("Id_Tipo_Asociacion"); }
        public Object UpdateCat_Tipo_Proyecto(Cat_Tipo_Proyecto inv) { return inv.Update("Id_Tipo_Proyecto"); }
        #endregion
       
    }
}
