//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_Participantes_ModelComponent }  from './CaseTable_Participantes_ModelComponent.js'
class Cat_Tipo_Participaciones_ModelComponent extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {ModelProperty}*/ Id_Tipo_Participacion = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ Descripcion = { type: 'text' };
   /**@type {ModelProperty}*/ CaseTable_Participantes = { type: 'MasterDetail',  ModelObject: ()=> new CaseTable_Participantes_ModelComponent()};
}
export { Cat_Tipo_Participaciones_ModelComponent }
