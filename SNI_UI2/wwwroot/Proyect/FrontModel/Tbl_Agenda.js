import {EntityClass} from "../../WDevCore/WModules/EntityClass";

class Tbl_Agenda extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }

    Id_Dependencia = {type: 'number', hidden: true};
    IdAgenda = {type: 'number', primary: true};
    Dia = {type: 'Select', Dataset: ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"]};
    Hora_Inicial = {type: 'HORA'};
    Hora_Final = {type: 'HORA'};
    Fecha_Caducidad = {type: 'date'};
}

export {Tbl_Agenda};