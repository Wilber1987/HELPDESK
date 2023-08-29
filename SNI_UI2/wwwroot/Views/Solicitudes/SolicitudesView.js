
import { CaseTable_Case, Cat_Dependencias } from '../../Model/ProyectDataBaseModel.js';
import { StylesControlsV2, StylesControlsV3 } from "../../WDevCore/StyleModules/WStyleComponents.js";
import { WForm } from "../../WDevCore/WComponents/WForm.js";
import { WPaginatorViewer } from '../../WDevCore/WComponents/WPaginatorViewer.js';
import { ComponentsManager, WRender } from '../../WDevCore/WModules/WComponentsTools.js';
import { css } from '../../WDevCore/WModules/WStyledRender.js';
import { WFilterOptions } from "../../WDevCore/WComponents/WFilterControls.js";

const OnLoad = async () => {
    const Solicitudes = await new CaseTable_Case().GetOwSolicitudesPendientesAprobar();
    const AdminPerfil = new MainSolicitudesView(Solicitudes);
    Main.appendChild(AdminPerfil);
}
window.onload = OnLoad;
class MainSolicitudesView extends HTMLElement {
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
                type: "WSELECT", ModelObject: ()=> new Cat_Dependencias()
            }
        });
        this.DrawMainSolicitudesView();
    }
    connectedCallback() { }
    DrawMainSolicitudesView = async () => {
        //this.OptionContainer.append(WRender.Create({ tagName: 'input', type: 'button', className: 'Block-Basic', value: 'Estadística', onclick: this.dashBoardView }))
        this.OptionContainer.append(WRender.Create({ tagName: 'input', type: 'button', className: 'Block-Alert', value: 'Casos Pendientes de Aprobación', onclick: this.actividadesManager }))
        this.OptionContainer.append(WRender.Create({ tagName: 'input', type: 'button', className: 'Block-Success', value: 'Nuevo Caso', onclick: this.nuevoCaso }))

        this.shadowRoot.append(this.OptionContainer, this.TabContainer);
        //this.dashBoardView();
        this.actividadesManager();
    }
    actividadesManager = async () => {
        const paginator = new WPaginatorViewer({ Dataset: this.mapCaseToPaginatorElement(this.Dataset), userStyles: [StylesControlsV2] });
        this.FilterOptions = new WFilterOptions({
            Dataset: this.Dataset,
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
        return WRender.Create({
            className: "actividad", object: actividad, children: [
                { tagName: 'h4', innerText: actividad.Descripcion },
                {
                    className: "propiedades", children: [
                        { tagName: 'label', innerText: "Estado: " + actividad.Estado },
                        { tagName: 'label', innerText: "Dependencia: " + actividad.Dependencia },
                        { tagName: 'label', innerText: "Fecha inicio: " + actividad.Fecha_Inicial?.toString().toDateFormatEs() },
                        { tagName: 'label', innerText: "Fecha de finalización: " + actividad.Fecha_Final?.toString().toDateFormatEs() },
                    ]
                },  {
                    className: "options", children: [
                        { tagName: 'button', className: 'Btn-Mini', innerText: "Detalle", onclick: async () => await this.actividadDetail(actividad) },
                      //  { tagName: 'button', className: 'Btn-Mini', innerText: 'Informe', onclick: this.action }
                    ]
                },
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

    nuevoCaso = async () => {
        const form = new WForm({
            ModelObject: this.ModelObject
        })
        this.TabManager.NavigateFunction("Tab-nuevoCasoView",
            WRender.Create({ className: "nuevoCasoView", children: [form] }));
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
customElements.define('w-main-solicitudes-component', MainSolicitudesView);
export { MainSolicitudesView };

