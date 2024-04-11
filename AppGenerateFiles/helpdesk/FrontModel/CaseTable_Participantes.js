//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_Tareas }  from './CaseTable_Tareas.js'
import { Cat_Tipo_Participaciones }  from './Cat_Tipo_Participaciones.js'
import { Tbl_Profile }  from './Tbl_Profile.js'
class CaseTable_Participantes extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {CaseTable_Tareas} ManyToOne*/ CaseTable_Tareas;
   /**@type {Cat_Tipo_Participaciones} ManyToOne*/ Cat_Tipo_Participaciones;
   /**@type {Tbl_Profile} ManyToOne*/ Tbl_Profile;
}
export { CaseTable_Participantes }
