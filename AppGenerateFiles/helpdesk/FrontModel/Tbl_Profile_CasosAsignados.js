//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_Case }  from './CaseTable_Case.js'
import { Tbl_Profile }  from './Tbl_Profile.js'
class Tbl_Profile_CasosAsignados extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Date}*/ Fecha;
   /**@type {CaseTable_Case} ManyToOne*/ CaseTable_Case;
   /**@type {Tbl_Profile} ManyToOne*/ Tbl_Profile;
}
export { Tbl_Profile_CasosAsignados }
