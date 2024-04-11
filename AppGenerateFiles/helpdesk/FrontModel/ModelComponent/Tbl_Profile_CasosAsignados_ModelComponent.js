//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_Case_ModelComponent }  from './CaseTable_Case_ModelComponent.js'
import { Tbl_Profile_ModelComponent }  from './Tbl_Profile_ModelComponent.js'
class Tbl_Profile_CasosAsignados_ModelComponent extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {ModelProperty}*/ Fecha = { type: 'date' };
   /**@type {ModelProperty}*/ CaseTable_Case = { type: 'WSELECT',  ModelObject: ()=> new CaseTable_Case_ModelComponent()};
   /**@type {ModelProperty}*/ Tbl_Profile = { type: 'WSELECT',  ModelObject: ()=> new Tbl_Profile_ModelComponent()};
}
export { Tbl_Profile_CasosAsignados_ModelComponent }
