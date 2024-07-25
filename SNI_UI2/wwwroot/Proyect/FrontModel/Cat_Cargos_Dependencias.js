import {EntityClass} from "../../WDevCore/WModules/EntityClass";

class Cat_Cargos_Dependencias extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }

    IdCargo = {type: 'number', primary: true};
    Descripcion = {type: 'text'};
    //Tbl_Dependencias_Usuarios = { type: 'MasterDetail', ModelObject: () => new Tbl_Dependencias_Usuarios() };
}

export {Cat_Cargos_Dependencias};