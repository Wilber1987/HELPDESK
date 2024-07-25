import {Tbl_Comments} from "./Tbl_Comments";

class Tbl_Comments_Tasks extends Tbl_Comments {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }

    Id_Tarea = {type: "text", hidden: true};
}

export {Tbl_Comments_Tasks};