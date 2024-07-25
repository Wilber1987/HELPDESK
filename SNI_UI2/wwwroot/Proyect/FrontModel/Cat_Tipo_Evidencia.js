import {EntityClass} from "../../WDevCore/WModules/EntityClass.js";

class Cat_Tipo_Evidencia extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }

    IdTipo = {type: 'number', primary: true};
    Descripcion = {type: 'text'};
    Estado = {type: "Select", Dataset: ["Activo", "Inactivo"]};
}

export {Cat_Tipo_Evidencia};