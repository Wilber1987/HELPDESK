//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_Evidencias }  from './CaseTable_Evidencias.js'
class Cat_Tipo_Evidencia extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ IdTipo;
   /**@type {String}*/ Descripcion;
   /**@type {String}*/ Estado;
   /**@type {Array<CaseTable_Evidencias>} OneToMany*/ CaseTable_Evidencias;
}
export { Cat_Tipo_Evidencia }
