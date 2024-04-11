//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_Tareas_ModelComponent }  from './CaseTable_Tareas_ModelComponent.js'
import { Cat_Dependencias_ModelComponent }  from './Cat_Dependencias_ModelComponent.js'
class CaseTable_Calendario_ModelComponent extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {ModelProperty}*/ IdCalendario = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ Estado = { type: 'SELECT', Dataset: ["ACTIVO", "INACTIVO"]  };
   /**@type {ModelProperty}*/ Fecha_Inicio = { type: 'date' };
   /**@type {ModelProperty}*/ Fecha_Final = { type: 'date' };
   /**@type {ModelProperty}*/ CaseTable_Tareas = { type: 'WSELECT',  ModelObject: ()=> new CaseTable_Tareas_ModelComponent()};
   /**@type {ModelProperty}*/ Cat_Dependencias = { type: 'WSELECT',  ModelObject: ()=> new Cat_Dependencias_ModelComponent()};
}
export { CaseTable_Calendario_ModelComponent }
