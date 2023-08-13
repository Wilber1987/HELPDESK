
class Tbl_Profile {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Perfil = { type: "number", primary: true };
	Nombres = { type: "text" };
	Apellidos = { type: "text" };
	FechaNac = { type: "date" };
	//IdUser = { type: "number" };
	Sexo = { type: "text" };
	Foto = { type: "IMAGE" };
	DNI = { type: "text" };
	Correo_institucional = { type: "text" };
	Id_Pais_Origen = { type: "number" };
	Id_Institucion = { type: "number" };
	Estado = { type: "Select", Dataset: ["Activo", "Inactivo", "Postulante"] };
}
export { Tbl_Profile }

class Cat_Tipo_Servicio {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Tipo_Servicio = { type: "number", primary: true };
	Descripcion = { type: "text" };
	Estado = { type: "text" };
	Icon = { type: "IMAGE" };
}
export { Cat_Tipo_Servicio }
class Tbl_Servicios {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Servicio = { type: "number", primary: true };
	Nombre_Proyecto = { type: "text" };
	Descripcion_Servicio = { type: "text" };
	Id_Tipo_Servicio = { type: "number" };
	Visibilidad = { type: "text" };
	Estado = { type: "text" };
	Fecha_Inicio = { type: "date" };
	Fecha_Finalizacion = { type: "date" };
}
export { Tbl_Servicios }


class ViewParticipantesServicios {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Perfil = { type: "number", primary: true };
	Id_Servicio = { type: "number" };
	Fecha_Ingreso = { type: "date" };
	Estado_Participante = { type: "text" };
	Descripcion_Servicio = { type: "text" };
	Fecha_Inicio = { type: "date" };
	Fecha_Finalizacion = { type: "date" };
	Visibilidad = { type: "text" };
	Cargo = { type: "text" };
	Descripcion = { type: "text" };
	Estado = { type: "text" };
	Nombre_Proyecto = { type: "text" };
	Estado = { type: "text" };
}
export { ViewParticipantesServicios }

class CaseTable_Case {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Case = { type: "number", primary: true };
	Titulo = { type: "text" };
	Descripcion = { type: "text", hiddenInTable: true };
	Id_Perfil = { type: "number", hidden: true };
	Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
	Id_Dependencia = { type: "number" };
	Fecha_Inicial = { type: "date" };
	Fecha_Final = { type: "date" };
	Id_Servicio = { type: "number" };
}
export { CaseTable_Case }

class CaseTable_Calendario {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	IdCalendario = { type: "number", primary: true };
	Id_Tarea = { type: "number" };
	Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
	Fecha_Inicial = { type: "date" };
	Fecha_Final = { type: "date" };
}
export { CaseTable_Calendario }

class CaseTable_Tareas {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Tarea = { type: "number", primary: true };
	Titulo = { type: "text" };
	Id_TareaPadre = { type: "number" };
	Id_Case = { type: "number" };
	Descripcion = { type: "text", hiddenInTable: true };
	Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
}
export { CaseTable_Tareas }

class ViewCalendarioByDependencia {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Dependencia = { type: "number", primary: true };
	Id_Case = { type: "number" };
	Id_TareaPadre = { type: "number" };
	Fecha_Inicial = { type: "date" };
	Fecha_Final = { type: "date" };
	Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
	IdCalendario = { type: "number" };
	Id_Tarea = { type: "number" };
}
export { ViewCalendarioByDependencia }
class CaseTable_Participantes {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Perfil = { type: "number", primary: true };
	Id_Tarea = { type: "number" };
	Id_Tipo_Participacion = { type: "number" };
}
export { CaseTable_Participantes }

class ViewActividadesParticipantes {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Case = { type: "number", primary: true };
	Titulo = { type: "text" };
	Descripcion = { type: "text", hiddenInTable: true };
	Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
	IdUsuario = { type: "number" };
}
export { ViewActividadesParticipantes }

class Cat_Cargos_Dependencias {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	IdCargo = { type: "number", primary: true };
	Descripcion = { type: "text", hiddenInTable: true };
}
export { Cat_Cargos_Dependencias }

class Cat_Tipo_Participaciones {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Tipo_Participacion = { type: "number", primary: true };
	Descripcion = { type: "text", hiddenInTable: true };
}
export { Cat_Tipo_Participaciones }

class CaseTable_Agenda {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	IdAgenda = { type: "number", primary: true };
	Id_Perfil = { type: "number", hidden: true };
	Id_Dependencia = { type: "number" };
	Dia = { type: "text" };
	Hora_Inicial = { type: "text" };
	Hora_Final = { type: "text" };
	Fecha_Caducidad = { type: "date" };
}
export { CaseTable_Agenda }

class CaseTable_Dependencias_Usuarios {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Perfil = { type: "number", hidden: true };
	Id_Dependencia = { type: "number" };
	Id_Cargo = { type: "number" };
}
export { CaseTable_Dependencias_Usuarios }

class CaseTable_Evidencias {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	IdEvidencia = { type: "number", primary: true };
	IdTipo = { type: "number" };
	Data = { type: "text" };
	Id_Tarea = { type: "number" };
}
export { CaseTable_Evidencias }
class Cat_Cargos {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Cargo = { type: "number", primary: true };
	Descripcion = { type: "text", hiddenInTable: true };
	Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
}
export { Cat_Cargos }

