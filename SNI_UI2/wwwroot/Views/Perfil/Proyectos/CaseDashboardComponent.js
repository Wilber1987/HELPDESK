

import { ColumChart, RadialChart } from '../../../WDevCore/WComponents/WChartJSComponents.js';
import { WArrayF, WRender } from '../../../WDevCore/WModules/WComponentsTools.js';
import { css } from '../../../WDevCore/WModules/WStyledRender.js';

class CaseDashboardComponent extends HTMLElement {
    constructor(Dataset) {
        super();
        this.Dataset = Dataset;
        this.attachShadow({ mode: 'open' });
        this.shadowRoot.append(this.WStyle)
        this.DrawCaseDashboardComponent();
    }
    connectedCallback() { }
    DrawCaseDashboardComponent = async () => {
        this.dashBoardView();
    }
    dashBoardView = async () => {
        const datasetMap = this.Dataset.map(x => {
            x.Dependencia = x.Cat_Dependencias.Descripcion;
            x.val = 1;
            return x;
        });
        const columChart = new ColumChart({
            Title: "Estado de los Casos por dependencia",
            Dataset: datasetMap, percentCalc: true,
            EvalValue: "val",
            AttNameEval: "Estado",
            groupParams: ["Dependencia"]
        });
        columChart.id = "ColumnCasosPorDependencia"
        const radialChartDependencias = new RadialChart({
            Title: "Casos por dependencia",
            Dataset: WArrayF.GroupBy(datasetMap, "Dependencia"), EvalValue: "count", AttNameEval: "Dependencia"
        });
        const radialChart = new RadialChart({
            Title: "Estado de los Casos",
            Dataset: WArrayF.GroupBy(this.Dataset, "Estado"), EvalValue: "count", AttNameEval: "Estado"
        });
        //new WTableDynamicComp({Dataset: dataset})
        const MapDataset = this.Dataset.filter(c =>
            !c.Estado.includes("Pendiente") && !c.Estado.includes("Solicitado")
        ).map(c => ({
            Estado: c.Estado,
            Caso: "Caso",
            Mes: c.Fecha_Inicial.getMonthFormatEs(),
            val: 1
        }));
        const MapDatasetAll = this.Dataset.map(c => ({
            Estado: c.Estado,
            Caso: "Caso",
            Mes: c.Fecha_Inicial.getMonthFormatEs(),
            val: 1
        }));
        const columChartMonth = new ColumChart({
            Title: "Frecuencia de cambio de estado por mes",
            TypeChart: "Line",
            Dataset: MapDataset,
            EvalValue: "val",
            AttNameEval: "Estado",
            groupParams: ["Mes"]
        });
        const MapDatasetAperturaCasos = this.Dataset.map(c => ({
            Estado: c.Estado,
            Caso: "Caso",
            Mes: c.Fecha_Inicial.getMonthFormatEs(),
            val: 1
        }));
        const columChartAperturaCasos = new ColumChart({
            Title: "Frecuencia de solicitudes por mes",
            TypeChart: "Line",
            Dataset: MapDatasetAperturaCasos,
            EvalValue: "val",
            AttNameEval: "Caso",
            groupParams: ["Mes"]
        });
        this.shadowRoot.append(WRender.Create({
            className: "dashBoardView",
            children: [columChart,
                radialChartDependencias,
                columChartAperturaCasos,
                columChartMonth, 
                radialChart,]
        }));
    }
    WStyle = css`
        .dashBoardView{
            display: grid;
            grid-template-columns: 38% 38% 23%;  
            grid-gap: 20px          
        }
        .dashBoardView #ColumnCasosPorDependencia { 
            grid-column: span 2;
        }
    `
}
customElements.define('w-case-dasboard', CaseDashboardComponent);
export { CaseDashboardComponent };

