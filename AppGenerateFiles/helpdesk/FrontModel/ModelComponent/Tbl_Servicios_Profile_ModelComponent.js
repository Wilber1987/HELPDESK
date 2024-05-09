//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { Tbl_Profile_ModelComponent }  from './Tbl_Profile_ModelComponent.js'
import { Tbl_Servicios_ModelComponent }  from './Tbl_Servicios_ModelComponent.js'
class Tbl_Servicios_Profile_ModelComponent extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {ModelProperty}*/ Tbl_Profile = { type: 'WSELECT',  ModelObject: ()=> new Tbl_Profile_ModelComponent()};
   /**@type {ModelProperty}*/ Tbl_Servicios = { type: 'WSELECT',  ModelObject: ()=> new Tbl_Servicios_ModelComponent()};
}
export { Tbl_Servicios_Profile_ModelComponent }
