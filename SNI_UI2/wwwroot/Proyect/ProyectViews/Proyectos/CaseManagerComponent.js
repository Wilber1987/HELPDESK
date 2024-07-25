

import { caseGeneralData } from './CaseDetailComponent.js';
import { CaseSearcherToVinculate } from '../../../AppComponents/CaseSearcherToVinculate.js';
import { priorityStyles } from '../../../AppComponents/Styles.js';
import { Tbl_Case, Tbl_VinculateCase } from '../../FrontModel/ProyectDataBaseModel.js';
import { StylesControlsV2, StylesControlsV3 } from "../../../WDevCore/StyleModules/WStyleComponents.js";
import { ModalMessege, ModalVericateAction, WForm } from "../../../WDevCore/WComponents/WForm.js";
import { WModalForm } from '../../../WDevCore/WComponents/WModalForm.js';
import { WPaginatorViewer } from '../../../WDevCore/WComponents/WPaginatorViewer.js';
import { WTableComponent } from "../../../WDevCore/WComponents/WTableComponent.js";
import { ComponentsManager, WRender } from '../../../WDevCore/WModules/WComponentsTools.js';
import { ControlBuilder } from '../../../WDevCore/WModules/WControlBuilder.js';
import { css } from '../../../WDevCore/WModules/WStyledRender.js';
import { activityStyle } from '../../style.js';
import { Permissions, WSecurity } from '../../../WDevCore/Security/WSecurity.js';
import { WFilterOptions } from '../../../WDevCore/WComponents/WFilterControls.js';
import {Tbl_Tareas} from "../../FrontModel/Tbl_Tareas";
import {Cat_Dependencias} from "../../FrontModel/Cat_Dependencias";
import {Tbl_Agenda} from "../../FrontModel/Tbl_Agenda";

class CaseManagerComponent extends HTMLElement {
    /**
     * 
     * @param {Array<Tbl_Case>} [Dataset] 
     * @param {Array<Cat_Dependencias>} Dependencias 
     */
    constructor(Dependencias, Dataset) {
        super();
        this.Dataset = Dataset = [];
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
        this.OptionContainer.append(WRender.Create({ tagName: 'input', type: 'button', className: 'Block-Alert', value: 'Lista de Casos', onclick: this.actividadesManager }))
        //this.OptionContainer.append(WRender.Create({ tagName: 'input', type: 'button', className: 'Block-Secundary', value: 'Dependencias', onclick: this.dependenciasViewer }))
        if (this.Dependencias.length != 0) {
            this.OptionContainer.append(WRender.Create({
                tagName: 'input', type: 'button', className: 'Block-Success',
                value: 'Nuevo Caso', onclick: this.CaseForm
            }))
        }
        this.shadowRoot.append(this.OptionContainer, this.TabContainer);
        //this.dashBoardView();
        this.actividadesManager();
    }
    actividadesManager = async () => {
        this.Paginator =  new WPaginatorViewer({ Dataset: [], userStyles: [StylesControlsV2] });
        this.FilterOptions =  new WFilterOptions({
            Dataset: [],
            UseEntityMethods: false,
            AutoFilter: true,
            Display: true,
            AutoSetDate: true,
            ModelObject: new Tbl_Case(),
            FilterFunction: async (/** @type {Array | undefined} */ DFilt) => {
                // @ts-ignore
                const data = await new Tbl_Case({ FilterData: DFilt }).GetOwCase();
                const datasetMap = data.map(actividad => {
                    actividad.Dependencia = actividad.Cat_Dependencias?.Descripcion;
                    actividad.Progreso = actividad.Tbl_Tareas?.filter(tarea => tarea.Estado?.includes("Finalizado")).length;
                    return this.actividadElement(actividad);
                });
                this.Paginator.Draw(datasetMap);
            }
        });
        
        this.TabManager.NavigateFunction("Tab-Actividades-Manager",
            WRender.Create({
                className: "actividadesView", children: [this.FilterOptions, this.Paginator]
            }));
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
                                WSecurity.HavePermission(Permissions.ADMINISTRAR_CASOS_DEPENDENCIA) ?
                                    { tagName: 'button', className: 'Btn-Mini', innerText: 'Vincular Caso', onclick: () => this.Vincular(actividad) } :
                                    ""
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
    actividadElementDetail = (actividad) => {
        return WRender.Create({
            className: "actividadDetail", object: actividad, children: [
                this.actividadElement(actividad)
            ]
        })
    }

    actividadDetail = async (actividad = (new Tbl_Case())) => {
        sessionStorage.setItem("detailCase", JSON.stringify(actividad));
        window.location = "/ProyectViews/CaseDetail"
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
            WRender.Create({
                className: "CaseFormView", children: [CaseForm(undefined, this.Dependencias, () => {
                    console.log(false);
                    this.shadowRoot.append(ModalMessege("Caso guardado correctamente", null, true))
                })]
            }));
    }
    Vincular = async (actividad) => {
        this.shadowRoot.append(new WModalForm({
            title: "Vincular Casos",
            ObjectModal: CaseSearcherToVinculate(actividad, "Vincular", async (caso_vinculado, TableComponent, model) => {
                this.shadowRoot.append(ModalVericateAction(async () => {
                    const response = await new Tbl_VinculateCase({
                        Casos_Vinculados: [actividad, caso_vinculado]
                    }).VincularCaso();
                    const updateData = await model.Get();
                    TableComponent.Dataset = updateData;
                    TableComponent.DrawTable();
                }, "Esta seguro de Vincular este caso"))
            })
        }));
    }



