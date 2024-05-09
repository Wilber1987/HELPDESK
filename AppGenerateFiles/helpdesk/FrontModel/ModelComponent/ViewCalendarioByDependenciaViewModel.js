//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
class ViewCalendarioByDependencia_ModelComponent extends EntityClass {
   constructor(props) {
       super(props, 'ViewHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {ModelProperty}*/ Id_Case = { type: 'number' };
   /**@type {ModelProperty}*/ Id_TareaPadre = { type: 'number' };
   /**@type {ModelProperty}*/ Fecha_Inicio = { type: 'date' };
   /**@type {ModelProperty}*/ Estado = { type: 'SELECT', Dataset: ["ACTIVO", "INACTIVO"]  };
   /**@type {ModelProperty}*/ IdCalendario = { type: 'number' };
   /**@type {ModelProperty}*/ Id_Tarea = { type: 'number' };
   /**@type {ModelProperty}*/ Id_Dependencia = { type: 'number' };
}
export { ViewCalendarioByDependencia_ModelComponent }
