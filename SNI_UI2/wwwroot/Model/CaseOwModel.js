import { CaseTable_Case, Cat_Dependencias, Tbl_Servicios } from "./ProyectDataBaseModel.js";

const CaseOwModel = async ()=> {
    const dep = await new Cat_Dependencias().GetOwDependencies();
    const tbl_servicios = dep.flatMap(d => d.Tbl_Servicios);
    console.log(tbl_servicios);
    const ModelObject = new CaseTable_Case({
        CaseTable_Tareas: {
            type: "text",  hidden: true
        }, Estado: {
            type: "text",  hidden: true
        }, Cat_Dependencias: {
            type: "WSELECT", hidden: true
        }, Tbl_Servicios: {
            type: 'WSelect', hiddenFilter: true, ModelObject:  new Tbl_Servicios() , Dataset: tbl_servicios
        }
    });
    return ModelObject;
}
export {CaseOwModel}