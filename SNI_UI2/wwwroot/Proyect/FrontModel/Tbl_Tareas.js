//@ts-check
import {EntityClass} from "../../WDevCore/WModules/EntityClass.js";
import { Tbl_Calendario } from "./Tbl_Calendario.js";
import { Tbl_Participantes } from "./Tbl_Participantes.js";

class Tbl_Tareas extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        //this.Fecha_Inicio = undefined;
        this.Tbl_Case = undefined;
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }

    Id_Tarea = {type: 'number', primary: true};
    Titulo = {type: 'text'};
    Id_Case = {type: 'number', hidden: true, value: undefined};
    Descripcion = {type: 'text', hiddenInTable: true};
    Tbl_Tarea = {
        type: 'WSelect', hiddenFilter: true, label: "Tarea principal", SelfChargeDataset: "Tbl_Tareas",
        ModelObject: () => new Tbl_Tareas(), require: false
    };
    Estado = {type: "Select", Dataset: ["Activo", "Proceso", "Finalizado", "Espera", "Inactivo"]};
    Fecha_Inicio = {type: "date"}
    //Tbl_TareasHijas = { type: 'MULTISELECT', hiddenFilter: true, ModelObject: () => new Tbl_Tareas() };

    Tbl_Participantes = {type: 'MasterDetail', ModelObject: () => new Tbl_Participantes()};
    //Tbl_Evidencias = { type: 'MasterDetail', require: false, ModelObject: () => new Tbl_Evidencias() };
    Tbl_Calendario = {
        type: 'CALENDAR',
        ModelObject: () => new Tbl_Calendario(),
        require: true,
        hiddenInTable: true,
        CalendarFunction: () => {
        }
    };
    GetOwParticipations = async () => {
        return await this.GetData("Proyect/GetOwParticipations");
    }
}

export {Tbl_Tareas};