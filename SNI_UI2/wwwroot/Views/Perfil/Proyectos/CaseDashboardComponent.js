

import { CaseTable_Participantes, CaseTable_Tareas } from '../../../Model/ProyectDataBaseModel.js';
import { ColumChart, RadialChart } from '../../../WDevCore/WComponents/WChartJSComponents.js';
import { WTableComponent } from '../../../WDevCore/WComponents/WTableComponent.js';
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
        const { columChart, radialChartDependencias, columChartAperturaCasos, columChartMonth, radialChart } = this.newMethod();
        const Tareas = await new CaseTable_Tareas().Get();
        const TareasMap = []
        Tareas.forEach(/**@type {CaseTable_Tareas} */ t => {
            t.CaseTable_Participantes.forEach(/**@type {CaseTable_Participantes} */ p => {
                if (TareasMap.find(f => f.Id_Perfil == p.Id_Perfil) == null) {
                    const tp = Tareas.filter(tf => tf.CaseTable_Participantes.filter(tpf => tpf.Id_Perfil == p.Id_Perfil).length > 0)
                    TareasMap.push({
                        Id_Perfil: p.Id_Perfil,
                        Tecnico: p.Tbl_Profile.Nombres + " " + p.Tbl_Profile.Apellidos,
                        Proceso: tp.filter(tf => tf.Estado == "Proceso").length,
                        Finalizado: tp.filter(tf => tf.Estado == "Finalizado").length,
                        Espera: tp.filter(tf => tf.Estado == "Espera").length
                    })
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
        this.shadowRoot.append(WRender.Create({
            className: "dashBoardView",
            children: [tableTareas,
                columChart,
                radialChartDependencias,
                columChartAperturaCasos,
                columChartMonth,
                radialChart,]
        }));
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

    newMethod() {
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
        columChart.id = "ColumnCasosPorDependencia";
        const radialChartDependencias = new RadialChart({
            Title: "Casos por dependencia",
            Dataset: WArrayF.GroupBy(datasetMap, "Dependencia"), EvalValue: "count", AttNameEval: "Dependencia"
        });
        const radialChart = new RadialChart({
            Title: "Estado de los Casos",
            Dataset: WArrayF.GroupBy(this.Dataset, "Estado"), EvalValue: "count", AttNameEval: "Estado"
        });
        //new WTableDynamicComp({Dataset: dataset})
        const MapDataset = this.Dataset.filter(c => !c.Estado.includes("Pendiente") && !c.Estado.includes("Solicitado")
        ).map(c => ({
            Estado: c.Estado,
            Servicio: c.Tbl_Servicios.Descripcion_Servicio,
            Caso: "Caso",
            Mes: c.Fecha_Inicial.getMonthFormatEs(),
            val: 1
        }));
        // const MapDatasetAll = this.Dataset.map(c => ({
        //     Estado: c.Estado,
        //     Caso: "Caso",
        //     Mes: c.Fecha_Inicial.getMonthFormatEs(),
        //     val: 1
        // }));
        const columChartMonth = new ColumChart({
            Title: "Cumplimiento del SLA por mes",
            //TypeChart: "Line",
            Dataset: MapDataset,
            EvalValue: "val",
            AttNameEval: "Estado",
            groupParams: [ "Servicio", "Mes"]
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
        return { columChart, radialChartDependencias, columChartAperturaCasos, columChartMonth, radialChart };
    }
}
customElements.define('w-case-dasboard', CaseDashboardComponent);
export { CaseDashboardComponent };

