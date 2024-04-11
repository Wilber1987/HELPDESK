//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_Participantes }  from './CaseTable_Participantes.js'
class Cat_Tipo_Participaciones extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ Id_Tipo_Participacion;
   /**@type {String}*/ Descripcion;
   /**@type {Array<CaseTable_Participantes>} OneToMany*/ CaseTable_Participantes;
}
export { Cat_Tipo_Participaciones }
