//@ts-check
import { EntityClass } from "../../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../../WDevCore/WModules/WComponentsTools.js";
// @ts-ignore 
import { ModelProperty } from "../../../WDevCore/WModules/CommonModel.js";
import { Tests_ModelComponent } from './Tests_ModelComponent.js'
class Cat_Categorias_Test_ModelComponent extends EntityClass {
    /** @param {Partial<Cat_Categorias_Test_ModelComponent>} [props] */
    constructor(props) {
        super(props, 'EntityQuestionnaires');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
   /**@type {ModelProperty}*/ Id_categoria = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ Descripcion = { type: 'text' };
   /**@type {ModelProperty}*/ Imagen = { type: 'img' };
   /**@type {ModelProperty}*/ Estado = { type: 'SELECT', Dataset: ["ACTIVO", "INACTIVO"] };
    ///**@type {ModelProperty}*/ Created_at = { type: 'date' };
    ///**@type {ModelProperty}*/ Updated_at = { type: 'date' };
    ///**@type {ModelProperty}*/ Tests = { type: 'MasterDetail',  ModelObject: ()=> new Tests_ModelComponent()};
}
export { Cat_Categorias_Test_ModelComponent }
