import { StylesControlsV2 } from "../../WDevCore/StyleModules/WStyleComponents.js";
import { WAppNavigator } from '../../WDevCore/WComponents/WAppNavigator.js';
import { WTableComponent } from "../../WDevCore/WComponents/WTableComponent.js";
import { WAjaxTools } from "../../WDevCore/WModules/WAjaxTools.js";
import { ComponentsManager, WRender } from '../../WDevCore/WModules/WComponentsTools.js';
import { WCssClass, WStyledRender } from '../../WDevCore/WModules/WStyledRender.js';
import { AgendaModel } from '../FrontModel/AgendaModel.js';
class AgendaView extends HTMLElement {
    constructor() {
        super();
        this.className = "HomeView DivContainer";
        this.append(this.WStyle, StylesControlsV2.cloneNode(true));
        this.TabContainer = WRender.createElement({ type: 'div', props: { class: "content-container", id: "TabContainer" } });
        this.TabManager = new ComponentsManager({ MainContainer: this.TabContainer });
        this.DrawAgendaView();
    }
    connectedCallback() { }
    DrawAgendaView = async () => {
        const response = await WAjaxTools.PostRequest("./api/Calendar/TakeData");
        this.TabAgenda = new WAppNavigator({
            NavStyle: "tab",
            Inicialize: true,
            Elements: response[0].map(dependencia => {
                return {
                    name: dependencia.descripcion, url: "#",
                    action: async (ev) => {
                        const DataPost = await WAjaxTools.PostRequest("./api/Calendar/AgendaUsuarioDependencia", dependencia);
                        this.NavAgenda("Tab-" + dependencia.descripcion, DataPost, dependencia.idDependencia);
                    }
                };
            })
        });
        this.append(this.TabAgenda, this.TabContainer);
    }
    NavAgenda = async (TabId, DataPost, IdDependencia) => {
        const Table = new WTableComponent({
            Dataset: DataPost,
            DisplayData: ['dia', "hora_Inicial", "hora_Final", "fecha_Caducidad"],
            ModelObject: new AgendaModel({ IdUsuario: 1, IdDependencia: IdDependencia }),
            Options: {
                Add: true, UrlAdd: 'api/Calendar/SaveAgendaUsuarioDependencia',
                Edit: true, UrlUpdate: 'api/Calendar/SaveAgendaUsuarioDependencia',
            }
        });
        this.TabManager.NavigateFunction(TabId, [Table]);
    }
    WStyle = new WStyledRender({
        ClassList: [
            new WCssClass(`.HomeView`, {
                display: 'flex',
                "flex-direction": "column"
            }), new WCssClass(`.OptionContainer`, {
                display: 'flex',
                "justify-content": "center",
            }), new WCssClass(`.OptionContainer img`, {
                "box-shadow": "0 0 4px rgb(0,0,0/50%)",
                height: 100,
                width: 100,
                margin: 10
            }), new WCssClass(`.TabContainer`, {
                height: 500,
                overflow: "hidden",
                "overflow-y": "auto"
            }),
        ], MediaQuery: [{
            condicion: '(max-width: 600px)',
            ClassList: []
        },
        ]
    });

}
customElements.define('w-agenda-view', AgendaView);
export { AgendaView };
