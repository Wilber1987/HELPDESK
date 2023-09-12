

import { CaseSearcherToVinculate } from '../../../AppComponents/CaseSearcherToVinculate.js';
import { CaseOwModel } from '../../../Model/CaseOwModel.js';
import { ViewCalendarioByDependencia } from '../../../Model/DBOViewModel.js';
import { CaseTable_Agenda, CaseTable_Calendario, CaseTable_Case, CaseTable_Comments, CaseTable_Evidencias, CaseTable_Tareas, CaseTable_VinculateCase, Cat_Dependencias } from '../../../Model/ProyectDataBaseModel.js';
import { WSecurity } from '../../../WDevCore/Security/WSecurity.js';
import { StylesControlsV2, StylesControlsV3 } from "../../../WDevCore/StyleModules/WStyleComponents.js";
import { WAppNavigator } from '../../../WDevCore/WComponents/WAppNavigator.js';
import { GanttChart } from '../../../WDevCore/WComponents/WChartJSComponents.js';
import { WCommentsComponent } from '../../../WDevCore/WComponents/WCommentsComponent.js';
import { DocumentViewer } from '../../../WDevCore/WComponents/WDocumentViewer.js';
import { ModalMessege, ModalVericateAction, WForm } from "../../../WDevCore/WComponents/WForm.js";
import { WModalForm } from '../../../WDevCore/WComponents/WModalForm.js';
import { WPaginatorViewer } from '../../../WDevCore/WComponents/WPaginatorViewer.js';
import { WTableComponent } from "../../../WDevCore/WComponents/WTableComponent.js";
import { ComponentsManager, WRender } from '../../../WDevCore/WModules/WComponentsTools.js';
import { ControlBuilder } from '../../../WDevCore/WModules/WControlBuilder.js';
import { css } from '../../../WDevCore/WModules/WStyledRender.js';
import { TaskManagers } from './TaskManager.js';

class CaseDetailComponent extends HTMLElement {
    /**
     * 
     * @param {CaseTable_Case} Actividad 
     * @param {Array<Cat_Dependencias>} Dependencias 
     */
    constructor(Actividad) {
        super();
        this.Actividad = Actividad;
        this.attachShadow({ mode: 'open' });
        this.shadowRoot.append(this.WStyle, StylesControlsV2.cloneNode(true), StylesControlsV3.cloneNode(true));
        this.TabContainer = WRender.createElement({ type: 'div', props: { class: 'TabContainer', id: "TabContainer" } });
        this.TabManager = new ComponentsManager({ MainContainer: this.TabContainer });
        this.OptionContainer = WRender.Create({ className: "OptionContainer" });
        this.OptionContainer.append(WRender.Create({
            tagName: 'a', className: 'Block-Alert', innerText: 'Lista de Casos', href: "/Perfil/Proyectos"
        }))

        this.shadowRoot.append(this.OptionContainer, this.TabContainer);
        this.DrawCaseDetailComponent(this.Actividad);
    }
    connectedCallback() { }

