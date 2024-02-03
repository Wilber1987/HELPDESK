import { Tbl_Profile } from "../WDevCore/Security/Tbl_Profile.js";
import { EntityClass } from "../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../WDevCore/WModules/WComponentsTools.js";


class Cat_Tipo_Evidencia extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    IdTipo = { type: 'number', primary: true };
    Descripcion = { type: 'text' };
    Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
}
export { Cat_Tipo_Evidencia }

class CaseTable_Evidencias extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    IdEvidencia = { type: 'number', primary: true };
    Cat_Tipo_Evidencia = { type: 'WSelect', hiddenFilter: true, ModelObject: () => new Cat_Tipo_Evidencia() };
    Data = { type: 'file' };
    Id_Tarea = { type: 'number', hidden: true };

}
export { CaseTable_Evidencias }




class Cat_Tipo_Servicio extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Id_Tipo_Servicio = { type: 'number', primary: true };
    Descripcion = { type: 'text' };
    Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
    Icon = { type: 'img' };
    //Tbl_Servicios = { type: 'MasterDetail', ModelObject: () => new Tbl_Servicios() };
}
export { Cat_Tipo_Servicio }
class Tbl_Servicios extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Id_Servicio = { type: 'number', primary: true };
    //Nombre_Proyecto = { type: 'text', label: "Nombre" };
    Descripcion_Servicio = { type: 'text' };
    //Visibilidad = { type: 'text' };
    Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
    //Cat_Tipo_Servicio = { type: 'WSelect', hiddenFilter: true, ModelObject: () => new Cat_Tipo_Servicio() };
    Cat_Dependencias = { type: 'WSelect', hiddenFilter: true, ModelObject: () => new Cat_Dependencias() }
    //Fecha_Inicio = { type: 'date' };
    //Fecha_Finalizacion = { type: 'date' };
    //CaseTable_Case = { type: 'MasterDetail', ModelObject: () => new CaseTable_Case() };
}
export { Tbl_Servicios }

