//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { Cat_Cargos_Dependencias_ModelComponent }  from './Cat_Cargos_Dependencias_ModelComponent.js'
import { Cat_Dependencias_ModelComponent }  from './Cat_Dependencias_ModelComponent.js'
import { Tbl_Profile_ModelComponent }  from './Tbl_Profile_ModelComponent.js'
class CaseTable_Dependencias_Usuarios_ModelComponent extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {ModelProperty}*/ Cat_Cargos_Dependencias = { type: 'WSELECT',  ModelObject: ()=> new Cat_Cargos_Dependencias_ModelComponent()};
   /**@type {ModelProperty}*/ Cat_Dependencias = { type: 'WSELECT',  ModelObject: ()=> new Cat_Dependencias_ModelComponent()};
   /**@type {ModelProperty}*/ Tbl_Profile = { type: 'WSELECT',  ModelObject: ()=> new Tbl_Profile_ModelComponent()};
}
export { CaseTable_Dependencias_Usuarios_ModelComponent }
