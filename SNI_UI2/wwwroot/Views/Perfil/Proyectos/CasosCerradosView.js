

import { CaseSearcherToVinculate } from '../../../AppComponents/CaseSearcherToVinculate.js';
import { priorityStyles } from '../../../AppComponents/Styles.js';
import { CaseOwModel } from '../../../Model/CaseOwModel.js';
import { ViewCalendarioByDependencia } from '../../../Model/DBOViewModel.js';
import { CaseTable_Agenda, CaseTable_Calendario, CaseTable_Case, CaseTable_Comments, CaseTable_Evidencias, CaseTable_Tareas, CaseTable_VinculateCase, Cat_Dependencias } from '../../../Model/ProyectDataBaseModel.js';
import { WSecurity } from '../../../WDevCore/Security/WSecurity.js';
import { StylesControlsV2, StylesControlsV3 } from "../../../WDevCore/StyleModules/WStyleComponents.js";
import { WAppNavigator } from '../../../WDevCore/WComponents/WAppNavigator.js';
import { GanttChart } from '../../../WDevCore/WComponents/WChartJSComponents.js';
import { WCommentsComponent } from '../../../WDevCore/WComponents/WCommentsComponent.js';
import { DocumentViewer } from '../../../WDevCore/WComponents/WDocumentViewer.js';
import { WFilterOptions } from '../../../WDevCore/WComponents/WFilterControls.js';
import { ModalMessege, ModalVericateAction, WForm } from "../../../WDevCore/WComponents/WForm.js";
import { WModalForm } from '../../../WDevCore/WComponents/WModalForm.js';
import { WPaginatorViewer } from '../../../WDevCore/WComponents/WPaginatorViewer.js';
import { WTableComponent } from "../../../WDevCore/WComponents/WTableComponent.js";
import { ComponentsManager, WRender } from '../../../WDevCore/WModules/WComponentsTools.js';
import { ControlBuilder } from '../../../WDevCore/WModules/WControlBuilder.js';
import { css } from '../../../WDevCore/WModules/WStyledRender.js';
import { TaskManagers } from './TaskManager.js';

/**
 * @typedef {Object} ComponentConfig
 * * @property {Object} [propierty]
 */
class CasosCerradosView extends HTMLElement {
    /**
    * 
    * @param {Array<CaseTable_Case>} Dataset 
    * @param {Array<Cat_Dependencias>} Dependencias 
    */
    constructor(Dataset, Dependencias) {
        super();
        this.Dataset = Dataset;
        this.Dependencias = Dependencias;
        this.attachShadow({ mode: 'open' });
        this.shadowRoot?.append(this.WStyle, StylesControlsV2.cloneNode(true), StylesControlsV3.cloneNode(true));
        this.TabContainer = WRender.createElement({ type: 'div', props: { class: 'TabContainer', id: "TabContainer" } });
        this.TabManager = new ComponentsManager({ MainContainer: this.TabContainer });
        this.OptionContainer = WRender.Create({ className: "OptionContainer" });
        this.ModelObject = new CaseTable_Case({
            CaseTable_Tareas: undefined, Estado: undefined, Cat_Dependencias: {
                type: "WSELECT",  hiddenFilter: true, ModelObject: () => new Cat_Dependencias()
            }, Get : async ()=> {
                return await this.ModelObject.GetData("Proyect/GetOwCloseCase");
            }
        });
        this.DrawCaseManagerComponent();
    }
    connectedCallback() { }
    DrawCaseManagerComponent = async () => {
        //this.OptionContainer.append(WRender.Create({ tagName: 'input', type: 'button', className: 'Block-Basic', value: 'Estadística', onclick: this.dashBoardView }))
        this.shadowRoot?.append(this.OptionContainer, this.TabContainer);
        //this.dashBoardView();
        this.actividadesManager();
    }
    actividadesManager = async () => {
        const datasetMap = this.generatePaginatorList(this.Dataset);
        this.paginator = new WPaginatorViewer({ Dataset: datasetMap, userStyles: [StylesControlsV2] });
        this.FilterOptions = new WFilterOptions({
            Dataset: this.Dataset,
            ModelObject: this.ModelObject,
            FilterFunction: (DFilt) => {
                this.paginator?.Draw(this.generatePaginatorList(DFilt));
            }
        });
        this.TabManager.NavigateFunction("Tab-Actividades-Manager",
            WRender.Create({ className: "actividadesView", children: [this.FilterOptions, this.paginator] }));
    }
    generatePaginatorList = (Dataset)=>{
        return Dataset.filter(x => x.Estado != "Vinculado").map(actividad => {
            actividad.Dependencia = actividad.Cat_Dependencias?.Descripcion;
            actividad.Progreso = actividad.CaseTable_Tareas?.filter(tarea => tarea.Estado?.includes("Finalizado")).length;
            return this.actividadElement(actividad);
        });
    }

