import {EntityClass} from "../../WDevCore/WModules/EntityClass";

class Cat_Paises extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }

    Id_Pais = {type: 'number', primary: true};
    Estado = {type: "Select", Dataset: ["Activo", "Inactivo"]};
    Descripcion = {type: 'text'};
}

export {Cat_Paises};