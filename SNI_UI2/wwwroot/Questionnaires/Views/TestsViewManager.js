
import { StylesControlsV2, StyleScrolls } from "../../WDevCore/StyleModules/WStyleComponents.js";
import { WTableComponent } from "../../WDevCore/WComponents/WTableComponent.js";
import { WFilterOptions } from "../../WDevCore/WComponents/WFilterControls.js";
import { css } from "../../WDevCore/WModules/WStyledRender.js";
import { Tests_ModelComponent } from "../Model/QuestionnairesComponentsModel.js";
import { Tests } from "../Model/QuestionnairesDataBaseModel.js";
import { WRender } from "../../WDevCore/WModules/WComponentsTools.js";

/**
 * @typedef {Object} ComponentConfig
 * * @property {Object} [propierty]
 */
class TestsViewManager extends HTMLElement {
    /**
    * @param {ComponentConfig} props
    */
    constructor(props) {
        super();
        this.Draw();
    }
    Draw = async () => {
        /**@type {EntityClass} */
        this.ModelComponent = new Tests_ModelComponent();
        /**@type {EntityClass} */
        this.EntityModel = new Tests();
        /**@type {Array} */
        this.Dataset = await this.EntityModel.Get();
        this.TabContainer = WRender.Create({ class: 'TabContainer' });
        this.MainComponent = new WTableComponent({
            ModelObject: this.ModelComponent,
            EntityModel: this.EntityModel,
            Dataset: this.Dataset, Options: {
                Add: true,
                Edit: true,
                Search: true,
                UserActions: [{
                    name: "action", action: (entity) => {
                        //action
                    }
                }]
            }
        });
        this.FilterOptions = new WFilterOptions({
            Dataset: this.Dataset,
            ModelObject: this.EntityModel,
            FilterFunction: (/** @type {Array | undefined} */ DFilt) => {
                this.MainComponent?.DrawTable(DFilt);
            }
        });
        this.TabContainer.append(this.MainComponent);
        this.append(
            StylesControlsV2.cloneNode(true),
            StyleScrolls.cloneNode(true),
            this.CustomStyle,
            this.FilterOptions,
            this.TabContainer
        );
    };
    update = async () => {
        /**@type {Array|undefined} */
        const response = await this.EntityModel?.Get();
        this.MainComponent?.DrawTable(response);
    };
    CustomStyle = css`
         .component{
            display: block;
         }           
     `;
}
customElements.define('w-component-tests-manager', TestsViewManager);
export { TestsViewManager };
