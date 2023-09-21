import { CaseTable_Case } from "../../../ModelProyect/ProyectDataBaseModel.js";
import { CaseDetailComponent } from "./CaseDetailComponent.js";

const OnLoad = async () => {
    const caseD = JSON.parse(sessionStorage.getItem("detailCase"));
    const find = await new CaseTable_Case({ Id_Case: caseD.Id_Case }).Get()
    const CaseDetail = new CaseDetailComponent(find[0]);
    Main.appendChild(CaseDetail);
}
window.onload = OnLoad;