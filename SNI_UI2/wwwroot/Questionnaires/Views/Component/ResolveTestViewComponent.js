//@ts-check
import { WRender, ComponentsManager, WAjaxTools, WArrayF, html } from "../../../WDevCore/WModules/WComponentsTools.js";
import { StylesControlsV2, StylesControlsV3, StyleScrolls } from "../../../WDevCore/StyleModules/WStyleComponents.js"
import { css } from "../../../WDevCore/WModules/WStyledRender.js";
import { Tests_ModelComponent } from "../../FrontModel/ModelComponent/Tests_ModelComponent.js";
import { Tests } from "../../FrontModel/Tests.js";
// @ts-ignore
import { ModelProperty } from "../../../WDevCore/WModules/CommonModel.js";
import { WModalForm } from "../../../WDevCore/WComponents/WModalForm.js";
import { Resultados_Tests } from "../../FrontModel/Resultados_Tests.js";
import { Resultados_Pregunta_Tests } from "../../FrontModel/Resultados_Pregunta_Tests.js";
import { Cat_Valor_Preguntas } from "../../FrontModel/Cat_Valor_Preguntas.js";
import { Pregunta_Tests } from "../../FrontModel/Pregunta_Tests.js";
import { ModalMessege } from "../../../WDevCore/WComponents/WForm.js";
/**
 * @typedef {Object} ComponentConfig
 * * @property {Object} [propierty]
 */
class ResolveTestViewComponent extends HTMLElement {
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
        /**@type {Tests_ModelComponent} */
        this.ModelComponent = new Tests_ModelComponent();
        /**@type {Tests} */
        this.EntityModel = new Tests();
        /**@type {Array<Tests>} */
        this.Dataset = await this.EntityModel.Get();

        /**@type {Array} */
        this.DatasetCategories = WArrayF.GroupBy(this.Dataset.map(d => d.Cat_Categorias_Test), "Descripcion");
        this.DatasetCategories.forEach(element => {
            const testCategories = this.Dataset?.filter(test => test.Cat_Categorias_Test.Descripcion == element.Descripcion);
            testCategories?.forEach(test => {
                this.TabContainer.append(WRender.Create({
                    class: "cardText", children: [
                        test.Descripcion,
                        {
                            tagName: 'input', type: 'button', className: 'className', value: 'Resolve', onclick: async () => {
                                this.BuildTest(test);
                            }
                        }
                    ]
                }))
            });
        });
    }


    /**
     * @param {Tests} test
     */
    BuildTest(test) {
        const model = {};
        test.Pregunta_Tests.forEach(p => {
            let type = "WRADIO";
            /**@type {ModelProperty} */
            const modelPropierty = {
                type: type,
                Dataset: p.Cat_Tipo_Preguntas.Cat_Valor_Preguntas,
                label: p.Descripcion_pregunta
            };
            model[p.Id_pregunta_test] = modelPropierty;
        });
        this.shadowRoot?.append(new WModalForm({
            ModelObject: model, ObjectOptions: {
                SaveFunction: async (/**@type {Object} */ editinObject) => {
                    /**@type {Array<Resultados_Pregunta_Tests>} */
                    await this.SaveTest(editinObject, test);
                }
            }
        }));
    }

    /**
     * @param {{ [x: string]: Cat_Valor_Preguntas; }} editinObject
     * @param {Tests} test
     */
    async SaveTest(editinObject, test) {
        const resultados = [];

        for (const prop in editinObject) {

            /**@type {Cat_Valor_Preguntas} */
            const pregunta = editinObject[prop];
            console.log(pregunta, prop);
            console.log(test);

            resultados.push(new Resultados_Pregunta_Tests({
                Id_Perfil: 1,
                Cat_Valor_Preguntas: pregunta,
                Pregunta_Tests: test.Pregunta_Tests?.find(p => p.Id_pregunta_test.toString() == prop),
                Fecha: new Date(),
                Resultado: pregunta.Valor,
                Respuesta: "",
                Estado: "ACTIVO"
            }));
        }

        /**@type {Array<Pregunta_Tests>} */
        const secciones = WArrayF.GroupBy(resultados.map(r => r.Pregunta_Tests), "Seccion");
        const Test = new Tests({Resultados_Tests: []});

        for (const pregntaTest of secciones) {
            const resultadosSeccion = resultados.filter(r => r.Pregunta_Tests.Seccion == pregntaTest.Seccion);
            const resultado = new Resultados_Tests({
                Id_Perfil: 1,
                Tests: test,
                Fecha: new Date(),
                Valor: WArrayF.SumValAtt(resultadosSeccion, "Resultado").toString(),
                Seccion: pregntaTest.Seccion,
                Resultados_Pregunta_Tests: resultadosSeccion,
                Tipo: pregntaTest.Seccion != null ? "SUB_ESCALA" : "ESCALA",
                Categoria_valor: "Por definir" //TODO DEFINIR EN BACKEND
            });
            Test.Resultados_Tests.push(resultado);
        }
        const response = await Test.SaveResultado();
        this.append(ModalMessege(response.message));
    }

    SetOption() {
        this.OptionContainer.append(WRender.Create({
            tagName: 'button', className: 'Block-Primary', innerText: 'Datos contrato',
            onclick: async () => this.Manager.NavigateFunction("id", undefined ?? WRender.Create({ className: "component" }))
        }))
    }

    CustomStyle = css`
        .component{
           display: block;
        }           
    `
}
customElements.define('w-resolve-test-view', ResolveTestViewComponent);
export { ResolveTestViewComponent }