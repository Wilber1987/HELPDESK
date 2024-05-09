//@ts-check
import { EntityClass } from "../../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../../WDevCore/WModules/WComponentsTools.js";
//@ts-ignore
import { ModelProperty } from "../../WDevCore/WModules/CommonModel.js";
import { Cat_Paises }  from './Cat_Paises.js'
import { Security_Users }  from './Security_Users.js'
import { CaseTable_Agenda }  from './CaseTable_Agenda.js'
import { CaseTable_Case }  from './CaseTable_Case.js'
import { CaseTable_Dependencias_Usuarios }  from './CaseTable_Dependencias_Usuarios.js'
import { CaseTable_Participantes }  from './CaseTable_Participantes.js'
import { Tbl_Profile_CasosAsignados }  from './Tbl_Profile_CasosAsignados.js'
import { Tbl_Servicios_Profile }  from './Tbl_Servicios_Profile.js'
class Tbl_Profile extends EntityClass {
   constructor(props) {
       super(props, 'EntitySecurity');
       for (const prop in props) {
           this[prop] = props[prop];
       }
   }
   /**@type {Number}*/ Id_Perfil;
   /**@type {String}*/ Nombres;
   /**@type {String}*/ Apellidos;
   /**@type {Date}*/ FechaNac;
   /**@type {String}*/ Sexo;
   /**@type {String}*/ Foto;
   /**@type {String}*/ DNI;
   /**@type {String}*/ Correo_institucional;
   /**@type {String}*/ Estado;
   /**@type {Cat_Paises} ManyToOne*/ Cat_Paises;
   /**@type {Security_Users} ManyToOne*/ Security_Users;
   /**@type {Array<CaseTable_Agenda>} OneToMany*/ CaseTable_Agenda;
   /**@type {Array<CaseTable_Case>} OneToMany*/ CaseTable_Case;
   /**@type {Array<CaseTable_Dependencias_Usuarios>} OneToMany*/ CaseTable_Dependencias_Usuarios;
   /**@type {Array<CaseTable_Participantes>} OneToMany*/ CaseTable_Participantes;
   /**@type {Array<Tbl_Profile_CasosAsignados>} OneToMany*/ Tbl_Profile_CasosAsignados;
   /**@type {Array<Tbl_Servicios_Profile>} OneToMany*/ Tbl_Servicios_Profile;
}
export { Tbl_Profile }
