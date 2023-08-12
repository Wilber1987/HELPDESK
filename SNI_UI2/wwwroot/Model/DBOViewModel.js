import { EntityClass } from "../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../WDevCore/WModules/WComponentsTools.js";

class ViewParticipantesProyectos extends EntityClass {
   constructor(props) {
       super(props, 'ViewDBO');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   Id_Investigador = { type: 'number' };
   Id_Proyecto = { type: 'number' };
   Fecha_Ingreso = { type: 'date' };
   Estado_Participante = { type: 'text' };
   DescripcionProyecto = { type: 'text' };
   Fecha_Inicio = { type: 'date' };
   Fecha_Finalizacion = { type: 'date' };
   Visibilidad = { type: 'text' };
   Cargo = { type: 'text' };
   Descripcion_Tipo_Proyecto = { type: 'text' };
   Estado_Tipo_Proyecto = { type: 'text' };
   Nombre_Proyecto = { type: 'text' };
   Estado_Proyecto = { type: 'text' };
}
export { ViewParticipantesProyectos }

class ViewCalendarioByDependencia extends EntityClass {
   constructor(props) {
       super(props, 'ViewDBO');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   IdActividad = { type: 'number' };
   IdTareaPadre = { type: 'number' };
   Fecha_Inicial = { type: 'date' };
   Fecha_Final = { type: 'date' };
   Estado = { type: 'text' };
   IdCalendario = { type: 'number' };
   IdTarea = { type: 'number' };
   Id_Dependencia = { type: 'number' };
}
export { ViewCalendarioByDependencia }
class ViewActividadesParticipantes extends EntityClass {
   constructor(props) {
       super(props, 'ViewDBO');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   IdActividad = { type: 'number' };
   Titulo = { type: 'text' };
   Descripcion = { type: 'text' };
   Estado = { type: 'text' };
   Id_Investigador = { type: 'number' };
}
export { ViewActividadesParticipantes }
