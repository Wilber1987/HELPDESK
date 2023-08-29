

import { CaseTable_Case } from '../Model/ProyectDataBaseModel.js';
import { WFilterOptions } from '../WDevCore/WComponents/WFilterControls.js';
import { WTableComponent } from "../WDevCore/WComponents/WTableComponent.js";
import { WRender } from '../WDevCore/WModules/WComponentsTools.js';
const CaseSearcher = (actionName, action) => {
    const model = new CaseTable_Case();
    const TableComponent = new WTableComponent({
        ModelObject: model, Dataset: [], Options: {
            UserActions: [{
                name: actionName ?? "Selecionar",
                action: async (caso) => {
                    await action(caso, TableComponent, model);
                    
                }
            }]
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
export { CaseSearcher };
