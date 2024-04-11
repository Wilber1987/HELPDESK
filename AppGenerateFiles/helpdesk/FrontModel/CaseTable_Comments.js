//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_Case }  from './CaseTable_Case.js'
class CaseTable_Comments extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ Id_Comentario;
   /**@type {String}*/ Body;
   /**@type {String}*/ Estado;
   /**@type {Date}*/ Fecha;
   /**@type {Number}*/ Id_User;
   /**@type {String}*/ NickName;
   /**@type {String}*/ Mail;
   /**@type {String}*/ Attach_Files;
   /**@type {String}*/ Mails;
   /**@type {CaseTable_Case} ManyToOne*/ CaseTable_Case;
}
export { CaseTable_Comments }
