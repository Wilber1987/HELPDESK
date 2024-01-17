//@ts-check
import { CaseTable_Agenda, CaseTable_Calendario, CaseTable_Tareas } from '../../../ModelProyect/ProyectDataBaseModel.js';
import { StyleScrolls, StylesControlsV2, StylesControlsV3 } from "../../../WDevCore/StyleModules/WStyleComponents.js";
import { WDetailObject } from '../../../WDevCore/WComponents/WDetailObject.js';
import { WModalForm } from '../../../WDevCore/WComponents/WModalForm.js';
import { ComponentsManager, WRender } from '../../../WDevCore/WModules/WComponentsTools.js';
import { css } from '../../../WDevCore/WModules/WStyledRender.js';
import { TareaDetailView } from './TareaDetailView.js';

class TaskManagers extends HTMLElement {
    /**
     * 
     * @param {Array<CaseTable_Tareas>} Dataset 
     * @param {CaseTable_Tareas} Model 
     * @param {Object} [Config] 
     */
    constructor(Dataset, Model, Config) {
        super();
        this.Dataset = Dataset;
        this.Config = Config;
        this.TaskModel = Model ?? new CaseTable_Tareas();
        this.attachShadow({ mode: 'open' });
        this.shadowRoot?.append(this.WStyle,
            StyleScrolls.cloneNode(true),
            StylesControlsV2.cloneNode(true),
            StylesControlsV3.cloneNode(true));
        this.TabContainer = WRender.Create({ class: 'TabContainer', id: "TabContainer" });
        this.TabManager = new ComponentsManager({ MainContainer: this.TabContainer });
        this.OptionContainer = WRender.Create({ className: "OptionContainer" });
        this.shadowRoot?.append(this.TabContainer);
        this.StatePanelContainer = WRender.Create({
            className: "panelContainer",
            style: " grid-template-columns: repeat(" + this.TaskModel.Estado.Dataset.length + ", auto);"
        })
        this.DrawTaskManagers();
    }
    connectedCallback() { }
    DrawTaskManagers = async () => { 
        this.StatePanelContainer.innerHTML = ""; 
        this.TaskManager(this.Dataset);
    }
    /**
     * 
     * @param {Array<Object>} DatasetData 
     */
    TaskManager = (DatasetData = this.Dataset) => {
        
        this.TaskModel.Estado.Dataset.forEach(state => {
            const Dataset = DatasetData.filter(t => t.Estado == state);
            const Panel = WRender.Create({
                className: Dataset.length > 0 ? "panel" : "panel-inact", id: "Panel-" + state,
                ondrop: (ev) => {
                    var data = ev.dataTransfer.getData("text");
                    const taskCard = this.shadowRoot?.getElementById(data);
                    if (ev.target.className.includes("panel")) {
                        ev.target.appendChild(taskCard);
                        // @ts-ignore
                        this.cardDrop(taskCard?.task, state);
                    }
                }, ondragover: (ev) => {
                    ev.preventDefault();
                }, children: [
                    { tagName: "label", class: "title-panel", innerText: state }
                ]
            });
            Dataset.forEach(task => {
                Panel.append(this.taskCard(task));
            });
            const panelOptions = WRender.Create({
                className: "panel-options", children: [
                    {//display
                        tagName: 'input', style: 'transform: rotate(90deg)', class: 'BtnDinamictT', value: '>', onclick: async (ev) => {
                            if (Panel.className == "panel") {
                                ev.target.style["transform"] = "inherit";
                                Panel.className = "panel-inact";
                            } else {
                                ev.target.style["transform"] = "rotate(90deg)";
                                Panel.className = "panel";
                            }
                        }

                    }]
            });
            this.StatePanelContainer.appendChild(WRender.Create({
                className: "panel-container",
                children: [panelOptions, Panel]
            }));
        });
        this.TabManager.NavigateFunction("main-task", this.StatePanelContainer);
    }
    taskCard = (task) => {
        return WRender.Create({
            className: "task-card",
            draggable: true,
            // @ts-ignore
            task: task,
            id: "task" + task.Id_Tarea,
            ondragstart: (ev) => {
                ev.dataTransfer.setData("text", ev.target.id);
            }, children: [
                { tagName: "label", class: "task-title", innerText: task.Titulo + " #" + task.Id_Tarea },
                { tagName: "label", class: "task-detail", innerText: task.CaseTable_Case?.Titulo },
                //{ tagName: "p", class: "p-title", innerText: task.Descripcion },
                {
                    class: "p-participantes", children: task.CaseTable_Participantes?.map(I => ({
                        tagName: 'img', className: "img-participantes",
                        src: "" + I.Tbl_Profile?.Foto
                    }))
                }, {
                    class: "card-options", children: [{
                        tagName: "buttom", class: "Btn-Mini", innerText: "Editar",
                        onclick: () => this.taskEdit(task)
                    }, {
                        tagName: "buttom", class: "Btn-Mini-Success", innerText: "Detalles",
                        onclick: () => this.taskDetail(task)
                    }]
                }
            ]
        })
    }
    /**
    * 
    * @param {CaseTable_Tareas} task 
    */
    taskEdit = async (task) => {
        const CalendarModel = {
            type: 'CALENDAR',
            ModelObject: () => new CaseTable_Calendario(),
            require: false,
            CalendarFunction: async () => {
                return {
                    Agenda: await new CaseTable_Agenda({
                        // @ts-ignore
                        Id_Dependencia: task?.CaseTable_Case?.Id_Dependencia
                    }).Get(),
                    Calendario: await new CaseTable_Calendario({
                        // @ts-ignore
                        Id_Dependencia: task?.CaseTable_Case?.Id_Dependencia
                    }).Get()
                }
            }
        }
        // @ts-ignore
        this.TaskModel.CaseTable_Calendario = CalendarModel;
        this.shadowRoot?.append(new WModalForm({
            EditObject: task,
            ImageUrlPath: this.Config?.ImageUrlPath,
            AutoSave: true,
            ModelObject: this.TaskModel
        }))
    }
    /**
    * 
    * @param {CaseTable_Tareas} task 
    */
    taskDetail = async (task) => {
        const find = await new CaseTable_Tareas({ Id_Tarea: task.Id_Tarea }).Get()
        const CaseDetail = new TareaDetailView({ Task: find[0] });
       //this.TabManager.NavigateFunction("Detail" + task.Id_Tarea, CaseDetail)
        this.shadowRoot?.append(new WModalForm({
            title: "Detalle",
            StyleForm: "FullScreen",
            ImageUrlPath: this.Config?.ImageUrlPath,
            ObjectModal:  CaseDetail,
        }));
    }
    /**
     * 
     * @param {CaseTable_Tareas} task 
     * @param {String} state 
     */
    cardDrop = async (task, state) => {
        // @ts-ignore
        task.Estado = state;
        const response = await task.Update();
        if (response.status == 200) {
            this.Config.action(task);
        }
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
        .panelContainer {
            display: grid;
            overflow-x: auto;
            overflow-y: hidden;
            padding: 10px;
            gap: 10px;
            width: fit-content;
            height: 500px;
            max-width: calc(100% - 50px);
        } 
        .panel-options {
            background-color: #e4e4e4;              
            border: 1px solid #d6d3d3;
            border-radius: 0px 10px 10px 0px;
        }
        .panel-container {
            padding: 0px;            
            border-radius: 0px 10px 10px 0px;
            background-color: #eee;        
            border: 1px solid #d6d3d3;
            height: 500px;
            display: grid;
            grid-template-columns: 30px fit-content(340px);
            
        }
        .BtnDinamictT {
            font-weight: bold;
            border: none;
            padding: 0px;
            margin: 5px;
            outline: none;
            text-align: center;
            display: inline-block;
            font-size: 10px;
            cursor: pointer;
            background-color: #4894aa;
            color: #fff;
            border-radius: 0.2cm;
            width: 15px;
            height: 15px;
            background-color: #4894aa;
            font-family: monospace;
        }
        .panel {          
            padding: 5px;  
            overflow-y: auto;    
            height: calc(100% - 40px);
            transition: all 0.4s;   
            width: 310px;           
        }
        .panel-inact {          
            padding: 5px;  
            overflow: hidden;    
            width: calc(200pxpx); 
            font-size: 14px;
            transition: all 0.4s; 
        }
        .task-card {
            background-color: #fff;
            height: 130px;
            border-radius: 10px;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            margin-bottom: 15px;        
            box-shadow: 0 0 5px 0 #adacac;
            container-type: inline-size;
        }
        .task-title{
            padding: 10px 10px;
            font-size: 14px;
            font-weight: bold;
            background-color: #eee;
            cursor: pointer;
        }
        .card-options {
            padding: 0px;
            width:  calc(100% - 20px);
            height: 25px;
            justify-content: flex-end;
            display: flex;
        }
        .title-panel {
            font-size: 14px; 
            text-transform: uppercase;
            font-weight: bold;
            margin-bottom: 10px;
            display: block;
            color: #0a1338;
        }
        .p-title {
            height: 100%;
            padding: 5px 10px;
            margin: 0px;
        }
        .task-detail{
            padding: 5px 10px; 
            font-size: 11px
        }
        .p-participantes{
            display: flex;
            padding: 5px 10px;
        }
        .img-participantes {
            padding: 0;
            height: 25px;
            width: 25px;
            border-radius: 50%;
            margin-right: 5px;
            overflow: hidden;
            box-shadow: 0 0 3px 0 rgba(0,0,0,0.5);
        }
        @container (max-width: 200px){
            .p-participantes {
                display: none;
            }
            .card-options {
                flex-direction: column;
                height: auto;
                justify-content: flex-start;
            }
        }
    `
}
customElements.define('w-main-task', TaskManagers);
export { TaskManagers };

