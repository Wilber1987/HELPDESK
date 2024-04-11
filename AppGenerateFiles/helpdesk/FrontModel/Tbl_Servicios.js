//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { Cat_Dependencias }  from './Cat_Dependencias.js'
import { Cat_Tipo_Servicio }  from './Cat_Tipo_Servicio.js'
import { CaseTable_Case }  from './CaseTable_Case.js'
import { Tbl_Servicios_Profile }  from './Tbl_Servicios_Profile.js'
class Tbl_Servicios extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ Id_Servicio;
   /**@type {String}*/ Nombre_Servicio;
   /**@type {String}*/ Descripcion_Servicio;
   /**@type {String}*/ Visibilidad;
   /**@type {String}*/ Estado;
   /**@type {Date}*/ Fecha_Inicio;
   /**@type {Date}*/ Fecha_Finalizacion;
   /**@type {Cat_Dependencias} ManyToOne*/ Cat_Dependencias;
   /**@type {Cat_Tipo_Servicio} ManyToOne*/ Cat_Tipo_Servicio;
   /**@type {Array<CaseTable_Case>} OneToMany*/ CaseTable_Case;
   /**@type {Array<Tbl_Servicios_Profile>} OneToMany*/ Tbl_Servicios_Profile;
}
export { Tbl_Servicios }
