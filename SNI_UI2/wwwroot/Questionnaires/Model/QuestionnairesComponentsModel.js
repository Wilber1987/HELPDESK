import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { BasicStates, WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
class Cat_Categorias_Test_ModelComponent extends EntityClass {
    constructor(props) {
        super(props, 'EntityQuestionnaires');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
   /**@type {ModelProperty}*/ id_categoria = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ descripcion = { type: 'text' };
   /**@type {ModelProperty}*/ imagen = { type: 'img', hiddenInTable: true };
   /**@type {ModelProperty}*/ estado = { type: 'select', Dataset: BasicStates };
   ///**@type {ModelProperty}*/ created_at = { type: 'date' };
   ///**@type {ModelProperty}*/ updated_at = { type: 'date' };
   ///**@type {ModelProperty}*/ Tests = { type: 'MasterDetail', ModelObject: () => new Tests_ModelComponent() };
}
export { Cat_Categorias_Test_ModelComponent }
class Cat_Tipo_Preguntas_ModelComponent extends EntityClass {
    constructor(props) {
        super(props, 'EntityQuestionnaires');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
   /**@type {ModelProperty}*/ id_tipo_pregunta = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ tipo_pregunta = { type: 'text' };
   /**@type {ModelProperty}*/ descripcion = { type: 'text' };
   /**@type {ModelProperty}*/ estado = { type: 'select', Dataset: BasicStates };
   /**@type {ModelProperty}*/ fecha_crea = { type: 'date' };
   ///**@type {ModelProperty}*/ created_at = { type: 'date' };
   ///**@type {ModelProperty}*/ updated_at = { type: 'date' };
   /**@type {ModelProperty}*/ editable = { type: 'checkbox' };
   /**@type {ModelProperty}*/ descripcion_general = { type: 'text' };
   /**@type {ModelProperty}*/ Cat_Valor_Preguntas = { type: 'MasterDetail', ModelObject: () => new Cat_Valor_Preguntas_ModelComponent() };
    ///**@type {ModelProperty}*/ Pregunta_Tests = { type: 'MasterDetail',  ModelObject: ()=> new Pregunta_Tests_ModelComponent()};
}
export { Cat_Tipo_Preguntas_ModelComponent }
class Cat_Valor_Preguntas_ModelComponent extends EntityClass {
    constructor(props) {
        super(props, 'EntityQuestionnaires');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
   /**@type {ModelProperty}*/ id_valor_pregunta = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ descripcion = { type: 'text' };
   /**@type {ModelProperty}*/ estado = { type: 'select', Dataset: BasicStates };
   /**@type {ModelProperty}*/ valor = { type: 'number' };
   ///**@type {ModelProperty}*/ created_at = { type: 'date' };
   ///**@type {ModelProperty}*/ updated_at = { type: 'date' };
   /**@type {ModelProperty}*/ Cat_Tipo_Preguntas = { type: 'WSELECT', ModelObject: () => new Cat_Tipo_Preguntas_ModelComponent() };
   /**@type {ModelProperty}*/ Resultados_Pregunta_Tests = { type: 'MasterDetail', ModelObject: () => new Resultados_Pregunta_Tests_ModelComponent() };
}
export { Cat_Valor_Preguntas_ModelComponent }
class Pregunta_Tests_ModelComponent extends EntityClass {
    constructor(props) {
        super(props, 'EntityQuestionnaires');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
   /**@type {ModelProperty}*/ id_pregunta_test = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ estado = { type: 'select', Dataset: BasicStates };
   /**@type {ModelProperty}*/ descripcion_pregunta = { type: 'text' };
   /**@type {ModelProperty}*/ fecha = { type: 'date' };
   ///**@type {ModelProperty}*/ created_at = { type: 'date' };
   ///**@type {ModelProperty}*/ updated_at = { type: 'date' };
   /**@type {ModelProperty}*/ seccion = { type: 'text' };
   /**@type {ModelProperty}*/ descripcion_general = { type: 'text' };
   /**@type {ModelProperty}*/ Cat_Tipo_Preguntas = { type: 'WSELECT', ModelObject: () => new Cat_Tipo_Preguntas_ModelComponent() };
    ///**@type {ModelProperty}*/ Tests = { type: 'WSELECT',  ModelObject: ()=> new Tests_ModelComponent()};
    ///**@type {ModelProperty}*/ Resultados_Pregunta_Tests = { type: 'MasterDetail',  ModelObject: ()=> new Resultados_Pregunta_Tests_ModelComponent()};
}
export { Pregunta_Tests_ModelComponent }
class Resultados_Pregunta_Tests_ModelComponent extends EntityClass {
    constructor(props) {
        super(props, 'EntityQuestionnaires');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
   /**@type {ModelProperty}*/ Id_Perfil = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ resultado = { type: 'number' };
   /**@type {ModelProperty}*/ respuesta = { type: 'text' };
   /**@type {ModelProperty}*/ estado = { type: 'select', Dataset: BasicStates };
   ///**@type {ModelProperty}*/ created_at = { type: 'date' };
   ///**@type {ModelProperty}*/ updated_at = { type: 'date' };
   /**@type {ModelProperty}*/ fecha = { type: 'date', primary: true };
   /**@type {ModelProperty}*/ Cat_Valor_Preguntas = { type: 'WSELECT', ModelObject: () => new Cat_Valor_Preguntas_ModelComponent() };
   /**@type {ModelProperty}*/ Pregunta_Tests = { type: 'WSELECT', ModelObject: () => new Pregunta_Tests_ModelComponent() };
}
export { Resultados_Pregunta_Tests_ModelComponent }
class Resultados_Tests_ModelComponent extends EntityClass {
    constructor(props) {
        super(props, 'EntityQuestionnaires');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
   /**@type {ModelProperty}*/ Id_Perfil = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ fecha = { type: 'date', primary: true };
   /**@type {ModelProperty}*/ seccion = { type: 'text' };
   ///**@type {ModelProperty}*/ created_at = { type: 'date' };
   ///**@type {ModelProperty}*/ updated_at = { type: 'date' };
   /**@type {ModelProperty}*/ valor = { type: 'text' };
   /**@type {ModelProperty}*/ categoria_valor = { type: 'text' };
   /**@type {ModelProperty}*/ tipo = { type: 'text' };
   /**@type {ModelProperty}*/ Tests = { type: 'WSELECT', ModelObject: () => new Tests_ModelComponent() };
}
export { Resultados_Tests_ModelComponent }
class Tests_ModelComponent extends EntityClass {
    constructor(props) {
        super(props, 'EntityQuestionnaires');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
   /**@type {ModelProperty}*/ id_test = { type: 'number', primary: true };
   /**@type {ModelProperty}*/ titulo = { type: 'text' };
   /**@type {ModelProperty}*/ descripcion = { type: 'text', hiddenInTable: true };
   ///**@type {ModelProperty}*/ grado = { type: 'number' };
   ///**@type {ModelProperty}*/ tipo_test = { type: 'text' };
   /**@type {ModelProperty}*/ estado = { type: 'select', Dataset: BasicStates };
   /**@type {ModelProperty}*/ fecha_publicacion = { type: 'date' };
   ///**@type {ModelProperty}*/ created_at = { type: 'date' };
   ///**@type {ModelProperty}*/ updated_at = { type: 'date' };
   ///**@type {ModelProperty}*/ referencias = { type: 'text' };
   /**@type {ModelProperty}*/ tiempo = { type: 'number' };
   /**@type {ModelProperty}*/ caducidad = { type: 'number' };
   /**@type {ModelProperty}*/ color = { type: 'color', defaultValue: "#888" };
   /**@type {ModelProperty}*/ image = { type: 'img' };
   /**@type {ModelProperty}*/ Cat_Categorias_Test = { type: 'WSELECT', ModelObject: () => new Cat_Categorias_Test_ModelComponent() };
   /**@type {ModelProperty}*/ Pregunta_Tests = { type: 'MasterDetail', ModelObject: () => new Pregunta_Tests_ModelComponent() };
    ///**@type {ModelProperty}*/ Resultados_Tests = { type: 'MasterDetail',  ModelObject: ()=> new Resultados_Tests_ModelComponent()};
}
export { Tests_ModelComponent }
