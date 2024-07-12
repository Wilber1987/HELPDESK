

//@ts-check
import { Tbl_Case, Tbl_Participantes, Tbl_Tareas } from '../../../ModelProyect/ProyectDataBaseModel.js';
import { StylesControlsV2 } from '../../../WDevCore/StyleModules/WStyleComponents.js';
import { ColumChart, RadialChart } from '../../../WDevCore/WComponents/WChartJSComponents.js';
import { WFilterOptions } from '../../../WDevCore/WComponents/WFilterControls.js';
import { WModalForm } from '../../../WDevCore/WComponents/WModalForm.js';
import { WReportComponent } from '../../../WDevCore/WComponents/WReportComponent.js';
import { WTableComponent } from '../../../WDevCore/WComponents/WTableComponent.js';
import { WArrayF, WRender } from '../../../WDevCore/WModules/WComponentsTools.js';
import { css } from '../../../WDevCore/WModules/WStyledRender.js';

class CaseDashboardComponent extends HTMLElement {
    /**
     * @param {undefined} [Dataset]
     */
    constructor(Dataset) {
        //console.log(Dataset);
        super();
        this.Dataset = [];
        this.attachShadow({ mode: 'open' });
        this.shadowRoot?.append(this.WStyle);
        this.OptionContainer = WRender.Create({ className: "options-container" });
        this.shadowRoot?.append(this.OptionContainer, StylesControlsV2.cloneNode(true))
        this.DrawCaseDashboardComponent();
        
    }
    connectedCallback() { }
    DrawCaseDashboardComponent = async () => {
        this.dashBoardView();
    }

    SetOptions = (/** @type {Array} */ casosMap,
        /** @type {Array} */ casosProcesados,
        /** @type {Array} */ casosEtiquetadosPorMes) => {

        const title1 = "Casos por dependencia";
        const title2 = "Estado de los Casos";
        const title3 = "Cumplimiento del SLA por mes";
        const title4 = "Frecuencia de solicitudes por mes";
        const title5 = "Estado de los Casos por dependencia";
        this.OptionContainer.innerHTML = "";
        this.OptionContainer.append(WRender.Create({
            tagName: 'input', type: 'button',
            className: 'Btn-Mini', value: title1, onclick: () =>
                this.drawReport(WArrayF.GroupBy(casosMap, "Dependencia"), title1, new Tbl_Case({
                    Dependencia: { type: "text" },
                    val: { type: "number" }
                }))
        }))
        this.OptionContainer.append(WRender.Create({
            tagName: 'input', type: 'button',
            className: 'Btn-Mini', value: title2, onclick: () =>
                this.drawReport(WArrayF.GroupBy(this.Dataset, "Estado"), title2, new Tbl_Case())
        }))
        // this.OptionContainer.append(WRender.Create({
        //     tagName: 'input', type: 'button',
        //     className: 'Btn-Mini', value: title3, onclick: () =>
        //         this.drawReport(casosProcesados, title3, new Tbl_Case({
        //             Estado: { type: "text" },
        //             Servicio: { type: "text" },
        //             Caso: { type: "text" },
        //             Mes: { type: "text" },
        //             val: { type: "number" },
        //         }))
        // }))
        //console.log(casosEtiquetadosPorMes);
        this.OptionContainer.append(WRender.Create({
            tagName: 'input', type: 'button',
            className: 'Btn-Mini', value: title4, onclick: () =>
                this.drawReport(casosEtiquetadosPorMes, title4, new Tbl_Case({
                    Estado: { type: "text" },
                    Caso: { type: "text" },
                    Mes: { type: "text" },
                    val: { type: "number" },
                }))
        }))
        this.OptionContainer.append(WRender.Create({
            tagName: 'input', type: 'button',
            className: 'Btn-Mini', value: title5, onclick: () =>
                this.drawReport(casosMap, title5, new Tbl_Case({
                    Dependencia: { type: "text" },
                    val: { type: "number" }
                }))
        }))
    }
    drawReport = (/** @type {any[]} */ MapData, /**@type {String} */ title, /**@type {Object} */ model) => {
        this.shadowRoot?.append(new WModalForm({ title: title, ObjectModal: new WReportComponent({ Dataset: MapData, ModelObject: model }) }))
    }
    dashBoardView = async () => {
        this.Modelcase = new Tbl_Case();
        this.ModelTareas = new Tbl_Tareas();
        const dasboardContainer = WRender.Create({
            className: "dashBoardView",
            children: []
        });
        this.FilterOptions = new WFilterOptions({
            Dataset: this.Dataset,
            AutoSetDate: true,
            ModelObject: {
                Fecha_Inicio: { type: 'date' },
                Estado: { type: "Select", Dataset: ["Activo", "Espera", "Pendiente", "Finalizado"] }
            },
            Display: true,
            UseEntityMethods: false,
            FilterFunction: async (/** @type {any} */ FilterData) => {
                this.Dataset = await new Tbl_Case({ FilterData: FilterData }).Get();
                this.TareasDataset = await new Tbl_Tareas({ FilterData: FilterData }).Get();
                const { columChart,
                    radialChartDependencias,
                    columChartAperturaCasos,
                    columChartMonth,
                    radialChart } = this.buildCharts();
                const tableTareas = await this.taskData();
                dasboardContainer.innerHTML = "";
                dasboardContainer.append(tableTareas,
                    columChart,
                    radialChartDependencias,
                    columChartAperturaCasos,
                    columChartMonth,
                    radialChart);
            }
        });

        //this.TareasDataset = await new Tbl_Tareas().Get();
        //const { columChart, radialChartDependencias, columChartAperturaCasos, columChartMonth, radialChart } = this.buildCharts();
        //const tableTareas = await this.taskData();



        this.shadowRoot?.append(this.FilterOptions, dasboardContainer);
        await this.FilterOptions.filterFunction();
    }
    WStyle = css`
        .dashBoardView{
            display: grid;
            grid-template-columns: 37% 37% 23%;  
            grid-gap: 20px          
        }
        .dashBoardView #ColumnCasosPorDependencia { 
            grid-column: span 1;
        }
    `

