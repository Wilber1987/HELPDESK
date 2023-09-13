
import { CaseTable_Case, CaseTable_Comments, Cat_Dependencias } from '../../Model/ProyectDataBaseModel.js';
import { StylesControlsV2, StylesControlsV3 } from "../../WDevCore/StyleModules/WStyleComponents.js";
import { ModalMessege, ModalVericateAction, WForm } from "../../WDevCore/WComponents/WForm.js";
import { WPaginatorViewer } from '../../WDevCore/WComponents/WPaginatorViewer.js';
import { ComponentsManager, WRender } from '../../WDevCore/WModules/WComponentsTools.js';
import { css } from '../../WDevCore/WModules/WStyledRender.js';
import { WFilterOptions } from "../../WDevCore/WComponents/WFilterControls.js";
import { WTableComponent } from '../../WDevCore/WComponents/WTableComponent.js';
import { WModalForm } from '../../WDevCore/WComponents/WModalForm.js';
import { CaseForm, simpleCaseForm } from '../Perfil/Proyectos/CaseManagerComponent.js';
import { ControlBuilder } from '../../WDevCore/WModules/WControlBuilder.js';
import { WCommentsComponent } from '../../WDevCore/WComponents/WCommentsComponent.js';
import { WSecurity } from '../../WDevCore/Security/WSecurity.js';
import { priorityStyles } from '../../AppComponents/Styles.js';

