//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { Tbl_Servicios_ModelComponent }  from './Tbl_Servicios_ModelComponent.js'
class Cat_Tipo_Servicio_ModelComponent extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {ModelProperty}*/ Id_Tipo_Servicio = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ Descripcion = { type: 'text' };
   /**@type {ModelProperty}*/ Estado = { type: 'SELECT', Dataset: ["ACTIVO", "INACTIVO"]  };
   /**@type {ModelProperty}*/ Icon = { type: 'text' };
   /**@type {ModelProperty}*/ Tbl_Servicios = { type: 'MasterDetail',  ModelObject: ()=> new Tbl_Servicios_ModelComponent()};
}
export { Cat_Tipo_Servicio_ModelComponent }