    DrawCaseDetailComponent = async (actividad = (new CaseTable_Case())) => {
        const tareasActividad = await new CaseTable_Tareas({ Id_Case: actividad.Id_Case }).Get();
        actividad.CaseTable_Tareas = tareasActividad;

        this.actividadDetailView = WRender.Create({ className: "actividadDetailView", children: [this.actividadElementDetail(actividad)] });
        const taskModel = new CaseTable_Tareas({
            Id_Case: { type: 'number', hidden: true, value: actividad.Id_Case },
            CaseTable_Tarea: {
                type: 'WSelect', label: "Tarea principal", require: false, hiddenInTable: true,
                Dataset: tareasActividad, ModelObject: () => new CaseTable_Tareas()
            },
            CaseTable_Calendario: {
                type: 'CALENDAR', CalendarFunction: async () => {
                    return {
                        Agenda: await new CaseTable_Agenda({ Id_Dependencia: actividad.Cat_Dependencias.Id_Dependencia }).Get(),
                        Calendario: await new ViewCalendarioByDependencia({ Id_Dependencia: actividad.Cat_Dependencias.Id_Dependencia }).Get()
                    }
                }, require: true
            }
        });
        this.tasktable = new WTableComponent({
            Dataset: tareasActividad,
            maxElementByPage: 6,
            ModelObject: taskModel, Options: {
                //Add: true, UrlAdd: "../api/ApiEntityDBO/saveCaseTable_Tareas",
                //Edit: true, UrlUpdate: "../api/ApiEntityDBO/updateCaseTable_Tareas",
                //Search: true, UrlSearch: "../api/ApiEntityDBO/getCaseTable_Tareas",
                UserActions: [{
                    name: "Nueva Evidencia", action: (Tarea) => {
                        this.actividadDetailView.append(new WModalForm({
                            ModelObject: new CaseTable_Evidencias({ Id_Tarea: Tarea.Id_Tarea }),
                            StyleForm: "columnX1"
                        }))
                    }
                }, {
                    name: "Ver Evidencias", action: async (Tarea) => {
                        const response = await new CaseTable_Evidencias({ Id_Tarea: Tarea.Id_Tarea }).Get();
                        this.actividadDetailView.append(new WModalForm({
                            ObjectModal: new DocumentViewer({
                                Actividad: response.map((e, index) => ({
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
        this.ganttChart = new GanttChart({ Dataset: tareasActividad ?? [], EvalValue: "date" });
        const tabManager = new ComponentsManager({ MainContainer: taskContainer });

        const commentsActividad = await new CaseTable_Comments({ Id_Case: actividad.Id_Case }).Get();
        const commentsContainer = new WCommentsComponent({
            Dataset: commentsActividad,
            ModelObject: new CaseTable_Comments(),
            User: WSecurity.UserData,
            UserIdProp: "Id_User",
            CommentsIdentify: actividad.Id_Case,
            UrlSearch: "../api/ApiEntityHelpdesk/getCaseTable_Comments",
            UrlAdd: "../api/ApiEntityHelpdesk/saveCaseTable_Comments"
        });
        this.taskManager = new TaskManagers(tareasActividad,
            taskModel, {
            ImageUrlPath: "/Media/Image/", action: async (task) => {
                this.update();
            }
        })
        const taskNav = new WAppNavigator({
            //NavStyle: "tab",
            Inicialize: true,
            Elements: [
                {
                    name: "Vista de panel", action: async (ev) => {
                        tabManager.NavigateFunction("taskManager", this.taskManager)
                    }
                },
                { name: "Vista de progreso", action: async (ev) => { tabManager.NavigateFunction("ganttChart", this.ganttChart) } },
                //{ name: "Vista de detalles", action: async (ev) => { tabManager.NavigateFunction("taskTable", this.tasktable) } },
                {
                    name: "Nueva Tarea", action: async (ev) => {
                        this.shadowRoot.append(new WModalForm({
                            ModelObject: taskModel,
                            AutoSave: true,
                            title: "Nueva Tarea",
                            ObjectOptions: {
                                SaveFunction: (task) => {
                                    this.update();
                                }
                            }
                        }))
                    }
                },
                //actividad.Id_Vinculate != null ? 
                {
                    name: "Vinculaciones", action: async (ev) => {
                        const modelVinculate = new CaseTable_Case({ Id_Vinculate: actividad.Id_Vinculate });
                        console.log(modelVinculate);
                        const vinculateTable = new WTableComponent({
                            Dataset: await modelVinculate.GetVinculateCase(),
                            ModelObject: new CaseTable_Case(),
                            AddItemsFromApi: false,
                            Options: {
                                UserActions: [{
                                    name: "Desvincular caso", action: (caso) => {
                                        this.Desvincular(caso, vinculateTable, modelVinculate);
                                    }
                                }]
                            }
                        })
                        tabManager.NavigateFunction("vinculaciones", vinculateTable)
                    }
                }
            ]
        });

        this.actividadDetailView.append(commentsContainer, taskNav, taskContainer)
        this.TabManager.NavigateFunction("Tab-Actividades-Viewer" + actividad.Id_Case, this.actividadDetailView);
    }

    actividadElement = (actividad) => {
        actividad.Progreso = actividad.CaseTable_Tareas?.filter(tarea => tarea.Estado?.includes("Finalizado")).length;
        return WRender.Create({
            className: "actividad", object: actividad, children: [
                { tagName: 'h4', innerText: `#${actividad.Id_Case} - ${actividad.Titulo} (${actividad.Tbl_Servicios?.Descripcion_Servicio ?? ""})` },
                {
                    className: "options", children: [
                        { tagName: 'button', className: 'Btn-Mini', innerText: "Editar", onclick: async () => this.editCase() },
                        actividad.Estado == "Finalizado" ?
                            { tagName: 'button', className: 'Btn-Mini', innerText: 'Reabrir Caso', onclick: () => this.Reabrir(actividad) } :
                            { tagName: 'button', className: 'Btn-Mini', innerText: 'Cerrar Caso', onclick: () => this.CerrarCaso(actividad) }
                    ]
                }, {
                    className: "propiedades", children: [
                        { tagName: 'label', innerText: "Estado: " + actividad.Estado },
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

    editCase = async () => {
        this.shadowRoot.append(new WModalForm({
            title: "Editar Caso",
            AutoSave: true,
            EditObject: this.Actividad, 
            ModelObject: await CaseOwModel(),
            ObjectOptions: { SaveFunction: ()=> {
                this.update();
            }}
        }))
    }

    actividadElementDetail = (actividad) => {
        return WRender.Create({
            className: "actividadDetail", object: actividad, children: [
                this.actividadElement(actividad)
            ]
        })
    }

    Desvincular = async (actividad, table, modelVinculate) => {
        this.shadowRoot.append(ModalVericateAction(async () => {
            const response = await new CaseTable_VinculateCase({
                Casos_Vinculados: [actividad]
            }).DesvincularCaso();
            this.shadowRoot.append(ModalMessege("Caso desvinculado exitosamente"));
            table.Dataset = await modelVinculate.GetOwCase();
            table.DrawTable();
        }, "¿Está seguro que desea desvincular este caso?"))

    }
    CerrarCaso = async (actividad) => {
        this.shadowRoot.append(ModalVericateAction(async () => {
            const response = await new CaseTable_Case(actividad).CerrarCaso();
            if (response.status == 200) {
                this.shadowRoot.append(ModalMessege("Caso cerrado exitosamente"));
                this.update();
            } else {
                this.shadowRoot.append(ModalMessege(response.message))
            }

        }, "¿Está seguro que desea cerrar este caso?"))

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
    update = async () => {
        // const find = actividad.CaseTable_Tareas.find(t => t.Id_Tarea == task.Id_Tarea);
        // for (const prop in task) {
        //     find[prop] = task[prop]
        // }


        const dataTask = await new CaseTable_Tareas({ Id_Case: this.Actividad.Id_Case }).Get();
        console.log(dataTask);
        this.ganttChart.Dataset = dataTask;
        this.Actividad.CaseTable_Tareas = dataTask;


        this.tasktable.Dataset = dataTask;
        this.taskManager.Dataset = dataTask;

        this.Actividad.Progreso = this.Actividad.CaseTable_Tareas?.filter(tarea => tarea.Estado?.includes("Finalizado")).length;
        this.actividadDetailView.querySelector(".actividadDetail").innerHTML = "";
        this.actividadDetailView.querySelector(".actividadDetail").append(this.actividadElementDetail(this.Actividad));

        this.tasktable.DrawTable();
        this.taskManager.DrawTaskManagers();
        this.ganttChart.DrawComponent();
        this.ganttChart.Animate();
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
customElements.define('w-case-detail', CaseDetailComponent);
export { CaseDetailComponent };