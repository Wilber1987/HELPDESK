//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_Case_ModelComponent }  from './CaseTable_Case_ModelComponent.js'
import { CaseTable_Tareas_ModelComponent }  from './CaseTable_Tareas_ModelComponent.js'
import { CaseTable_Calendario_ModelComponent }  from './CaseTable_Calendario_ModelComponent.js'
import { CaseTable_Evidencias_ModelComponent }  from './CaseTable_Evidencias_ModelComponent.js'
import { CaseTable_Participantes_ModelComponent }  from './CaseTable_Participantes_ModelComponent.js'
import { CaseTable_Tareas_ModelComponent }  from './CaseTable_Tareas_ModelComponent.js'
class CaseTable_Tareas_ModelComponent extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {ModelProperty}*/ Id_Tarea = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ Titulo = { type: 'text' };
   /**@type {ModelProperty}*/ Descripcion = { type: 'text' };
   /**@type {ModelProperty}*/ Estado = { type: 'SELECT', Dataset: ["ACTIVO", "INACTIVO"]  };
   /**@type {ModelProperty}*/ Fecha_Inicio = { type: 'date' };
   /**@type {ModelProperty}*/ Fecha_Finalizacion = { type: 'date' };
   /**@type {ModelProperty}*/ Fecha_Inicio_Proceso = { type: 'date' };
   /**@type {ModelProperty}*/ Fecha_Finalizacion_Proceso = { type: 'date' };
   /**@type {ModelProperty}*/ CaseTable_Case = { type: 'WSELECT',  ModelObject: ()=> new CaseTable_Case_ModelComponent()};
   /**@type {ModelProperty}*/ CaseTable_Tareas = { type: 'WSELECT',  ModelObject: ()=> new CaseTable_Tareas_ModelComponent()};
   /**@type {ModelProperty}*/ CaseTable_Calendario = { type: 'MasterDetail',  ModelObject: ()=> new CaseTable_Calendario_ModelComponent()};
   /**@type {ModelProperty}*/ CaseTable_Evidencias = { type: 'MasterDetail',  ModelObject: ()=> new CaseTable_Evidencias_ModelComponent()};
   /**@type {ModelProperty}*/ CaseTable_Participantes = { type: 'MasterDetail',  ModelObject: ()=> new CaseTable_Participantes_ModelComponent()};
   /**@type {ModelProperty}*/ CaseTable_Tareas = { type: 'MasterDetail',  ModelObject: ()=> new CaseTable_Tareas_ModelComponent()};
}
export { CaseTable_Tareas_ModelComponent }
