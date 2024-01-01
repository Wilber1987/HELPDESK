//@ts-check
import { WRender, ComponentsManager, WAjaxTools, WArrayF, html } from "../../../WDevCore/WModules/WComponentsTools.js";
import { StylesControlsV2, StylesControlsV3, StyleScrolls } from "../../../WDevCore/StyleModules/WStyleComponents.js"
import { css } from "../../../WDevCore/WModules/WStyledRender.js";
import { WCommentsComponent } from "../../../WDevCore/WComponents/WCommentsComponent.js";
import { CaseTable_Comments, CaseTable_Comments_Tasks, CaseTable_Tareas } from "../../../ModelProyect/ProyectDataBaseModel.js";
import { WSecurity } from "../../../WDevCore/Security/WSecurity.js";

/**
 * @typedef {Object} ComponentConfig
 * * @property {CaseTable_Tareas} [Task]
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
        const commentsActividad = await new CaseTable_Comments({ Id_Case: this.Task?.Id_Tarea }).Get();
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
    <div class="thumbnail"><img class="left"
            src="https://cdn2.hubspot.net/hubfs/322787/Mychefcom/images/BLOG/Header-Blog/photo-culinaire-pexels.jpg" />
    </div>
    <div class="right">
        <h1>${this.Task?.Descripcion}</h1>
        <div class="author"><img src="https://randomuser.me/api/portraits/men/95.jpg" />
            <h2>Igor MARTY</h2>
        </div>
        <div class="separator"></div>
        <p>Magnesium is one of the six essential macro-minerals that is required by the body for energy production and
            synthesis of protein and enzymes. It contributes to the development of bones and most importantly it is
            responsible for synthesis of your DNA and RNA. A new report that has appeared in theBritish Journal of
            Cancer, gives you another reason to add more magnesium to your diet...</p>
    </div>
    <h5>12</h5>
    <h6>JANUARY</h6>
    <ul>
        <li><i class="fa fa-eye fa-2x"></i></li>
        <li><i class="fa fa-heart-o fa-2x"></i></li>
        <li><i class="fa fa-envelope-o fa-2x"></i></li>
        <li><i class="fa fa-share-alt fa-2x"></i></li>
    </ul>
    <div class="fab"><i class="fa fa-arrow-down fa-3x"> </i></div>
</div>`
        node.append(css`
        @import url(https://fonts.googleapis.com/css?family=Roboto);
/*Just the background stuff*/
span.s1 {
position: absolute;
top: 0;
font-size: 15rem;
font-weight: 800;
text-transform: uppercase;
color: #3C4447;
}

span.s2 {
font-weight: 800;
position: absolute;
bottom: 0;
right: 0;
font-size: 15rem;
text-transform: uppercase;
color: #3C4447;
}

/*My hum... body.. yeah..*/
body {
background-color: #353B3F;
font-family: "Roboto", sans-serif;
}

/* The card */
.card {
position: relative;
height: 450px;
width: 900px;
margin: 200px auto;
background-color: #FFF;
-webkit-box-shadow: 10px 10px 93px 0px rgba(0, 0, 0, 0.75);
-moz-box-shadow: 10px 10px 93px 0px rgba(0, 0, 0, 0.75);
box-shadow: 10px 10px 93px 0px rgba(0, 0, 0, 0.75);
}

/* Image on the left side */
.thumbnail {
float: left;
position: relative;
left: 30px;
top: -30px;
height: 320px;
width: 530px;
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
margin-left: 590px;
margin-right: 20px;
}

h1 {
padding-top: 15px;
font-size: 1.3rem;
color: #4B4B4B;
}

.author {
background-color: #9ECAFF;
height: 30px;
width: 110px;
border-radius: 20px;
}

.author > img {
padding-top: 5px;
margin-left: 10px;
float: left;
height: 20px;
width: 20px;
border-radius: 50%;
}

h2 {
padding-top: 8px;
margin-right: 6px;
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

/* DATE of release*/
h5 {
position: absolute;
left: 30px;
bottom: -120px;
font-size: 6rem;
color: #C3C3C3;
}

h6 {
position: absolute;
left: 30px;
bottom: -55px;
font-size: 2rem;
color: #C3C3C3;
}

/* Those futur buttons */
ul {
margin-left: 250px;
}

li {
display: inline;
list-style: none;
padding-right: 40px;
color: #7B7B7B;
}

/* Floating action button */
.fab {
position: absolute;
right: 50px;
bottom: -40px;
box-sizing: border-box;
padding-top: 18px;
background-color: #1875D0;
width: 80px;
height: 80px;
color: white;
text-align: center;
border-radius: 50%;
-webkit-box-shadow: 10px 10px 50px 0px rgba(0, 0, 0, 0.75);
-moz-box-shadow: 10px 10px 50px 0px rgba(0, 0, 0, 0.75);
box-shadow: 10px 10px 50px 0px rgba(0, 0, 0, 0.75);
}   
        `)
        return node;
    }


    CustomStyle = css`
        .component{
           display: block;
        }           
    `
}
customElements.define('w-tarea-detail-component', TareaDetailView);
export { TareaDetailView }