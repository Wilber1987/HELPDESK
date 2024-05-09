//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { Tbl_Profile }  from './Tbl_Profile.js'
import { Tbl_Servicios }  from './Tbl_Servicios.js'
class Tbl_Servicios_Profile extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Tbl_Profile} ManyToOne*/ Tbl_Profile;
   /**@type {Tbl_Servicios} ManyToOne*/ Tbl_Servicios;
}
export { Tbl_Servicios_Profile }
