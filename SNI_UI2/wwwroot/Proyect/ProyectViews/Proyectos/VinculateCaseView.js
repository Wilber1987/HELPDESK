//@ts-check
import { WRender, ComponentsManager, WAjaxTools, WArrayF } from "../../../WDevCore/WModules/WComponentsTools.js";
import { StylesControlsV2, StylesControlsV3, StyleScrolls } from "../../../WDevCore/StyleModules/WStyleComponents.js"
import { css } from "../../../WDevCore/WModules/WStyledRender.js";
import { WTableComponent } from "../../../WDevCore/WComponents/WTableComponent.js";
import { CaseTable_VinculateCase } from "../../../ModelProyect/ProyectDataBaseModel.js";
import { WForm } from "../../../WDevCore/WComponents/WForm.js";
import { WModalForm } from "../../../WDevCore/WComponents/WModalForm.js";
/**
 * @typedef {Object} ComponentConfig
 * * @property {Object} [propierty]
 */
class ComponentView extends HTMLElement {
    /**
     * 
     * @param {ComponentConfig} [props] 
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
        this.Draw();
    }
    Draw = async () => {
        this.SetOption();
    }
  

    SetOption() {
        this.OptionContainer.append(WRender.Create({
            tagName: 'button', className: 'Block-Primary', innerText: 'Datos 1',
            onclick: async () => {
                this.Manager.NavigateFunction("table", new WTableComponent({ ModelObject: new CaseTable_VinculateCase()}))
            } 
        }))  
        this.OptionContainer.append(WRender.Create({
            tagName: 'button', className: 'Block-Primary', innerText: 'Datos 2',
            onclick: async () => {
                this.Manager.NavigateFunction("form", new WForm({ ModelObject: new CaseTable_VinculateCase()}))
            } 
        }))      
        this.OptionContainer.append(WRender.Create({
            tagName: 'button', className: 'Block-Primary', innerText: 'Datos 2',
            onclick: async () => {
                //this.Manager.NavigateFunction("formv", new ComponentView({}))
                this.shadowRoot?.append(new WModalForm({ObjectModal: new ComponentView()}))
            } 
        })) 
    }
   
    CustomStyle = css`
        .component{
           display: block;
        }           
    `
}
customElements.define('w-component', ComponentView);
export { ComponentView }

window.onload = ()=>{
    const t = document.createElement("w-component");
   // @ts-ignore
   Main.append(new ComponentView()); 
   // @ts-ignore
   Main.append(t);
}