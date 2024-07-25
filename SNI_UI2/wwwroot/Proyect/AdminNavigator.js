import { LogErrorView } from "../Admin/LogErrorView.js";
import { StylesControlsV2 } from "../WDevCore/StyleModules/WStyleComponents.js";
import { WAppNavigator } from "../WDevCore/WComponents/WAppNavigator.js";
import { WFilterOptions } from "../WDevCore/WComponents/WFilterControls.js";
import { WTableComponent } from "../WDevCore/WComponents/WTableComponent.js";
import { ComponentsManager, WRender } from '../WDevCore/WModules/WComponentsTools.js';
import { WOrtograficValidation } from "../WDevCore/WModules/WOrtograficValidation.js";
import {Cat_Tipo_Servicio} from "./FrontModel/Cat_Tipo_Servicio";
import {Cat_Dependencias} from "./FrontModel/Cat_Dependencias";
import {Cat_Tipo_Participaciones} from "./FrontModel/Cat_Tipo_Participaciones";
import {Cat_Paises} from "./FrontModel/Cat_Paises";
import {WAjaxTools} from "../WDevCore/WModules/WAjaxTools";
window.addEventListener("load", async () => {
    setTimeout(async () => {
        const DOMManager = new ComponentsManager({ MainContainer: Main });
        Main.append(WRender.createElement(StylesControlsV2));

        Aside.append(WRender.Create({ tagName: "h3", innerText: "Mantenimiento de Catalogos" }));
        Aside.append(new WAppNavigator({
            Direction: "column",
            Elements: [{
                name: WOrtograficValidation.es("Mantenimiento de Catalogos"), SubNav: {
                    Elements: [
                        ElementTab(DOMManager, new Cat_Dependencias()),
                        ElementTab(DOMManager, new Tbl_Servicios()),
                        //ElementTab(DOMManager, new Cat_Tipo_Servicio()),
                        ElementTab(DOMManager, new Cat_Cargos_Dependencias()),
                        //ElementTab(DOMManager, new Cat_Tipo_Evidencia()),
                        //ElementTab(DOMManager, new Cat_Tipo_Participaciones()),
                        ElementTab(DOMManager, new Cat_Paises())
                    ]
                }
            }, {
                name: WOrtograficValidation.es("Log de errores"), action: async () => {
                    DOMManager.NavigateFunction("error-log", new LogErrorView());
                }
            }]
        }));
    }, 100);
});
function ElementTab(DOMManager, Model) {
    return {
        name: WOrtograficValidation.es(Model.constructor.name), url: "#",
        action: async (ev) => {
            const response = await WAjaxTools.PostRequest("../api/ApiEntityHelpdesk/get" + Model.constructor.name, {});
            if (Model.constructor.name == "Cat_Dependencias") {
                response.forEach(e => {
                    e.Password = undefined;
                });
            }
            const Table = new WTableComponent({
                Dataset: response,
                ModelObject: Model,
                Options: {
                    Filter: true,
                    FilterDisplay: true,
                    Add: true, UrlAdd: "../api/ApiEntityHelpdesk/save" + Model.constructor.name,
                    Edit: true, UrlUpdate: "../api/ApiEntityHelpdesk/update" + Model.constructor.name,
                    // Search: true, UrlSearch: "../api/ApiEntityHelpdesk/get" + Model.constructor.name,
                }
            });
        
            DOMManager.NavigateFunction(Model.constructor.name, [WRender.Create({
                tagName: "h2",
                innerText: WOrtograficValidation.es(Model.constructor.name)
            }), Table]);
        }
    };
}