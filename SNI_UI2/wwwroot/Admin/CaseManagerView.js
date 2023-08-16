import { CaseTable_Case, CaseTable_Tareas, Cat_Dependencias } from "../Model/ProyectDataBaseModel.js";
import { CaseDashboardComponent } from "../Views/Perfil/Proyectos/CaseDashboardComponent.js";
import { CaseManagerComponent } from "../Views/Perfil/Proyectos/CaseManagerComponent.js";
import { TaskManagers } from "../Views/Perfil/Proyectos/TaskManager.js";
import { StylesControlsV2 } from "../WDevCore/StyleModules/WStyleComponents.js";
import { WAppNavigator } from "../WDevCore/WComponents/WAppNavigator.js";
import { WFilterOptions } from "../WDevCore/WComponents/WFilterControls.js";
import { ComponentsManager, WRender } from '../WDevCore/WModules/WComponentsTools.js';
window.onload = () => {
    const DOMManager = new ComponentsManager({ MainContainer: Main });
    Main.append(WRender.createElement(StylesControlsV2));
    Aside.append(WRender.Create({ tagName: "h3", innerText: "Administración de Casos" }))
    Aside.append(new WAppNavigator({
        Direction: "column",
        Inicialize: true,
        Elements: [{
            name: "Dashboard", action: async (ev) => {
                const dataset = await new CaseTable_Case().GetOwCase();
                //const dependencias = await new Cat_Dependencias().GetOwDependencies();
                DOMManager.NavigateFunction("Tab-dasboard", new CaseDashboardComponent(dataset));
            }
        }, {
            name: "Administrador de Casos",
            action: async (ev) => {
                const dataset = await new CaseTable_Case().Get();
                const dependencias = await new Cat_Dependencias().Get();
                DOMManager.NavigateFunction("Tab-Generales",
                    new CaseManagerComponent(dataset, dependencias));
            }
        }, {
            name: "Administrador de Tareas", action: async (ev) => {
                const tasks = await new CaseTable_Tareas().Get();
                DOMManager.NavigateFunction("Tab-Tasks-Manager", ChargeTasks(tasks));
            }
        }]
    }));
}
const ChargeTasks = (tasks) => {
    const tasksManager = new TaskManagers(tasks,new CaseTable_Tareas(),  { ImageUrlPath: "/Media/Image/"});
    const filterOptions = new WFilterOptions({
        Dataset: tasks,
        Display: true,
        ModelObject: new CaseTable_Tareas(),
        //DisplayFilts: [],
        FilterFunction: (DFilt) => {
            tasksManager.DrawTaskManagers(DFilt);
        }
    })
    return WRender.Create({ className: "task-container",
     children: [filterOptions, tasksManager] })
}