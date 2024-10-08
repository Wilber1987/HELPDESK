import { Tbl_Profile } from "../WDevCore/Security/Tbl_Profile.js";
import { WDetailObject } from "../WDevCore/WComponents/WDetailObject.js";
import { WModalForm } from "../WDevCore/WComponents/WModalForm.js";
import { WAjaxTools } from "../WDevCore/WModules/WAjaxTools.js";
import { ComponentsManager, WRender } from "../WDevCore/WModules/WComponentsTools.js";
import { WCssClass } from "../WDevCore/WModules/WStyledRender.js";

class HomeClass extends HTMLElement {
    constructor(response) {
        super();
        this.id = "HomeClass";
        this.className = "HomeClass DivContainer";
        this.response = response;
        this.contain = WRender.createElement({ type: 'div', props: { id: '', class: 'CardContainer' }, children: [] });
        this.DOMManager = new ComponentsManager({ MainContainer: this });
        this.append(WRender.createElement(this.Style));
        this.append(this.contain);
    }
    connectedCallback() {
        if (this.contain.innerHTML != "") {
            return;
        }
        this.DrawComponent();
    }
    DrawComponent = async () => {        
    }
    Style = {
        type: "w-style",
        props: {
            ClassList: [
                new WCssClass(".CardContainer", {
                    display: "flex",
                    "flex-direction": "column"
                }), new WCssClass(".CardInves", {
                    overflow: "auto",
                    padding: "20px",
                    "margin-bottom": 10,
                    "margin-left": 5,
                    "margin-right": 5,
                    "min-height": 100,
                    "border-radius": "0.2cm",
                    "background-color": "#fff",
                    "box-shadow": "0 0px 3px 0 rgba(0,0,0,0.4)"
                }), new WCssClass("w-view-detail", {
                    overflow: "auto",
                    padding: "20px",
                    background: "#fff",
                    display: "block",
                    "border-radius": 20,
                    "box-shadow": "0 0 4px 0 rgb(0, 0, 0, 40%)"
                })
            ], MediaQuery: [{
                condicion: "(max-width: 1200px)",
                ClassList: [
                    new WCssClass(".ImagesContainer", {
                        display: "grid",
                        "grid-template-columns": "auto auto auto"
                    })
                ]
            }, {
                condicion: "(max-width: 600px)",
                ClassList: [
                    new WCssClass(".ImagesContainer", {
                        display: "grid",
                        "grid-template-columns": "auto auto"
                    })
                ]
            }]
        }
    };
}
customElements.define("app-home", HomeClass);
const ActionFunction = async (Id_Perfil, DOMManager) => {
    const response = await WAjaxTools.PostRequest("../api/Investigaciones/TakeProfile",
        { Id_Perfil: Id_Perfil }
    );
    console.log(response);
    const divRedes = WRender.createElement({ type: 'div', props: { id: '', class: 'divRedes' } });
    const cadenaB64 = "data:image/png;base64,";
    response.Tbl_Invest_RedS?.forEach(element => {
        divRedes.append(WRender.createElement([{ type: 'img', props: { src: cadenaB64 + element.Icon, class: 'RedsIcon' } },
        { type: 'a', props: { innerText: element.Descripcion, href: element.Url_red_inv, target: "_blank" } }]));
    });
    divRedes.append(WRender.CreateStringNode("<hr style='margin-top: 30px'>"))
    const dataResume = WRender.createElement({
        type: 'div', props: { id: '', class: 'ResumenContainer' }, children: [
            WRender.CreateStringNode("<h3>Logros</h3>"),
            "Investigaciones: " + response.Investigaciones?.length,
            "Proyectos: " + response.Proyectos?.length,
            "Colaboraciones: " + response.Colaboraciones?.length,
            WRender.CreateStringNode("<h3>Redes Sociales</h3>"),
            divRedes
        ]
    });
    const BodyComponents = new WDetailObject({
        ObjectDetail: response,
        ModelObject: new Tbl_Profile(),
        ImageUrlPath: "",
        DOMManager: DOMManager
    }); // new WProfileInvestigador(response, { DOMManager: DOMManager });
    DOMManager.NavigateFunction("Investigador" + Id_Perfil, BodyComponents);
}

function ModalComp(BodyComponents, dataResume) {
    return new WModalForm({
        title: "SINI - SISTEMA NACIONAL DE INVESTIGADORES",
        //StyleForm: "FullScreen",
        ObjectModal: WRender.Create({
            style: {
                display: "grid",
                gridTemplateColumns: "calc(98% - 270px) 250px",
                justifyContent: "center",
                margin: "5px"
            }, children: [BodyComponents, dataResume]
        })
    });
}
async function ChargeInvestigacion(Investigacion, DOMManager) {
    const Id_Investigacion = Investigacion.Id_Investigacion;
    const response = await WAjaxTools.PostRequest("../api/Investigaciones/TakeInvestigacion",
        { Id_Investigacion: Id_Investigacion }
    );
    const Reader = new InvestigacionViewer(response, DOMManager);
    DOMManager.NavigateFunction("Investigacion" + Id_Investigacion, Reader);
}

export { ActionFunction, ChargeInvestigacion, HomeClass, ModalComp };
