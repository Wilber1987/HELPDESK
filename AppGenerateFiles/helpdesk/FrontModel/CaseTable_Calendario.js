//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_Tareas }  from './CaseTable_Tareas.js'
import { Cat_Dependencias }  from './Cat_Dependencias.js'
class CaseTable_Calendario extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ IdCalendario;
   /**@type {String}*/ Estado;
   /**@type {Date}*/ Fecha_Inicio;
   /**@type {Date}*/ Fecha_Final;
   /**@type {CaseTable_Tareas} ManyToOne*/ CaseTable_Tareas;
   /**@type {Cat_Dependencias} ManyToOne*/ Cat_Dependencias;
}
export { CaseTable_Calendario }
