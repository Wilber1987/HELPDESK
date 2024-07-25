import {Tbl_Profile} from "../../WDevCore/Security/Tbl_Profile.js";
import {EntityClass} from "../../WDevCore/WModules/EntityClass.js";
import {Tbl_Servicios} from "./Tbl_Servicios";
import {Tbl_Comments} from "./Tbl_Comments";
import Tbl_Tareas from "./Tbl_Tareas";
import {Cat_Cargos_Dependencias} from "./Cat_Cargos_Dependencias";
import Cat_Dependencias from "./Cat_Dependencias";
import {WAjaxTools} from "../../WDevCore/WModules/WAjaxTools";


class Tbl_Case extends EntityClass {
    /**
    * @param {Partial<Tbl_Case>} props 
    */
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        };
        //this.Mail = undefined;
    }
    Id_Case = { type: 'number', primary: true };
    Id_Vinculate = { type: 'number', hidden: true };
    //image = { type: 'img',   hidden: true};
    firma = { type: 'draw', hidden: true };
    Cat_Dependencias = { type: 'WSelect', hiddenFilter: true, ModelObject: () => new Cat_Dependencias() };
    Tbl_Servicios = { type: 'WSelect', hiddenFilter: true, ModelObject: () => new Tbl_Servicios(), hiddenInTable: true };
    Titulo = { type: 'text' };
    Fecha_Inicio = { type: 'date', hiddenInTable: true, };
    Mail = { type: 'text', hidden: true };
    Estado = { type: "Select", Dataset: ["Activo", "Espera", "Pendiente", "Finalizado"] };
    Case_Priority = { type: "Select", Dataset: ["Alta", "Media", "Baja"], label: "Prioridad", hiddenInTable: true };
    Fecha_Final = { type: 'date', hiddenFilter: true, hiddenInTable: true };
    Descripcion = { type: 'richtext', hiddenFilter: true };
    Tbl_Tareas = { type: 'MasterDetail', ModelObject: () => new Tbl_Tareas() };
    /**
     * @returns {Array<Tbl_Case>}
     */
    GetOwCase = async () => {
        return await this.GetData("Proyect/GetOwCase");
    }
    /**
     * @returns {Array<Tbl_Case>}
     */
    GetOwCloseCase = async () => {
        return await this.GetData("Proyect/GetOwCloseCase");
    }
    /**
     * @returns {Array<Tbl_Case>}
     */
    GetVinculateCase = async () => {
        return await this.GetData("Proyect/GetVinculateCase");
    }
    /**
     * @returns {Array<Tbl_Case>}
     */
    GetOwSolicitudesPendientesAprobar = async () => {
        return await this.GetData("Proyect/GetOwSolicitudesPendientesAprobar");
    }
    /**
     * @returns {Array<Tbl_Case>}
    */
    GetOwSolicitudesPendientes = async () => {
        return await this.GetData("Proyect/GetOwSolicitudesPendientes");
    }
    /**
     * @returns {Array<Tbl_Case>}
     */
    GetOwSolicitudesProceso = async () => {
        return await this.GetData("Proyect/GetOwSolicitudesProceso");
    }
    /**
     * @returns {Array<Tbl_Case>}
     */
    GetOwSolicitudesEspera = async () => {
        return await this.GetData("Proyect/GetOwSolicitudesEspera");
    }
    /**
     * @returns {Array<Tbl_Case>}
     */
    GetSolicitudesPendientesAprobar = async () => {
        return await this.GetData("Proyect/GetSolicitudesPendientesAprobar",);
    }
    /**
     * @returns {Array<Tbl_Case>}
     */
    GetSolicitudesPendientesAprobarAdmin = async () => {
        return await this.GetData("Proyect/GetSolicitudesPendientesAprobarAdmin");
    }
    /**
     * @returns {Object}
     */
    RechazarSolicitud = async () => {
        return await this.GetData("Proyect/RechazarSolicitud");
    }
    /**
     * @returns {Object}
     */
    CerrarCaso = async () => {
        return await this.GetData("Proyect/CerrarCaso");
    }
    /**
    * @param {Array<Tbl_Case>} element
    * @param {Tbl_Case} table_case
    * @returns {Object}
    */
    AprobarCaseList = async (element, table_case) => {
        return await WAjaxTools.PostRequest("/api/Proyect/AprobarCaseList",
            { Tbl_Cases: element, servicio: table_case.Tbl_Servicios });
    }
    /**
       * @param {Array<Tbl_Case>} element
       *  @param {Tbl_Comments} comentario
       * @returns {Object}
       */
    RechazarCaseList = async (element, comentario) => {
        return await WAjaxTools.PostRequest("/api/Proyect/RechazarCaseList", {
            Tbl_Cases: element,
            comentarios: [comentario]
        });
    }
    /**
       * @param {Array<Tbl_Case>} element
       * @param {Tbl_Comments} dependencia
       * @param {Tbl_Case} table_case
       * @param {Array<Tbl_Comments>} comentarios
       * @returns {Object}
       */
    RemitirCasos = async (element, dependencia, comentarios, table_case) => {
        return await WAjaxTools.PostRequest("/api/Proyect/RemitirCasos", {
            Tbl_Cases: element,
            dependencia: dependencia,
            comentarios: comentarios,
            servicio: table_case.Tbl_Servicios
        });
    }
}
export { Tbl_Case }
class Tbl_Dependencias_Usuarios extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Tbl_Profile = { type: 'WSelect', hiddenFilter: true, ModelObject: () => new Tbl_Profile() }
    Cat_Cargos_Dependencias = { type: 'WSelect', hiddenFilter: true, ModelObject: () => new Cat_Cargos_Dependencias() }
}
export { Tbl_Dependencias_Usuarios }

class Tbl_VinculateCase extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Id_Vinculate = { type: 'number', primary: true };
    Descripcion = { type: 'text' };
    //Fecha = { type: 'dated' };


    Casos_Vinculados = {
        type: 'MasterDetail', ModelObject: () => new Tbl_Case(),
        require: false
    };

    VincularCaso = async () => {
        return await this.GetData("Proyect/VincularCaso");
    }
    DesvincularCaso = async () => {
        return await this.GetData("Proyect/DesvincularCaso");
    }
}
export { Tbl_VinculateCase }