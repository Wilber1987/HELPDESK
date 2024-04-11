//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { Cat_Paises_ModelComponent }  from './Cat_Paises_ModelComponent.js'
import { Security_Users_ModelComponent }  from './Security_Users_ModelComponent.js'
import { CaseTable_Agenda_ModelComponent }  from './CaseTable_Agenda_ModelComponent.js'
import { CaseTable_Case_ModelComponent }  from './CaseTable_Case_ModelComponent.js'
import { CaseTable_Dependencias_Usuarios_ModelComponent }  from './CaseTable_Dependencias_Usuarios_ModelComponent.js'
import { CaseTable_Participantes_ModelComponent }  from './CaseTable_Participantes_ModelComponent.js'
import { Tbl_Profile_CasosAsignados_ModelComponent }  from './Tbl_Profile_CasosAsignados_ModelComponent.js'
import { Tbl_Servicios_Profile_ModelComponent }  from './Tbl_Servicios_Profile_ModelComponent.js'
class Tbl_Profile_ModelComponent extends EntityClass {
   constructor(props) {
       super(props, 'EntitySecurity');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {ModelProperty}*/ Id_Perfil = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ Nombres = { type: 'text' };
   /**@type {ModelProperty}*/ Apellidos = { type: 'text' };
   /**@type {ModelProperty}*/ FechaNac = { type: 'date' };
   /**@type {ModelProperty}*/ Sexo = { type: 'text' };
   /**@type {ModelProperty}*/ Foto = { type: 'text' };
   /**@type {ModelProperty}*/ DNI = { type: 'text' };
   /**@type {ModelProperty}*/ Correo_institucional = { type: 'text' };
   /**@type {ModelProperty}*/ Estado = { type: 'SELECT', Dataset: ["ACTIVO", "INACTIVO"]  };
   /**@type {ModelProperty}*/ Cat_Paises = { type: 'WSELECT',  ModelObject: ()=> new Cat_Paises_ModelComponent()};
   /**@type {ModelProperty}*/ Security_Users = { type: 'WSELECT',  ModelObject: ()=> new Security_Users_ModelComponent()};
   /**@type {ModelProperty}*/ CaseTable_Agenda = { type: 'MasterDetail',  ModelObject: ()=> new CaseTable_Agenda_ModelComponent()};
   /**@type {ModelProperty}*/ CaseTable_Case = { type: 'MasterDetail',  ModelObject: ()=> new CaseTable_Case_ModelComponent()};
   /**@type {ModelProperty}*/ CaseTable_Dependencias_Usuarios = { type: 'MasterDetail',  ModelObject: ()=> new CaseTable_Dependencias_Usuarios_ModelComponent()};
   /**@type {ModelProperty}*/ CaseTable_Participantes = { type: 'MasterDetail',  ModelObject: ()=> new CaseTable_Participantes_ModelComponent()};
   /**@type {ModelProperty}*/ Tbl_Profile_CasosAsignados = { type: 'MasterDetail',  ModelObject: ()=> new Tbl_Profile_CasosAsignados_ModelComponent()};
   /**@type {ModelProperty}*/ Tbl_Servicios_Profile = { type: 'MasterDetail',  ModelObject: ()=> new Tbl_Servicios_Profile_ModelComponent()};
}
export { Tbl_Profile_ModelComponent }
