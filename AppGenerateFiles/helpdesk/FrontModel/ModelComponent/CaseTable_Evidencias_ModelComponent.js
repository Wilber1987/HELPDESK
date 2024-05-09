//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_Tareas_ModelComponent }  from './CaseTable_Tareas_ModelComponent.js'
import { Cat_Tipo_Evidencia_ModelComponent }  from './Cat_Tipo_Evidencia_ModelComponent.js'
class CaseTable_Evidencias_ModelComponent extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {ModelProperty}*/ IdEvidencia = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ Data = { type: 'text' };
   /**@type {ModelProperty}*/ CaseTable_Tareas = { type: 'WSELECT',  ModelObject: ()=> new CaseTable_Tareas_ModelComponent()};
   /**@type {ModelProperty}*/ Cat_Tipo_Evidencia = { type: 'WSELECT',  ModelObject: ()=> new Cat_Tipo_Evidencia_ModelComponent()};
}
export { CaseTable_Evidencias_ModelComponent }
