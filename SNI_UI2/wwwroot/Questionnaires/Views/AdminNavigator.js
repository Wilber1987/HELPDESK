//@ts-check
import { StylesControlsV2 } from "../../WDevCore/StyleModules/WStyleComponents.js";
import { WAppNavigator } from "../../WDevCore/WComponents/WAppNavigator.js";
import { WFilterOptions } from "../../WDevCore/WComponents/WFilterControls.js";
import { WTableComponent } from "../../WDevCore/WComponents/WTableComponent.js";
import { ComponentsManager, WAjaxTools, WRender } from '../../WDevCore/WModules/WComponentsTools.js';
import { WOrtograficValidation } from "../../WDevCore/WModules/WOrtograficValidation.js";
import { Cat_Categorias_Test_ModelComponent, Cat_Tipo_Preguntas_ModelComponent } from "../Model/QuestionnairesComponentsModel.js";
import { Cat_Categorias_Test, Cat_Tipo_Preguntas } from "../Model/QuestionnairesDataBaseModel.js";
window.addEventListener("load", async () => {
    setTimeout(async () => {
        // @ts-ignore
        const DOMManager = new ComponentsManager({ MainContainer: Main });
        // @ts-ignore
        Main.append(WRender.createElement(StylesControlsV2));
        // @ts-ignore
        Aside.append(WRender.Create({ tagName: "h3", innerText: "Mantenimiento de Tests" }));
        // @ts-ignore
        Aside.append(new WAppNavigator({
            Direction: "column",
            Elements: [
                ElementTab(DOMManager, new Cat_Tipo_Preguntas_ModelComponent(), new Cat_Tipo_Preguntas()),
                ElementTab(DOMManager, new Cat_Categorias_Test_ModelComponent(), new Cat_Categorias_Test())
            ]
        }));
    }, 100);
});
function ElementTab(DOMManager, ModelComponent, ModelEntity) {
    return {
        name: WOrtograficValidation.es(ModelEntity.constructor.name), url: "#",
        action: async (ev) => {
            const response = await ModelEntity.Get();
            const Table = new WTableComponent({
                Dataset: response,
                ModelObject: ModelComponent,
                EntityModel: ModelEntity,
                AutoSave: true,
                Options: {
                    Add: true,
                    Edit: true
                }
            });
            const FilterOptions = new WFilterOptions({
                Dataset: response,
                ModelObject: ModelComponent,
                AutoSetDate: true,
                Display: true,
                FilterFunction: (DFilt) => {
                    Table?.DrawTable(DFilt);
                }
            });
            DOMManager.NavigateFunction(ModelEntity.constructor.name, [WRender.Create({
                tagName: "h2",
                innerText: WOrtograficValidation.es(ModelEntity.constructor.name)
            }), FilterOptions, Table]);
        }
    };
}