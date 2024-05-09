//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_Case }  from './CaseTable_Case.js'
class CaseTable_Mails extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ Id_Mail;
   /**@type {String}*/ Subject;
   /**@type {String}*/ MessageID;
   /**@type {String}*/ Sender;
   /**@type {String}*/ FromAdress;
   /**@type {String}*/ ReplyTo;
   /**@type {String}*/ Bcc;
   /**@type {String}*/ Cc;
   /**@type {String}*/ ToAdress;
   /**@type {Date}*/ Date;
   /**@type {String}*/ Uid;
   /**@type {String}*/ Flags;
   /**@type {String}*/ Estado;
   /**@type {String}*/ Body;
   /**@type {String}*/ Attach_Files;
   /**@type {CaseTable_Case} ManyToOne*/ CaseTable_Case;
}
export { CaseTable_Mails }
