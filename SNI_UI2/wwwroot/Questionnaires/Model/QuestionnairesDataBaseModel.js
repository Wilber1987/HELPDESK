import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
class Cat_Categorias_Test extends EntityClass {
   constructor(props) {
       super(props, 'EntityQuestionnaires');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ id_categoria;
   /**@type {String}*/ descripcion;
   /**@type {String}*/ imagen;
   /**@type {String}*/ estado;
   /**@type {Date}*/ created_at;
   /**@type {Date}*/ updated_at;
   /**@type {Array<Tests>} OneToMany*/ Tests;
}
export { Cat_Categorias_Test }
class Cat_Tipo_Preguntas extends EntityClass {
   constructor(props) {
       super(props, 'EntityQuestionnaires');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ id_tipo_pregunta;
   /**@type {String}*/ tipo_pregunta;
   /**@type {String}*/ descripcion;
   /**@type {String}*/ estado;
   /**@type {Date}*/ fecha_crea;
   /**@type {Date}*/ created_at;
   /**@type {Date}*/ updated_at;
   /**@type {Boolean}*/ editable;
   /**@type {String}*/ descripcion_general;
   /**@type {Array<Cat_Valor_Preguntas>} OneToMany*/ Cat_Valor_Preguntas;
   /**@type {Array<Pregunta_Tests>} OneToMany*/ Pregunta_Tests;
}
export { Cat_Tipo_Preguntas }
class Cat_Valor_Preguntas extends EntityClass {
   constructor(props) {
       super(props, 'EntityQuestionnaires');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ id_valor_pregunta;
   /**@type {String}*/ descripcion;
   /**@type {String}*/ estado;
   /**@type {Number}*/ valor;
   /**@type {Date}*/ created_at;
   /**@type {Date}*/ updated_at;
   /**@type {Cat_Tipo_Preguntas} ManyToOne*/ Cat_Tipo_Preguntas;
   /**@type {Array<Resultados_Pregunta_Tests>} OneToMany*/ Resultados_Pregunta_Tests;
}
export { Cat_Valor_Preguntas }
class Pregunta_Tests extends EntityClass {
   constructor(props) {
       super(props, 'EntityQuestionnaires');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ id_pregunta_test;
   /**@type {String}*/ estado;
   /**@type {String}*/ descripcion_pregunta;
   /**@type {Date}*/ fecha;
   /**@type {Date}*/ created_at;
   /**@type {Date}*/ updated_at;
   /**@type {String}*/ seccion;
   /**@type {String}*/ descripcion_general;
   /**@type {Cat_Tipo_Preguntas} ManyToOne*/ Cat_Tipo_Preguntas;
   /**@type {Tests} ManyToOne*/ Tests;
   /**@type {Array<Resultados_Pregunta_Tests>} OneToMany*/ Resultados_Pregunta_Tests;
}
export { Pregunta_Tests }
class Resultados_Pregunta_Tests extends EntityClass {
   constructor(props) {
       super(props, 'EntityQuestionnaires');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ Id_Perfil;
   /**@type {Number}*/ resultado;
   /**@type {String}*/ respuesta;
   /**@type {String}*/ estado;
   /**@type {Date}*/ created_at;
   /**@type {Date}*/ updated_at;
   /**@type {Date}*/ fecha;
   /**@type {Cat_Valor_Preguntas} ManyToOne*/ Cat_Valor_Preguntas;
   /**@type {Pregunta_Tests} ManyToOne*/ Pregunta_Tests;
}
export { Resultados_Pregunta_Tests }
class Resultados_Tests extends EntityClass {
   constructor(props) {
       super(props, 'EntityQuestionnaires');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ Id_Perfil;
   /**@type {Date}*/ fecha;
   /**@type {String}*/ seccion;
   /**@type {Date}*/ created_at;
   /**@type {Date}*/ updated_at;
   /**@type {String}*/ valor;
   /**@type {String}*/ categoria_valor;
   /**@type {String}*/ tipo;
   /**@type {Tests} ManyToOne*/ Tests;
}
export { Resultados_Tests }
class Tests extends EntityClass {
   constructor(props) {
       super(props, 'EntityQuestionnaires');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ id_test;
   /**@type {String}*/ titulo;
   /**@type {String}*/ descripcion;
   /**@type {Number}*/ grado;
   /**@type {String}*/ tipo_test;
   /**@type {String}*/ estado;
   /**@type {Date}*/ fecha_publicacion;
   /**@type {Date}*/ created_at;
   /**@type {Date}*/ updated_at;
   /**@type {String}*/ referencias;
   /**@type {Number}*/ tiempo;
   /**@type {Number}*/ caducidad;
   /**@type {String}*/ color;
   /**@type {String}*/ image;
   /**@type {Cat_Categorias_Test} ManyToOne*/ Cat_Categorias_Test;
   /**@type {Array<Pregunta_Tests>} OneToMany*/ Pregunta_Tests;
   /**@type {Array<Resultados_Tests>} OneToMany*/ Resultados_Tests;
}
export { Tests }
