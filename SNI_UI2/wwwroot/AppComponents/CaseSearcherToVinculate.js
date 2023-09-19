

import { CaseTable_Case } from '../Model/ProyectDataBaseModel.js';
import { WFilterOptions } from '../WDevCore/WComponents/WFilterControls.js';
import { WTableComponent } from "../WDevCore/WComponents/WTableComponent.js";
import { WRender } from '../WDevCore/WModules/WComponentsTools.js';
/**
 * 
 * @param {CaseTable_Case} caseToVinculate 
 * @param {String} actionName 
 * @param {Function} action 
 * @returns 
 */
const CaseSearcherToVinculate = (caseToVinculate, actionName = null, action = null) => {
    const model = new CaseTable_Case();
    model.Fecha_Final.hiddenFilter = true;
    model.Estado.hiddenFilter = true;
    model.Cat_Dependencias.hiddenFilter = true;
    model.Vinculado = { type: "color"}


    model.Get = async () => {
        const response = await new CaseTable_Case(caseToVinculate).GetData("Proyect/GetCasosToVinculate");
        return response.map(c => { 
            c.Vinculado = c.Id_Vinculate != null ? "#28a745" : "rgba(0, 0, 0, 0.2)";
            return c;
        })
    }
    const TableComponent = new WTableComponent({
        ModelObject: model, Dataset: [],
        maxElementByPage: 5, Options: {
            UserActions: action != null ? [{
                name: actionName ?? "Selecionar",
                action: async (caso) => {
                    await action(caso, TableComponent, model);

                }
            }]: undefined
        }
    })
    const FilterOptions = new WFilterOptions({
        Dataset: [],
        ModelObject: model,
        Display: true,
        FilterFunction: (DFilt) => {
            TableComponent.Dataset = DFilt;
            TableComponent?.DrawTable();
        }
    });
    return WRender.Create({ className: "main-container", children: [FilterOptions, TableComponent] });
}
export { CaseSearcherToVinculate };
