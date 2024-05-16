import { WRender, ComponentsManager, WAjaxTools, WArrayF } from "../../../WDevCore/WModules/WComponentsTools.js";
import { StylesControlsV2, StylesControlsV3, StyleScrolls } from "../../../WDevCore/StyleModules/WStyleComponents.js"
import { css } from "../../../WDevCore/WModules/WStyledRender.js";
import { TaskManagers } from "./TaskManager.js";
import { WFilterOptions } from "../../../WDevCore/WComponents/WFilterControls.js";
import { Tbl_Tareas } from "../../../ModelProyect/ProyectDataBaseModel.js";
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
        this.Model = new Tbl_Tareas({ Get: async ()=> {
            return this.Model.GetOwParticipations();
        }});
        this.Draw();
    }
    Draw = async () => {
        this.SetOption();
        const tasks = await new Tbl_Tareas().GetOwParticipations();
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
            AutoSetDate: true,
            Display: true,
            ModelObject: this.Model,
            //DisplayFilts: [],
            FilterFunction: (DFilt) => {
                tasksManager.Dataset = DFilt;
                tasksManager.DrawTaskManagers();
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