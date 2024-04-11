//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
class CaseTable_Comments_Tasks_ModelComponent extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {ModelProperty}*/ Id_Comentario = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ Body = { type: 'text' };
   /**@type {ModelProperty}*/ Estado = { type: 'SELECT', Dataset: ["ACTIVO", "INACTIVO"]  };
   /**@type {ModelProperty}*/ Fecha = { type: 'date' };
   /**@type {ModelProperty}*/ Id_Tarea = { type: 'number' };
   /**@type {ModelProperty}*/ Id_User = { type: 'number' };
   /**@type {ModelProperty}*/ NickName = { type: 'text' };
   /**@type {ModelProperty}*/ Mail = { type: 'text' };
   /**@type {ModelProperty}*/ Attach_Files = { type: 'text' };
   /**@type {ModelProperty}*/ Mails = { type: 'text' };
}
export { CaseTable_Comments_Tasks_ModelComponent }
