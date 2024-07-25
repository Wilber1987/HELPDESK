import {EntityClass} from "../../WDevCore/WModules/EntityClass";

class Tbl_Comments extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
        ;
        this.Id_Tarea = undefined;
    }

    Id_Comentario = {type: "number", primary: true};
    Estado = {type: "text", hidden: true};
    NickName = {type: "text", hidden: true};
    Body = {type: "textarea", label: "Mensaje"};
    Id_Case = {type: "text", hidden: true};
}

export {Tbl_Comments};