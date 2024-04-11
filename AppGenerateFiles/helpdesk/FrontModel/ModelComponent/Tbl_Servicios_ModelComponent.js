//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { Cat_Dependencias_ModelComponent }  from './Cat_Dependencias_ModelComponent.js'
import { Cat_Tipo_Servicio_ModelComponent }  from './Cat_Tipo_Servicio_ModelComponent.js'
import { CaseTable_Case_ModelComponent }  from './CaseTable_Case_ModelComponent.js'
import { Tbl_Servicios_Profile_ModelComponent }  from './Tbl_Servicios_Profile_ModelComponent.js'
class Tbl_Servicios_ModelComponent extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {ModelProperty}*/ Id_Servicio = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ Nombre_Servicio = { type: 'text' };
   /**@type {ModelProperty}*/ Descripcion_Servicio = { type: 'text' };
   /**@type {ModelProperty}*/ Visibilidad = { type: 'text' };
   /**@type {ModelProperty}*/ Estado = { type: 'SELECT', Dataset: ["ACTIVO", "INACTIVO"]  };
   /**@type {ModelProperty}*/ Fecha_Inicio = { type: 'date' };
   /**@type {ModelProperty}*/ Fecha_Finalizacion = { type: 'date' };
   /**@type {ModelProperty}*/ Cat_Dependencias = { type: 'WSELECT',  ModelObject: ()=> new Cat_Dependencias_ModelComponent()};
   /**@type {ModelProperty}*/ Cat_Tipo_Servicio = { type: 'WSELECT',  ModelObject: ()=> new Cat_Tipo_Servicio_ModelComponent()};
   /**@type {ModelProperty}*/ CaseTable_Case = { type: 'MasterDetail',  ModelObject: ()=> new CaseTable_Case_ModelComponent()};
   /**@type {ModelProperty}*/ Tbl_Servicios_Profile = { type: 'MasterDetail',  ModelObject: ()=> new Tbl_Servicios_Profile_ModelComponent()};
}
export { Tbl_Servicios_ModelComponent }
