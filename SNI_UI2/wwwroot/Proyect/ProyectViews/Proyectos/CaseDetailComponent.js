

import { priorityStyles } from '../../../AppComponents/Styles.js';
import { CaseOwModel } from '../../../ModelProyect/CaseOwModel.js';
import { ViewCalendarioByDependencia } from '../../../ModelProyect/DBOViewModel.js';
import { Tbl_Agenda, Tbl_Case, Tbl_Comments, Tbl_Evidencias, Tbl_Tareas, Tbl_VinculateCase, Cat_Dependencias, Tbl_Servicios } from '../../../ModelProyect/ProyectDataBaseModel.js';
import { Permissions, WSecurity } from '../../../WDevCore/Security/WSecurity.js';
import { StylesControlsV2, StylesControlsV3 } from "../../../WDevCore/StyleModules/WStyleComponents.js";
import { WAppNavigator } from '../../../WDevCore/WComponents/WAppNavigator.js';
import { GanttChart } from '../../../WDevCore/WComponents/WChartJSComponents.js';
import { WCommentsComponent } from '../../../WDevCore/WComponents/WCommentsComponent.js';
import { DocumentViewer } from '../../../WDevCore/WComponents/WDocumentViewer.js';
import { ModalMessege, ModalVericateAction } from "../../../WDevCore/WComponents/WForm.js";
import { WModalForm } from '../../../WDevCore/WComponents/WModalForm.js';
import { WTableComponent } from "../../../WDevCore/WComponents/WTableComponent.js";
import { ComponentsManager, WRender } from '../../../WDevCore/WModules/WComponentsTools.js';
import { ControlBuilder } from '../../../WDevCore/WModules/WControlBuilder.js';
import { css } from '../../../WDevCore/WModules/WStyledRender.js';
import { activityStyle } from '../../style.js';
import { simpleCaseForm } from './CaseManagerComponent.js';
import { TaskManagers } from './TaskManager.js';

class CaseDetailComponent extends HTMLElement {
    /**
     * 
     * @param {Tbl_Case} Actividad 
     * @param {Array<Cat_Dependencias>} Dependencias 
     */
    constructor(Actividad) {
        super();
        this.Actividad = Actividad;
        this.attachShadow({ mode: 'open' });
        this.shadowRoot.append(this.WStyle, this.CustomStyle, StylesControlsV2.cloneNode(true), StylesControlsV3.cloneNode(true));
        this.TabContainer = WRender.createElement({ type: 'div', props: { class: 'TabContainer', id: "TabContainer" } });
        this.TabManager = new ComponentsManager({ MainContainer: this.TabContainer });
        this.OptionContainer = WRender.Create({ className: "OptionContainer" });
        // this.OptionContainer.append(WRender.Create({
        //     tagName: 'a', className: 'Block-Alert', innerText: 'Lista de Casos', href: "/ProyectViews/Proyectos"
        // }))

        this.shadowRoot.append(this.OptionContainer, this.TabContainer);
        this.DrawCaseDetailComponent(this.Actividad);
    }
    connectedCallback() { }

