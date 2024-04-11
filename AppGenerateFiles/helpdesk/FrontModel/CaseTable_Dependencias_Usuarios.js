//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { Cat_Cargos_Dependencias }  from './Cat_Cargos_Dependencias.js'
import { Cat_Dependencias }  from './Cat_Dependencias.js'
import { Tbl_Profile }  from './Tbl_Profile.js'
class CaseTable_Dependencias_Usuarios extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Cat_Cargos_Dependencias} ManyToOne*/ Cat_Cargos_Dependencias;
   /**@type {Cat_Dependencias} ManyToOne*/ Cat_Dependencias;
   /**@type {Tbl_Profile} ManyToOne*/ Tbl_Profile;
}
export { CaseTable_Dependencias_Usuarios }
