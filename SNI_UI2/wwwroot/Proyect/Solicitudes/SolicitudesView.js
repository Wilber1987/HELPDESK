
import { Tbl_Case, Tbl_Comments, Cat_Dependencias } from '../../ModelProyect/ProyectDataBaseModel.js';
import { StylesControlsV2, StylesControlsV3 } from "../../WDevCore/StyleModules/WStyleComponents.js";
import { ModalMessege, WForm } from "../../WDevCore/WComponents/WForm.js";
import { WPaginatorViewer } from '../../WDevCore/WComponents/WPaginatorViewer.js';
import { ComponentsManager, WRender } from '../../WDevCore/WModules/WComponentsTools.js';
import { css } from '../../WDevCore/WModules/WStyledRender.js';
import { WFilterOptions } from "../../WDevCore/WComponents/WFilterControls.js";
import { WCommentsComponent } from '../../WDevCore/WComponents/WCommentsComponent.js';
import { WSecurity } from '../../WDevCore/Security/WSecurity.js';
import { priorityStyles } from '../../AppComponents/Styles.js';
import { caseGeneralData } from '../ProyectViews/Proyectos/CaseDetailComponent.js';
import { activityStyle } from '../style.js';

const OnLoad = async () => {
    const Solicitudes = await new Tbl_Case().GetOwSolicitudesPendientesAprobar();
    const AdminPerfil = new MainSolicitudesView(Solicitudes);
    Main.appendChild(AdminPerfil);
}
window.onload = OnLoad;
class MainSolicitudesView extends HTMLElement {
    /**
     * 
     * @param {Array<Tbl_Case>} Dataset 
     * @param {Array<Cat_Dependencias>} Dependencias 
     */
    constructor(Dataset) {
        super();
        this.Dataset = Dataset;
        //this.Dependencias = Dependencias;
        this.attachShadow({ mode: 'open' });
        this.shadowRoot.append(this.WStyle, StylesControlsV2.cloneNode(true), StylesControlsV3.cloneNode(true));
        this.TabContainer = WRender.createElement({ type: 'div', props: { class: 'TabContainer', id: "TabContainer" } });
        this.TabManager = new ComponentsManager({ MainContainer: this.TabContainer });
        this.OptionContainer = WRender.Create({ className: "OptionContainer" });
        this.ModelObject = new Tbl_Case({
            Tbl_Tareas: {
                type: "text", hidden: true
            }, Estado: {
                type: "text", hidden: true
            }, Cat_Dependencias: {
                type: "WSELECT", hiddenFilter: true, ModelObject: () => new Cat_Dependencias()
            }
        });
        this.DrawMainSolicitudesView();
    }
    connectedCallback() { }
    DrawMainSolicitudesView = async () => {
        //this.OptionContainer.append(WRender.Create({ tagName: 'input', type: 'button', className: 'Block-Basic', value: 'Estadística', onclick: this.dashBoardView }))
        this.OptionContainer.append(WRender.Create({ tagName: 'input', type: 'button', className: 'Block-Alert', value: 'Lista de casos', onclick: this.actividadesManager }))
        this.OptionContainer.append(WRender.Create({ tagName: 'input', type: 'button', className: 'Block-Success', value: 'Nuevo Caso', onclick: this.nuevoCaso }))

        this.shadowRoot.append(this.OptionContainer, this.TabContainer);
        //this.dashBoardView();
        this.actividadesManager();
    }
    actividadesManager = async () => {
        const paginator = new WPaginatorViewer({ Dataset: this.mapCaseToPaginatorElement(this.Dataset), userStyles: [StylesControlsV2] });
        this.FilterOptions = new WFilterOptions({
            Dataset: this.Dataset,
            AutoSetDate: true,
            ModelObject: this.ModelObject,
            Display: true,
            FilterFunction: (DFilt) => {
                this.paginator?.Draw(DFilt);
            }
        });
        this.TabManager.NavigateFunction("Tab-Actividades-Manager",
            WRender.Create({ className: "actividadesView", children: [this.FilterOptions, paginator] }));
    }

    actividadElement = (actividad) => {
        this.shadowRoot.append(priorityStyles.cloneNode(true));
        return WRender.Create({
            className: "actividad", object: actividad, children: [
                { tagName: 'h4', innerText: `#${actividad.Id_Case} - ${actividad.Titulo} (${actividad.Tbl_Servicios?.Descripcion_Servicio ?? ""})` },
                caseGeneralData(actividad), {
                    className: "options", children: [
                        {
                            tagName: 'button', className: 'Btn-Mini', innerText: "Detalle",
                            onclick: async () => await this.actividadDetail(actividad)
                        },
                    ]
                },
            ]
        })
    }
    actividadDetail = async (actividad) => {
        const actividadDetailView = WRender.Create({ className: "actividadDetailView", children: [this.actividadElementDetail(actividad)] });
        const commentsDataset = await new Tbl_Comments({ Id_Case: actividad.Id_Case }).Get();
        const commentsContainer = new WCommentsComponent({
            Dataset: commentsDataset,
            ModelObject: new Tbl_Comments(),
            User: WSecurity.UserData,
            UserIdProp: "Id_User",
            CommentsIdentify: actividad.Id_Case,
            UrlSearch: "../api/ApiEntityHelpdesk/getTbl_Comments",
            UrlAdd: "../api/ApiEntityHelpdesk/saveTbl_Comments"
        });
        actividadDetailView.append(commentsContainer)
        this.TabManager.NavigateFunction("Tab-Actividades-Viewer" + actividad.Id_Case, actividadDetailView);
    }

    actividadElementDetail = (actividad) => {
        return WRender.Create({
            className: "actividadDetail", object: actividad, children: [
                this.actividadElement(actividad)
            ]
        })
    }

    nuevoCaso = async () => {
        const form = new WForm({
            ModelObject: this.ModelObject,
            SaveFunction: ()=> {
                this.shadowRoot.append(ModalMessege("Aviso", "Caso guardado correctamente", true))
            }
        })
        this.TabManager.NavigateFunction("Tab-nuevoCasoView",
            WRender.Create({ className: "nuevoCasoView", children: [form] }));
    }


    WStyle = activityStyle.cloneNode(true);

    mapCaseToPaginatorElement(Dataset) {
        return Dataset.map(actividad => {
            actividad.Dependencia = actividad.Cat_Dependencias.Descripcion;
            //actividad.Progreso = actividad.Tbl_Tareas?.filter(tarea => tarea.Estado?.includes("Finalizado")).length;
            return this.actividadElement(actividad);
        });
    }
}
customElements.define('w-main-solicitudes', MainSolicitudesView);
export { MainSolicitudesView };

