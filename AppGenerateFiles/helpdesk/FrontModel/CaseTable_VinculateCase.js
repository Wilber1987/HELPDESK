//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_Case }  from './CaseTable_Case.js'
class CaseTable_VinculateCase extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ Id_Vinculate;
   /**@type {String}*/ Descripcion;
   /**@type {Date}*/ Fecha;
   /**@type {Array<CaseTable_Case>} OneToMany*/ CaseTable_Case;
}
export { CaseTable_VinculateCase }
