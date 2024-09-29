//@ts-check
import { StylesControlsV2 } from "../../WDevCore/StyleModules/WStyleComponents.js";
import { WAppNavigator } from '../../WDevCore/WComponents/WAppNavigator.js';
import { WDetailObject } from '../../WDevCore/WComponents/WDetailObject.js';
import { ModalVericateAction, WForm } from "../../WDevCore/WComponents/WForm.js";
import { WModalForm } from "../../WDevCore/WComponents/WModalForm.js";
import { WTableComponent } from "../../WDevCore/WComponents/WTableComponent.js";
import { ComponentsManager, html, WRender } from '../../WDevCore/WModules/WComponentsTools.js';
import { css, WCssClass, WStyledRender } from '../../WDevCore/WModules/WStyledRender.js';

import { WAjaxTools } from "../../WDevCore/WModules/WAjaxTools.js";
import { ChangePasswordModel } from "../../WDevCore/Security/SecurityModel.js";
import { Tbl_Profile } from "../FrontModel/Tbl_Profile.js";
import { Tbl_Grupo_ModelComponent } from "../FrontModel/Tbl_Grupo_ModelComponent.js";

const OnLoad = async () => {
    // @ts-ignore
    //Main.append(WRender.Create({ tagName: "h3", innerText: "Administración de perfiles" }));
    const AdminPerfil = new PerfilClass();
    // @ts-ignore
    Main.append(AdminPerfil.MainNav);
    // @ts-ignore
    Main.appendChild(AdminPerfil);

}
window.onload = OnLoad;
class PerfilClass extends HTMLElement {
    constructor() {
        super();
        this.Id_Perfil = 1;
        this.id = "PerfilClass";
        this.className = "PerfilClass DivContainer";
        this.append(this.WStyle, StylesControlsV2.cloneNode(true));
        this.TabContainer = WRender.createElement({ type: 'div', props: { class: 'content-container', id: "TabContainer" } });
        this.TabManager = new ComponentsManager({ MainContainer: this.TabContainer });
        this.OptionContainer = WRender.Create({ className: "OptionContainer" });
        this.TabActividades = this.MainNav;
        this.DrawComponent();
    }
    EditarPerfilNav = () => {
        return [{
            name: "Perfil", action: async (ev) => { this.EditProfile(); }
        }];
    }
    MainNav = new WAppNavigator({
        //NavStyle: "tab",
        Direction: "row",
        Inicialize: true,
        Elements: [
            {
                name: "Datos Generales",
                action: async (ev) => {
                    this.response = await WAjaxTools.PostRequest("../../api/Profile/TakeProfile",
                        { Id_Perfil: this.Id_Perfil }
                    );
                    this.TabManager.NavigateFunction("Tab-Generales",
                        new WDetailObject({ ObjectDetail: this.response, ModelObject: new Tbl_Profile(), ImageUrlPath: "" }));
                }
            }, {
                name: "Editar Perfil",
                action: async (ev) => {
                    await this.NavigateToEdit();
                }
            }, {
                name: "Grupo",
                action: async (ev) => {
                    if (this.response.Grupo == null) {
                        const container = html`<div class="GrupoContainer">
                            <div class="OptionContainer">
                                <button class="Btn" onclick="${() => this.NavigateToEdit()}">Unirse a un grupo</button>
                                <button class="Btn" onclick="${() => this.CreateGroup()}">Crear grupo</button>
                            </div>                        
                            <div class="content-container">
                                <h3>No hay grupo disponible</h3>
                            </div>
                        </div>`;
                        this.TabManager.NavigateFunction("Tab-Group", container);
                    } else {
                        const container = html`<div class="GrupoContainer">
                        <div class="OptionContainer">
                            <button class="Btn" onclick="${() => this.NavigateToEdit()}">Cambiarse de grupo</button>
                        </div>                        
                        <div class="content-container">
                            ${new WDetailObject({ ObjectDetail: this.response.Grupo, ModelObject: new Tbl_Grupo_ModelComponent() })}
                        </div>
                    </div>`;
                        this.TabManager.NavigateFunction("Tab-Group", container);
                    }
                    // this.response.Tbl_Dependencias_Usuarios = undefined;
                    // this.response.Tbl_Participantes = undefined;

                }
            }, {
                name: "Editar Contraseña",
                action: async (ev) => {
                    this.append(new WModalForm({
                        title: "CAMBIO DE CONTRASEÑA",
                        EditObject: { Password: "" },
                        ModelObject: new ChangePasswordModel(),
                        StyleForm: "ColumnX1",
                        ObjectOptions: { Url: "../api/ApiEntitySECURITY/changePassword" }
                    }));
                }
            }
        ]
    });
    CreateGroup() {
        this.append(new WModalForm({
            title: "Nuevo Grupo",
            AutoSave: true,
            ModelObject: new Tbl_Grupo_ModelComponent(),
            StyleForm: "columnX1"
        }));
    }

    EditProfile = async () => {
        //const Id_Institucion = await WAjaxTools.PostRequest("../../api/PublicCat/GetInstitucion");
        // const Id_Paises = await WAjaxTools.PostRequest("../../api/PublicCat/GetPaises");
        const InvestigadorModel = new Tbl_Profile({
            Cat_Dependencias: undefined, Tbl_Servicios: undefined
        });
        const EditForm = WRender.Create({
            className: "FormContainer", style: {
                padding: "10px",
                borderRadius: ".3cm",
                boxShadow: "0 0 4px 0 rgb(0 0 0 / 40%)",
                margin: "10px"
            }, children: [
                new WForm({
                    ModelObject: InvestigadorModel,
                    EditObject: this.response,
                    ImageUrlPath: "",
                    ObjectOptions: { Url: "../../api/Profile/SaveProfile" },
                })
            ]
        });
        this.TabManager.NavigateFunction("Tab-Editar", EditForm);
    }


    async NavigateToEdit() {
        this.response = await WAjaxTools.PostRequest("../../api/Profile/TakeProfile",
            { Id_Perfil: this.Id_Perfil }
        );
        // this.response.Tbl_Dependencias_Usuarios = undefined;
        // this.response.Tbl_Participantes = undefined;
        this.TabManager.NavigateFunction("Tab-Edit-Generales",
            new WForm({
                AutoSave: true,
                EditObject: this.response,
                ModelObject: new Tbl_Profile({ Cat_Dependencias: undefined, Tbl_Servicios: undefined }),
                ImageUrlPath: ""
            }));
    }

    connectedCallback() { }
    DrawComponent = async () => {
        this.append(this.TabContainer);
    }
    WStyle = css`
        .PerfilClass {}
        w-app-navigator {
            display: block;
            margin-bottom: 20px;
        }

        .OptionContainer {
            display: flex;
            justify-content: center;
        }

        .OptionContainer img {
            box-shadow: 0 0 4px rgb(0, 0, 0/50%);
            height: 100px;
            width: 100px;
            margin: 10px;
        }
        .GrupoContainer {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .TabContainer {
            overflow: hidden;
            overflow-y: auto;
        }

        .FormContainer {
            background-color: #fff;
        }

        @media (max-width: 600px) {}
        `
    }

customElements.define('w-perfil', PerfilClass);