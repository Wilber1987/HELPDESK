

//@ts-check
import { CaseTable_Case, CaseTable_Participantes, CaseTable_Tareas } from '../../../ModelProyect/ProyectDataBaseModel.js';
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
        this.DrawCaseDashboardComponent();
        this.OptionContainer = WRender.Create({ className: "options-container" });
        this.shadowRoot?.append(this.OptionContainer, StylesControlsV2.cloneNode(true))
    }
    connectedCallback() { }
    DrawCaseDashboardComponent = async () => {
        this.dashBoardView();
    }

    SetOptions = (/** @type {Array} */ datasetMap,
        /** @type {Array} */ MapDataset,
        /** @type {Array} */ MapDatasetAperturaCasos) => {

        const title1 = "Casos por dependencia";
        const title2 = "Estado de los Casos";
        const title3 = "Cumplimiento del SLA por mes";
        const title4 = "Frecuencia de solicitudes por mes";
        const title5 = "Estado de los Casos por dependencia";
        this.OptionContainer.innerHTML = "";
        this.OptionContainer.append(WRender.Create({
            tagName: 'input', type: 'button',
            className: 'Btn-Mini', value: title1, onclick: () =>
                this.drawReport(WArrayF.GroupBy(datasetMap, "Dependencia"), title1)
        }))
        this.OptionContainer.append(WRender.Create({
            tagName: 'input', type: 'button',
            className: 'Btn-Mini', value: title2, onclick: () =>
                this.drawReport(WArrayF.GroupBy(this.Dataset, "Estado"), title2)
        }))
        this.OptionContainer.append(WRender.Create({
            tagName: 'input', type: 'button',
            className: 'Btn-Mini', value: title3, onclick: () =>
                this.drawReport(MapDataset, title3)
        }))
        console.log(MapDatasetAperturaCasos);
        this.OptionContainer.append(WRender.Create({
            tagName: 'input', type: 'button',
            className: 'Btn-Mini', value: title4, onclick: () =>
                this.drawReport(MapDatasetAperturaCasos, title4)
        }))
        this.OptionContainer.append(WRender.Create({
            tagName: 'input', type: 'button',
            className: 'Btn-Mini', value: title5, onclick: () =>
                this.drawReport(datasetMap, title5)
        }))
    }
    drawReport = (/** @type {any[]} */ MapData, /**@type {String} */ title) => {
        this.shadowRoot?.append(new WModalForm({ title: title, ObjectModal: new WReportComponent({ Dataset: MapData }) }))
    }
    dashBoardView = async () => {
        this.Modelcase = new CaseTable_Case();
        this.ModelTareas = new CaseTable_Tareas();
        this.Dataset = await this.Modelcase.GetOwCase();
        this.TareasDataset = await new CaseTable_Tareas().Get();
        const { columChart, radialChartDependencias, columChartAperturaCasos, columChartMonth, radialChart } = this.buildCharts();
        const tableTareas = await this.taskData();

        const dasboardContainer = WRender.Create({
            className: "dashBoardView",
            children: [tableTareas,
                columChart,
                radialChartDependencias,
                columChartAperturaCasos,
                columChartMonth,
                radialChart]
        });
        this.FilterOptions = new WFilterOptions({
            Dataset: this.Dataset,
            ModelObject: {
                Fecha_Inicio: { type: 'date' },
                Estado: { type: "Select", Dataset: ["Activo", "Espera", "Pendiente", "Finalizado"] }
            },
            Display: true,
            AutoFilter: false,
            FilterFunction: async (/** @type {any} */ FilterData) => {
                this.Dataset = await new CaseTable_Case({ FilterData: FilterData }).GetOwCase();
                this.TareasDataset = await new CaseTable_Tareas({ FilterData: FilterData }).Get();
                const { columChart, radialChartDependencias, columChartAperturaCasos, columChartMonth, radialChart } = this.buildCharts();
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
        this.shadowRoot?.append(this.FilterOptions, dasboardContainer);
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
            t.CaseTable_Participantes.forEach((p) => {
                if (TareasMap.find(f => f.Id_Perfil == p.Id_Perfil) == null) {
                    const tp = this.TareasDataset?.filter(tf => tf.CaseTable_Participantes.filter((tpf) => tpf.Id_Perfil == p.Id_Perfil).length > 0);
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
        console.log(TareasMap);
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
        const datasetMap = this.Dataset.map(x => {
            x.Dependencia = x.Cat_Dependencias.Descripcion;
            x.val = 1;
            return x;
        });
        const MapDataset = this.Dataset.filter(c => !c.Estado.includes("Pendiente") && !c.Estado.includes("Solicitado")
        ).map(c => ({
            Estado: c.Estado,
            Servicio: c.Tbl_Servicios?.Descripcion_Servicio ?? "",
            Caso: "Caso",
            Mes: c.Fecha_Inicio.getMonthFormatEs(),
            val: 1
        }));
        const MapDatasetAperturaCasos = this.Dataset.map(c => ({
            Estado: c.Estado,
            Caso: "Caso",
            Mes: c.Fecha_Inicio.getMonthFormatEs(),
            val: 1
        }));
        console.log(MapDatasetAperturaCasos);
        this.SetOptions(datasetMap, MapDataset, MapDatasetAperturaCasos)

        const columChart = new ColumChart({
            // @ts-ignore
            Title: "Estado de los Casos por dependencia",
            Dataset: datasetMap, percentCalc: true,
            EvalValue: "val",
            AttNameEval: "Estado",
            groupParams: ["Dependencia"]
        });
        columChart.id = "ColumnCasosPorDependencia";
        const radialChartDependencias = new RadialChart({
            // @ts-ignore
            Title: "Casos por dependencia",
            Dataset: WArrayF.GroupBy(datasetMap, "Dependencia"), EvalValue: "count", AttNameEval: "Dependencia"
        });
        const radialChart = new RadialChart({
            // @ts-ignore
            Title: "Estado de los Casos",
            Dataset: WArrayF.GroupBy(this.Dataset, "Estado"), EvalValue: "count", AttNameEval: "Estado"
        });
        // const MapDatasetAll = this.Dataset.map(c => ({
        //     Estado: c.Estado,
        //     Caso: "Caso",
        //     Mes: c.Fecha_Inicio.getMonthFormatEs(),
        //     val: 1
        // }));
        const columChartMonth = new ColumChart({
            // @ts-ignore
            Title: "Cumplimiento del SLA por mes",
            //TypeChart: "Line",
            Dataset: MapDataset,
            EvalValue: "val",
            AttNameEval: "Estado",
            groupParams: ["Servicio", "Mes"]
        });
        const columChartAperturaCasos = new ColumChart({
            Title: "Frecuencia de solicitudes por mes",
            // @ts-ignore
            TypeChart: "Line",
            Dataset: MapDatasetAperturaCasos,
            EvalValue: "val",
            AttNameEval: "Caso",
            groupParams: ["Mes"]
        });
        return { columChart, radialChartDependencias, columChartAperturaCasos, columChartMonth, radialChart };
    }
}
customElements.define('w-case-dasboard', CaseDashboardComponent);
export { CaseDashboardComponent };