    DrawCaseDetailComponent = async (actividad = (new Tbl_Case())) => {
        const tareasActividad = await new Tbl_Tareas({ Id_Case: actividad.Id_Case }).Get();
        actividad.Tbl_Tareas = tareasActividad;

        this.actividadDetailView = WRender.Create({ className: "actividadDetailView", children: [this.actividadElementDetail(actividad)] });
        const taskModel = new Tbl_Tareas({
            Id_Case: { type: 'number', hidden: true, value: actividad.Id_Case },
            Tbl_Tarea: {
                type: 'WSelect', label: "Tarea principal", require: false, hiddenInTable: true,
                Dataset: tareasActividad, ModelObject: () => new Tbl_Tareas()
            },
            Tbl_Calendario: {
                type: 'CALENDAR', CalendarFunction: async () => {
                    return {
                        Agenda: await new Tbl_Agenda({ Id_Dependencia: actividad.Cat_Dependencias.Id_Dependencia }).Get(),
                        Calendario: await new ViewCalendarioByDependencia({ Id_Dependencia: actividad.Cat_Dependencias.Id_Dependencia }).Get()
                    }
                }, require: true
            }
        });
        // this.tasktable = new WTableComponent({
        //     Dataset: tareasActividad,
        //     maxElementByPage: 6,
        //     ModelObject: taskModel, Options: {
        //         //Add: true, UrlAdd: "../api/ApiEntityDBO/saveTbl_Tareas",
        //         //Edit: true, UrlUpdate: "../api/ApiEntityDBO/updateTbl_Tareas",
        //         //Search: true, UrlSearch: "../api/ApiEntityDBO/getTbl_Tareas",
        //         UserActions: [{
        //             name: "Nueva Evidencia", action: (Tarea) => {
        //                 this.actividadDetailView.append(new WModalForm({
        //                     ModelObject: new Tbl_Evidencias({ Id_Tarea: Tarea.Id_Tarea }),
        //                     StyleForm: "columnX1"
        //                 }))
        //             }
        //         }, {
        //             name: "Ver Evidencias", action: async (Tarea) => {
        //                 const response = await new Tbl_Evidencias({ Id_Tarea: Tarea.Id_Tarea }).Get();
        //                 this.actividadDetailView.append(new WModalForm({
        //                     ObjectModal: new DocumentViewer({
        //                         Actividad: response.map((e, index) => ({
        //                             TypeDocuement: e.Cat_Tipo_Evidencia?.Descripcion,
        //                             Description: e.Descripcion ?? "document " + (index + 1),
        //                             Document: e.Data
        //                         }))
        //                     })
        //                 }))
        //             }
        //         }]
        //     }
        // })
        const taskContainer = WRender.Create({ className: "" });
        this.ganttChart = new GanttChart({ Dataset: tareasActividad ?? [], EvalValue: "date" });
        const tabManager = new ComponentsManager({ MainContainer: taskContainer });

        const commentsActividad = await new Tbl_Comments({ Id_Case: actividad.Id_Case }).Get();
        const commentsContainer = new WCommentsComponent({
            Dataset: commentsActividad,
            ModelObject: new Tbl_Comments(),
            User: WSecurity.UserData,
            UserIdProp: "Id_User",
            CommentsIdentify: actividad.Id_Case,
            CommentsIdentifyName: "Id_Case",
            UrlSearch: "../api/ApiEntityHelpdesk/getTbl_Comments",
            UrlAdd: "../api/ApiEntityHelpdesk/saveTbl_Comments",
            AddObject: true
        });
        this.taskManager = new TaskManagers(tareasActividad,
            taskModel, {
            ImageUrlPath: "", action: async (task) => {
                this.update();
            }
        })
        const taskNav = new WAppNavigator({
            //NavStyle: "tab",
            Inicialize: true,
            Elements: [/*{
                name: "Bandeja de entrada", action: async (ev) => {
                    tabManager.NavigateFunction("bandeja", commentsContainer)
                }
            },*/ {
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
                        const modelVinculate = new Tbl_Case({ Id_Vinculate: actividad.Id_Vinculate });
                        console.log(modelVinculate);
                        const vinculateTable = new WTableComponent({
                            Dataset: await modelVinculate.GetVinculateCase(),
                            ModelObject: new Tbl_Case(),
                            AddItemsFromApi: false,
                            Options: {
                                UserActions: WSecurity.HavePermission(Permissions.ADMINISTRAR_CASOS_DEPENDENCIA) ? [{
                                    name: "Desvincular caso", action: (caso) => {
                                        this.Desvincular(caso, vinculateTable, modelVinculate);
                                    }
                                }] : undefined
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
        actividad.Progreso = actividad.Tbl_Tareas?.filter(tarea => tarea.Estado?.includes("Finalizado")).length;
        this.shadowRoot.append(priorityStyles.cloneNode(true));
        return WRender.Create({
            className: "actividad", object: actividad, children: [
                {
                    tagName: 'h4', innerText: `#${actividad.Id_Case} - ${actividad.Titulo} (${actividad.Tbl_Servicios?.Descripcion_Servicio ?? ""})`, children: [
                        {
                            className: "options", children: [
                                WSecurity.HavePermission(Permissions.ADMINISTRAR_CASOS_DEPENDENCIA) ?
                                    { tagName: 'button', className: 'Btn-Mini', innerText: "Editar", onclick: async () => this.editCase() } : "",

                                actividad.Estado == "Finalizado" ?
                                    { tagName: 'button', className: 'Btn-Mini', innerText: 'Reabrir Caso', onclick: () => this.Reabrir(actividad) } :
                                    (
                                        actividad.Estado == "Solicitado" ?
                                            { tagName: 'button', className: 'Btn-Mini', innerText: 'Aprobar Caso', onclick: () => this.AprobarCaso(actividad) } :
                                            { tagName: 'button', className: 'Btn-Mini', innerText: 'Cerrar Caso', onclick: () => this.CerrarCaso(actividad) }
                                    )

                            ]
                        }
                    ]
                },
                , caseGeneralData(actividad),
                { tagName: 'h4', innerText: "Progreso" },
                ControlBuilder.BuildProgressBar(actividad.Progreso,
                    actividad.Tbl_Tareas?.filter(tarea => !tarea.Estado?.includes("Inactivo"))?.length)
            ]
        })
    }

    editCase = async () => {
        this.shadowRoot.append(new WModalForm({
            title: "Editar Caso",
            AutoSave: true,
            EditObject: this.Actividad,
            ModelObject: await CaseOwModel(),
            ObjectOptions: {
                SaveFunction: () => {
                    this.update();
                }
            }
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
            const response = await new Tbl_VinculateCase({
                Casos_Vinculados: [actividad]
            }).DesvincularCaso();
            this.shadowRoot.append(ModalMessege("Caso desvinculado exitosamente"));
            table.Dataset = await modelVinculate.GetOwCase();
            table.DrawTable();
        }, "¿Está seguro que desea desvincular este caso?"))

    }
    CerrarCaso = async (actividad) => {
        this.shadowRoot.append(ModalVericateAction(async () => {
            const response = await new Tbl_Case(actividad).CerrarCaso();
            if (response.status == 200) {
                this.shadowRoot.append(ModalMessege("Caso cerrado exitosamente"));
                this.update();
            } else {
                this.shadowRoot.append(ModalMessege(response.message))
            }

        }, "¿Está seguro que desea cerrar este caso?"))

    }
    AprobarCaso = async (actividad) => {
        const dependencias = await new Cat_Dependencias().Get();
        const servicios = await new Tbl_Servicios({ Id_Dependencia: actividad?.Cat_Dependencias?.Id_Dependencia }).Get();
        console.log(dependencias.filter(d => d.Id_Dependencia == actividad?.Cat_Dependencias?.Id_Dependencia));
        console.log(actividad);
        const modal = new WModalForm({
            ObjectModal: simpleCaseForm(actividad,
                dependencias.filter(d => d.Id_Dependencia == actividad?.Cat_Dependencias?.Id_Dependencia),
                servicios,
                async (table_case) => {
                    const response = await new Tbl_Case()
                        .AprobarCaseList([actividad], table_case);
                    if (response.status == 200) {
                        this.shadowRoot.append(ModalMessege("Solicitud aprobada"));
                        actividad.Estado = "Activa";
                        this.update();
                    } else {
                        this.shadowRoot.append(ModalMessege("Error"));
                    }
                    modal.close();
                })
        });
        this.shadowRoot.append(modal);
    }
    Reabrir = async (actividad) => {
        this.shadowRoot.append(ModalVericateAction(async () => {
            actividad.Estado = "Activo"
            const response = await new Tbl_Case(actividad).Update();
            if (response.status == 200) {
                this.shadowRoot.append(ModalMessege("Caso reabierto exitosamente"));
                this.update();
            } else {
                this.append(ModalMessege(response.message))
            }
        }, "¿Está seguro que desea reabrir este caso?"))

    }
    update = async () => {
        console.log("update");
        // const find = actividad.Tbl_Tareas.find(t => t.Id_Tarea == task.Id_Tarea);
        // for (const prop in task) {
        //     find[prop] = task[prop]
        // }
        const dataTask = await new Tbl_Tareas({ Id_Case: this.Actividad.Id_Case }).Get();
        //console.log(dataTask);
        this.ganttChart.Dataset = dataTask;
        this.Actividad.Tbl_Tareas = dataTask;


        //this.tasktable.Dataset = dataTask;
        this.taskManager.Dataset = dataTask;
        console.log(dataTask);

        this.Actividad.Progreso = this.Actividad.Tbl_Tareas?.filter(tarea => tarea.Estado?.includes("Finalizado")).length;
        this.actividadDetailView.querySelector(".actividadDetail").innerHTML = "";
        this.actividadDetailView.querySelector(".actividadDetail").append(this.actividadElementDetail(this.Actividad));

        //this.tasktable.DrawTable();
        this.taskManager.DrawTaskManagers();
        this.ganttChart.DrawComponent();
        this.ganttChart.Animate();
    }

    WStyle = activityStyle.cloneNode(true)
    CustomStyle = css`
        w-coment-component {
            grid-row: span 3;
        }
       .actividadDetailView {
            display: grid;
            grid-template-columns: calc(100% - 620px) 600px;
            grid-template-rows: 180px 50px auto;
            gap: 0px 20px;
        }
        @media(max-width: 1400px){
            .actividadDetailView {
                display: grid;
                grid-template-columns: calc(100% - 20px);
                grid-template-rows: 180px 50px auto;
                gap: 0px 20px;
            }
            w-coment-component {
                grid-row: span 3;
                position: fixed;
                z-index: 1000;
                background: #fff;
                width: 700px;
                background-color: #fff;
                bottom: 0;
                right: 10px;
                display: block;
                padding: 10px;
                border: solid 1px #eee;
                height: 80vh;
                box-shadow: 0 0 5px 0 #999;
                max-height:20px;
                transition: all 0.5s;
            }
            w-coment-component::before{
                content: "comentarios";
                height: 30px;
                display: block;                
                cursor: pointer;
            } 
            w-coment-component:hover {
                max-height: 100vh;
            }
        }      
    `
}
customElements.define('w-case-detail', CaseDetailComponent);
export { CaseDetailComponent };
const caseGeneralData = (actividad) => {
    return {
        className: "propiedades", children: [
            { tagName: 'label', innerText: "Solicitante: " + (actividad.Mail ?? "") },
            { tagName: 'label', innerText: "Estado: " + actividad.Estado },
            {
                tagName: 'label', className: "prioridad_" + (actividad.Case_Priority != null ? actividad.Case_Priority : undefined),
                innerText: "Prioridad: " + (actividad.Case_Priority != null ? actividad.Case_Priority ?? "indefinida" : "indefinida")
            },
            { tagName: 'label', innerText: "Dependencia: " + (actividad.Cat_Dependencias.Descripcion ?? "") },
            { tagName: 'label', innerText: "Fecha inicio: " + (actividad.Fecha_Inicio?.toString().toDateFormatEs() ?? "") },
            { tagName: 'label', innerText: "Fecha de finalización: " + (actividad.Fecha_Final?.toString().toDateFormatEs() ?? "") },
        ]
    };
}

export { caseGeneralData };