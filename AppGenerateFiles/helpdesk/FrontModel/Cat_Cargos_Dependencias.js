//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_Dependencias_Usuarios }  from './CaseTable_Dependencias_Usuarios.js'
class Cat_Cargos_Dependencias extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ Id_Cargo;
   /**@type {String}*/ Descripcion;
   /**@type {Array<CaseTable_Dependencias_Usuarios>} OneToMany*/ CaseTable_Dependencias_Usuarios;
}
export { Cat_Cargos_Dependencias }
