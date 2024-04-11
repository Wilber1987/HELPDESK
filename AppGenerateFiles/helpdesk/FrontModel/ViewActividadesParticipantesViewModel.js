//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
class ViewActividadesParticipantes extends EntityClass {
   constructor(props) {
       super(props, 'ViewHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ Id_Case;
   /**@type {String}*/ Titulo;
   /**@type {String}*/ Descripcion;
   /**@type {String}*/ Estado;
   /**@type {Number}*/ Id_Perfil;
}
export { ViewActividadesParticipantes }
