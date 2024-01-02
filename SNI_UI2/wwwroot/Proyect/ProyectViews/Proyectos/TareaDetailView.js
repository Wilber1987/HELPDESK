//@ts-check
import { WRender, ComponentsManager, WAjaxTools, WArrayF, html } from "../../../WDevCore/WModules/WComponentsTools.js";
import { StylesControlsV2, StylesControlsV3, StyleScrolls } from "../../../WDevCore/StyleModules/WStyleComponents.js"
import { css } from "../../../WDevCore/WModules/WStyledRender.js";
import { WCommentsComponent } from "../../../WDevCore/WComponents/WCommentsComponent.js";
import { CaseTable_Agenda, CaseTable_Calendario, CaseTable_Comments, CaseTable_Comments_Tasks, CaseTable_Tareas } from "../../../ModelProyect/ProyectDataBaseModel.js";
import { WSecurity } from "../../../WDevCore/Security/WSecurity.js";
import { WModalForm } from "../../../WDevCore/WComponents/WModalForm.js";
import { WDetailObject } from "../../../WDevCore/WComponents/WDetailObject.js";

/**
 * @typedef {Object} ComponentConfig
 * * @property {CaseTable_Tareas} Task
 */
class TareaDetailView extends HTMLElement {
    /**
     * 
     * @param {ComponentConfig} props 
     */
    constructor(props) {
        super();
        this.attachShadow({ mode: 'open' });
        this.OptionContainer = WRender.Create({ className: "OptionContainer" });
        this.TabContainer = WRender.Create({ className: "TabContainer", id: 'TabContainer' });
        this.Manager = new ComponentsManager({ MainContainer: this.TabContainer, SPAManage: false });
        this.Task = props.Task;
        this.shadowRoot?.append(this.CustomStyle);
        this.shadowRoot?.append(
            StylesControlsV2.cloneNode(true),
            StyleScrolls.cloneNode(true),
            StylesControlsV3.cloneNode(true),
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
        const commentsActividad = await new CaseTable_Comments_Tasks({ Id_Tarea: this.Task?.Id_Tarea }).Get();
        const commentsContainer = new WCommentsComponent({
            Dataset: commentsActividad,
            ModelObject: new CaseTable_Comments_Tasks(),
            User: WSecurity.UserData,
            UserIdProp: "Id_User",
            CommentsIdentify: this.Task?.Id_Tarea,
            CommentsIdentifyName: "Id_Tarea",
            UrlSearch: "../api/ApiEntityHelpdesk/getCaseTable_Comments_Tasks",
            UrlAdd: "../api/ApiEntityHelpdesk/saveCaseTable_Comments_Tasks"
        });

        const node = html`<div class="card">
                <!-- <div class="thumbnail"><img class="left"
                        src="https://cdn2.hubspot.net/hubfs/322787/Mychefcom/images/BLOG/Header-Blog/photo-culinaire-pexels.jpg" />
                </div> -->
                <div class="right">
                    <h1>${this.Task?.Titulo}</h1>
                    <h3> Estado: (${this.Task.Estado})</h3>                    
                    <div class="authores">
                        ${
                            this.Task?.CaseTable_Participantes.map(I => `<div class="author"><img src="${I.Tbl_Profile?.Foto}" />
                                <h2>${I.Tbl_Profile?.Nombres} ${I.Tbl_Profile?.Apellidos ?? ""}</h2></div>`).join("")
                        }
                    </div>
                    <div class="separator"></div>
                    <p>${this.Task?.Descripcion}</p>
                    <div class="horarios">
                        <h5>Horario</h5>
                        ${
                            this.Task?.CaseTable_Calendario?.map(H => `<div class="horario">
                               del ${H.Fecha_Inicio?.toDateFormatEs()} hasta ${H.Fecha_Final?.toDateFormatEs()}
                            </div>`).join("")
                        }
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
        node.append(WRender.Create({ className: "options", children: [
            { tagName:'input',  type:'button', className: 'Btn-Mini', value: 'Editar', onclick: async ()=>{
               this.taskEdit(this.Task);
            }},{ tagName:'input',  type:'button', className: 'Btn-Mini', value: 'Activar', onclick: async ()=>{
                this.changeState(this.Task, "Activo")                
            }},{ tagName:'input',  type:'button', className: 'Btn-Mini', value: 'En proceso', onclick: async ()=>{
                this.changeState(this.Task, "Proceso")
            }},{ tagName:'input',  type:'button', className: 'Btn-Mini', value: 'Finalizar', onclick: async ()=>{
                this.changeState(this.Task, "Finalizado")
            }},{ tagName:'input',  type:'button', className: 'Btn-Mini', value: 'En espera', onclick: async ()=>{
                this.changeState(this.Task, "Espera")
            }},{ tagName:'input',  type:'button', className: 'Btn-Mini', value: 'Inactivar', onclick: async ()=>{
                this.changeState(this.Task, "Inactivo")
            }}
        ]}),            
            css`
             @import url(https://fonts.googleapis.com/css?family=Roboto);
             @import url('https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css');
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
                height: 40px;
                width: 150px;
                border-radius: 20px;
            }

            .author > img {
                float: left;
                height: 40px;
                width: 40px;
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
            }   
        `)
        return WRender.Create({ className: "container", children: [node, commentsContainer]});
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
        this.TaskModel = new CaseTable_Tareas();
        // @ts-ignore
        this.TaskModel.CaseTable_Calendario = CalendarModel;
        this.shadowRoot?.append(new WModalForm({
            EditObject: task,
            AutoSave: true,            
            title: "Editar",
            ModelObject: this.TaskModel
        }))
    }
    /**
     * 
     * @param {CaseTable_Tareas} task 
     * @param {String} state 
     */
    changeState = async (task, state) => {
        // @ts-ignore
        task.Estado = state;
        const response = await task.Update();        
    }


    CustomStyle = css`
        .component{
           display: block;
        }           
    `
}
customElements.define('w-tarea-detail-component', TareaDetailView);
export { TareaDetailView }