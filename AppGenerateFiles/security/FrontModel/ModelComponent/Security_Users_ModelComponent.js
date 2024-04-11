//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { Security_Users_Roles_ModelComponent }  from './Security_Users_Roles_ModelComponent.js'
import { Tbl_Profile_ModelComponent }  from './Tbl_Profile_ModelComponent.js'
class Security_Users_ModelComponent extends EntityClass {
   constructor(props) {
       super(props, 'EntitySecurity');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {ModelProperty}*/ Id_User = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ Nombres = { type: 'text' };
   /**@type {ModelProperty}*/ Estado = { type: 'SELECT', Dataset: ["ACTIVO", "INACTIVO"]  };
   /**@type {ModelProperty}*/ Descripcion = { type: 'text' };
   /**@type {ModelProperty}*/ Password = { type: 'text' };
   /**@type {ModelProperty}*/ Mail = { type: 'text' };
   /**@type {ModelProperty}*/ Token = { type: 'text' };
   /**@type {ModelProperty}*/ Token_Date = { type: 'date' };
   /**@type {ModelProperty}*/ Token_Expiration_Date = { type: 'date' };
   /**@type {ModelProperty}*/ Security_Users_Roles = { type: 'MasterDetail',  ModelObject: ()=> new Security_Users_Roles_ModelComponent()};
   /**@type {ModelProperty}*/ Tbl_Profile = { type: 'MasterDetail',  ModelObject: ()=> new Tbl_Profile_ModelComponent()};
}
export { Security_Users_ModelComponent }
