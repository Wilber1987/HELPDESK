

import { Cat_Dependencias, CaseTable_Case, CaseTable_Agenda, CaseTable_Calendario, CaseTable_Evidencias, CaseTable_Participantes, CaseTable_Tareas, CaseTable_Comments, CaseTable_VinculateCase } from '../../../Model/ProyectDataBaseModel.js';
import { ViewCalendarioByDependencia } from '../../../Model/DBOViewModel.js';
import { StylesControlsV2, StylesControlsV3 } from "../../../WDevCore/StyleModules/WStyleComponents.js";
import { WAppNavigator } from '../../../WDevCore/WComponents/WAppNavigator.js';
import { ColumChart, GanttChart, RadialChart } from '../../../WDevCore/WComponents/WChartJSComponents.js';
import { DocumentViewer } from '../../../WDevCore/WComponents/WDocumentViewer.js';
import { WFilterOptions } from '../../../WDevCore/WComponents/WFilterControls.js';
import { ModalVericateAction, WForm } from "../../../WDevCore/WComponents/WForm.js";
import { WModalForm } from '../../../WDevCore/WComponents/WModalForm.js';
import { WPaginatorViewer } from '../../../WDevCore/WComponents/WPaginatorViewer.js';
import { WTableComponent } from "../../../WDevCore/WComponents/WTableComponent.js";
import { ComponentsManager, WArrayF, WRender } from '../../../WDevCore/WModules/WComponentsTools.js';
import { ControlBuilder } from '../../../WDevCore/WModules/WControlBuilder.js';
import { WCssClass, WStyledRender, css } from '../../../WDevCore/WModules/WStyledRender.js';
import { TaskManagers } from './TaskManager.js';
import { WCommentsComponent } from '../../../WDevCore/WComponents/WCommentsComponent.js';
import { WSecurity } from '../../../WDevCore/WModules/WSecurity.js';
import { CaseSearcherToVinculate } from '../../../AppComponents/CaseSearcherToVinculate.js';

