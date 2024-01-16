//@ts-check
import { WRender, ComponentsManager, WAjaxTools, WArrayF } from "../../WDevCore/WModules/WComponentsTools.js";
import { StylesControlsV2, StylesControlsV3, StyleScrolls } from "../../WDevCore/StyleModules/WStyleComponents.js"
import { css } from "../../WDevCore/WModules/WStyledRender.js";
import { Dashboard } from "./Dashboard.js";
import { ColumChart } from "../../WDevCore/WComponents/WChartJSComponents.js";
import { CaseDetailComponent } from "../ProyectViews/Proyectos/CaseDetailComponent.js";
import { CaseTable_Case, CaseTable_Tareas } from "../../ModelProyect/ProyectDataBaseModel.js";
import { TareaDetailView } from "../ProyectViews/Proyectos/TareaDetailView.js";
import { WPaginatorViewer } from "../../WDevCore/WComponents/WPaginatorViewer.js";
/**
 * @typedef {Object} ComponentConfig
 * * @property {Object} [propierty]
 */
class AppDashboardComponentView extends HTMLElement {
    /**
     * 
     * @param {ComponentConfig} props 
     */
    constructor(props) {
        super();
        this.attachShadow({ mode: 'open' });
        this.OptionContainer = WRender.Create({ className: "OptionContainer" });
        this.TabContainer = WRender.Create({ className: "TabContainer", id: 'TabContainer' });
        this.Manager = new ComponentsManager({ MainContainer: this.TabContainer, SPAManage: true });
        this.shadowRoot?.append(this.CustomStyle);
        this.shadowRoot?.append(
            StylesControlsV2.cloneNode(true),
            StyleScrolls.cloneNode(true),
            StylesControlsV3.cloneNode(true),
            this.OptionContainer,
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
        /**@type {Dashboard} */
        // @ts-ignore
        const data = await new Dashboard().GetDasboard();
        const component = WRender.Create({ className: "dashboard-component" });

        const dependencies = WRender.Create({ className: "dashboard-dependencies" });
        const chartCase = WRender.Create({ className: "dashboard-chart-case" });
        const comment = WRender.Create({
            className: "dashboard-comment", children: [
                WRender.CreateStringNode(`<h2>Actividad</h2>`)
            ]
        });

        const caseList = WRender.Create({ className: "dashboard-caseList" });
        const task = WRender.Create({ className: "dashboard-task" });
        const taskContainer = WRender.Create({
            className: "dashboard-task-container", children: [
                WRender.CreateStringNode(`<h2>Tareas asignadas</h2>`), task
            ]
        });

        const dataCase = data.caseTickets.map(element => this.caseView(element))
        // @ts-ignore
        const paginator = new WPaginatorViewer({ Dataset:  dataCase });
        caseList.append(paginator)
        // @ts-ignore
        data.caseTickets.forEach(t => t.Dependencia = t.Cat_Dependencias.Descripcion);
        chartCase.append(new ColumChart({
            Dataset: data.caseTickets,
            AttNameEval: "Estado",
            groupParams: ["Dependencia"],
            Title: "Estado de los casos",
            //TypeChart: "Line",
        }))

        data.comments.forEach(element => {
            comment.append(this.chatView(element));
        });

        data.task.forEach(element => {
            task.append(this.taskView(element));
        });

        data.dependencies.forEach(element => {
            dependencies.append(this.dependencieCards(element));
        });

        component.append(dependencies, chartCase, comment, caseList, taskContainer);
        return component;
    }


    /**
     * @param {import("../../ModelProyect/ProyectDataBaseModel.js").Cat_Dependencias} element
     */
    dependencieCards(element) {
        const card = WRender.CreateStringNode(`<div class="card card-style">
            <div class="top-section">
                <div class="border"></div>
                <div class="icons">
                    <div class="logo">
                    
                    </div>
                </div>
                </div>
                <div class="bottom-section">
                <span class="title">${element.Descripcion}</span>
                <span class="subtitle">${element.Username}</span>
                <div class="row row1">
                    <div class="item">
                        <span class="big-text">${element.NCasos}</span>
                        <span class="regular-text">Casos en proceso</span>
                    </div>
                    <div class="item">
                        <span class="big-text">${element.NCasosFinalizados}</span>
                        <span class="regular-text">Casos finalizados</span>
                    </div>
                    <div class="item">
                        <span class="big-text">${element.CaseTable_Dependencias_Usuarios?.length ?? 0}</span>
                        <span class="regular-text">Miembros activos</span>
                    </div>
                </div>
            </div>
        </div>`);
        card.append(css`
            .card, .card-style {
                width: 400px;
                border-radius: 20px;
                background: #1b233d;
                padding: 5px;
                overflow: hidden;
                box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 20px 0px;
                transition: transform 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                max-height: 300px;
            }

            .card .top-section {
                height: 40px;
                border-radius: 15px;
                display: flex;
                flex-direction: column;
                background: linear-gradient(45deg, rgb(4, 159, 187) 0%, rgb(80, 246, 255) 100%);
                position: relative;
            }

            .card .top-section .border {
                border-bottom-right-radius: 10px;
                height: 30px;
                width: 130px;
                background: white;
                background: #1b233d;
                position: relative;
                transform: skew(-40deg);
                box-shadow: -10px -10px 0 0 #1b233d;
            }

            .card .top-section .border::before {
                content: "";
                position: absolute;
                width: 15px;
                height: 15px;
                top: 0;
                right: -15px;
                background: rgba(255, 255, 255, 0);
                border-top-left-radius: 10px;
                box-shadow: -5px -5px 0 2px #1b233d;
            }

            .card .top-section::before {
                content: "";
                position: absolute;
                top: 30px;
                left: 0;
                background: rgba(255, 255, 255, 0);
                height: 15px;
                width: 15px;
                border-top-left-radius: 15px;
                box-shadow: -5px -5px 0 2px #1b233d;
            }

            .card .top-section .icons {
                position: absolute;
                top: 0;
                width: 100%;
                height: 30px;
                display: flex;
                justify-content: space-between;
            }

            .card .top-section .icons .logo {
                height: 100%;
                aspect-ratio: 1;
                padding: 7px 0 7px 15px;
            }

            .card .top-section .icons .logo .top-section {
                height: 100%;
            }

            .card .top-section .icons .social-media {
                height: 100%;
                padding: 8px 15px;
                display: flex;
                gap: 7px;
            }

            .card .top-section .icons .social-media .svg {
                height: 100%;
                fill: #1b233d;
            }

            .card .top-section .icons .social-media .svg:hover {
                fill: white;
            }

            .card .bottom-section {
                margin-top: 8px;
                padding: 10px 5px;
            }

            .card .bottom-section .title {
                display: block;
                font-size: 17px;
                font-weight: bolder;
                color: white;
                text-align: center;
                letter-spacing: 2px;
            }
            .card .bottom-section .subtitle {
                display: block;
                font-size: 9px;
                font-weight: 400;
                color: white;
                text-align: center;
                letter-spacing: 2px;
            }           

            .card .bottom-section .row {
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }

            .card .bottom-section .row .item {
                flex: 30%;
                text-align: center;
                padding: 5px;
                color: rgba(170, 222, 243, 0.721);
            }

            .card .bottom-section .row .item .big-text {
                font-size: 12px;
                display: block;
            }

            .card .bottom-section .row .item .regular-text {
                font-size: 9px;
            }

            .card .bottom-section .row .item:nth-child(2) {
                border-left: 1px solid rgba(255, 255, 255, 0.126);
                border-right: 1px solid rgba(255, 255, 255, 0.126);
            }    
        `);
        return card;
    }
    /**
     * @param {import("../../ModelProyect/ProyectDataBaseModel.js").CaseTable_Case} element
     */
    caseView(element) {
        return WRender.Create({
            className: "case-detail blog-card", children: [
                WRender.CreateStringNode(`<div class="meta">
                            <div class="photo" style="background-image: url(https://storage.googleapis.com/chydlx/codepen/blog-cards/image-1.jpg)"></div>
                            <ul class="details">
                                <li class="author">${element.Mail}</li>
                                <li class="date">${element.Fecha_Inicio}</li>                          
                            </ul>
                    </div>`), {
                    className: "description", children: [
                        { tagName: "h1", innerHTML: element.Titulo },
                        { tagName: "h2", innerHTML: element.Cat_Dependencias.Descripcion },
                        { tagName: "p", innerHTML: element.Descripcion },
                        {
                            tagName: "a", innerHTML: "Ver detalles", onclick: async () => {
                                const find = await new CaseTable_Case({ Id_Case: element.Id_Case }).Get()
                                const CaseDetail = new CaseDetailComponent(find[0]);
                                this.Manager.NavigateFunction("Detail" + element.Id_Case, CaseDetail)
                            }
                        },
                        css`.blog-card {
                            width: 100%;
                            display: flex;
                            flex-direction: column;
                            margin: 1rem auto;
                            box-shadow: 0 3px 7px -1px rgba(0, 0, 0, 0.1);
                            margin-bottom: 1.6%;
                            background: #fff;
                            line-height: 1.4;
                            font-family: Source Sans Pro;
                            border-radius: 5px;
                            overflow: hidden;
                            z-index: 0;
                            position: relative;
                            font-size: 11px;
                            height: 150px;
                            min-height: 150px;
                        }
                        .blog-card a {
                            color: inherit;
                            cursor: pointer;
                            position: absolute;
                            bottom: 5px;
                            right: 5px;
                        }
                        .blog-card a:hover {
                            color: #5ad67d;
                        }
                        .blog-card:hover .photo {
                            transform: scale(1.3) rotate(3deg);
                        }
                        .blog-card .meta {
                            position: relative;
                            z-index: 0;
                            height: 200px;
                        }
                        .blog-card .photo {
                            position: absolute;
                            top: 0;
                            right: 0;
                            bottom: 0;
                            left: 0;
                            background-size: cover;
                            background-position: center;
                            transition: transform 0.2s;
                        }
                        .blog-card .details,
                        .blog-card .details ul {
                            margin: auto;
                            padding: 0;
                            list-style: none;
                        }
                        .blog-card .details {
                            position: absolute;
                            top: 0;
                            bottom: 0;
                            left: -100%;
                            margin: auto;
                            transition: left 0.2s;
                            background: rgba(0, 0, 0, 0.6);
                            color: #fff;
                            padding: 10px;
                            width: 100%;
                            font-size: 12px;
                            display: flex;
                            flex-direction: column;
                            justify-content: flex-start;
                        }
                        
                        .blog-card .details ul li {
                            display: inline-block;
                            list-style: none;
                        }
                        
                        
                        .blog-card .details .tags li {
                            margin-right: 2px;
                        }
                        .blog-card .details .tags li:first-child {
                            margin-left: -4px;
                        }
                        .blog-card .description {
                            padding: 1rem;
                            background: #fff;
                            position: relative;
                            z-index: 1;
                            max-width: 360px;
                            overflow: hidden;
                        }
                        .blog-card .description h1,
                        .blog-card .description h2 {
                            font-family: Source Sans Pro;
                        }
                        .blog-card .description h1 {
                            line-height: 1;
                            margin: 0;
                            font-size: 13px;
                        }
                        .blog-card .description h2 {
                            font-size: 12px;
                            font-weight: 300;
                            text-transform: uppercase;
                            color: #a2a2a2;
                            margin: 5px 0px;

                        }
                        .blog-card .description .read-more {
                            text-align: right;
                        }
                        .blog-card .description .read-more a {
                            color: #5ad67d;
                            display: inline-block;                            
                        }
                        .blog-card .description .read-more a:after {
                            content: "";
                            font-family: FontAwesome;
                            margin-left: -10px;
                            opacity: 0;
                            vertical-align: middle;
                            transition: margin 0.3s, opacity 0.3s;
                        }
                        .blog-card .description .read-more a:hover:after {
                            margin-left: 5px;
                            opacity: 1;
                        }
                        .blog-card p {
                            position: relative;
                            margin: 5px 0 0;
                            text-overflow: ellipsis;
                            white-space: nowrap;
                            overflow: hidden;
                            max-height: 80px;
                            font-size: 9px !important;
                            text-transform: lowercase !important;
                        }                       
                        .blog-card p:first-of-type:before {
                            content: "";
                            height: 5px;
                            display: block;
                            background: #5ad67d;
                            width: 35px;
                            border-radius: 3px;
                            margin-bottom:5px;
                        }
                        .blog-card:hover .details {
                            left: 0%;
                        }
                        @media (min-width: 640px) {
                            .blog-card {
                                flex-direction: row;
                                max-width: 700px;
                            }
                            .blog-card .meta {
                                flex-basis: 40%;
                                height: auto;
                            }
                            .blog-card .description {
                                flex-basis: 60%;
                            }                            
                            .blog-card.alt {
                                flex-direction: row-reverse;
                            }
                            .blog-card.alt .description:before {
                                left: inherit;
                                right: -10px;
                                transform: skew(3deg);
                            }
                            .blog-card.alt .details {
                                padding-left: 25px;
                            }
                        }
                        `
                    ]
                }


            ]
        });
    }

    /**
     * @param {import("../../ModelProyect/ProyectDataBaseModel.js").CaseTable_Comments} element
     */
    chatView(element) {
        return WRender.Create({
            className: "case-dependencie cookieCard", children: [
                { tagName: "p", className: "cookieHeading", innerHTML: element.NickName },
                { tagName: "p", className: "cookieDescription", innerHTML: element.Body?.replaceAll("<br>", "") ?? "adjunto" },
                {
                    tagName: 'input', type: 'button', className: 'acceptButton', value: 'ver', onclick: async () => {
                        //const find = await new CaseTable_Tareas({ Id_Tarea: element.Id_Tarea }).Get()
                        //const CaseDetail = new TareaDetailView({ Task: find[0] });
                        //this.Manager.NavigateFunction("Detail" + element.Id_Tarea, CaseDetail)

                        const find = await new CaseTable_Case({ Id_Case: element.Id_Case }).Get()
                        const CaseDetail = new CaseDetailComponent(find[0]);
                        this.Manager.NavigateFunction("Detail" + element.Id_Case, CaseDetail)
                    }
                }, css`
                        .cookieCard {
                            width: 300px;
                            height:120px;
                            min-height:80px;
                            background: linear-gradient(to right,rgb(137, 104, 255),rgb(175, 152, 255));
                            display: flex;
                            flex-direction: column;
                            align-items: flex-start;
                            justify-content: flex-start;
                            gap: 5px;
                            padding: 10px;
                            position: relative;
                            overflow: hidden;
                            position: relative;
                            border-radius: 5px;
                        }

                        .cookieCard::before {
                            width: 150px;
                            height: 150px;
                            content: "";
                            background: linear-gradient(to right,rgb(142, 110, 255),rgb(208, 195, 255));
                            position: absolute;
                            z-index: 1;
                            border-radius: 50%;
                            right: -25%;
                            top: -25%;
                            }

                        .cookieHeading {
                            font-size: 12px;
                            padding: 0px;
                            margin: 5px;
                            font-weight: 600;
                            color: rgb(241, 241, 241);
                            z-index: 2;
                            }

                        .cookieDescription {
                            font-size: 0.9em;
                            color: rgb(241, 241, 241);
                            z-index: 2;
                            padding: 0px;
                            margin: 0px;
                            text-overflow: ellipsis;
                            white-space: nowrap;
                            overflow: hidden;
                            width: calc(100% - 40px);
                            }

                        .cookieDescription *{
                            appearance: none;
                            margin: 0px;
                            padding: 0px;
                            text-overflow: ellipsis;
                            white-space: nowrap;
                            overflow: hidden;
                        }

                        .cookieDescription a {
                            color: rgb(241, 241, 241);
                            }

                        .acceptButton {
                            padding: 5px 10px;
                            background-color: #7b57ff;
                            transition-duration: .2s;
                            border: none;
                            color: rgb(241, 241, 241);
                            cursor: pointer;
                            font-weight: 600;
                            z-index: 2;
                            position: absolute;
                            right: 10px;
                            bottom: 10px;
                            }

                        .acceptButton:hover {
                            background-color: #714aff;
                            transition-duration: .2s;
                            }
                    `
            ]
        });
    }
    /**
     * @param {import("../../ModelProyect/ProyectDataBaseModel.js").CaseTable_Tareas} element
     */
    taskView(element) {
        return WRender.Create({
            className: "task", children: [
                {
                    className: "tags", children: [
                        { tagName: "span", className: "tag", innerHTML: "Tarea de: " + element.CaseTable_Case.Titulo },
                        {
                            tagName: 'button', className: 'options', children: [WRender.CreateStringNode(`<div><svg xml:space="preserve" viewBox="0 0 41.915 41.916" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg" id="Capa_1" version="1.1" fill="#000000"><g stroke-width="0" id="SVGRepo_bgCarrier"></g><g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier"></g><g id="SVGRepo_iconCarrier"><g><g><path d="M11.214,20.956c0,3.091-2.509,5.589-5.607,5.589C2.51,26.544,0,24.046,0,20.956c0-3.082,2.511-5.585,5.607-5.585 C8.705,15.371,11.214,17.874,11.214,20.956z"></path> <path d="M26.564,20.956c0,3.091-2.509,5.589-5.606,5.589c-3.097,0-5.607-2.498-5.607-5.589c0-3.082,2.511-5.585,5.607-5.585 C24.056,15.371,26.564,17.874,26.564,20.956z"></path> <path d="M41.915,20.956c0,3.091-2.509,5.589-5.607,5.589c-3.097,0-5.606-2.498-5.606-5.589c0-3.082,2.511-5.585,5.606-5.585 C39.406,15.371,41.915,17.874,41.915,20.956z"></path></g></g></g></svg></div>`)],
                            onclick: async () => {
                                //code.....
                            }
                        }
                    ]
                }, {
                    tagName: "label", className: "labelheader", innerHTML: element.Titulo
                }, {
                    tagName: "p", className: "", innerHTML: element.Descripcion
                }, {
                    className: "stats", children: [
                        [
                            WRender.CreateStringNode(`<div><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><g stroke-width="0" id="SVGRepo_bgCarrier"></g><g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier"></g><g id="SVGRepo_iconCarrier"> <path stroke-linecap="round" stroke-width="2" d="M12 8V12L15 15"></path> <circle stroke-width="2" r="9" cy="12" cx="12"></circle> </g></svg>
                                ${new Date(element.Fecha_Inicio).toLocaleDateString()}</div>`),
                            //WRender.CreateStringNode(`<div><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><g stroke-width="0" id="SVGRepo_bgCarrier"></g><g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier"></g><g id="SVGRepo_iconCarrier"> <path stroke-linejoin="round" stroke-linecap="round" stroke-width="1.5" d="M16 10H16.01M12 10H12.01M8 10H8.01M3 10C3 4.64706 5.11765 3 12 3C18.8824 3 21 4.64706 21 10C21 15.3529 18.8824 17 12 17C11.6592 17 11.3301 16.996 11.0124 16.9876L7 21V16.4939C4.0328 15.6692 3 13.7383 3 10Z"></path> </g></svg>18</div>`),
                            //WRender.CreateStringNode(`<div><svg fill="#000000" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="-2.5 0 32 32"><g stroke-width="0" id="SVGRepo_bgCarrier"></g><g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier"></g><g id="SVGRepo_iconCarrier"> <g id="icomoon-ignore"> </g> <path fill="#000000" d="M0 10.284l0.505 0.36c0.089 0.064 0.92 0.621 2.604 0.621 0.27 0 0.55-0.015 0.836-0.044 3.752 4.346 6.411 7.472 7.060 8.299-1.227 2.735-1.42 5.808-0.537 8.686l0.256 0.834 7.63-7.631 8.309 8.309 0.742-0.742-8.309-8.309 7.631-7.631-0.834-0.255c-2.829-0.868-5.986-0.672-8.686 0.537-0.825-0.648-3.942-3.3-8.28-7.044 0.11-0.669 0.23-2.183-0.575-3.441l-0.352-0.549-8.001 8.001zM1.729 10.039l6.032-6.033c0.385 1.122 0.090 2.319 0.086 2.334l-0.080 0.314 0.245 0.214c7.409 6.398 8.631 7.39 8.992 7.546l-0.002 0.006 0.195 0.058 0.185-0.087c2.257-1.079 4.903-1.378 7.343-0.836l-13.482 13.481c-0.55-2.47-0.262-5.045 0.837-7.342l0.104-0.218-0.098-0.221-0.031 0.013c-0.322-0.632-1.831-2.38-7.498-8.944l-0.185-0.215-0.282 0.038c-0.338 0.045-0.668 0.069-0.981 0.069-0.595 0-1.053-0.083-1.38-0.176z"> </path> </g></svg>7</div>`),
                            {
                                className: "viewer", children: element.CaseTable_Participantes.map(I =>
                                ({
                                    tagName: 'img', className: "img-participantes",
                                    src: "" + I.Tbl_Profile?.Foto
                                }))// [
                                // WRender.CreateStringNode(`<span><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><g stroke-width="0" id="SVGRepo_bgCarrier"></g><g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier"></g><g id="SVGRepo_iconCarrier"> <path stroke-width="2" stroke="#ffffff" d="M17 8C17 10.7614 14.7614 13 12 13C9.23858 13 7 10.7614 7 8C7 5.23858 9.23858 3 12 3C14.7614 3 17 5.23858 17 8Z"></path> <path stroke-linecap="round" stroke-width="2" stroke="#ffffff" d="M3 21C3.95728 17.9237 6.41998 17 12 17C17.58 17 20.0427 17.9237 21 21"></path> </g></svg>`),
                                // WRender.CreateStringNode(`<span><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><g stroke-width="0" id="SVGRepo_bgCarrier"></g><g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier"></g><g id="SVGRepo_iconCarrier"> <path stroke-width="2" stroke="#ffffff" d="M17 8C17 10.7614 14.7614 13 12 13C9.23858 13 7 10.7614 7 8C7 5.23858 9.23858 3 12 3C14.7614 3 17 5.23858 17 8Z"></path> <path stroke-linecap="round" stroke-width="2" stroke="#ffffff" d="M3 21C3.95728 17.9237 6.41998 17 12 17C17.58 17 20.0427 17.9237 21 21"></path> </g></svg>`),
                                // WRender.CreateStringNode(`<span><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><g stroke-width="0" id="SVGRepo_bgCarrier"></g><g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier"></g><g id="SVGRepo_iconCarrier"> <path stroke-width="2" stroke="#ffffff" d="M17 8C17 10.7614 14.7614 13 12 13C9.23858 13 7 10.7614 7 8C7 5.23858 9.23858 3 12 3C14.7614 3 17 5.23858 17 8Z"></path> <path stroke-linecap="round" stroke-width="2" stroke="#ffffff" d="M3 21C3.95728 17.9237 6.41998 17 12 17C17.58 17 20.0427 17.9237 21 21"></path> </g></svg>`)
                                //]
                            }, {
                                tagName: "a", innerHTML: "Ver detalles", onclick: async () => {
                                    const find = await new CaseTable_Tareas({ Id_Tarea: element.Id_Tarea }).Get()
                                    const CaseDetail = new TareaDetailView({ Task: find[0] });
                                    this.Manager.NavigateFunction("Detail" + element.Id_Tarea, CaseDetail)
                                }
                            }
                        ]
                    ]
                }, css`
                .task {
                    position: relative;
                    color: #2e2e2f;
                    cursor: move;
                    background-color: #fff;
                    padding: 1rem;
                    border-radius: 8px;
                    box-shadow: rgba(99, 99, 99, 0.1) 0px 2px 8px 0px;
                    margin-bottom: 1rem;
                    border: 3px dashed transparent;
                    min-width: 350px;
                    border: solid #e6e6e6 1px;
                    min-height: 150px;
                    height: 150px;
                    display: grid;
                    grid-template-rows: 30px 20px 60px 40px;
                  }
                  .labelheader {
                    margin: 10px 0px;
                    display: block;
                    font-size: 14px;
                    font-weight: 600;
                    text-transform: capitalize;
                  }
                  
                  .task:hover {
                    box-shadow: rgba(99, 99, 99, 0.3) 0px 2px 8px 0px;
                    border-color: rgba(162, 179, 207, 0.2) !important;
                  }
                  
                  .task p {
                    font-size: 13px;
                    margin: 10px 0;
                    text-overflow: ellipsis;
                    white-space: nowrap;
                    overflow: hidden;
                  }
                  
                  .tag {
                    border-radius: 100px;
                    padding: 4px 13px;
                    font-size: 12px;
                    color: #ffffff;
                    background-color: #1389eb;
                  }
                  
                  .tags {
                    width: 100%;
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                  }
                  
                  .options {
                    background: transparent;
                    border: 0;
                    color: #c4cad3;
                    font-size: 17px;
                  }
                  
                  .options svg {
                    fill: #9fa4aa;
                    width: 20px;
                  }
                  
                  .stats {
                    position: relative;
                    width: 100%;
                    color: #9fa4aa;
                    font-size: 12px;
                    display: flex;
                    align-items: center;
                    justify-content: space-between;                   
                  }
                  .viewer {
                    justify-content: flex-end;
                  }
                  .stats div {
                    margin-right: 1rem;
                    height: 20px;
                    display: flex;
                    align-items: center;
                    cursor: pointer;
                    width: 100%;
                  }
                  
                  .stats svg {
                    margin-right: 5px;
                    height: 100%;
                    stroke: #9fa4aa;
                  }
                  
                  .viewer .img-participantes {
                    height: 30px;
                    width: 30px;
                    background-color: rgb(28, 117, 219);
                    margin-right: -10px;
                    border-radius: 50%;
                    border: 1px solid #fff;
                    display: grid;
                    align-items: center;
                    text-align: center;
                    font-weight: bold;
                    color: #fff;
                    padding: 2px;
                  }
                  
                  .viewer span svg {
                    stroke: #fff;
                  }                  
                    `
            ]
        });
    }
    CustomStyle = css`
        .dashboard-component{
           display: grid;
           grid-template-columns: 400px calc(100% - 800px) 350px;
           grid-template-rows: 350px 350px;
           gap: 20px;
        }  
        .dashboard-component h2{
            font-size:16px;
            margin: 8px 0px;
        }       
        .dashboard-dependencies,
        .dashboard-comment,
        .dashboard-caseList,
        .dashboard-task {
            display: flex;
            gap: 5px; 
            flex-direction: column;
            height: 100%;
            overflow: auto;
            max-height: 350px;
        } 
        .dashboard-task-container {
            grid-column: span 2;
        }
        .dashboard-dependencies{
            flex-direction: row;
            flex-wrap: wrap;
        }    
        .dashboard-task{
            flex-direction: row;
            flex-wrap: wrap;
            max-height: 300px;
        }    
        .dashboard-comment h2 {
            position: sticky;
            position: -webkit-sticky;
            top: 0; /* required */
            z-index: 3;
            background-color: #fff;
        }        
    `
}
customElements.define('w-app-dasboard', AppDashboardComponentView);
export { AppDashboardComponentView }