    WStyle = activityStyle.cloneNode(true)
}
customElements.define('w-case-manager', CaseManagerComponent);
export { CaseManagerComponent };
export { CaseForm };
export { simpleCaseForm };
/**
 * @param {Tbl_Case} [entity] 
 * @param {Array<Cat_Dependencias>} [dependencias] 
 * @param {Function} [action] 
 * @returns {WForm}
 */
const CaseForm = (entity, dependencias, action) => {
    const ModelCalendar = {
        type: 'CALENDAR',
        ModelObject: () => new Tbl_Calendario(),
        require: false,
        CalendarFunction: async () => {
            return {
                Agenda: await new Tbl_Agenda({ Id_Dependencia: form.FormObject.Cat_Dependencias?.Id_Dependencia }).Get(),
                Calendario: await new Tbl_Calendario({ Id_Dependencia: form.FormObject.Cat_Dependencias?.Id_Dependencia }).Get()
            }
        }
    }

    const form = new WForm({
        EditObject: entity,
        SaveFunction: action,
        ImageUrlPath: "",
        AutoSave: true,
        ModelObject: new Tbl_Case({
            Tbl_Tareas: {
                type: 'MasterDetail',
                ModelObject: () => new Tbl_Tareas({ Tbl_Calendario: ModelCalendar })
            }, Cat_Dependencias: {
                type: "WSELECT", hiddenFilter: true, ModelObject: new Cat_Dependencias(),
                Dataset: dependencias,
                action: (caso) => {
                    caso.Tbl_Tareas
                        .forEach(Tbl_Tarea => Tbl_Tarea.Tbl_Calendario = []);
                    form.DrawComponent();
                }
            }
        })
    })
    return form;
}

/**
 * @param {Tbl_Case} [entity] 
 * @param {Array<Cat_Dependencias>} [dependencias] 
 * @param {Array<Tbl_Servicios>} [servicios] 
 * @param {Function} [action] 
 * @returns {WForm}
 */
const simpleCaseForm = (entity, dependencias, servicios, action) => {
    servicios = servicios?.map(s => {
        s.Descripcion = s.Descripcion_Servicio;
        return s;
    })
    const form = new WForm({
        EditObject: entity,
        SaveFunction: action,
        ImageUrlPath: "",
        ModelObject: new Tbl_Case({
            Tbl_Tareas: { type: "text", hidden: true },
            Id_Vinculate: { type: "text", hidden: true },
            Titulo: { type: "text", hidden: true },
            Tbl_Servicios: {
                type: "wselect", ModelObject: new Cat_Dependencias(),
                Dataset: servicios, required: false
            },
            Fecha_Inicio: { type: "text", hidden: true },
            Estado: { type: "text", hidden: true },
            Fecha_Final: { type: "text", hidden: true },
            Descripcion: { type: "text", hidden: true },
            Tbl_Comments: { type: "MasterDetail", ModelObject: new Tbl_Comments(), label: "Comentario", hidden: true },
            Cat_Dependencias: {
                type: "WSELECT", hiddenFilter: true, ModelObject: new Cat_Dependencias(),
                Dataset: dependencias,
                action: async (caso) => {
                    const servicios = await new Tbl_Servicios({ Id_Dependencia: caso.Cat_Dependencias?.Id_Dependencia }).Get();
                    form.ModelObject.Tbl_Servicios.Dataset = servicios;
                    form.DrawComponent();
                }
            },
        })
    })
    return form;
}

