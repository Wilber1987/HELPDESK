import { WRender, ComponentsManager } from "../../../WDevCore/WModules/WComponentsTools.js";
import { StylesControlsV2, StylesControlsV3, StyleScrolls } from "../../../WDevCore/StyleModules/WStyleComponents.js"
import { css } from "../../../WDevCore/WModules/WStyledRender.js";
import { TaskManagers } from "./TaskManager.js";
import { WFilterOptions } from "../../../WDevCore/WComponents/WFilterControls.js";
import {WArrayF} from "../../../WDevCore/WModules/WArrayF";
import {Tbl_Tareas} from "../../FrontModel/Tbl_Tareas";
import {WAjaxTools} from "../../../WDevCore/WModules/WAjaxTools";
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
        this.Model = new Tbl_Tareas({
            Get: async () => {
                return this.Model.GetOwParticipations();
            }
        });
        this.Draw();
    }
    Draw = async () => {
        this.SetOption();
        //const tasks = await new Tbl_Tareas().GetOwParticipations();
        this.Manager.NavigateFunction("Tab-OWTasks-Manager", this.ChargeTasks());
    }
    SetOption() {
        /*  this.OptionContainer.append(WRender.Create({
             tagName: 'button', className: 'Block-Primary', innerText: 'Datos Tareas',
             onclick: async () => {
                 
             } 
         }))       */
    }
    ChargeTasks() {
        const tasksManager = new TaskManagers([]);
        const filterOptions = new WFilterOptions({
            AutoSetDate: true,
            Display: true,
            ModelObject: this.Model,
            UseEntityMethods: false,
            AutoFilter: true,
            //DisplayFilts: [],
            FilterFunction: async (DFilt) => {
                const tasks = await new Tbl_Tareas({FilterData: DFilt}).GetOwParticipations();
                tasksManager.Dataset = tasks;
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