import { Tbl_Case, Tbl_Comments, Tbl_Tareas, Cat_Dependencias } from "../../ModelProyect/ProyectDataBaseModel.js";
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";

class Dashboard extends EntityClass {
    constructor(props) {
        super(props, 'Dashboard');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    /**@type {Array<Cat_Dependencias>} */ dependencies;
    /**@type {Array<Tbl_Case>} */ caseTickets;
    /**@type {Array<Tbl_Tareas>} */ task;
    /**@type {Array<Tbl_Comments>} */ comments;

    GetDasboard = async (object) => {
        return await WAjaxTools.PostRequest("/api/Proyect/getDashboardgET", object);
    }
}
export { Dashboard }