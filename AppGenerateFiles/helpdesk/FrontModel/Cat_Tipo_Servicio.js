//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { Tbl_Servicios }  from './Tbl_Servicios.js'
class Cat_Tipo_Servicio extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ Id_Tipo_Servicio;
   /**@type {String}*/ Descripcion;
   /**@type {String}*/ Estado;
   /**@type {String}*/ Icon;
   /**@type {Array<Tbl_Servicios>} OneToMany*/ Tbl_Servicios;
}
export { Cat_Tipo_Servicio }