const OnLoad = async () => {
    const Solicitudes = await new CaseTable_Case().GetSolicitudesPendientesAprobar();
    const AdminPerfil = new SolicitudesPendientesView(Solicitudes);
    Main.appendChild(AdminPerfil);
}
window.onload = OnLoad;
class SolicitudesPendientesView extends HTMLElement {
    /**
     * 
     * @param {Array<CaseTable_Case>} Dataset 
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
        this.OptionContainer2 = WRender.Create({ className: "OptionContainer" });
        this.ModelObject = new CaseTable_Case({
            CaseTable_Tareas: {
                hidden: true
            }, Estado: {
                hidden: true
            }, Cat_Dependencias: {
                type: "WSELECT", ModelObject: () => new Cat_Dependencias()
            }
        });
        this.DrawSolicitudesPendientesView();
    }
    connectedCallback() { }
    DrawSolicitudesPendientesView = async () => {
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
        this.mainTable = new WTableComponent({
            Dataset: this.Dataset,
            AddItemsFromApi: false,
            ModelObject: this.ModelObject, userStyles: [StylesControlsV2],
            Options: {
                MultiSelect: true
            }
        });
        this.FilterOptions = new WFilterOptions({
            Dataset: this.Dataset,
            ModelObject: this.ModelObject,
            FilterFunction: (DFilt) => {
                this.mainTable?.DrawTable(DFilt);
            }
        });
        this.TabManager.NavigateFunction("Tab-Actividades-Manager",
            WRender.Create({
                className: "actividadesView", children:
                    [this.FilterOptions, this.OptionContainer2, this.mainTable]
            }));
    }

    nuevoCaso = async () => {
        const form = new WForm({
            ModelObject: this.ModelObject
        })
        this.TabManager.NavigateFunction("Tab-nuevoCasoView",
            WRender.Create({ className: "nuevoCasoView", children: [form] }));
    }
    update = async () => {
        const Solicitudes = await new CaseTable_Case().GetSolicitudesPendientesAprobar();
        this.mainTable?.DrawTable(Solicitudes);
    }

    actividadDetail = async (actividad) => {
        const actividadDetailView = WRender.Create({ className: "actividadDetailView", children: [this.actividadElementDetail(actividad)] });
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
                { tagName: 'h4', innerText: `#${actividad.Id_Case} - ${actividad.Titulo} (${actividad.Tbl_Servicios?.Descripcion_Servicio ?? ""})` },
               {
                    className: "options", children: [
                        { tagName: 'button', className: 'Btn-Mini', innerText: "Detalle", onclick: async () => await this.actividadDetail(actividad) },
                        { tagName: 'button', className: 'Btn-Mini', innerText: 'Vincular Caso', onclick: () => this.Vincular(actividad) }
                    ]
                }, {
                    className: "propiedades", children: [
                        { tagName: 'label', innerText: "Estado: " + actividad.Estado },
                        { tagName: 'label', className: "prioridad_" + (actividad.Case_Priority != null ?  actividad.Case_Priority : undefined ), 
                        innerText: "Prioridad: " + (actividad.Case_Priority != null ?  actividad.Case_Priority ?? "indefinida" : "indefinida" ) },
                        { tagName: 'label', innerText: "Dependencia: " + actividad.Cat_Dependencias.Descripcion },
                        { tagName: 'label', innerText: "Fecha inicio: " + actividad.Fecha_Inicial?.toString().toDateFormatEs() },
                        { tagName: 'label', innerText: "Fecha de finalización: " + actividad.Fecha_Final?.toString().toDateFormatEs() },
                    ]
                }
            ]
        })
    }
    UserActions = [
        {
            name: "Aprobar", action: async (/**@type {CaseTable_Case}*/element) => {
                // const dependencias = await new Cat_Dependencias().GetOwDependencies();
                // const modal = new WModalForm({
                //     ObjectModal: CaseForm(element, dependencias, async (table_case) => {
                //         this.shadowRoot.append(ModalVericateAction(async () => {
                //             const response = await table_case.Update();
                //             if (response.status == 200) {
                //                 this.shadowRoot.append(ModalMessege("Solicitud aprobada"));
                //                 this.update();
                //             } else {
                //                 this.shadowRoot.append(ModalMessege("Error"));
                //             }
                //             modal.close();
                //         }, "Esta seguro que desea aprobar esta solicitud"))
                //     })
                // });
                // this.shadowRoot.append(modal);
                if (this.mainTable.selectedItems.length <= 0) {
                    this.shadowRoot.append(ModalMessege("Seleccione solicitudes"));
                    return;
                }
                this.shadowRoot.append(ModalVericateAction(async () => {
                    const response = await new CaseTable_Case()
                        .AprobarCaseList(this.mainTable.selectedItems);
                    if (response.status == 200) {
                        this.shadowRoot.append(ModalMessege("Solicitudes aprobadas"));
                        this.update();
                    } else {
                        this.shadowRoot.append(ModalMessege("Error"));
                    }
                    //modal.close();
                }, "Esta seguro que desea aprobar estas solicitudes"));
            }
        }, {
            name: "Rechazar", action: async (/**@type {CaseTable_Case}*/element) => {
                if (this.mainTable.selectedItems.length <= 0) {
                    this.shadowRoot.append(ModalMessege("Seleccione solicitudes"));
                    return;
                }
                this.shadowRoot.append(new WModalForm({
                    title: "Escriba la razón por la cual se están rechazando estas solicitudes",
                    EditObject: {
                        Id_Case: element.Id_Case,
                    },
                    ModelObject: new CaseTable_Comments(),
                    ObjectOptions: {
                        SaveFunction: async (comentario) => {
                            this.shadowRoot.append(ModalVericateAction(async () => {
                                const response = await new CaseTable_Case()
                                    .RechazarCaseList(this.mainTable.selectedItems, comentario);
                                if (response.status == 200) {
                                    this.shadowRoot.append(ModalMessege("Solicitudes rechazadas"));
                                    this.update();
                                } else {
                                    this.shadowRoot.append(ModalMessege("Error"));
                                }
                                // modal.close();
                            }, "Esta seguro que desea rechazar estas solicitudes"));
                        }
                    }
                }))

            }
        }, {
            name: "Remitir a otra dependencia", action: async (/**@type {CaseTable_Case}*/element) => {
                if (this.mainTable.selectedItems.length <= 0) {
                    this.shadowRoot.append(ModalMessege("Seleccione solicitudes"));
                    return;
                }
                const dependencias = await new Cat_Dependencias().Get();
                const modal = new WModalForm({
                    ObjectModal: simpleCaseForm(element,
                        dependencias.filter(d => d.Id_Dependencia != element.Id_Dependencia),
                        async (table_case) => {
                            this.shadowRoot.append(ModalVericateAction(async () => {
                                const response =
                                    await new CaseTable_Case().RemitirCasos(this.mainTable.selectedItems,
                                        table_case.Cat_Dependencias, table_case.CaseTable_Comments);
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
        },
        // {
        //     name: "Ver bandeja", action: async (/**@type {CaseTable_Case}*/element) => {
        //         this.actividadDetail(element);
        //     }
        // }
    ]


    WStyle = css`
        .dashBoardView{
            display: grid;
            grid-template-columns: auto auto ;  
            grid-gap: 20px          
        }
        .OptionContainer {
            margin: 0 0 20px 0;
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
        }
        .actividad h4 {
            margin: 5px 0px;
         }
        .actividad .propiedades {
            font-size: 14px;
            display: flex;
            gap: 20px;
        }
        .actividad .options {
            display: flex;
            justify-content: flex-end;            
        }
    `

    mapCaseToPaginatorElement(Dataset) {
        return Dataset.map(actividad => {
            actividad.Dependencia = actividad.Cat_Dependencias.Descripcion;
            //actividad.Progreso = actividad.CaseTable_Tareas?.filter(tarea => tarea.Estado?.includes("Finalizado")).length;
            return this.actividadElement(actividad);
        });
    }
}
customElements.define('w-main-solicitudes-component', SolicitudesPendientesView);
export { SolicitudesPendientesView };

