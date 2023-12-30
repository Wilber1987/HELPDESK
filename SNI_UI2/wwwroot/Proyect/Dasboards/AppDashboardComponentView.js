//@ts-check
import { WRender, ComponentsManager, WAjaxTools, WArrayF } from "../../WDevCore/WModules/WComponentsTools.js";
import { StylesControlsV2, StylesControlsV3, StyleScrolls } from "../../WDevCore/StyleModules/WStyleComponents.js"
import { css } from "../../WDevCore/WModules/WStyledRender.js";
import { Dashboard } from "./Dashboard.js";
import { ColumChart } from "../../WDevCore/WComponents/WChartJSComponents.js";
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
        this.Manager = new ComponentsManager({ MainContainer: this.TabContainer, SPAManage: false });
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
            onclick: async () => this.Manager.NavigateFunction("id", await this.CreateDasboard())
        }))
        this.Manager.NavigateFunction("id", await this.CreateDasboard());
    }
    async CreateDasboard() {
        /**@type {Dashboard} */
        // @ts-ignore
        const data = await new Dashboard().Get();
        const component = WRender.Create({ className: "dashboard-component" });

        const dependencies = WRender.Create({ className: "dashboard-dependencies" });
        const chartCase = WRender.Create({ className: "dashboard-chart-case" });
        const comment = WRender.Create({ className: "dashboard-comment" , children: [
            WRender.CreateStringNode(`<h2>Comentarios</h2>`)
        ] });

        const caseList = WRender.Create({ className: "dashboard-caseList" });
        const task = WRender.Create({ className: "dashboard-task" });


        data.caseTickets.forEach(element => {
            caseList.append(WRender.CreateStringNode(`<div class="case-detail blog-card">
                <div class="meta">
                <div class="photo" style="background-image: url(https://storage.googleapis.com/chydlx/codepen/blog-cards/image-1.jpg)"></div>
                <ul class="details">
                  <li class="author"><a href="#">${element.Descripcion}</a></li>
                  <li class="date">${element.Descripcion}</li>
                  <li class="tags">
                    <ul>
                      <li><a href="#">${element.Descripcion}</a></li>
                      <li><a href="#">${element.Descripcion}</a></li>
                      <li><a href="#">${element.Descripcion}</a></li>
                      <li><a href="#">${element.Descripcion}</a></li>
                    </ul>
                  </li>
                </ul>
              </div>
              <div class="description">
                <h1>${element.Descripcion}</h1>
                <h2>${element.Descripcion}</h2>
                <p> ${element.Descripcion}</p>
                <p class="read-more">
                  <a href="#">Read More</a>
                </p>
              </div>
            </div>`));
        });
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
            dependencies.append(WRender.CreateStringNode(`<div class="card card-style">
                <div class="top-section">
                    <div class="border"></div>
                    <div class="icons">
                        <div class="logo">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 94 94" class="svg">
                            <path fill="white" d="M38.0481 4.82927C38.0481 2.16214 40.018 0 42.4481 0H51.2391C53.6692 0 55.6391 2.16214 55.6391 4.82927V40.1401C55.6391 48.8912 53.2343 55.6657 48.4248 60.4636C43.6153 65.2277 36.7304 67.6098 27.7701 67.6098C18.8099 67.6098 11.925 65.2953 7.11548 60.6663C2.37183 56.0036 3.8147e-06 49.2967 3.8147e-06 40.5456V4.82927C3.8147e-06 2.16213 1.96995 0 4.4 0H13.2405C15.6705 0 17.6405 2.16214 17.6405 4.82927V39.1265C17.6405 43.7892 18.4805 47.2018 20.1605 49.3642C21.8735 51.5267 24.4759 52.6079 27.9678 52.6079C31.4596 52.6079 34.0127 51.5436 35.6268 49.4149C37.241 47.2863 38.0481 43.8399 38.0481 39.0758V4.82927Z"></path>
                            <path fill="white" d="M86.9 61.8682C86.9 64.5353 84.9301 66.6975 82.5 66.6975H73.6595C71.2295 66.6975 69.2595 64.5353 69.2595 61.8682V4.82927C69.2595 2.16214 71.2295 0 73.6595 0H82.5C84.9301 0 86.9 2.16214 86.9 4.82927V61.8682Z"></path>
                            <path fill="white" d="M2.86102e-06 83.2195C2.86102e-06 80.5524 1.96995 78.3902 4.4 78.3902H83.6C86.0301 78.3902 88 80.5524 88 83.2195V89.1707C88 91.8379 86.0301 94 83.6 94H4.4C1.96995 94 0 91.8379 0 89.1707L2.86102e-06 83.2195Z"></path>
                        </svg>
                        </div>
                        <div class="social-media">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 30" class="svg">
                            <path d="M 9.9980469 3 C 6.1390469 3 3 6.1419531 3 10.001953 L 3 20.001953 C 3 23.860953 6.1419531 27 10.001953 27 L 20.001953 27 C 23.860953 27 27 23.858047 27 19.998047 L 27 9.9980469 C 27 6.1390469 23.858047 3 19.998047 3 L 9.9980469 3 z M 22 7 C 22.552 7 23 7.448 23 8 C 23 8.552 22.552 9 22 9 C 21.448 9 21 8.552 21 8 C 21 7.448 21.448 7 22 7 z M 15 9 C 18.309 9 21 11.691 21 15 C 21 18.309 18.309 21 15 21 C 11.691 21 9 18.309 9 15 C 9 11.691 11.691 9 15 9 z M 15 11 A 4 4 0 0 0 11 15 A 4 4 0 0 0 15 19 A 4 4 0 0 0 19 15 A 4 4 0 0 0 15 11 z"></path>
                        </svg>
                        <svg class="svg" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                            <path d="M459.37 151.716c.325 4.548.325 9.097.325 13.645 0 138.72-105.583 298.558-298.558 298.558-59.452 0-114.68-17.219-161.137-47.106 8.447.974 16.568 1.299 25.34 1.299 49.055 0 94.213-16.568 130.274-44.832-46.132-.975-84.792-31.188-98.112-72.772 6.498.974 12.995 1.624 19.818 1.624 9.421 0 18.843-1.3 27.614-3.573-48.081-9.747-84.143-51.98-84.143-102.985v-1.299c13.969 7.797 30.214 12.67 47.431 13.319-28.264-18.843-46.781-51.005-46.781-87.391 0-19.492 5.197-37.36 14.294-52.954 51.655 63.675 129.3 105.258 216.365 109.807-1.624-7.797-2.599-15.918-2.599-24.04 0-57.828 46.782-104.934 104.934-104.934 30.213 0 57.502 12.67 76.67 33.137 23.715-4.548 46.456-13.32 66.599-25.34-7.798 24.366-24.366 44.833-46.132 57.827 21.117-2.273 41.584-8.122 60.426-16.243-14.292 20.791-32.161 39.308-52.628 54.253z"></path>
                        </svg>
                        <svg class="svg" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
                            <path d="M524.531,69.836a1.5,1.5,0,0,0-.764-.7A485.065,485.065,0,0,0,404.081,32.03a1.816,1.816,0,0,0-1.923.91,337.461,337.461,0,0,0-14.9,30.6,447.848,447.848,0,0,0-134.426,0,309.541,309.541,0,0,0-15.135-30.6,1.89,1.89,0,0,0-1.924-.91A483.689,483.689,0,0,0,116.085,69.137a1.712,1.712,0,0,0-.788.676C39.068,183.651,18.186,294.69,28.43,404.354a2.016,2.016,0,0,0,.765,1.375A487.666,487.666,0,0,0,176.02,479.918a1.9,1.9,0,0,0,2.063-.676A348.2,348.2,0,0,0,208.12,430.4a1.86,1.86,0,0,0-1.019-2.588,321.173,321.173,0,0,1-45.868-21.853,1.885,1.885,0,0,1-.185-3.126c3.082-2.309,6.166-4.711,9.109-7.137a1.819,1.819,0,0,1,1.9-.256c96.229,43.917,200.41,43.917,295.5,0a1.812,1.812,0,0,1,1.924.233c2.944,2.426,6.027,4.851,9.132,7.16a1.884,1.884,0,0,1-.162,3.126,301.407,301.407,0,0,1-45.89,21.83,1.875,1.875,0,0,0-1,2.611,391.055,391.055,0,0,0,30.014,48.815,1.864,1.864,0,0,0,2.063.7A486.048,486.048,0,0,0,610.7,405.729a1.882,1.882,0,0,0,.765-1.352C623.729,277.594,590.933,167.465,524.531,69.836ZM222.491,337.58c-28.972,0-52.844-26.587-52.844-59.239S193.056,219.1,222.491,219.1c29.665,0,53.306,26.82,52.843,59.239C275.334,310.993,251.924,337.58,222.491,337.58Zm195.38,0c-28.971,0-52.843-26.587-52.843-59.239S388.437,219.1,417.871,219.1c29.667,0,53.307,26.82,52.844,59.239C470.715,310.993,447.538,337.58,417.871,337.58Z"></path>
                        </svg>
                        </div>
                    </div>
                    </div>
                    <div class="bottom-section">
                    <span class="title">UNIVERSE OF UI</span>
                    <div class="row row1">
                        <div class="item">
                        <span class="big-text">2626</span>
                        <span class="regular-text">UI elements</span>
                        </div>
                        <div class="item">
                        <span class="big-text">100%</span>
                        <span class="regular-text">Free for use</span>
                        </div>
                        <div class="item">
                        <span class="big-text">38,631</span>
                        <span class="regular-text">Contributers</span>
                        </div>
                    </div>
                </div>
            </div>`));
        });

        component.append(dependencies, chartCase, comment, caseList, task);
        return component;
    }


    chatView(element) {
        return WRender.Create({
            className: "case-dependencie cookieCard", children: [
                { tagName: "p", className: "cookieHeading", innerHTML: element.NickName },
                { tagName: "p", className: "cookieDescription", innerHTML: element.Body?.replaceAll("<br>", "") },
                {
                    tagName: 'input', type: 'button', className: 'acceptButton', value: 'ver', onclick: async () => {
                        //code.....
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
    taskView(element) {
        return WRender.Create({
            className: "task", children: [
                {
                    className: "tags", children: [
                        { tagName: "span", className: "tag", innerHTML: "test" },
                        {
                            tagName: 'button', className: 'options', children: [WRender.CreateStringNode(`<div><svg xml:space="preserve" viewBox="0 0 41.915 41.916" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg" id="Capa_1" version="1.1" fill="#000000"><g stroke-width="0" id="SVGRepo_bgCarrier"></g><g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier"></g><g id="SVGRepo_iconCarrier"><g><g><path d="M11.214,20.956c0,3.091-2.509,5.589-5.607,5.589C2.51,26.544,0,24.046,0,20.956c0-3.082,2.511-5.585,5.607-5.585 C8.705,15.371,11.214,17.874,11.214,20.956z"></path> <path d="M26.564,20.956c0,3.091-2.509,5.589-5.606,5.589c-3.097,0-5.607-2.498-5.607-5.589c0-3.082,2.511-5.585,5.607-5.585 C24.056,15.371,26.564,17.874,26.564,20.956z"></path> <path d="M41.915,20.956c0,3.091-2.509,5.589-5.607,5.589c-3.097,0-5.606-2.498-5.606-5.589c0-3.082,2.511-5.585,5.606-5.585 C39.406,15.371,41.915,17.874,41.915,20.956z"></path></g></g></g></svg></div>`)],
                            onclick: async () => {
                                //code.....
                            }
                        }
                    ]
                }, {
                    tagName: "p", className: "", innerHTML: element.NickName
                }, {
                    className: "stats", children: [
                        [
                            WRender.CreateStringNode(`<div><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><g stroke-width="0" id="SVGRepo_bgCarrier"></g><g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier"></g><g id="SVGRepo_iconCarrier"> <path stroke-linecap="round" stroke-width="2" d="M12 8V12L15 15"></path> <circle stroke-width="2" r="9" cy="12" cx="12"></circle> </g></svg>"Feb 24"</div>`),
                            WRender.CreateStringNode(`<div><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><g stroke-width="0" id="SVGRepo_bgCarrier"></g><g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier"></g><g id="SVGRepo_iconCarrier"> <path stroke-linejoin="round" stroke-linecap="round" stroke-width="1.5" d="M16 10H16.01M12 10H12.01M8 10H8.01M3 10C3 4.64706 5.11765 3 12 3C18.8824 3 21 4.64706 21 10C21 15.3529 18.8824 17 12 17C11.6592 17 11.3301 16.996 11.0124 16.9876L7 21V16.4939C4.0328 15.6692 3 13.7383 3 10Z"></path> </g></svg>18</div>`),
                            WRender.CreateStringNode(`<div><svg fill="#000000" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="-2.5 0 32 32"><g stroke-width="0" id="SVGRepo_bgCarrier"></g><g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier"></g><g id="SVGRepo_iconCarrier"> <g id="icomoon-ignore"> </g> <path fill="#000000" d="M0 10.284l0.505 0.36c0.089 0.064 0.92 0.621 2.604 0.621 0.27 0 0.55-0.015 0.836-0.044 3.752 4.346 6.411 7.472 7.060 8.299-1.227 2.735-1.42 5.808-0.537 8.686l0.256 0.834 7.63-7.631 8.309 8.309 0.742-0.742-8.309-8.309 7.631-7.631-0.834-0.255c-2.829-0.868-5.986-0.672-8.686 0.537-0.825-0.648-3.942-3.3-8.28-7.044 0.11-0.669 0.23-2.183-0.575-3.441l-0.352-0.549-8.001 8.001zM1.729 10.039l6.032-6.033c0.385 1.122 0.090 2.319 0.086 2.334l-0.080 0.314 0.245 0.214c7.409 6.398 8.631 7.39 8.992 7.546l-0.002 0.006 0.195 0.058 0.185-0.087c2.257-1.079 4.903-1.378 7.343-0.836l-13.482 13.481c-0.55-2.47-0.262-5.045 0.837-7.342l0.104-0.218-0.098-0.221-0.031 0.013c-0.322-0.632-1.831-2.38-7.498-8.944l-0.185-0.215-0.282 0.038c-0.338 0.045-0.668 0.069-0.981 0.069-0.595 0-1.053-0.083-1.38-0.176z"> </path> </g></svg>7</div>`),
                            {
                                className: "viewer", children: [
                                    WRender.CreateStringNode(`<span><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><g stroke-width="0" id="SVGRepo_bgCarrier"></g><g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier"></g><g id="SVGRepo_iconCarrier"> <path stroke-width="2" stroke="#ffffff" d="M17 8C17 10.7614 14.7614 13 12 13C9.23858 13 7 10.7614 7 8C7 5.23858 9.23858 3 12 3C14.7614 3 17 5.23858 17 8Z"></path> <path stroke-linecap="round" stroke-width="2" stroke="#ffffff" d="M3 21C3.95728 17.9237 6.41998 17 12 17C17.58 17 20.0427 17.9237 21 21"></path> </g></svg>`),
                                    WRender.CreateStringNode(`<span><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><g stroke-width="0" id="SVGRepo_bgCarrier"></g><g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier"></g><g id="SVGRepo_iconCarrier"> <path stroke-width="2" stroke="#ffffff" d="M17 8C17 10.7614 14.7614 13 12 13C9.23858 13 7 10.7614 7 8C7 5.23858 9.23858 3 12 3C14.7614 3 17 5.23858 17 8Z"></path> <path stroke-linecap="round" stroke-width="2" stroke="#ffffff" d="M3 21C3.95728 17.9237 6.41998 17 12 17C17.58 17 20.0427 17.9237 21 21"></path> </g></svg>`),
                                    WRender.CreateStringNode(`<span><svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><g stroke-width="0" id="SVGRepo_bgCarrier"></g><g stroke-linejoin="round" stroke-linecap="round" id="SVGRepo_tracerCarrier"></g><g id="SVGRepo_iconCarrier"> <path stroke-width="2" stroke="#ffffff" d="M17 8C17 10.7614 14.7614 13 12 13C9.23858 13 7 10.7614 7 8C7 5.23858 9.23858 3 12 3C14.7614 3 17 5.23858 17 8Z"></path> <path stroke-linecap="round" stroke-width="2" stroke="#ffffff" d="M3 21C3.95728 17.9237 6.41998 17 12 17C17.58 17 20.0427 17.9237 21 21"></path> </g></svg>`)
                                ]
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
                    max-width: 350px;
                    border: solid #e6e6e6 1px;
                    max-height: 150px;
                  }
                  
                  .task:hover {
                    box-shadow: rgba(99, 99, 99, 0.3) 0px 2px 8px 0px;
                    border-color: rgba(162, 179, 207, 0.2) !important;
                  }
                  
                  .task p {
                    font-size: 15px;
                    margin: 1.2rem 0;
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
                  
                  .stats div {
                    margin-right: 1rem;
                    height: 20px;
                    display: flex;
                    align-items: center;
                    cursor: pointer;
                  }
                  
                  .stats svg {
                    margin-right: 5px;
                    height: 100%;
                    stroke: #9fa4aa;
                  }
                  
                  .viewer span {
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
        @import url(https://fonts.googleapis.com/css?family=Source+Sans+Pro:500);
        @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css');
        .dashboard-component{
           display: grid;
           grid-template-columns: 400px calc(100% - 800px) 350px;
           grid-template-rows: 350px 350px;
           gap: 20px;
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
            max-height: 500px;
        } 
        .dashboard-task {
            grid-column: span 2;
        }
        .dashboard-dependencies{
            flex-direction: row;
        }    
        .dashboard-task{
            flex-direction: row;
            flex-wrap: wrap;
        }    
        .dashboard-comment h2 {
            position: sticky;
            position: -webkit-sticky;
            top: 0; /* required */
            z-index: 3;
            background-color: #fff;
        } 
        /**BLOGCARD 1 */          
        .blog-card {
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
        }
        .blog-card a {
        color: inherit;
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
        font-size: 0.9rem;
        }
        .blog-card .details a {
        -webkit-text-decoration: dotted underline;
                text-decoration: dotted underline;
        }
        .blog-card .details ul li {
        display: inline-block;
        }
        .blog-card .details .author:before {
        font-family: FontAwesome;
        margin-right: 10px;
        content: "";
        }
        .blog-card .details .date:before {
        font-family: FontAwesome;
        margin-right: 10px;
        content: "";
        }
        .blog-card .details .tags ul:before {
        font-family: FontAwesome;
        content: "";
        margin-right: 10px;
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
        }
        .blog-card .description h1,
        .blog-card .description h2 {
        font-family: Source Sans Pro;
        }
        .blog-card .description h1 {
        line-height: 1;
        margin: 0;
        font-size: 1.7rem;
        }
        .blog-card .description h2 {
        font-size: 1rem;
        font-weight: 300;
        text-transform: uppercase;
        color: #a2a2a2;
        margin-top: 5px;
        }
        .blog-card .description .read-more {
        text-align: right;
        }
        .blog-card .description .read-more a {
        color: #5ad67d;
        display: inline-block;
        position: relative;
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
        margin: 1rem 0 0;
        }
        .blog-card p:first-of-type {
        margin-top: 1.25rem;
        }
        .blog-card p:first-of-type:before {
        content: "";
        position: absolute;
        height: 5px;
        background: #5ad67d;
        width: 35px;
        top: -0.75rem;
        border-radius: 3px;
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
        .blog-card .description:before {
            transform: skewX(-3deg);
            content: "";
            background: #fff;
            width: 30px;
            position: absolute;
            left: -10px;
            top: 0;
            bottom: 0;
            z-index: -1;
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
        /**card 2 */

       
        /**cards */
        .card, .card-style {
        width: 230px;
        border-radius: 20px;
        background: #1b233d;
        padding: 5px;
        overflow: hidden;
        box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 20px 0px;
        transition: transform 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        max-height: 300px;
        }

        .card .top-section {
        height: 150px;
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
        margin-top: 15px;
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
    `
}
customElements.define('w-app-dasboard', AppDashboardComponentView);
export { AppDashboardComponentView }