//@ts-check
import { WRender } from "../WModules/WComponentsTools.js";
import { WCssClass, css } from "../WModules/WStyledRender.js";
class modelFiles {
    constructor(value, type) {
        this.type = type;
        this.value = value
    }
    value = ""//base64,
    type = "" //PDF,PNG,JPG
}
class WRichText extends HTMLElement {
    constructor() {
        super();
        this.value = "";
        /**
         * @type {Array<modelFiles>}
         */
        this.Files = [];
        this.DrawComponent();
    }
    connectedCallback() {
    }
    DrawComponent = async () => {
        this.innerHTML != "";
        this.append(WRichTextStyle.cloneNode(true))
        this.DrawOptions();
        this.Divinput = WRender.Create({
            // @ts-ignore
            contentEditable: true,
            class: "WREditor",
            oninput: () => {
                // @ts-ignore
                this.value = this.querySelector(".WREditor").innerHTML;
            }
        })
        this.append(this.Divinput);
    }
    DrawOptions() {
        const OptionsSection = WRender.Create({
            tagName: "section", class: "WOptionsSection"
        })
        this.Commands.forEach(command => {
            let CommandBtn = WRender.Create({
                tagName: "input",
                className: "ROption tooltip " + command.class,
                type: command.type,
                id: "ROption" + command.commandName,
                // @ts-ignore
                title: command.commandName,
                value: command.label
            });
            CommandBtn[command.event] = () => {
                const ROption = this.querySelector("#ROption" + command.commandName);
                //console.log( ROption.value );   
                // @ts-ignore
                document.execCommand(command.commandName, false, ROption.value);
            }
            OptionsSection.append(WRender.Create({
                class: "tooltip",
                children: [CommandBtn, { tagName: "span", class: "tooltiptext", children: [command.commandName] }]
            }))
        });
        const OptionsAdjuntosSection = WRender.Create({
            tagName: "section", class: "WOptionsSection", children: [
                WRender.Create({tagName: "input", type: "file", onchange: ()=>{
                    this.Files.push(new modelFiles("pdf", "zjshikzhsdjk"))
                    console.log(this.Files);
                }})
            ]
        })
        this.append(OptionsSection, OptionsAdjuntosSection);
    }
    Commands = [
        //{ commandName: "backColor", icon: "", type: "color", commandOptions: null, state: 1, event: "onchange" },
        { commandName: "bold", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick", class: "bold", label: "B" },
        { commandName: "createLink", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "copy", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "cut", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "defaultParagraphSeparator", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "delete", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "fontName", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "fontSize", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "foreColor", icon: "", type: "color", commandOptions: null, state: 1, event: "onchange" },
        { commandName: "formatBlock", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "forwardDelete", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "insertHorizontalRule", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "insertHTML", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "insertImage", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "insertLineBreak", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "insertOrderedList", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "insertParagraph", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "insertText", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "insertUnorderedList", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "justifyCenter", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "justifyFull", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "justifyLeft", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "justifyRight", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "outdent", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "paste", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "redo", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "selectAll", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "strikethrough", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "styleWithCss", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "subscript", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "superscript", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "undo", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
        { commandName: "unlink", icon: "", type: "button", commandOptions: null, state: 1, event: "onclick" },
    ];
}

const WRichTextStyle = css` 
    w-rich-text .WREditor {
        height: 200px;
        border: solid 1px #000;
        display: block;
        margin: 0px;
        padding: 10px;
    }

    w-rich-text .WOptionsSection {
        border: solid 1px #000;
        display: block;
        margin: 0px;
    }

    w-rich-text .ROption {
        border: solid 1px #000;
        padding: 5px;
        margin: 0px;
    }

    .tooltip {
        position: relative;
        display: inline-block;
        padding: 0px;
        margin: 5px;
    }

    .tooltiptext {
        visibility: hidden;
        min-width: 120px;
        background-color: black;
        color: #fff;
        text-align: center;
        border-radius: 6px;
        padding: 5px;
        position: absolute;
        z-index: 1;
        bottom: 150%;
        left: 50%;
        margin-left: -60px;
    }

    .tooltiptext::after {
        content: "";
        position: absolute;
        top: 100%;
        left: 50%;
        margin-left: -5px;
        border-width: 5px;
        border-style: solid;
        border-color: black transparent transparent transparent;
    }

    .tooltip:hover .tooltiptext {
        visibility: visible;
    } 
    input {
        cursor: pointer;
    }
    .bold {
        font-weight: bold;
        font-size: 16px;
    }
    `

customElements.define("w-rich-text", WRichText);
export { WRichText }