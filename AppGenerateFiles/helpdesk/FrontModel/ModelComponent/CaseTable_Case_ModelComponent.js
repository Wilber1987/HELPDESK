//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_VinculateCase_ModelComponent }  from './CaseTable_VinculateCase_ModelComponent.js'
import { Cat_Dependencias_ModelComponent }  from './Cat_Dependencias_ModelComponent.js'
import { Tbl_Profile_ModelComponent }  from './Tbl_Profile_ModelComponent.js'
import { Tbl_Servicios_ModelComponent }  from './Tbl_Servicios_ModelComponent.js'
import { CaseTable_Comments_ModelComponent }  from './CaseTable_Comments_ModelComponent.js'
import { CaseTable_Mails_ModelComponent }  from './CaseTable_Mails_ModelComponent.js'
import { CaseTable_Tareas_ModelComponent }  from './CaseTable_Tareas_ModelComponent.js'
import { Tbl_Profile_CasosAsignados_ModelComponent }  from './Tbl_Profile_CasosAsignados_ModelComponent.js'
class CaseTable_Case_ModelComponent extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {ModelProperty}*/ Id_Case = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ Titulo = { type: 'text' };
   /**@type {ModelProperty}*/ Descripcion = { type: 'text' };
   /**@type {ModelProperty}*/ Estado = { type: 'SELECT', Dataset: ["ACTIVO", "INACTIVO"]  };
   /**@type {ModelProperty}*/ Fecha_Inicio = { type: 'date' };
   /**@type {ModelProperty}*/ Fecha_Final = { type: 'date' };
   /**@type {ModelProperty}*/ Mail = { type: 'text' };
   /**@type {ModelProperty}*/ Case_Priority = { type: 'text' };
   /**@type {ModelProperty}*/ CaseTable_VinculateCase = { type: 'WSELECT',  ModelObject: ()=> new CaseTable_VinculateCase_ModelComponent()};
   /**@type {ModelProperty}*/ Cat_Dependencias = { type: 'WSELECT',  ModelObject: ()=> new Cat_Dependencias_ModelComponent()};
   /**@type {ModelProperty}*/ Tbl_Profile = { type: 'WSELECT',  ModelObject: ()=> new Tbl_Profile_ModelComponent()};
   /**@type {ModelProperty}*/ Tbl_Servicios = { type: 'WSELECT',  ModelObject: ()=> new Tbl_Servicios_ModelComponent()};
   /**@type {ModelProperty}*/ CaseTable_Comments = { type: 'MasterDetail',  ModelObject: ()=> new CaseTable_Comments_ModelComponent()};
   /**@type {ModelProperty}*/ CaseTable_Mails = { type: 'MasterDetail',  ModelObject: ()=> new CaseTable_Mails_ModelComponent()};
   /**@type {ModelProperty}*/ CaseTable_Tareas = { type: 'MasterDetail',  ModelObject: ()=> new CaseTable_Tareas_ModelComponent()};
   /**@type {ModelProperty}*/ Tbl_Profile_CasosAsignados = { type: 'MasterDetail',  ModelObject: ()=> new Tbl_Profile_CasosAsignados_ModelComponent()};
}
export { CaseTable_Case_ModelComponent }
