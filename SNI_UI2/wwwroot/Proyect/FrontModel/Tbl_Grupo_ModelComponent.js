import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";

class Tbl_Grupo_ModelComponent extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    /**@type {ModelProperty}*/ Id_Grupo = { type: 'number', primary: true };
    /**@type {ModelProperty}*/ Descripcion = { type: 'text' };
}
export { Tbl_Grupo_ModelComponent }