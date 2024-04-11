//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { Cat_Dependencias_ModelComponent }  from './Cat_Dependencias_ModelComponent.js'
import { CaseTable_Agenda_ModelComponent }  from './CaseTable_Agenda_ModelComponent.js'
import { CaseTable_Calendario_ModelComponent }  from './CaseTable_Calendario_ModelComponent.js'
import { CaseTable_Case_ModelComponent }  from './CaseTable_Case_ModelComponent.js'
import { CaseTable_Dependencias_Usuarios_ModelComponent }  from './CaseTable_Dependencias_Usuarios_ModelComponent.js'
import { Cat_Dependencias_ModelComponent }  from './Cat_Dependencias_ModelComponent.js'
import { Tbl_Servicios_ModelComponent }  from './Tbl_Servicios_ModelComponent.js'
class Cat_Dependencias_ModelComponent extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {ModelProperty}*/ Id_Dependencia = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ Descripcion = { type: 'text' };
   /**@type {ModelProperty}*/ Username = { type: 'text' };
   /**@type {ModelProperty}*/ Password = { type: 'text' };
   /**@type {ModelProperty}*/ Host = { type: 'text' };
   /**@type {ModelProperty}*/ AutenticationType = { type: 'text' };
   /**@type {ModelProperty}*/ TENAT = { type: 'text' };
   /**@type {ModelProperty}*/ CLIENT = { type: 'text' };
   /**@type {ModelProperty}*/ OBJECTID = { type: 'text' };
   /**@type {ModelProperty}*/ CLIENT_SECRET = { type: 'text' };
   /**@type {ModelProperty}*/ HostService = { type: 'text' };
   /**@type {ModelProperty}*/ SMTPHOST = { type: 'text' };
   /**@type {ModelProperty}*/ Default = { type: 'checkbox' };
   /**@type {ModelProperty}*/ Cat_Dependencias = { type: 'WSELECT',  ModelObject: ()=> new Cat_Dependencias_ModelComponent()};
   /**@type {ModelProperty}*/ CaseTable_Agenda = { type: 'MasterDetail',  ModelObject: ()=> new CaseTable_Agenda_ModelComponent()};
   /**@type {ModelProperty}*/ CaseTable_Calendario = { type: 'MasterDetail',  ModelObject: ()=> new CaseTable_Calendario_ModelComponent()};
   /**@type {ModelProperty}*/ CaseTable_Case = { type: 'MasterDetail',  ModelObject: ()=> new CaseTable_Case_ModelComponent()};
   /**@type {ModelProperty}*/ CaseTable_Dependencias_Usuarios = { type: 'MasterDetail',  ModelObject: ()=> new CaseTable_Dependencias_Usuarios_ModelComponent()};
   /**@type {ModelProperty}*/ Cat_Dependencias = { type: 'MasterDetail',  ModelObject: ()=> new Cat_Dependencias_ModelComponent()};
   /**@type {ModelProperty}*/ Tbl_Servicios = { type: 'MasterDetail',  ModelObject: ()=> new Tbl_Servicios_ModelComponent()};
}
export { Cat_Dependencias_ModelComponent }
