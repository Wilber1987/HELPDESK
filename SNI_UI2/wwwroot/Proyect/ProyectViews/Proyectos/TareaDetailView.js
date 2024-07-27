//@ts-check
import { WSecurity } from "../../../WDevCore/Security/WSecurity.js";
import { StylesControlsV2, StylesControlsV3, StyleScrolls } from "../../../WDevCore/StyleModules/WStyleComponents.js";
import { WCommentsComponent } from "../../../WDevCore/WComponents/WCommentsComponent.js";
import { WModalForm } from "../../../WDevCore/WComponents/WModalForm.js";
import { ComponentsManager, html, WRender } from "../../../WDevCore/WModules/WComponentsTools.js";
import { css } from "../../../WDevCore/WModules/WStyledRender.js";
import { Tbl_Agenda_ModelComponent } from "../../FrontModel/Tbl_Agenda.js";
import { Tbl_Calendario_ModelComponent } from "../../FrontModel/Tbl_Calendario.js";
import { Tbl_Comments_Tasks_ModelComponent } from "../../FrontModel/Tbl_Comments_Tasks.js";
import { Tbl_Tareas, Tbl_Tareas_ModelComponent } from "../../FrontModel/Tbl_Tareas.js";

/**
 * @typedef {Object} ComponentConfig
 * * @property {Tbl_Tareas} Task
 * * @property {Function} [action]
 * * @property {Function} [BackAction]
 */
class TareaDetailView extends HTMLElement {
    /**
     * @param {ComponentConfig} Config 
     */
    constructor(Config) {
        super();
        this.attachShadow({ mode: 'open' });
        this.OptionContainer = WRender.Create({ className: "OptionContainer" });
        this.TabContainer = WRender.Create({ className: "TabContainer", id: 'TabContainer' });
        this.Manager = new ComponentsManager({ MainContainer: this.TabContainer, SPAManage: false });
        this.Task = Config.Task;
        this.Config = Config;
        this.shadowRoot?.append(
            StylesControlsV2.cloneNode(true),
            StyleScrolls.cloneNode(true),
            StylesControlsV3.cloneNode(true),
            this.CustomStyle,
            //this.OptionContainer,
            this.TabContainer
        );
        this.Draw();
    }
    Draw = async () => {
        this.SetOption();
    }

    async SetOption() {
        this.OptionContainer.append(WRender.Create({
            tagName: 'button', className: 'Block-Primary', innerText: 'Home',
            onclick: async () => this.Manager.NavigateFunction("id", await this.MainComponent())
        }))
        this.Manager.NavigateFunction("id", await this.MainComponent());
    }
    async MainComponent() {
        const commentsActividad = await new Tbl_Comments_Tasks_ModelComponent({ Id_Tarea: this.Task?.Id_Tarea }).Get();
        const commentsContainer = new WCommentsComponent({
            Dataset: commentsActividad,
            ModelObject: new Tbl_Comments_Tasks_ModelComponent(),
            User: WSecurity.UserData,
            UserIdProp: "Id_User",
            CommentsIdentify: this.Task?.Id_Tarea,
            CommentsIdentifyName: "Id_Tarea",
            UrlSearch: "../api/ApiEntityHelpdesk/getTbl_Comments_Tasks",
            UrlAdd: "../api/ApiEntityHelpdesk/saveTbl_Comments_Tasks"
        });

        const node = html`<div class="card">
                <!-- <div class="thumbnail"><img class="left"
                        src="https://cdn2.hubspot.net/hubfs/322787/Mychefcom/images/BLOG/Header-Blog/photo-culinaire-pexels.jpg" />
                </div> -->
                <div class="right">
                    
                    <h1>${this.Task?.Titulo}</h1>
                    <h3> Estado: (${this.Task.Estado})</h3>                    
                    <div class="authores">
                        ${this.Task?.Tbl_Participantes?.map(I => `<div class="author"><img src="${I.Tbl_Profile?.Foto}" />
                                <label>${I.Tbl_Profile?.Nombres} ${I.Tbl_Profile?.Apellidos ?? ""}</label></div>`)?.join("") ?? "Sin Participantes"}
                    </div>
                    <div class="separator"></div>
                    <p>${this.Task?.Descripcion}</p>
                    <div class="horarios">
                        <h5>Horario</h5>
                        ${this.Task?.Tbl_Calendario?.map(H => `<div class="horario">
                               del ${H.Fecha_Inicio?.// @ts-ignore
                               toDateFormatEs()} hasta ${H.Fecha_Final?.toDateFormatEs()}
                            </div>`)?.join("") ?? "-"}
                    </div>
                </div>
                <!-- <h5>12</h5>
                <h6>JANUARY</h6> -->
                <!-- <ul>
                    <li><i class="fa fa-eye fa-2x"></i></li>
                    <li><i class="fa fa-heart-o fa-2x"></i></li>
                    <li><i class="fa fa-envelope-o fa-2x"></i></li>
                    <li><i class="fa fa-share-alt fa-2x"></i></li>
                </ul><div class="fab"><i class="fa fa-arrow-down fa-3x"> </i></div> -->
                
            </div>`
        //"Activo", "Proceso", "Finalizado", "Espera", "Inactivo"
        node.append(WRender.Create({
            className: "options", children: [
                {
                    tagName: 'input', type: 'button', className: 'Btn-Mini', value: 'Editar', onclick: async () => {
                        this.taskEdit(this.Task);
                    }
                }, {
                    tagName: 'input', type: 'button', className: 'Btn-Mini', value: 'Activar', onclick: async () => {
                        this.changeState(this.Task, "Activo")
                    }
                }, {
                    tagName: 'input', type: 'button', className: 'Btn-Mini', value: 'En proceso', onclick: async () => {
                        this.changeState(this.Task, "Proceso")
                    }
                }, {
                    tagName: 'input', type: 'button', className: 'Btn-Mini', value: 'Finalizar', onclick: async () => {
                        this.changeState(this.Task, "Finalizado")
                    }
                }, {
                    tagName: 'input', type: 'button', className: 'Btn-Mini', value: 'En espera', onclick: async () => {
                        this.changeState(this.Task, "Espera")
                    }
                }, {
                    tagName: 'input', type: 'button', className: 'Btn-Mini', value: 'Inactivar', onclick: async () => {
                        this.changeState(this.Task, "Inactivo")
                    }
                }
            ]
        }))
        if (this.Config.BackAction) {
            node.append(WRender.Create({
                tagName: 'input', type: 'button', className: 'Btn-Mini-Success btn-return', value: '<', onclick: () => {
                    // @ts-ignore
                    this.Config.BackAction();
                }
            }))
        }
        return WRender.Create({ className: "container", children: [node, commentsContainer] });
    }

