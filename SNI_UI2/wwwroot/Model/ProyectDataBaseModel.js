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
    Cat_Tipo_Evidencia = { type: 'WSelect', ModelObject: () => new Cat_Tipo_Evidencia() };
    Data = { type: 'file' };

}
export { CaseTable_Evidencias }


class Tbl_Profile extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Id_Perfil = { type: 'number', primary: true };
    Nombres = { type: 'text' };
    Apellidos = { type: 'text' };
    FechaNac = { type: 'date' };
    Sexo = { type: 'text' };
    Foto = { type: 'img' };
    DNI = { type: 'text' };
    Correo_institucional = { type: 'text' };
    Indice_H = { type: 'text' };
    Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
}
export { Tbl_Profile }

class Cat_Tipo_Servicio extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Id_Tipo_Servicio = { type: 'number', primary: true };
    Descripcion = { type: 'text' };
    Estado = { type: 'text' };
    Icon = { type: 'img' };
    Tbl_Servicios = { type: 'MasterDetail', ModelObject: () => new Tbl_Servicios() };
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
    Nombre_Proyecto = { type: 'text' };
    Descripcion_Servicio = { type: 'text' };
    Visibilidad = { type: 'text' };
    Estado = { type: 'text' };
    Fecha_Inicio = { type: 'date' };
    Fecha_Finalizacion = { type: 'date' };
    CaseTable_Case = { type: 'MasterDetail', ModelObject: () => new CaseTable_Case() };
}
export { Tbl_Servicios }

class CaseTable_Case extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Id_Case = { type: 'number', primary: true };

    Titulo = { type: 'text' };
    Tbl_Servicios = { type: 'WSelect', ModelObject: () => new Tbl_Servicios() };
    Fecha_Inicial = { type: 'date' };

    Cat_Dependencias = { type: 'WSelect', ModelObject: () => new Cat_Dependencias() };
    Estado = { type: "Select", Dataset: ["Activo", "Espera", "Pendiente", "Finalizado"] };
    Fecha_Final = { type: 'date' };

    Descripcion = { type: 'textarea', hiddenInTable: true, hiddenInFilter: true };
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
        return await this.GetData("Proyect/GetSolicitudesPendientesAprobar");
    }
    /**
     * @returns {Object}
     */
    RechazarSolicitud = async () => {
        return await this.GetData("Proyect/RechazarSolicitud");
    }
}
export { CaseTable_Case }
class CaseTable_Comments extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Id_Comentario = { type: "number", primary: true };
    Estado = { type: "text", hidden: true };
    NickName = { type: "text", hidden: true };
    Body = { type: "textarea", label: "Mensaje" };
    Id_Case = { type: "text", hidden: true };
}


export { CaseTable_Comments }
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
    Fecha_Inicial = { type: 'date' };
    Fecha_Final = { type: 'date' };
}
export { CaseTable_Calendario }
class CaseTable_Tareas extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Id_Tarea = { type: 'number', primary: true };
    Titulo = { type: 'text' };
    Id_Case = { type: 'number', hidden: true, value: undefined };
    Descripcion = { type: 'text', hiddenInTable: true };
    CaseTable_Tarea = {
        type: 'WSelect', label: "Tarea principal", SelfChargeDataset: "CaseTable_Tareas",
        ModelObject: () => new CaseTable_Tareas(), require: false
    };
    //CaseTable_TareasHijas = { type: 'MULTISELECT', ModelObject: () => new CaseTable_Tareas() };
    Estado = { type: "Select", Dataset: ["Activo", "Proceso", "Finalizado", "Espera", "Inactivo"] };
    CaseTable_Participantes = { type: 'MasterDetail', ModelObject: () => new CaseTable_Participantes() };
    //CaseTable_Evidencias = { type: 'MasterDetail', require: false, ModelObject: () => new CaseTable_Evidencias() };
    CaseTable_Calendario = {
        type: 'CALENDAR',
        ModelObject: () => new CaseTable_Calendario(),
        require: false,
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
    Tbl_Profile = { type: 'WSelect', ModelObject: () => new Tbl_Profile() }
    Cat_Tipo_Participaciones = { type: 'WSelect', ModelObject: () => new Cat_Tipo_Participaciones() }
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
    CaseTable_Dependencias_Usuarios = { type: 'MasterDetail', ModelObject: () => new CaseTable_Dependencias_Usuarios() };
}
export { Cat_Cargos_Dependencias }
class Cat_Dependencias extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Id_Dependencia = { type: 'number', primary: true };
    Descripcion = { type: 'text' };
    Cat_Dependencia = { type: 'WSelect', ModelObject: () => new Cat_Dependencias(), require: false };
    Cat_Dependencias_Hijas = { type: 'Multiselect', ModelObject: () => new Cat_Dependencias(), require: false };
    CaseTable_Agenda = { type: 'MasterDetail', ModelObject: () => new CaseTable_Agenda(), require: false };
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
    Tbl_Profile = { type: 'WSelect', ModelObject: () => new Tbl_Profile() }
    Cat_Cargos_Dependencias = { type: 'WSelect', ModelObject: () => new Cat_Cargos_Dependencias() }
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