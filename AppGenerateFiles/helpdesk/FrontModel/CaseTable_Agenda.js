//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { Cat_Dependencias }  from './Cat_Dependencias.js'
import { Tbl_Profile }  from './Tbl_Profile.js'
class CaseTable_Agenda extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ IdAgenda;
   /**@type {String}*/ Dia;
   /**@type {String}*/ Hora_Inicial;
   /**@type {String}*/ Hora_Final;
   /**@type {Date}*/ Fecha_Caducidad;
   /**@type {Cat_Dependencias} ManyToOne*/ Cat_Dependencias;
   /**@type {Tbl_Profile} ManyToOne*/ Tbl_Profile;
}
export { CaseTable_Agenda }
