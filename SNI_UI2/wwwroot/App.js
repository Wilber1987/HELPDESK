import { Cat_Dependencias } from "./Model/ProyectDataBaseModel.js";
import { WRender } from "./WDevCore/WModules/WComponentsTools.js";
import { css } from "./WDevCore/WModules/WStyledRender.js";

const ColorsList = ["#044fa2", "#0088ce", "#f6931e", "#eb1c24", "#01c0f4", "#00bff3", "#e63da4", "#6a549f"];

const OnLoad = async () => {
    const dep = await new Cat_Dependencias().Get();
    const container = WRender.Create({ className: "dep-container" });
    dep.forEach((element, index) => {
        container.append(WRender.Create({
            className: "card", style: { backgroundColor: ColorsList[index] }, children: [
                { tagName: "label", innerText: element.Descripcion }
            ]
        }))
    });
    Main.append(cssCus, container);
}
const cssCus = css`
    .dep-container{
        display: grid;
        grid-column: 30% 30% 30%;
        gap: 20px;
        padding: 20px;
    }
    .card {
        padding: 20px;
        background-color: #0e8bd9;
        color: #fff;
        border-radius: 15px;
    }
`
window.onload = OnLoad;