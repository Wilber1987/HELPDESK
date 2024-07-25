import {EntityClass} from "../../WDevCore/WModules/EntityClass.js";

class Tbl_Calendario extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }

    Id_Dependencia = {type: 'number', hidden: true};
    IdCalendario = {type: 'number', primary: true};
    Estado = {type: "Select", Dataset: ["Activo", "Inactivo"]};
    Fecha_Inicio = {type: 'date'};
    Fecha_Final = {type: 'date'};
}

export {Tbl_Calendario};