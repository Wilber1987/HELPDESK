//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_VinculateCase }  from './CaseTable_VinculateCase.js'
import { Cat_Dependencias }  from './Cat_Dependencias.js'
import { Tbl_Profile }  from './Tbl_Profile.js'
import { Tbl_Servicios }  from './Tbl_Servicios.js'
import { CaseTable_Comments }  from './CaseTable_Comments.js'
import { CaseTable_Mails }  from './CaseTable_Mails.js'
import { CaseTable_Tareas }  from './CaseTable_Tareas.js'
import { Tbl_Profile_CasosAsignados }  from './Tbl_Profile_CasosAsignados.js'
class CaseTable_Case extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ Id_Case;
   /**@type {String}*/ Titulo;
   /**@type {String}*/ Descripcion;
   /**@type {String}*/ Estado;
   /**@type {Date}*/ Fecha_Inicio;
   /**@type {Date}*/ Fecha_Final;
   /**@type {String}*/ Mail;
   /**@type {String}*/ Case_Priority;
   /**@type {CaseTable_VinculateCase} ManyToOne*/ CaseTable_VinculateCase;
   /**@type {Cat_Dependencias} ManyToOne*/ Cat_Dependencias;
   /**@type {Tbl_Profile} ManyToOne*/ Tbl_Profile;
   /**@type {Tbl_Servicios} ManyToOne*/ Tbl_Servicios;
   /**@type {Array<CaseTable_Comments>} OneToMany*/ CaseTable_Comments;
   /**@type {Array<CaseTable_Mails>} OneToMany*/ CaseTable_Mails;
   /**@type {Array<CaseTable_Tareas>} OneToMany*/ CaseTable_Tareas;
   /**@type {Array<Tbl_Profile_CasosAsignados>} OneToMany*/ Tbl_Profile_CasosAsignados;
}
export { CaseTable_Case }
