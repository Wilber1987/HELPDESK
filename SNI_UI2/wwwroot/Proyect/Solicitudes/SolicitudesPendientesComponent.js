import { priorityStyles } from '../../AppComponents/Styles.js';
import { Tbl_Case, Tbl_Comments, Cat_Dependencias, Tbl_Servicios } from '../../ModelProyect/ProyectDataBaseModel.js';
import { WSecurity } from '../../WDevCore/Security/WSecurity.js';
import { StylesControlsV2, StylesControlsV3 } from "../../WDevCore/StyleModules/WStyleComponents.js";
import { WCommentsComponent } from '../../WDevCore/WComponents/WCommentsComponent.js';
import { WFilterOptions } from "../../WDevCore/WComponents/WFilterControls.js";
import { ModalMessege, ModalVericateAction, WForm } from "../../WDevCore/WComponents/WForm.js";
import { WModalForm } from '../../WDevCore/WComponents/WModalForm.js';
import { WTableComponent } from '../../WDevCore/WComponents/WTableComponent.js';
import { ComponentsManager, WRender } from '../../WDevCore/WModules/WComponentsTools.js';
import { css } from '../../WDevCore/WModules/WStyledRender.js';
import { CaseDetailComponent, caseGeneralData } from '../ProyectViews/Proyectos/CaseDetailComponent.js';
import { simpleCaseForm } from '../ProyectViews/Proyectos/CaseManagerComponent.js';
import { activityStyle } from '../style.js';
class SolicitudesPendientesComponent extends HTMLElement {
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
        this.OptionContainer2 = WRender.Create({ className: "OptionContainer2" });
        this.ModelObject = new Tbl_Case({
            Tbl_Tareas: {
                type: "text", hidden: true
            }, Estado: {
                type: "text", hidden: true
            }, Cat_Dependencias: {
                type: "WSELECT", hiddenFilter: true, ModelObject: () => new Cat_Dependencias()
            }
        });
        this.filterD = [];
        this.nIntervId == null;
        this.DrawSolicitudesPendientesComponent();
    }
    connectedCallback() {
        if (this.nIntervId == null) {
            this.nIntervId = setInterval(this.update, 20000);
        }
    }
    disconnectedCallback() {
        clearInterval(this.nIntervId);
        // liberar nuestro inervalId de la variable
        this.nIntervId = null;
    }
    DrawSolicitudesPendientesComponent = async () => {
        this.OptionContainer.append(WRender.Create({ tagName: 'input', type: 'button', className: 'Block-Alert', value: 'Casos Pendientes de Aprobación', onclick: this.actividadesManager }))
        this.OptionContainer.append(WRender.Create({ tagName: 'input', type: 'button', className: 'Block-Success', value: 'Nuevo Caso', onclick: this.nuevoCaso }))
        this.UserActions.forEach(element => {
            this.OptionContainer2.append(WRender.Create({
                tagName: 'input', type: 'button', className: 'Btn',
                value: element.name, onclick: element.action
            }))

        });
        this.shadowRoot.append(this.OptionContainer, this.TabContainer);
        this.actividadesManager();
    }

    actividadesManager = async () => {
        if (this.mainTable == undefined) {
            this.mainTable = new WTableComponent({
                Dataset: this.Dataset,
                AddItemsFromApi: false,
                ModelObject: this.ModelObject, userStyles: [StylesControlsV2],
                Options: {
                    MultiSelect: true,
                    UserActions: [{
                        name: "ver detalles", action: async (element) => {
                            const find = await new Tbl_Case({ Id_Case: element.Id_Case }).Get()
                            const CaseDetail = new CaseDetailComponent(find[0]);
                            this.TabManager.NavigateFunction("Detail" + element.Id_Case, CaseDetail)
                        }
                    }]
                }
            });
            this.FilterOptions = new WFilterOptions({
                Dataset: this.Dataset,
                ModelObject: this.ModelObject,
                AutoFilter: false,
                AutoSetDate: true,
                Display: true,
                FilterFunction: (DFilt) => {
                    this.filterD = DFilt;
                    this.update(this.filterD);
                }
            });
            this.mainTable.FilterOptions = this.FilterOptions;

            this.TabManager.NavigateFunction("Tab-Actividades-Manager",
                WRender.Create({
                    className: "actividadesView", children:
                        [this.FilterOptions, this.OptionContainer2, this.mainTable]
                }));
        } else {
            this.TabManager.NavigateFunction("Tab-Actividades-Manager");
        }

    }

    nuevoCaso = async () => {
        const form = new WForm({
            ModelObject: this.ModelObject
        })
        this.TabManager.NavigateFunction("Tab-nuevoCasoView",
            WRender.Create({ className: "nuevoCasoView", children: [form] }));
    }
    update = async (inst = this.filterD) => {
        const Solicitudes = await new Tbl_Case({ FilterData: inst, OrderData:  this.mainTable?.Sorts }).GetSolicitudesPendientesAprobar();
        this.mainTable?.DrawTable(Solicitudes);
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
    actividadElement = (actividad) => {
        this.shadowRoot.append(priorityStyles.cloneNode(true));
        return WRender.Create({
            className: "actividad", object: actividad, children: [
                {
                    tagName: 'h4', innerText: `#${actividad.Id_Case} - ${actividad.Titulo} (${actividad.Tbl_Servicios?.Descripcion_Servicio ?? ""})`, children: [
                        {
                            className: "options", children: [
                                { tagName: 'button', className: 'Btn-Mini', innerText: "Detalle", onclick: async () => await this.actividadDetail(actividad) },
                                { tagName: 'button', className: 'Btn-Mini', innerText: 'Vincular Caso', onclick: () => this.Vincular(actividad) }
                            ]
                        }
                    ]
                }
                , caseGeneralData(actividad)
            ]
        })
    }
    UserActions = [
        {
            name: "Aprobar", action: async (/**@type {Tbl_Case}*/element) => {
                if (this.mainTable.selectedItems.length <= 0) {
                    this.shadowRoot.append(ModalMessege("Seleccione solicitudes"));
                    return;
                }
                // this.shadowRoot.append(ModalVericateAction(async () => {
                //     const response = await new Tbl_Case()
                //         .AprobarCaseList(this.mainTable.selectedItems);
                //     if (response.status == 200) {
                //         this.shadowRoot.append(ModalMessege("Solicitudes aprobadas"));
                //         this.update();
                //     } else {
                //         this.shadowRoot.append(ModalMessege("Error"));
                //     }
                //     //modal.close();
                // }, "Esta seguro que desea aprobar estas solicitudes"));
                const dependencias = await new Cat_Dependencias().Get();
                const servicios = await new Tbl_Servicios({ Id_Dependencia: this.mainTable.selectedItems[0]?.Cat_Dependencias?.Id_Dependencia }).Get();
                const modal = new WModalForm({
                    ObjectModal: simpleCaseForm(element,
                        dependencias.filter(d => d.Id_Dependencia == this.mainTable.selectedItems[0]?.Cat_Dependencias?.Id_Dependencia),
                        servicios,
                        async (table_case) => {
                            const response = await new Tbl_Case()
                                .AprobarCaseList(this.mainTable.selectedItems, table_case);
                            if (response.status == 200) {
                                this.shadowRoot.append(ModalMessege("Solicitudes aprobadas"));
                                this.update();
                            } else {
                                this.shadowRoot.append(ModalMessege("Error"));
                            }
                            modal.close();
                        })
                });
                this.shadowRoot.append(modal);
            }
        }, {
            name: "Rechazar", action: async (/**@type {Tbl_Case}*/element) => {
                if (this.mainTable.selectedItems.length <= 0) {
                    this.shadowRoot.append(ModalMessege("Seleccione solicitudes"));
                    return;
                }
                this.shadowRoot.append(new WModalForm({
                    title: "Escriba la razón por la cual se están rechazando estas solicitudes",
                    EditObject: {
                        Id_Case: element.Id_Case,
                    },
                    ModelObject: new Tbl_Comments(),
                    ObjectOptions: {
                        SaveFunction: async (comentario) => {
                            this.shadowRoot.append(ModalVericateAction(async () => {
                                const response = await new Tbl_Case()
                                    .RechazarCaseList(this.mainTable.selectedItems, comentario);
                                if (response.status == 200) {
                                    this.shadowRoot.append(ModalMessege("Solicitudes rechazadas"));
                                    this.update();
                                } else {
                                    this.shadowRoot.append(ModalMessege("Error"));
                                }
                                modal.close();
                            }, "Esta seguro que desea rechazar estas solicitudes"));
                        }
                    }
                }))

            }
        }, {
            name: "Remitir a otra dependencia", action: async (/**@type {Tbl_Case}*/element) => {
                if (this.mainTable.selectedItems.length <= 0) {
                    this.shadowRoot.append(ModalMessege("Seleccione solicitudes"));
                    return;
                }
                const dependencias = await new Cat_Dependencias().Get();
                const filterDepend = dependencias.filter(d => d.Id_Dependencia != this.mainTable.selectedItems[0]?.Cat_Dependencias?.Id_Dependencia)
                const servicios = await new Tbl_Servicios({ Id_Dependencia: filterDepend[0]?.Id_Dependencia }).Get();
                const modal = new WModalForm({
                    ObjectModal: simpleCaseForm(element,
                        filterDepend,
                        servicios,
                        async (table_case) => {
                            this.shadowRoot.append(ModalVericateAction(async () => {
                                const response =
                                    await new Tbl_Case().RemitirCasos(this.mainTable.selectedItems,
                                        table_case.Cat_Dependencias, table_case.Tbl_Comments, table_case);
                                if (response.status == 200) {
                                    this.shadowRoot.append(ModalMessege("Solicitud remitida"));
                                    this.update();
                                } else {
                                    this.shadowRoot.append(ModalMessege("Error"));
                                }
                                modal.close();
                            }, "Esta seguro que desea remitir esta solicitud"))
                        })
                });
                this.shadowRoot.append(modal);
            }
        }
    ]


    WStyle = activityStyle.cloneNode(true)

    mapCaseToPaginatorElement(Dataset) {
        return Dataset.map(actividad => {
            actividad.Dependencia = actividad.Cat_Dependencias.Descripcion;
            //actividad.Progreso = actividad.Tbl_Tareas?.filter(tarea => tarea.Estado?.includes("Finalizado")).length;
            return this.actividadElement(actividad);
        });
    }
}
customElements.define('w-main-solicitudes-component', SolicitudesPendientesComponent);
export { SolicitudesPendientesComponent };

