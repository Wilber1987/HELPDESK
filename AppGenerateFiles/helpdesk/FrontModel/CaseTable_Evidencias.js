//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_Tareas }  from './CaseTable_Tareas.js'
import { Cat_Tipo_Evidencia }  from './Cat_Tipo_Evidencia.js'
class CaseTable_Evidencias extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ IdEvidencia;
   /**@type {String}*/ Data;
   /**@type {CaseTable_Tareas} ManyToOne*/ CaseTable_Tareas;
   /**@type {Cat_Tipo_Evidencia} ManyToOne*/ Cat_Tipo_Evidencia;
}
export { CaseTable_Evidencias }
