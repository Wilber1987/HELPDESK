//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { CaseTable_Case }  from './CaseTable_Case.js'
import { CaseTable_Tareas }  from './CaseTable_Tareas.js'
import { CaseTable_Calendario }  from './CaseTable_Calendario.js'
import { CaseTable_Evidencias }  from './CaseTable_Evidencias.js'
import { CaseTable_Participantes }  from './CaseTable_Participantes.js'
import { CaseTable_Tareas }  from './CaseTable_Tareas.js'
class CaseTable_Tareas extends EntityClass {
   constructor(props) {
       super(props, 'EntityHelpdesk');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ Id_Tarea;
   /**@type {String}*/ Titulo;
   /**@type {String}*/ Descripcion;
   /**@type {String}*/ Estado;
   /**@type {Date}*/ Fecha_Inicio;
   /**@type {Date}*/ Fecha_Finalizacion;
   /**@type {Date}*/ Fecha_Inicio_Proceso;
   /**@type {Date}*/ Fecha_Finalizacion_Proceso;
   /**@type {CaseTable_Case} ManyToOne*/ CaseTable_Case;
   /**@type {CaseTable_Tareas} ManyToOne*/ CaseTable_Tareas;
   /**@type {Array<CaseTable_Calendario>} OneToMany*/ CaseTable_Calendario;
   /**@type {Array<CaseTable_Evidencias>} OneToMany*/ CaseTable_Evidencias;
   /**@type {Array<CaseTable_Participantes>} OneToMany*/ CaseTable_Participantes;
   /**@type {Array<CaseTable_Tareas>} OneToMany*/ CaseTable_Tareas;
}
export { CaseTable_Tareas }
