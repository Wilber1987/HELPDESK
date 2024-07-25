import {EntityClass} from "../../WDevCore/WModules/EntityClass.js";

class Tbl_Servicios extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }

    Id_Servicio = {type: 'number', primary: true};
    //Nombre_Proyecto = { type: 'text', label: "Nombre" };
    Descripcion_Servicio = {type: 'text'};
    //Visibilidad = { type: 'text' };
    Estado = {type: "Select", Dataset: ["Activo", "Inactivo"]};
    //Cat_Tipo_Servicio = { type: 'WSelect', hiddenFilter: true, ModelObject: () => new Cat_Tipo_Servicio() };
    Cat_Dependencias = {type: 'WSelect', hiddenFilter: true, ModelObject: () => new Cat_Dependencias()}
    //Fecha_Inicio = { type: 'date' };
    //Fecha_Finalizacion = { type: 'date' };
    //Tbl_Case = { type: 'MasterDetail', ModelObject: () => new Tbl_Case() };
}

export {Tbl_Servicios};