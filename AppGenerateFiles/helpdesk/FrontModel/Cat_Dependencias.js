//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { Cat_Dependencias }  from './Cat_Dependencias.js'
import { CaseTable_Agenda }  from './CaseTable_Agenda.js'
import { CaseTable_Calendario }  from './CaseTable_Calendario.js'
import { CaseTable_Case }  from './CaseTable_Case.js'
import { CaseTable_Dependencias_Usuarios }  from './CaseTable_Dependencias_Usuarios.js'
import { Cat_Dependencias }  from './Cat_Dependencias.js'
import { Tbl_Servicios }  from './Tbl_Servicios.js'
class Cat_Dependencias extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ Id_Dependencia;
   /**@type {String}*/ Descripcion;
   /**@type {String}*/ Username;
   /**@type {String}*/ Password;
   /**@type {String}*/ Host;
   /**@type {String}*/ AutenticationType;
   /**@type {String}*/ TENAT;
   /**@type {String}*/ CLIENT;
   /**@type {String}*/ OBJECTID;
   /**@type {String}*/ CLIENT_SECRET;
   /**@type {String}*/ HostService;
   /**@type {String}*/ SMTPHOST;
   /**@type {Boolean}*/ Default;
   /**@type {Cat_Dependencias} ManyToOne*/ Cat_Dependencias;
   /**@type {Array<CaseTable_Agenda>} OneToMany*/ CaseTable_Agenda;
   /**@type {Array<CaseTable_Calendario>} OneToMany*/ CaseTable_Calendario;
   /**@type {Array<CaseTable_Case>} OneToMany*/ CaseTable_Case;
   /**@type {Array<CaseTable_Dependencias_Usuarios>} OneToMany*/ CaseTable_Dependencias_Usuarios;
   /**@type {Array<Cat_Dependencias>} OneToMany*/ Cat_Dependencias;
   /**@type {Array<Tbl_Servicios>} OneToMany*/ Tbl_Servicios;
}
export { Cat_Dependencias }
