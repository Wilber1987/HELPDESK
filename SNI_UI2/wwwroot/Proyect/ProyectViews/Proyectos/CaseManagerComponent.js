

import { caseGeneralData } from './CaseDetailComponent.js';
import { CaseSearcherToVinculate } from '../../../AppComponents/CaseSearcherToVinculate.js';
import { priorityStyles } from '../../../AppComponents/Styles.js';
import { CaseTable_Agenda, CaseTable_Calendario, CaseTable_Case, CaseTable_Comments, CaseTable_Tareas, CaseTable_VinculateCase, Cat_Dependencias } from '../../../ModelProyect/ProyectDataBaseModel.js';
import { StylesControlsV2, StylesControlsV3 } from "../../../WDevCore/StyleModules/WStyleComponents.js";
import { ModalVericateAction, WForm } from "../../../WDevCore/WComponents/WForm.js";
import { WModalForm } from '../../../WDevCore/WComponents/WModalForm.js';
import { WPaginatorViewer } from '../../../WDevCore/WComponents/WPaginatorViewer.js';
import { WTableComponent } from "../../../WDevCore/WComponents/WTableComponent.js";
import { ComponentsManager, WRender } from '../../../WDevCore/WModules/WComponentsTools.js';
import { ControlBuilder } from '../../../WDevCore/WModules/WControlBuilder.js';
import { css } from '../../../WDevCore/WModules/WStyledRender.js';
import { activityStyle } from '../../style.js';

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
        this.OptionContainer.append(WRender.Create({ tagName: 'input', type: 'button', className: 'Block-Alert', value: 'Lista de Casos', onclick: this.actividadesManager }))
        //this.OptionContainer.append(WRender.Create({ tagName: 'input', type: 'button', className: 'Block-Secundary', value: 'Dependencias', onclick: this.dependenciasViewer }))
        if (this.Dependencias.length != 0) {
            this.OptionContainer.append(WRender.Create({
                tagName: 'input', type: 'button', className: 'Block-Success',
                value: 'Nueva Caso', onclick: this.CaseForm
            }))
        }
        this.shadowRoot.append(this.OptionContainer, this.TabContainer);
        //this.dashBoardView();
        this.actividadesManager();
    }
    actividadesManager = async () => {
        const datasetMap = this.Dataset.filter(x => x.Estado != "Vinculado").map(actividad => {
            actividad.Dependencia = actividad.Cat_Dependencias?.Descripcion;
            actividad.Progreso = actividad.CaseTable_Tareas?.filter(tarea => tarea.Estado?.includes("Finalizado")).length;
            return this.actividadElement(actividad);
        });
        this.TabManager.NavigateFunction("Tab-Actividades-Manager",
            WRender.Create({ className: "actividadesView", children: [new WPaginatorViewer({ Dataset: datasetMap, userStyles: [StylesControlsV2] })] }));
    }

    actividadElement = (actividad) => {
        this.shadowRoot.append(priorityStyles.cloneNode(true));
        return WRender.Create({
            className: "actividad", object: actividad, children: [
                { tagName: 'h4', innerText: `#${actividad.Id_Case} - ${actividad.Titulo} (${actividad.Tbl_Servicios?.Descripcion_Servicio ?? ""})` , children: [
                    {
                        className: "options", children: [
                            { tagName: 'button', className: 'Btn-Mini', innerText: "Detalle", onclick: async () => await this.actividadDetail(actividad) },
                            { tagName: 'button', className: 'Btn-Mini', innerText: 'Vincular Caso', onclick: () => this.Vincular(actividad) }
                        ]
                    }
                ] },
                ,caseGeneralData(actividad),
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
        ImageUrlPath: "",
        ModelObject: new CaseTable_Case({
            CaseTable_Tareas: {
                type: 'MasterDetail',
                ModelObject: () => new CaseTable_Tareas({ CaseTable_Calendario: ModelCalendar })
            }, Cat_Dependencias: {
                type: "WSELECT",  hiddenFilter: true, ModelObject: new Cat_Dependencias(),
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
        ImageUrlPath: "",
        ModelObject: new CaseTable_Case({
            CaseTable_Tareas: { type: "text", hidden: true },
            Id_Vinculate: { type: "text", hidden: true },
            Titulo: { type: "text", hidden: true },
            Tbl_Servicios: { type: "text", hidden: true },
            Fecha_Inicio: { type: "text", hidden: true },
            Estado: { type: "text", hidden: true },
            Fecha_Final: { type: "text", hidden: true },
            Descripcion: { type: "text", hidden: true },
            CaseTable_Comments: { type: "MasterDetail", ModelObject: new CaseTable_Comments(), label: "Comentario" },
            Cat_Dependencias: {
                type: "WSELECT",  hiddenFilter: true, ModelObject: new Cat_Dependencias(),
                Dataset: dependencias,
                action: (caso) => {

                }
            },
        })
    })
    return form;
}

