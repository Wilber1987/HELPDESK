import { CaseTable_Case, CaseTable_Comments, CaseTable_Tareas, Cat_Dependencias } from "../../ModelProyect/ProyectDataBaseModel.js";
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
    /**@type {Array<CaseTable_Case>} */ caseTickets;
    /**@type {Array<CaseTable_Tareas>} */ task;
    /**@type {Array<CaseTable_Comments>} */ comments;

    GetDasboard = async () => {
        return await WAjaxTools.GetRequest("/api/Proyect/getDashboardgET");
    }
}
export { Dashboard }