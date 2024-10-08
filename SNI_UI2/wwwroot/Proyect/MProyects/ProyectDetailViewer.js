import { StylesControlsV1 } from "../../WDevCore/StyleModules/WStyleComponents.js";
import { WRender } from '../../WDevCore/WModules/WComponentsTools.js';
import { WCssClass } from '../../WDevCore/WModules/WStyledRender.js';
import { ActionFunction } from '../Home.js';


class ProyectDetailViewer extends HTMLElement {
    constructor(response, DOMManager) {
        super();        
        this.DOMManager = DOMManager;
        this.response = response[0];
        this.ProyectContainer = WRender.createElement({ type: 'div', props: { class: 'ProyectContainer' }, children: [] });
        this.appendChild(WRender.createElement(StylesControlsV1));
        const BtnReturn = WRender.Create({
            className: "GroupOptions", children: [{
                tagName: 'input', type: 'button', className: 'BtnSuccess BtnReturn', value: 'Regresar', onclick: async () => {
                    this.DOMManager.Back();
                }
            }]
        })
        this.append(BtnReturn, WRender.createElement(this.styleComponent), this.ProyectContainer);
    }
    connectedCallback() {
        if (this.ProyectContainer.innerHTML != "") {
            return;
        }
        this.DrawComponent();
    }
    DrawComponent = async () => {  
        const Detaills = WRender.createElement({
            type: 'div',
            props: { class: 'PropiedadDetails' }, children: [
                {
                    type: 'div', props: { id: '', class: 'DetailsDiv' }, children: [
                        WRender.CreateStringNode(`<h3 class="headerTitle">Proyecto ${this.response.Nombre_Proyecto}</h3>`),
                        WRender.CreateStringNode("<h4>Descripción del Proyecto <hr></h4>"),
                        this.response.Descripcion_Servicio,
                        WRender.CreateStringNode(`<label class="labelDetail">Tipo de Proyecto: ${this.response.Descripcion}</label>`),
                        WRender.CreateStringNode(`<label class="labelDetail">Estado: ${this.response.Estado}</label>`),
                        WRender.CreateStringNode(`<label class="labelDetail">Fecha de Inicio: ${this.response.Fecha_Inicio}</label>`)             
                    ]
                }
            ]
        });
        this.ProyectContainer.append(WRender.createElement(Detaills));
        Colaboradores.ActionFunction = (Object) => {
            ActionFunction(Object.Id_Perfil, this.DOMManager);
        }
        this.ProyectContainer.append(WRender.createElement(Colaboradores));
    }
    styleComponent = {
        type: 'w-style', props: {
            ClassList: [
                new WCssClass(`.ProyectContainer`, {
                    display: 'flex',
                    "align-items": "center",
                    "justify-content": "center",
                    "flex-wrap": "wrap",
                    "flex-direction": "column",
                    padding: 20,
                    margin: 10,
                    "background-color": "#fff",
                    "box-shadow": "0 0px 5px 0 rgba(0,0,0,0.6)",
                    "border-radius": "0.3cm",
                    overflow: "hidden",
                    "text-align": "justify"
                }), new WCssClass( `.InstitucionesContainer`, {
                    display: 'flex',
                    "justify-content": "center"
                }),new WCssClass( `.DetailsDiv`, {
                    display: 'flex',
                    "flex-direction": "column",
                }),new WCssClass( `.InstitucionDiv`, {
                    display: 'flex',
                    "flex-direction": "column",
                    "box-shadow": "0 0px 5px 0 rgba(0,0,0,0.6)",
                    overflow: "hidden",
                    "border-radius": "0.2cm",
                    margin: 10,
                    "align-items": "center", 
                    "justify-content": "center",
                    padding: 5,
                    width: 120,
                    height: 150,
                    "font-size": 12,
                }),new WCssClass( `.InstitucionDiv img`, {
                    width: 80,
                    height: 80,
                    margin: 5,
                    "object-fit": "cover"
                }),new WCssClass( `.headerTitle`, {
                    "text-align": 'center',
                    padding:10,
                    margin: 0
                }), new WCssClass( `.labelDetail`, {
                    "border-radius": "0.2cm",
                    color: "#fff",
                    "background-color": "#28a745",
                    "font-size": 13,
                    padding: "5px 10px",
                    margin: 5,
                    width: 300
                }),new WCssClass(`w-card-carousel`, {
                    //width: "100%"
                }),
            ],  MediaQuery: [{
                condicion: "(max-width: 800px)",
                ClassList: [
                    new WCssClass(`.ProyectContainer`, {
                        overflow: "hidden", 
                        "flex-wrap": "inherit",                        
                    }), new WCssClass( `w-card-carousel`, {
                        //width: "100%"
                    }),
                ]
            }]
        }
    };
}
customElements.define('w-view', ProyectDetailViewer);
export { ProyectDetailViewer };
