import { CaseTable_Case, CaseTable_Tareas, Cat_Dependencias } from "../Model/ProyectDataBaseModel.js";
import { CaseDashboardComponent } from "../Views/Perfil/Proyectos/CaseDashboardComponent.js";
import { CaseManagerComponent } from "../Views/Perfil/Proyectos/CaseManagerComponent.js";
import { TaskManagers } from "../Views/Perfil/Proyectos/TaskManager.js";
import { SolicitudesPendientesComponent } from "../Views/Solicitudes/SolicitudesPendientesComponent.js";
import { MainSolicitudesView } from "../Views/Solicitudes/SolicitudesView.js";
import { StylesControlsV2 } from "../WDevCore/StyleModules/WStyleComponents.js";
import { WAppNavigator } from "../WDevCore/WComponents/WAppNavigator.js";
import { WFilterOptions } from "../WDevCore/WComponents/WFilterControls.js";
import { ComponentsManager, WRender } from '../WDevCore/WModules/WComponentsTools.js';
window.onload = () => {
    const navigator = new WAppNavigator({
        Direction: "column",
        Inicialize: true,
        Elements: [{
            id: "Tab-dasboard", name: "Dashboard", action: async (ev) => {
                const dataset = await new CaseTable_Case().GetOwCase();
                //const dependencias = await new Cat_Dependencias().GetOwDependencies();
                DOMManager.NavigateFunction("Tab-dasboard", new CaseDashboardComponent(dataset));
            }
        }, {
            id: "Tab-Generales", name: "Administrador de Casos",
            action: async (ev) => {
                const dataset = await new CaseTable_Case().Get();
                const dependencias = await new Cat_Dependencias().Get();
                DOMManager.NavigateFunction("Tab-Generales",
                    new MainSolicitudesView(dataset, dependencias));
            }
        }, {
            id: "Tab-Solicitudes", name: "Administrador de Solicitudes",
            action: async (ev) => {
                const Solicitudes = await new CaseTable_Case().GetSolicitudesPendientesAprobarAdmin();
                DOMManager.NavigateFunction("Tab-Solicitudes",
                    new SolicitudesPendientesComponent(Solicitudes));
            }
        }, {
            id: "Tab-Tasks-Manager", name: "Administrador de Tareas", action: async (ev) => {
                const tasks = await new CaseTable_Tareas().Get();
                DOMManager.NavigateFunction("Tab-Tasks-Manager", ChargeTasks(tasks));
            }
        }]
    })
    const DOMManager = new ComponentsManager({ MainContainer: Main, SPAManage: true, WNavigator: navigator });
    Main.append(WRender.createElement(StylesControlsV2));
    Aside.append(WRender.Create({ tagName: "h3", innerText: "Administración de Casos" }))
    Aside.append(navigator);
}
const ChargeTasks = (tasks) => {
    const tasksManager = new TaskManagers(tasks, new CaseTable_Tareas(), { ImageUrlPath: "" });
    const filterOptions = new WFilterOptions({
        Dataset: tasks,
        Display: true,
        ModelObject: new CaseTable_Tareas(),
        //DisplayFilts: [],
        FilterFunction: (DFilt) => {
            tasksManager.DrawTaskManagers(DFilt);
        }
    })
    return WRender.Create({
        className: "task-container",
        children: [filterOptions, tasksManager]
    })
}
