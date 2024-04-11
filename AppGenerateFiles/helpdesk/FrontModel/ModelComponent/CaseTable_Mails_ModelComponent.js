//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_Case_ModelComponent }  from './CaseTable_Case_ModelComponent.js'
class CaseTable_Mails_ModelComponent extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {ModelProperty}*/ Id_Mail = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ Subject = { type: 'text' };
   /**@type {ModelProperty}*/ MessageID = { type: 'text' };
   /**@type {ModelProperty}*/ Sender = { type: 'text' };
   /**@type {ModelProperty}*/ FromAdress = { type: 'text' };
   /**@type {ModelProperty}*/ ReplyTo = { type: 'text' };
   /**@type {ModelProperty}*/ Bcc = { type: 'text' };
   /**@type {ModelProperty}*/ Cc = { type: 'text' };
   /**@type {ModelProperty}*/ ToAdress = { type: 'text' };
   /**@type {ModelProperty}*/ Date = { type: 'date' };
   /**@type {ModelProperty}*/ Uid = { type: 'text' };
   /**@type {ModelProperty}*/ Flags = { type: 'text' };
   /**@type {ModelProperty}*/ Estado = { type: 'SELECT', Dataset: ["ACTIVO", "INACTIVO"]  };
   /**@type {ModelProperty}*/ Body = { type: 'text' };
   /**@type {ModelProperty}*/ Attach_Files = { type: 'text' };
   /**@type {ModelProperty}*/ CaseTable_Case = { type: 'WSELECT',  ModelObject: ()=> new CaseTable_Case_ModelComponent()};
}
export { CaseTable_Mails_ModelComponent }
