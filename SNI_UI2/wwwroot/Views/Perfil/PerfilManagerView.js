
import { Tbl_Profile } from '../../Model/ProyectDataBaseModel.js';
import { StylesControlsV2, StylesControlsV3 } from "../../WDevCore/StyleModules/WStyleComponents.js";
import { WAppNavigator } from '../../WDevCore/WComponents/WAppNavigator.js';
import { WDetailObject } from '../../WDevCore/WComponents/WDetailObject.js';
import { WFilterOptions } from '../../WDevCore/WComponents/WFilterControls.js';
import { ModalVericateAction, WForm } from "../../WDevCore/WComponents/WForm.js";
import { WModalForm } from "../../WDevCore/WComponents/WModalForm.js";
import { WTableComponent } from "../../WDevCore/WComponents/WTableComponent.js";
import { ComponentsManager, WAjaxTools, WRender } from '../../WDevCore/WModules/WComponentsTools.js';
import { WCssClass, WStyledRender, css } from '../../WDevCore/WModules/WStyledRender.js';
import { PerfilManagerComponent } from './PerfilManagerComponent.js';

const OnLoad = async () => {
    const Dataset = await new Tbl_Profile().Get();
    const ProfilesComp = new PerfilManagerComponent(Dataset);
    Main.appendChild(ProfilesComp);
}
window.onload = OnLoad;