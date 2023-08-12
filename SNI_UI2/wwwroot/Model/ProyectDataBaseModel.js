import { EntityClass } from "../WDevCore/WModules/EntityClass.js";
import { WAjaxTools } from "../WDevCore/WModules/WComponentsTools.js";


class CatalogoTipoEvidencia extends EntityClass {
    constructor(props) {
        super(props, 'EntityDBO');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    IdTipo = { type: 'number', primary: true };
    Descripcion = { type: 'text' };
    Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
}
export { CatalogoTipoEvidencia }

class ProyectoTableEvidencias extends EntityClass {
    constructor(props) {
        super(props, 'EntityDBO');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    IdEvidencia = { type: 'number', primary: true };
    CatalogoTipoEvidencia = { type: 'WSelect', ModelObject: () => new CatalogoTipoEvidencia() };
    Data = { type: 'file' };

}
export { ProyectoTableEvidencias }
class Cat_Tipo_Asociacion {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Tipo_Asociacion = { type: "number", primary: true };
	Descripcion = { type: "text", hiddenInTable: true };
	Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
}
export { Cat_Tipo_Asociacion }

class Cat_instituciones extends EntityClass {
    constructor(props) {
        super(props, 'EntityDBO');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Id_Institucion = { type: 'number', primary: true };
    Nombre = { type: 'text' };
    Direccion = { type: 'text' };
    Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
    Logo = { type: 'img' };
    ProyectoCatDependencias = { type: 'MasterDetail', ModelObject: () => new ProyectoCatDependencias() };
}
export { Cat_instituciones }
class Tbl_Profile extends EntityClass {
    constructor(props) {
        super(props, 'EntityDBO');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Id_Investigador = { type: 'number', primary: true };
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

class Cat_Tipo_Proyecto extends EntityClass {
    constructor(props) {
        super(props, 'EntityDBO');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Id_Tipo_Proyecto = { type: 'number', primary: true };
    Descripcion_Tipo_Proyecto = { type: 'text' };
    Estado_Tipo_Proyecto = { type: 'text' };
    Icon = { type: 'img' };
    Tbl_Proyectos = { type: 'MasterDetail', ModelObject: () => new Tbl_Proyectos() };
}
export { Cat_Tipo_Proyecto }
class Tbl_Proyectos extends EntityClass {
    constructor(props) {
        super(props, 'EntityDBO');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Id_Proyecto = { type: 'number', primary: true };
    Nombre_Proyecto = { type: 'text' };
    DescripcionProyecto = { type: 'text' };
    Visibilidad = { type: 'text' };
    Estado_Proyecto = { type: 'text' };
    Fecha_Inicio = { type: 'date' };
    Fecha_Finalizacion = { type: 'date' };
    ProyectoTableActividades = { type: 'MasterDetail', ModelObject: () => new ProyectoTableActividades() };
    Tbl_Participantes_Proyectos = { type: 'MasterDetail', ModelObject: () => new Tbl_Participantes_Proyectos() };
}
export { Tbl_Proyectos }
class Cat_Cargo_Proyecto extends EntityClass {
    constructor(props) {
        super(props, 'EntityDBO');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Id_Cargo_Proyecto = { type: 'number', primary: true };
    Descripcion = { type: 'text', hiddenInTable: true };
    Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
    Tbl_Participantes_Proyectos = { type: 'MasterDetail', ModelObject: () => new Tbl_Participantes_Proyectos() };
}
export { Cat_Cargo_Proyecto }
class Tbl_Participantes_Proyectos extends EntityClass {
    constructor(props) {
        super(props, 'EntityDBO');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Fecha_Ingreso = { type: 'date' };
    Estado_Participante = { type: 'text' };
}
export { Tbl_Participantes_Proyectos }

class ProyectoTableActividades extends EntityClass {
    constructor(props) {
        super(props, 'EntityDBO');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    IdActividad = { type: 'number', primary: true };
    Titulo = { type: 'text' };
    Descripcion = { type: 'text', hiddenInTable: true };
    Estado = { type: "Select", Dataset: ["Activo", "Inactivo", "En Proceso", "Pendientes", "Finalizada"] };
    Fecha_Inicial = { type: 'date' };
    Fecha_Final = { type: 'date' };
    ProyectoCatDependencias = { type: 'WSelect', ModelObject: () => new ProyectoCatDependencias() };
    ProyectoTableTareas = { type: 'MasterDetail', ModelObject: () => new ProyectoTableTareas() };
    GetOwActivities = async () => {
        return await this.GetData("Proyect/GetOwActivities");
    }
}
export { ProyectoTableActividades }
class ProyectoTableCalendario extends EntityClass {
    constructor(props) {
        super(props, 'EntityDBO');
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
export { ProyectoTableCalendario }
class ProyectoTableTareas extends EntityClass {
    constructor(props) {
        super(props, 'EntityDBO');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    IdTarea = { type: 'number', primary: true };
    Titulo = { type: 'text' };
    IdActividad = { type: 'number', hidden: true, value: undefined };
    Descripcion = { type: 'text', hiddenInTable: true };
    ProyectoTableTarea = { type: 'WSelect', ModelObject: () => new ProyectoTableTareas() };
    //ProyectoTableTareasHijas = { type: 'MULTISELECT', ModelObject: () => new ProyectoTableTareas() };
    Estado = { type: "Select", Dataset: ["Activo", "En Proceso", "En Espera", "Finalizada", "Inactivo"] };
    ProyectoTableParticipantes = { type: 'MasterDetail', ModelObject: () => new ProyectoTableParticipantes() };
    //ProyectoTableEvidencias = { type: 'MasterDetail', require: false, ModelObject: () => new ProyectoTableEvidencias() };
    ProyectoTableCalendario = {
        type: 'CALENDAR',
        ModelObject: () => new ProyectoTableCalendario(),
        require: false,
        hiddenInTable: true,
        CalendarFunction: () => { }
    };
    GetOwParticipations = async () => {
        return await this.GetData("Proyect/GetOwParticipations");
    }
}
export { ProyectoTableTareas }
class ProyectoTableParticipantes extends EntityClass {
    constructor(props) {
        super(props, 'EntityDBO');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Tbl_Profile = { type: 'WSelect', ModelObject: () => new Tbl_Profile() }
    ProyectoCatTipoParticipaciones = { type: 'WSelect', ModelObject: () => new ProyectoCatTipoParticipaciones() }    
}
export { ProyectoTableParticipantes }
class ProyectoCatCargosDependencias extends EntityClass {
    constructor(props) {
        super(props, 'EntityDBO');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    IdCargo = { type: 'number', primary: true };
    Descripcion = { type: 'text' };
    ProyectoTableDependencias_Usuarios = { type: 'MasterDetail', ModelObject: () => new ProyectoTableDependencias_Usuarios() };
}
export { ProyectoCatCargosDependencias }
class ProyectoCatDependencias extends EntityClass {
    constructor(props) {
        super(props, 'EntityDBO');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Id_Dependencia = { type: 'number', primary: true };
    Descripcion = { type: 'text' };
    ProyectoCatDependencia = { type: 'WSelect', ModelObject: () => new ProyectoCatDependencias(), require: false };
    Cat_instituciones = { type: 'WSelect', ModelObject: () => new Cat_instituciones() };
    ProyectoCatDependencias_Hijas = { type: 'Multiselect', ModelObject: () => new ProyectoCatDependencias(), require: false };
    ProyectoTableAgenda = { type: 'MasterDetail', ModelObject: () => new ProyectoTableAgenda(), require: false };
    ProyectoTableDependencias_Usuarios = { type: 'MasterDetail', ModelObject: () => new ProyectoTableDependencias_Usuarios(), require: false };
    GetOwDependencies = async () => {
        return await this.GetData("Proyect/GetOwDependencies");
    }
}
export { ProyectoCatDependencias }
class ProyectoCatTipoParticipaciones extends EntityClass {
    constructor(props) {
        super(props, 'EntityDBO');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    IdTipoParticipacion = { type: 'number', primary: true };
    Descripcion = { type: 'text', hiddenInTable: true };
    ProyectoTableParticipantes = { type: 'MasterDetail', ModelObject: () => new ProyectoTableParticipantes() };
}
export { ProyectoCatTipoParticipaciones }
class ProyectoTableAgenda extends EntityClass {
    constructor(props) {
        super(props, 'EntityDBO');
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
export { ProyectoTableAgenda }
class ProyectoTableDependencias_Usuarios extends EntityClass {
    constructor(props) {
        super(props, 'EntityDBO');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }
    Tbl_Profile = { type: 'WSelect', ModelObject: () => new Tbl_Profile() }
    ProyectoCatCargosDependencias = { type: 'WSelect', ModelObject: () => new ProyectoCatCargosDependencias() }
}
export { ProyectoTableDependencias_Usuarios }
