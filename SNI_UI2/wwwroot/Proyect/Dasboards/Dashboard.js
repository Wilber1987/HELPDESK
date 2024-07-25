import { Tbl_Case } from "../FrontModel/Tbl_CaseModule.js";
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import {Tbl_Tareas} from "../FrontModel/Tbl_Tareas.js";
import {Cat_Dependencias} from "../FrontModel/Cat_Dependencias.js";
import {WAjaxTools} from "../../WDevCore/WModules/WAjaxTools.js";

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