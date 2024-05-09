//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_Tareas_ModelComponent }  from './CaseTable_Tareas_ModelComponent.js'
import { Cat_Tipo_Participaciones_ModelComponent }  from './Cat_Tipo_Participaciones_ModelComponent.js'
import { Tbl_Profile_ModelComponent }  from './Tbl_Profile_ModelComponent.js'
class CaseTable_Participantes_ModelComponent extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {ModelProperty}*/ CaseTable_Tareas = { type: 'WSELECT',  ModelObject: ()=> new CaseTable_Tareas_ModelComponent()};
   /**@type {ModelProperty}*/ Cat_Tipo_Participaciones = { type: 'WSELECT',  ModelObject: ()=> new Cat_Tipo_Participaciones_ModelComponent()};
   /**@type {ModelProperty}*/ Tbl_Profile = { type: 'WSELECT',  ModelObject: ()=> new Tbl_Profile_ModelComponent()};
}
export { CaseTable_Participantes_ModelComponent }
