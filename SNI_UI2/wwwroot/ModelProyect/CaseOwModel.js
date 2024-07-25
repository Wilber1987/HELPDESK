import { Tbl_Case, Cat_Dependencias, Tbl_Servicios } from "./ProyectDataBaseModel.js";

const CaseOwModel = async (Id_Dependencia) => {
    const dep = await new Cat_Dependencias({ Id_Dependencia: Id_Dependencia }).GetOwDependencies();
    const tbl_servicios = dep.flatMap(d => d.Tbl_Servicios);
    const ModelObject = new Tbl_Case({
        Tbl_Tareas: {
            type: "text", hidden: true
        }, Estado: {
            type: "text", hidden: true
        }, Cat_Dependencias: {
            type: "WSELECT", hidden: true
        }, Tbl_Servicios: {
            type: 'WSelect', hiddenFilter: true, ModelObject: new Tbl_Servicios(), Dataset: tbl_servicios
        }
    });
    return ModelObject;
}
export { CaseOwModel }