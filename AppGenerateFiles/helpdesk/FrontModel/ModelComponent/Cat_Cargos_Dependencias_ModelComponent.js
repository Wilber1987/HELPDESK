//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_Dependencias_Usuarios_ModelComponent }  from './CaseTable_Dependencias_Usuarios_ModelComponent.js'
class Cat_Cargos_Dependencias_ModelComponent extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {ModelProperty}*/ Id_Cargo = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ Descripcion = { type: 'text' };
   /**@type {ModelProperty}*/ CaseTable_Dependencias_Usuarios = { type: 'MasterDetail',  ModelObject: ()=> new CaseTable_Dependencias_Usuarios_ModelComponent()};
}
export { Cat_Cargos_Dependencias_ModelComponent }
