//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
class ViewCalendarioByDependencia extends EntityClass {
   constructor(props) {
       super(props, 'ViewHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ Id_Case;
   /**@type {Number}*/ Id_TareaPadre;
   /**@type {Date}*/ Fecha_Inicio;
   /**@type {String}*/ Estado;
   /**@type {Number}*/ IdCalendario;
   /**@type {Number}*/ Id_Tarea;
   /**@type {Number}*/ Id_Dependencia;
}
export { ViewCalendarioByDependencia }
