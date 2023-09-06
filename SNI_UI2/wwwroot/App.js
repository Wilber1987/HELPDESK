import { Cat_Dependencias } from "./Model/ProyectDataBaseModel.js";
import { WRender } from "./WDevCore/WModules/WComponentsTools.js";
import { css } from "./WDevCore/WModules/WStyledRender.js";

const ColorsList = ["#044fa2", "#0088ce", "#f6931e", "#eb1c24", "#01c0f4", "#00bff3", "#e63da4", "#6a549f"];

const OnLoad = async () => {
    const dep = await new Cat_Dependencias().Get();
    const container = WRender.Create({ className: "dep-container" });
    dep.forEach((element, index) => {
        const cont = WRender.Create({
            className: "card", style: { backgroundColor: ColorsList[index] }, children: [
                { tagName: "h1", innerText: element.Descripcion },
                { tagName: "label", innerText: element.Username },
                {className: "cont-mini-cards", children: element.Tbl_Servicios?.map(s =>  WRender.Create({className: "mini-card", innerText: s.Descripcion_Servicio}))}               
            ]
        })
        
       
        container.append(cont)
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
    .cont-mini-cards {
        width: 100%;
        display: flex;
    }
    .mini-card {
        padding: 10px;
        background-color: #fff;
        border-radius: 10px;
        color: #444;
        margin: 10px;
    }
`
window.onload = OnLoad;