    actividadElement = (actividad) => {
        this.shadowRoot.append(priorityStyles.cloneNode(true));
        return WRender.Create({
            className: "actividad", object: actividad, children: [
                { tagName: 'h4', innerText: `#${actividad.Id_Case} - ${actividad.Titulo} (${actividad.Tbl_Servicios?.Descripcion_Servicio ?? ""})` },
                {
                    className: "options", children: [
                        { tagName: 'button', className: 'Btn-Mini', innerText: "Detalle", onclick: async () => await this.actividadDetail(actividad) },
                        { tagName: 'button', className: 'Btn-Mini', innerText: 'Reabrir Caso', onclick: () => this.Reabrir(actividad) }
                    ]
                }, {
                    className: "propiedades", children: [
                        { tagName: 'label', innerText: "Estado: " + actividad.Estado },
                        {
                            tagName: 'label', className: "prioridad_" + (actividad.Case_Priority != null ? actividad.Case_Priority : undefined),
                            innerText: "Prioridad: " + (actividad.Case_Priority != null ? actividad.Case_Priority ?? "indefinida" : "indefinida")
                        },
                        { tagName: 'label', innerText: "Dependencia: " + actividad.Cat_Dependencias.Descripcion },
                        { tagName: 'label', innerText: "Fecha inicio: " + actividad.Fecha_Inicial?.toString().toDateFormatEs() },
                        { tagName: 'label', innerText: "Fecha de finalización: " + actividad.Fecha_Final?.toString().toDateFormatEs() },
                    ]
                },
                { tagName: 'h4', innerText: "Progreso" },
                ControlBuilder.BuildProgressBar(actividad.Progreso,
                    actividad.CaseTable_Tareas?.filter(tarea => !tarea.Estado?.includes("Inactivo"))?.length)
            ]
        })
    }
    actividadElementDetail = (actividad) => {
        return WRender.Create({
            className: "actividadDetail", object: actividad, children: [
                this.actividadElement(actividad)
            ]
        })
    }

    actividadDetail = async (actividad = (new CaseTable_Case())) => {
        sessionStorage.setItem("detailCase", JSON.stringify(actividad));
        window.location = "/Perfil/CaseDetail"
    }
    dependenciasViewer = async () => {
        const dependenciasDetailView = WRender.Create({ className: "", children: [] });
        //const tareasActividad = await new Cat_Dependencias().Get();
        dependenciasDetailView.append(new WTableComponent({
            ModelObject: new Cat_Dependencias({}),
            Options: {
                Add: true, UrlAdd: "../api/ApiEntityDBO/saveCat_Dependencias",
                Edit: true, UrlUpdate: "../api/ApiEntityDBO/updateCat_Dependencias",
                Search: true, UrlSearch: "../api/ApiEntityDBO/getCat_Dependencias",
                UserActions: []
            }
        }))
        this.TabManager.NavigateFunction("Tab-Dependencias-Viewer", dependenciasDetailView);
    }
    CaseForm = async () => {
        this.TabManager.NavigateFunction("Tab-CaseFormView",
            WRender.Create({ className: "CaseFormView", children: [CaseForm(undefined, this.Dependencias)] }));
    }
    Reabrir = async (actividad) => {
        this.shadowRoot.append(ModalVericateAction(async () => {
            actividad.Estado = "Activo"
            const response = await new CaseTable_Case(actividad).Update();
            if (response.status == 200) {
                this.shadowRoot.append(ModalMessege("Caso reabierto exitosamente"));
                this.update();
            } else {
                this.append(ModalMessege(response.message))
            }
        }, "¿Está seguro que desea reabrir este caso?"))

    }


    WStyle = css`
        .dashBoardView{
            display: grid;
            grid-template-columns: auto auto ;  
            grid-gap: 20px          
        }
        .OptionContainer {
            margin: 0 0 20px 0;
        }
        .actividadDetailView {
            display: grid;
            grid-template-columns: calc(100% - 520px) 500px;
            grid-template-rows: 150px 50px auto;
            gap: 0px 20px;
        }
        w-coment-component {
            grid-row: span 3;
        }
        .dashBoardView w-colum-chart { 
            grid-column: span 2;
        }
        .actividad {
            border: 1px solid #d9d6d6;
            padding: 15px;
            margin-bottom: 10px;           
            color: #0a2542;
            border-radius: 15px;
            display: grid;
            grid-template-columns: calc(100% - 180px) 100px;
        }
        .actividad h4 {
            margin: 5px 0px;
            font-size: 13px;
         }
        .actividad .propiedades {
            font-size: 12px;
            display: flex;
            gap: 10px;
        }
        .actividad .options {
            display: flex;
            flex-direction: column;
            gap: 10;
            grid-row: span 4; 
            justify-content: space-around           
        }
    `
}
customElements.define('w-caos-cerrados-view', CasosCerradosView);
window.onload = async () => {
    const dependencias = await new Cat_Dependencias().GetOwDependencies();
    const dataset = await new CaseTable_Case().GetOwCloseCase();
    Main.appendChild(new CasosCerradosView(dataset, dependencias));
}
export { CasosCerradosView }