    /**
    * 
    * @param {Tbl_Tareas} task
    */
    taskEdit = async (task) => {
        const CalendarModel = {
            type: 'CALENDAR',
            ModelObject: () => new Tbl_Calendario_ModelComponent(),
            require: false,
            CalendarFunction: async () => {
                return {
                    Agenda: await new Tbl_Agenda_ModelComponent({
                        // @ts-ignore
                        Id_Dependencia: task?.Tbl_Case?.Id_Dependencia
                    }).Get(),
                    Calendario: await new Tbl_Calendario_ModelComponent({
                        // @ts-ignore
                        Id_Dependencia: task?.Tbl_Case?.Id_Dependencia
                    }).Get()
                }
            }
        }
        this.TaskModel = new Tbl_Tareas_ModelComponent();
        // @ts-ignore
        this.TaskModel.Tbl_Calendario = CalendarModel;
        this.shadowRoot?.append(new WModalForm({
            EditObject: task,
            AutoSave: true,
            title: "Editar",
            ModelObject: this.TaskModel
        }))
    }
    /**
     * 
     * @param {Tbl_Tareas} task
     * @param {String} state 
     */
    changeState = async (task, state) => {
        // @ts-ignore
        task.Estado = state;
        const response = await task.Update();
    }


    CustomStyle = css`
        @import url('https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css');
        .component{
           display: block;
        }  
        .btn-return {
            position: absolute;
            top: -25px;
            left: 5px;
            width: 50px;
            padding: 5px;
        }          
            /*Just the background stuff*/
            .container {
                display: grid;
                grid-template-columns: calc(100% - 600px) 580px;
                column-gap: 20px;
            }    
            /*My hum... body.. yeah..*/           

            /* The card */
            .card {
                position: relative;
                min-height: 500px;
                width: 100%;
                background-color: #FFF;
                border: solid 1px #d1cfcf;
                border-radius: 10px;
                margin-top: 30px;
            }

            /* Image on the left side */
            .thumbnail {
                float: left;
                position: relative;
                left: 30px;
                top: -10px;
                height: 100px;
                width: 180px;
                -webkit-box-shadow: 10px 10px 60px 0px rgba(0, 0, 0, 0.75);
                -moz-box-shadow: 10px 10px 60px 0px rgba(0, 0, 0, 0.75);
                box-shadow: 10px 10px 60px 0px rgba(0, 0, 0, 0.75);
                overflow: hidden;
            }

                /*object-fit: cover;*/
                /*object-position: center;*/
            img.left {
                position: absolute;
                left: 50%;
                top: 50%;
                height: auto;
                width: 100%;
                -webkit-transform: translate(-50%, -50%);
                -ms-transform: translate(-50%, -50%);
                transform: translate(-50%, -50%);
            }

            /* Right side of the card */
            .right {
                margin-left: 20px;
                margin-right: 20px;
            }

            h1 {
                padding-top: 16px;
                font-size: 1.3rem;
                color: #b1b1b1;
            }
            h3 {                
                font-size: 1.1rem;
                color: #575757;
            }

            .authores{
                display: flex;
                gap: 10px;
                align-items: center;
                width: 100%;
                flex-wrap: wrap;
            }

            .author {
                display: flex;
                align-items: center;
                gap: 5px;
                background-color: #9ECAFF;
                height: 30px;
                width: 250px;
                border-radius: 20px;
                font-size: 12px;
            }

            .author > img {
                float: left;
                height: 30px;
                width: 30px;
                border-radius: 50%;
            }

            h2 {
                padding: 0;
                margin: 0;
                text-align: right;
                font-size: 0.8rem;
            }
            .separator {
                margin-top: 10px;
                border: 1px solid #C3C3C3;
            }

            p {
                text-align: justify;
                padding-top: 10px;
                font-size: 0.95rem;
                line-height: 150%;
                color: #4B4B4B;
            }

            .horarios{
                display: flex;
                gap: 5px;
                align-items: flex-start;
                width: 100%;
                flex-wrap: wrap;
                flex-direction: column;
            }

            .horario {
                padding: 0;
                margin: 0;
                text-align: right;
                font-size: 14px;
            }
            h5 {
               margin:0px;
               padding:0px;
               font-size: 16px;
               color: #C3C3C3;
            }           
            /* Floating action button */
            .options {
                position: absolute;
                display: flex;
                background-color: #FFF;
                right: 50px;
                bottom: -10px;        
                padding: 10px;       
                text-align: center;                
                border: solid 1px #d1cfcf;
                border-radius: 10px;
                max-width: 70%;
                flex-wrap: wrap;
                gap: 5px;
            }                  
    `
}
customElements.define('w-tarea-detail-component', TareaDetailView);
export { TareaDetailView };

