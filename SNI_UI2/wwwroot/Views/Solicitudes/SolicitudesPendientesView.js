
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
        this.shadowRoot.append(this.OptionContainer, this.TabContainer);
        this.actividadesManager();
    }

    actividadesManager = async () => {
        this.mainTable = new WTableComponent({
            Dataset: this.Dataset,
            AddItemsFromApi: false,
            ModelObject: this.ModelObject, userStyles: [StylesControlsV2], Options: {
                UserActions: [
                    {
                        name: "Aprobar", action: async (/**@type {CaseTable_Case}*/element) => {
                            const dependencias = await new Cat_Dependencias().GetOwDependencies();
                            const modal = new WModalForm({
                                ObjectModal: CaseForm(element, dependencias, async (table_case) => {
                                    this.shadowRoot.append(ModalVericateAction(async () => {
                                        const response = await table_case.Update();
                                        if (response.status == 200) {
                                            this.shadowRoot.append(ModalMessege("Solicitud aprobada"));
                                            this.update();
                                        } else {
                                            this.shadowRoot.append(ModalMessege("Error"));
                                        }
                                        modal.close();
                                    }, "Esta seguro que desea aprobar esta solicitud"))
                                })
                            });
                            this.shadowRoot.append(modal);
                        }
                    }, {
                        name: "Rechazar", action: async (/**@type {CaseTable_Case}*/element) => {
                            this.shadowRoot.append(new WModalForm({
                                title: "Escriba la razón por la cual se está rechazando la solicitud",
                                EditObject: {
                                    Id_Case: element.Id_Case,
                                },
                                ModelObject: new CaseTable_Comments(),
                                ObjectOptions: {
                                    SaveFunction: async (comentario) => {
                                        element.CaseTable_Comments = [comentario];
                                        const modalV = ModalVericateAction(async () => {
                                            const response = await element.RechazarSolicitud();
                                            if (response.status == 200) {
                                                this.shadowRoot.append(ModalMessege("Solicitud rechazada"));
                                                this.update();
                                            }
                                            //modalV.close();
                                        }, "Esta seguro que desea rechazar está solicitud")
                                        this.shadowRoot.append(modalV);
                                    }
                                }
                            }))
                        }
                    }, {
                        name: "Remitir a otra dependencia", action: async (/**@type {CaseTable_Case}*/element) => {
                            const dependencias = await new Cat_Dependencias().Get();
                            const modal = new WModalForm({
                                ObjectModal: simpleCaseForm(element,
                                    dependencias.filter(d => d.Id_Dependencia != element.Id_Dependencia),
                                    async (table_case) => {
                                        this.shadowRoot.append(ModalVericateAction(async () => {
                                            const response = await table_case.Update();
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
            }
        });
        this.FilterOptions = new WFilterOptions({
            Dataset: this.Dataset,
            ModelObject: this.ModelObject,
            Display: true,
            FilterFunction: (DFilt) => {
                this.mainTable?.DrawTable(DFilt);
            }
        });
        this.TabManager.NavigateFunction("Tab-Actividades-Manager",
            WRender.Create({ className: "actividadesView", children: [this.FilterOptions, this.mainTable] }));
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