class CaseManagerComponent extends HTMLElement {
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
        this.shadowRoot.append(this.WStyle, StylesControlsV2.cloneNode(true), StylesControlsV3.cloneNode(true));
        this.TabContainer = WRender.createElement({ type: 'div', props: { class: 'TabContainer', id: "TabContainer" } });
        this.TabManager = new ComponentsManager({ MainContainer: this.TabContainer });
        this.OptionContainer = WRender.Create({ className: "OptionContainer" });
        this.DrawCaseManagerComponent();
    }
    connectedCallback() { }
    DrawCaseManagerComponent = async () => {
        //this.OptionContainer.append(WRender.Create({ tagName: 'input', type: 'button', className: 'Block-Basic', value: 'Estadística', onclick: this.dashBoardView }))
        this.OptionContainer.append(WRender.Create({ tagName: 'input', type: 'button', className: 'Block-Alert', value: 'Actividades', onclick: this.actividadesManager }))
        //this.OptionContainer.append(WRender.Create({ tagName: 'input', type: 'button', className: 'Block-Secundary', value: 'Dependencias', onclick: this.dependenciasViewer }))
        if (this.Dependencias.length != 0) {
            this.OptionContainer.append(WRender.Create({
                tagName: 'input', type: 'button', className: 'Block-Success',
                value: 'Nueva Actividad', onclick: this.CaseForm
            }))
        }
        this.shadowRoot.append(this.OptionContainer, this.TabContainer);
        //this.dashBoardView();
        this.actividadesManager();
    }
    actividadesManager = async () => {
        const datasetMap = this.Dataset.map(actividad => {
            actividad.Dependencia = actividad.Cat_Dependencias?.Descripcion;
            actividad.Progreso = actividad.CaseTable_Tareas?.filter(tarea => tarea.Estado?.includes("Finalizado")).length;
            return this.actividadElement(actividad);
        });
        this.TabManager.NavigateFunction("Tab-Actividades-Manager",
            WRender.Create({ className: "actividadesView", children: [new WPaginatorViewer({ Dataset: datasetMap, userStyles: [StylesControlsV2] })] }));
    }

    actividadElement = (actividad) => {
        return WRender.Create({
            className: "actividad", object: actividad, children: [
                { tagName: 'h4', innerText: `${actividad.Titulo} (${actividad.Tbl_Servicios?.Descripcion_Servicio ?? ""})` },
                {
                    className: "options", children: [
                        { tagName: 'button', className: 'Btn-Mini', innerText: "Detalle", onclick: async () => await this.actividadDetail(actividad) },
                        { tagName: 'button', className: 'Btn-Mini', innerText: 'Vincular Caso', onclick: () => this.Vincular(actividad) }
                    ]
                }, {
                    className: "propiedades", children: [
                        { tagName: 'label', innerText: "Estado: " + actividad.Estado },
                        { tagName: 'label', innerText: "Dependencia: " + actividad.Dependencia },
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
        const actividadDetailView = WRender.Create({ className: "actividadDetailView", children: [this.actividadElementDetail(actividad)] });
        const tareasActividad = await new CaseTable_Tareas({ Id_Case: actividad.Id_Case }).Get();
        const taskModel = new CaseTable_Tareas({
            Id_Case: { type: 'number', hidden: true, value: actividad.Id_Case },
            CaseTable_Tarea: { type: 'WSelect', Dataset: tareasActividad, ModelObject: () => new CaseTable_Tareas() },
            CaseTable_Calendario: {
                type: 'CALENDAR', CalendarFunction: async () => {
                    return {
                        Agenda: await new CaseTable_Agenda({ Id_Dependencia: actividad.Cat_Dependencias.Id_Dependencia }).Get(),
                        Calendario: await new ViewCalendarioByDependencia({ Id_Dependencia: actividad.Cat_Dependencias.Id_Dependencia }).Get()
                    }
                }, require: false, hiddenInTable: true
            }
        });
        const tasktable = new WTableComponent({
            Dataset: tareasActividad,
            ModelObject: taskModel, Options: {
                //Add: true, UrlAdd: "../api/ApiEntityDBO/saveCaseTable_Tareas",
                //Edit: true, UrlUpdate: "../api/ApiEntityDBO/updateCaseTable_Tareas",
                //Search: true, UrlSearch: "../api/ApiEntityDBO/getCaseTable_Tareas",
                UserActions: [{
                    name: "Nueva Evidencia", action: (Tarea) => {
                        actividadDetailView.append(new WModalForm({
                            ModelObject: new CaseTable_Evidencias({ Id_Tarea: Tarea.Id_Tarea }),
                            StyleForm: "columnX1"
                        }))
                    }
                }, {
                    name: "Ver Evidencias", action: async (Tarea) => {
                        const response = await new CaseTable_Evidencias({ Id_Tarea: Tarea.Id_Tarea }).Get();
                        actividadDetailView.append(new WModalForm({
                            ObjectModal: new DocumentViewer({
                                Dataset: response.map((e, index) => ({
                                    TypeDocuement: e.Cat_Tipo_Evidencia?.Descripcion,
                                    Description: e.Descripcion ?? "document " + (index + 1),
                                    Document: e.Data
                                }))
                            })
                        }))
                    }
                }]
            }
        })
        const taskContainer = WRender.Create({ className: "" });
        const ganttChart = new GanttChart({ Dataset: tareasActividad ?? [], EvalValue: "date" });
        const tabManager = new ComponentsManager({ MainContainer: taskContainer });
        const taskNav = new WAppNavigator({
            //NavStyle: "tab",
            Inicialize: true,
            Elements: [
                {
                    name: "Vista de panel", action: async (ev) => {
                        tabManager.NavigateFunction("taskPanel",
                            new TaskManagers(tareasActividad,
                                taskModel, {
                                ImageUrlPath: "/Media/Image/", action: async (task) => {
                                    const find = actividad.CaseTable_Tareas.find(t => t.Id_Tarea == task.Id_Tarea);
                                    for (const prop in task) {
                                        find[prop] = task[prop]
                                    }
                                    actividad.Progreso = actividad.CaseTable_Tareas?.filter(tarea => tarea.Estado?.includes("Finalizado")).length;
                                    actividadDetailView.querySelector(".actividadDetail").innerHTML = "";
                                    actividadDetailView.querySelector(".actividadDetail").append(this.actividadElementDetail(actividad));
                                }
                            }))
                    }
                },
                { name: "Vista de progreso", action: async (ev) => { tabManager.NavigateFunction("ganttChart", ganttChart) } },
                { name: "Vista de detalles", action: async (ev) => { tabManager.NavigateFunction("taskTable", tasktable) } },
                {
                    name: "Nueva Tarea", action: async (ev) => {
                        this.shadowRoot.append(new WModalForm({
                            ModelObject: taskModel,
                            AutoSave: true, title: "Nueva Tarea"
                        }))
                    }
                },
                actividad.Id_Vinculate != null ? {
                    name: "Vinculaciones", action: async (ev) => {
                        const modelVinculate = new CaseTable_Case({ Id_Vinculate: actividad.Id_Vinculate });
                        tabManager.NavigateFunction("vinculaciones",
                            new WTableComponent({ Dataset: await modelVinculate.GetOwCase(), ModelObject: new CaseTable_Case() }))
                    }
                } : undefined
            ]
        });
        const commentsDataset = await new CaseTable_Comments({ Id_Case: actividad.Id_Case }).Get();
        const commentsContainer = new WCommentsComponent({
            Dataset: commentsDataset,
            ModelObject: new CaseTable_Comments(),
            User: WSecurity.UserData,
            UserIdProp: "Id_User",
            CommentsIdentify: actividad.Id_Case,
            UrlSearch: "../api/ApiEntityHelpdesk/getCaseTable_Comments",
            UrlAdd: "../api/ApiEntityHelpdesk/saveCaseTable_Comments"
        });

        actividadDetailView.append(commentsContainer, taskNav, taskContainer)
        this.TabManager.NavigateFunction("Tab-Actividades-Viewer" + actividad.Id_Case, actividadDetailView);
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
    Vincular = async (actividad) => {
        this.shadowRoot.append(new WModalForm({
            title: "Vincular Casos",
            ObjectModal: CaseSearcherToVinculate(actividad, "Vincular", async (caso_vinculado, TableComponent, model) => {
                this.shadowRoot.append(ModalVericateAction(async () => {
                    const response = await new CaseTable_VinculateCase({
                        Casos_Vinculados: [actividad, caso_vinculado]
                    }).VincularCaso();
                    const updateData = await model.Get();
                    TableComponent.Dataset = updateData;
                    TableComponent.DrawTable();
                }, "Esta seguro de vincular este caso"))
            })
        }));
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
            grid-template-columns: calc(100% - 420px) 400px;
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
            grid-template-columns: calc(100% - 100px) 100px;
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
customElements.define('w-case-manager', CaseManagerComponent);
export { CaseManagerComponent };
/**
 * @param {CaseTable_Case} [entity] 
 * @param {Array<Cat_Dependencias>} [dependencias] 
 * @param {Function} [action] 
 * @returns {WForm}
 */
const CaseForm = (entity, dependencias, action) => {
    const ModelCalendar = {
        type: 'CALENDAR',
        ModelObject: () => new CaseTable_Calendario(),
        require: false,
        CalendarFunction: async () => {
            return {
                Agenda: await new CaseTable_Agenda({ Id_Dependencia: form.FormObject.Cat_Dependencias?.Id_Dependencia }).Get(),
                Calendario: await new CaseTable_Calendario({ Id_Dependencia: form.FormObject.Cat_Dependencias?.Id_Dependencia }).Get()
            }
        }
    }

    const form = new WForm({
        EditObject: entity,
        SaveFunction: action,
        ImageUrlPath: "/Media/Image/",
        ModelObject: new CaseTable_Case({
            CaseTable_Tareas: {
                type: 'MasterDetail',
                ModelObject: () => new CaseTable_Tareas({ CaseTable_Calendario: ModelCalendar })
            }, Cat_Dependencias: {
                type: "WSELECT", ModelObject: new Cat_Dependencias(),
                Dataset: dependencias,
                action: (caso) => {
                    caso.CaseTable_Tareas
                        .forEach(caseTable_Tarea => caseTable_Tarea.CaseTable_Calendario = []);
                    form.DrawComponent();
                }
            }
        })
    })
    return form;
}
export { CaseForm }

/**
 * @param {CaseTable_Case} [entity] 
 * @param {Array<Cat_Dependencias>} [dependencias] 
 * @param {Function} [action] 
 * @returns {WForm}
 */
const simpleCaseForm = (entity, dependencias, action) => {
    const form = new WForm({
        EditObject: entity,
        SaveFunction: action,
        ImageUrlPath: "/Media/Image/",
        ModelObject: new CaseTable_Case({
            CaseTable_Tareas: { hidden: true },
            Id_Vinculate: { hidden: true },
            Titulo: { hidden: true },
            Tbl_Servicios: { hidden: true },
            Fecha_Inicial: { hidden: true },
            Estado: { hidden: true },
            Fecha_Final: { hidden: true },
            Descripcion: { hidden: true },
            CaseTable_Comments: { type: "MasterDetail", ModelObject: new CaseTable_Comments(), label: "Comentario" },
            Cat_Dependencias: {
                type: "WSELECT", ModelObject: new Cat_Dependencias(),
                Dataset: dependencias,
                action: (caso) => {

                }
            },
        })
    })
    return form;
}
export { simpleCaseForm }