    async taskData() {
        const TareasMap = [];
        this.TareasDataset?.forEach(t => {
            t.Tbl_Participantes?.forEach((p) => {
                if (TareasMap.find(f => f.Id_Perfil == p.Id_Perfil) == null) {
                    const tp = this.TareasDataset?.filter(tf => tf.Tbl_Participantes?.filter((tpf) => tpf.Id_Perfil == p.Id_Perfil).length > 0);
                    TareasMap.push({
                        Id_Perfil: p.Id_Perfil,
                        Tecnico: (p.Tbl_Profile?.Nombres ?? "") + " " + (p.Tbl_Profile?.Apellidos ?? ""),
                        Proceso: tp?.filter(tf => tf.Estado == "Proceso").length,
                        Finalizado: tp?.filter(tf => tf.Estado == "Finalizado").length,
                        Espera: tp?.filter(tf => tf.Estado == "Espera").length
                    });
                }
            });
        });
        //console.log(TareasMap);
        const tableTareas = new WTableComponent({
            maxElementByPage: 8,
            ModelObject: {
                Id_Perfil: { type: "text", hidden: true },
                Tecnico: { type: "text" },
                Proceso: { type: "text" },
                Finalizado: { type: "text" },
                Espera: { type: "text" }
            },
            Dataset: TareasMap, Options: {}
        });
        return tableTareas;
    }

    buildCharts() {
        const casosMap = this.Dataset.map(x => {
            x.Dependencia = x.Cat_Dependencias.Descripcion;
            x.val = 1;
            return x;
        });
        const casosProcesados = this.Dataset.filter(c => !c.Estado.includes("Pendiente") && !c.Estado.includes("Solicitado")
        ).map(c => ({
            Estado: c.Estado,
            Servicio: c.Tbl_Servicios?.Descripcion_Servicio ?? "",
            Caso: "Caso",
            Mes: c.Fecha_Inicio.getMonthFormatEs(),
            val: 1
        }));
        
        const casosEtiquetadosPorMes = this.Dataset.map(c => ({
            Estado: c.Estado,
            Caso: "Caso",
            Mes: c.Fecha_Inicio.getMonthFormatEs(),
            val: 1
        }));
        //console.log(casosEtiquetadosPorMes);
        this.SetOptions(casosMap, casosProcesados, casosEtiquetadosPorMes)

        const columChart = new ColumChart({
            // @ts-ignore
            Title: "Estado de los Casos por dependencia",
            Dataset: casosMap, percentCalc: true,
            EvalValue: "val",
            AttNameEval: "Estado",
            groupParams: ["Dependencia"]
        });
        columChart.id = "ColumnCasosPorDependencia";
        
        this.OptionContainer.append(WRender.Create({
            tagName: 'input', type: 'button',
            className: 'Btn-Mini', value: "title1", onclick: () => {
                console.log(columChart.GroupsProcessData);
                this.drawReport(columChart.GroupsProcessData, "")
            }
        }))
        const radialChartDependencias = new RadialChart({
            // @ts-ignore
            Title: "Casos por dependencia",
            Dataset: WArrayF.GroupBy(casosMap, "Dependencia"), EvalValue: "count", AttNameEval: "Dependencia"
        });
        const radialChart = new RadialChart({
            // @ts-ignore
            Title: "Estado de los Casos",
            Dataset: WArrayF.GroupBy(this.Dataset, "Estado"), EvalValue: "count", AttNameEval: "Estado"
        });
        // const casosProcesadosAll = this.Dataset.map(c => ({
        //     Estado: c.Estado,
        //     Caso: "Caso",
        //     Mes: c.Fecha_Inicio.getMonthFormatEs(),
        //     val: 1
        // }));
        const columChartMonth = new ColumChart({
            // @ts-ignore
            Title: "Cumplimiento del SLA por mes",
            //TypeChart: "Line",
            Dataset: casosProcesados,
            EvalValue: "val",
            AttNameEval: "Estado",
            groupParams: ["Servicio", "Mes"]
        });
        const columChartAperturaCasos = new ColumChart({
            Title: "Frecuencia de solicitudes por mes",
            // @ts-ignore
            TypeChart: "Line",
            Dataset: casosEtiquetadosPorMes,
            EvalValue: "val",
            AttNameEval: "Caso",
            groupParams: ["Mes"]
        });
        return { columChart, radialChartDependencias, columChartAperturaCasos, columChartMonth, radialChart };
    }
}
customElements.define('w-case-dasboard', CaseDashboardComponent);
export { CaseDashboardComponent };

