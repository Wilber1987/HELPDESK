//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { Tbl_Profile }  from './Tbl_Profile.js'
class Cat_Paises extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ Id_Pais;
   /**@type {String}*/ Estado;
   /**@type {String}*/ Descripcion;
   /**@type {Array<Tbl_Profile>} OneToMany*/ Tbl_Profile;
}
export { Cat_Paises }
