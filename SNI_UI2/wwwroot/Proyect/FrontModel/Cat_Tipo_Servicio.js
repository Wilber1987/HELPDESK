import {EntityClass} from "../../WDevCore/WModules/EntityClass";

class Cat_Tipo_Servicio extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }

    Id_Tipo_Servicio = {type: 'number', primary: true};
    Descripcion = {type: 'text'};
    Estado = {type: "Select", Dataset: ["Activo", "Inactivo"]};
    Icon = {type: 'img'};
    //Tbl_Servicios = { type: 'MasterDetail', ModelObject: () => new Tbl_Servicios() };
}

export {Cat_Tipo_Servicio};