class CaseTable_Case extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        };
        this.Mail = undefined;
    }
    Id_Case = { type: 'number', primary: true };
    Id_Vinculate = { type: 'number', hidden: true };

    Tbl_Servicios = { type: 'WSelect', hiddenFilter: true, ModelObject: () => new Tbl_Servicios() };
    Fecha_Inicio = { type: 'date' };
    Titulo = { type: 'text' };
    Descripcion = { type: 'textarea', hiddenInTable: false, hiddenFilter: true };
    Cat_Dependencias = { type: 'WSelect', hiddenFilter: true, ModelObject: () => new Cat_Dependencias() };
    Estado = { type: "Select", Dataset: ["Activo", "Espera", "Pendiente", "Finalizado"] };
    Case_Priority = { type: "Select", Dataset: ["Alta", "Media", "Baja"], label: "Prioridad" };

    Fecha_Final = { type: 'date' , hiddenFilter: true };

    
    CaseTable_Tareas = { type: 'MasterDetail', ModelObject: () => new CaseTable_Tareas() };
    /**
     * @returns {Array<CaseTable_Case>}
     */
    GetOwCase = async () => {
        return await this.GetData("Proyect/GetOwCase");
    }
    /**
     * @returns {Array<CaseTable_Case>}
     */
    GetOwCloseCase = async () => {
        return await this.GetData("Proyect/GetOwCloseCase");
    }
    /**
     * @returns {Array<CaseTable_Case>}
     */
    GetVinculateCase = async () => {
        return await this.GetData("Proyect/GetVinculateCase");
    }
    /**
     * @returns {Array<CaseTable_Case>}
     */
    GetOwSolicitudesPendientesAprobar = async () => {
        return await this.GetData("Proyect/GetOwSolicitudesPendientesAprobar");
    }
    /**
     * @returns {Array<CaseTable_Case>}
    */
    GetOwSolicitudesPendientes = async () => {
        return await this.GetData("Proyect/GetOwSolicitudesPendientes");
    }
    /**
     * @returns {Array<CaseTable_Case>}
     */
    GetOwSolicitudesProceso = async () => {
        return await this.GetData("Proyect/GetOwSolicitudesProceso");
    }
    /**
     * @returns {Array<CaseTable_Case>}
     */
    GetOwSolicitudesEspera = async () => {
        return await this.GetData("Proyect/GetOwSolicitudesEspera");
    }
    /**
     * @returns {Array<CaseTable_Case>}
     */
    GetSolicitudesPendientesAprobar = async () => {
        return await this.GetData("Proyect/GetSolicitudesPendientesAprobar",);
    }
    /**
     * @returns {Array<CaseTable_Case>}
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
    * @param {Array<CaseTable_Case>} element
    * @param {CaseTable_Case} table_case
    * @returns {Object}
    */
    AprobarCaseList = async (element, table_case) => {
        return await WAjaxTools.PostRequest("/api/Proyect/AprobarCaseList",
            { caseTable_Cases: element, servicio:  table_case.Tbl_Servicios});
    }
    /**
       * @param {Array<CaseTable_Case>} element
       *  @param {CaseTable_Comments} comentario
       * @returns {Object}
       */
    RechazarCaseList = async (element, comentario) => {
        return await WAjaxTools.PostRequest("/api/Proyect/RechazarCaseList", {
            caseTable_Cases: element,
            comentarios: [comentario]
        });
    }
    /**
       * @param {Array<CaseTable_Case>} element
       * @param {CaseTable_Comments} dependencia
       * @param {CaseTable_Case} table_case
       * @param {Array<CaseTable_Comments>} comentarios
       * @returns {Object}
       */
    RemitirCasos = async (element, dependencia, comentarios) => {
        return await WAjaxTools.PostRequest("/api/Proyect/RemitirCasos", {
            caseTable_Cases: element,
            dependencia: dependencia,
            comentarios: comentarios,
            servicio: table_case.Tbl_Servicios
        });
    }
}
export { CaseTable_Case }
class CaseTable_Comments extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        };
        this.Id_Tarea = undefined;
    }
    Id_Comentario = { type: "number", primary: true };
    Estado = { type: "text", hidden: true };
    NickName = { type: "text", hidden: true };
    Body = { type: "textarea", label: "Mensaje" };
    Id_Case = { type: "text", hidden: true };
}
export { CaseTable_Comments }
class CaseTable_Comments_Tasks extends CaseTable_Comments {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Id_Tarea = { type: "text", hidden: true };
}
export { CaseTable_Comments_Tasks }
class CaseTable_Calendario extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Id_Dependencia = { type: 'number', hidden: true };
    IdCalendario = { type: 'number', primary: true };
    Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
    Fecha_Inicio = { type: 'date' };
    Fecha_Final = { type: 'date' };
}
export { CaseTable_Calendario }
class CaseTable_Tareas extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        this.Fecha_Inicio = undefined;
        this.CaseTable_Case = undefined;
        for (const prop in props) {
            this[prop] = props[prop];
        };
    }
    Id_Tarea = { type: 'number', primary: true };
    Titulo = { type: 'text' };
    Id_Case = { type: 'number', hidden: true, value: undefined };
    Descripcion = { type: 'text', hiddenInTable: true };
    CaseTable_Tarea = {
        type: 'WSelect', hiddenFilter: true, label: "Tarea principal", SelfChargeDataset: "CaseTable_Tareas",
        ModelObject: () => new CaseTable_Tareas(), require: false
    };
    //CaseTable_TareasHijas = { type: 'MULTISELECT', hiddenFilter: true, ModelObject: () => new CaseTable_Tareas() };
    Estado = { type: "Select", Dataset: ["Activo", "Proceso", "Finalizado", "Espera", "Inactivo"] };
    CaseTable_Participantes = { type: 'MasterDetail', ModelObject: () => new CaseTable_Participantes() };
    //CaseTable_Evidencias = { type: 'MasterDetail', require: false, ModelObject: () => new CaseTable_Evidencias() };
    CaseTable_Calendario = {
        type: 'CALENDAR',
        ModelObject: () => new CaseTable_Calendario(),
        require: true,
        hiddenInTable: true,
        CalendarFunction: () => { }
    };
    GetOwParticipations = async () => {
        return await this.GetData("Proyect/GetOwParticipations");
    }
}
export { CaseTable_Tareas }
class CaseTable_Participantes extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Tbl_Profile = { type: 'WSelect', hiddenFilter: true, ModelObject: () => new Tbl_Profile() }
    Cat_Tipo_Participaciones = { type: 'WSelect', hiddenFilter: true, ModelObject: () => new Cat_Tipo_Participaciones() }
}
export { CaseTable_Participantes }
class Cat_Cargos_Dependencias extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    IdCargo = { type: 'number', primary: true };
    Descripcion = { type: 'text' };
    //CaseTable_Dependencias_Usuarios = { type: 'MasterDetail', ModelObject: () => new CaseTable_Dependencias_Usuarios() };
}
export { Cat_Cargos_Dependencias }
class Cat_Dependencias extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        };
        this.NCasos = undefined;
        this.NCasosFinalizados = undefined;
    }
    Id_Dependencia = { type: 'number', primary: true, hiddenFilter: true };
    Descripcion = { type: 'text' };
    Username = { type: 'email' };
    Password = { type: 'text', hiddenInTable: true, require: false, hiddenFilter: true };
    Host = { type: 'text' };
    HostService = { type: 'select', Dataset: ["OUTLOOK", 'GMAIL'], hiddenInTable: true, require: false };
    AutenticationType = { type: 'select', Dataset: ["AUTH2", "BASIC"], hiddenInTable: true, require: false, hiddenFilter: true };
    TENAT = { type: 'text', hiddenInTable: true, require: false, hiddenFilter: true };
    CLIENT = { type: 'text', hiddenInTable: true, require: false, hiddenFilter: true };
    OBJECTID = { type: 'text', hiddenInTable: true, require: false, hiddenFilter: true };
    CLIENT_SECRET = { type: 'text', hiddenInTable: true, require: false, hiddenFilter: true };
    SMTPHOST = { type: 'text', hiddenInTable: true, require: false, hiddenFilter: true };

    //Cat_Dependencia = { type: 'WSelect', hiddenFilter: true, ModelObject: () => new Cat_Dependencias(), require: false };
    Cat_Dependencias_Hijas = { type: 'Multiselect', hiddenFilter: true, ModelObject: () => new Cat_Dependencias(), require: false };
    CaseTable_Agenda = { type: 'MasterDetail', ModelObject: () => new CaseTable_Agenda() };
    CaseTable_Dependencias_Usuarios = { type: 'MasterDetail', ModelObject: () => new CaseTable_Dependencias_Usuarios(), require: false };
    GetOwDependencies = async () => {
        return await this.GetData("Proyect/GetOwDependencies");
    }
}
export { Cat_Dependencias }
class Cat_Tipo_Participaciones extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Id_Tipo_Participacion = { type: 'number', primary: true };
    Descripcion = { type: 'text' };
    CaseTable_Participantes = { type: 'MasterDetail', ModelObject: () => new CaseTable_Participantes() };
}
export { Cat_Tipo_Participaciones }
class CaseTable_Agenda extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Id_Dependencia = { type: 'number', hidden: true };
    IdAgenda = { type: 'number', primary: true };
    Dia = { type: 'Select', Dataset: ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"] };
    Hora_Inicial = { type: 'HORA' };
    Hora_Final = { type: 'HORA' };
    Fecha_Caducidad = { type: 'date' };
}
export { CaseTable_Agenda }
class CaseTable_Dependencias_Usuarios extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Tbl_Profile = { type: 'WSelect', hiddenFilter: true, ModelObject: () => new Tbl_Profile() }
    Cat_Cargos_Dependencias = { type: 'WSelect', hiddenFilter: true, ModelObject: () => new Cat_Cargos_Dependencias() }
}
export { CaseTable_Dependencias_Usuarios }

class Cat_Paises extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Id_Pais = { type: 'number', primary: true };
    Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
    Descripcion = { type: 'text' };
}
export { Cat_Paises }

class CaseTable_VinculateCase extends EntityClass {
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
        type: 'MasterDetail', ModelObject: () => new CaseTable_Case(),
        require: false
    };

    VincularCaso = async () => {
        return await this.GetData("Proyect/VincularCaso");
    }
    DesvincularCaso = async () => {
        return await this.GetData("Proyect/DesvincularCaso");
    }
}
export { CaseTable_VinculateCase }