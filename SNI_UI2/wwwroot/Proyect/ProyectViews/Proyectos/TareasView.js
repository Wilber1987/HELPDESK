import { WRender, ComponentsManager, WAjaxTools, WArrayF } from "../../../WDevCore/WModules/WComponentsTools.js";
import { StylesControlsV2, StylesControlsV3, StyleScrolls } from "../../../WDevCore/StyleModules/WStyleComponents.js"
import { css } from "../../../WDevCore/WModules/WStyledRender.js";
import { TaskManagers } from "./TaskManager.js";
import { WFilterOptions } from "../../../WDevCore/WComponents/WFilterControls.js";
import { CaseTable_Tareas } from "../../../ModelProyect/ProyectDataBaseModel.js";
/**
 * @typedef {Object} ComponentConfig
 * * @property {Object} [propierty]
 */
class TareasComponentView extends HTMLElement {
    /**
     * 
     * @param {ComponentConfig} props 
     */
    constructor(props) {
        super();
        this.attachShadow({ mode: 'open' });     
        this.OptionContainer = WRender.Create({ className: "OptionContainer" });
        this.TabContainer = WRender.Create({ className: "TabContainer", id: 'TabContainer' });
        this.Manager = new ComponentsManager({ MainContainer: this.TabContainer, SPAManage: false });        
        this.shadowRoot?.append(this.CustomStyle);        
        this.shadowRoot?.append(
            StylesControlsV2.cloneNode(true),
            StyleScrolls.cloneNode(true),
            StylesControlsV3.cloneNode(true),
            this.OptionContainer,
            this.TabContainer
        );
        this.Model = new CaseTable_Tareas({ Get: async ()=> {
            this.Model.GetOwParticipations();
        }});
        this.Draw();
    }
    Draw = async () => {
        this.SetOption();
        const tasks = await new CaseTable_Tareas().GetOwParticipations();
                this.Manager.NavigateFunction("Tab-OWTasks-Manager", this.ChargeTasks(tasks));
    }
    SetOption() {
       /*  this.OptionContainer.append(WRender.Create({
            tagName: 'button', className: 'Block-Primary', innerText: 'Datos Tareas',
            onclick: async () => {
                
            } 
        }))       */  
    }
    ChargeTasks(tasks) {
        const tasksManager = new TaskManagers(tasks);
        const filterOptions = new WFilterOptions({
            Dataset: tasks,
            ModelObject: this.Model,
            //DisplayFilts: [],
            FilterFunction: (DFilt) => {
                tasksManager.DrawTaskManagers(DFilt);
            }
        })
        return WRender.Create({ className: "task-container", children: [filterOptions, tasksManager] })
    }
    CustomStyle = css`
        .component{
           display: block;
        }           
    `
}
window.onload = async () => {
    Main.appendChild(new TareasComponentView());
}
customElements.define('w-tareas-view', TareasComponentView);
export { TareasComponentView }