
class Tbl_Profile {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Investigador = { type: "number", primary: true };
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

class Cat_Tipo_Proyecto {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Tipo_Proyecto = { type: "number", primary: true };
	Descripcion_Tipo_Proyecto = { type: "text" };
	Estado_Tipo_Proyecto = { type: "text" };
	Icon = { type: "IMAGE" };
}
export { Cat_Tipo_Proyecto }
class Tbl_Proyectos {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Proyecto = { type: "number", primary: true };
	Nombre_Proyecto = { type: "text" };
	DescripcionProyecto = { type: "text" };
	Id_Tipo_Proyecto = { type: "number" };
	Visibilidad = { type: "text" };
	Estado_Proyecto = { type: "text" };
	Fecha_Inicio = { type: "date" };
	Fecha_Finalizacion = { type: "date" };
}
export { Tbl_Proyectos }
class Cat_Cargo_Proyecto {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Cargo_Proyecto = { type: "number", primary: true };
	Descripcion = { type: "text", hiddenInTable: true };
	Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
}
export { Cat_Cargo_Proyecto }
class Tbl_Participantes_Proyectos {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Proyecto = { type: "number", primary: true };
	Id_Investigador = { type: "number", hidden: true };
	Id_Cargo_Proyecto = { type: "number" };
	Fecha_Ingreso = { type: "date" };
	Estado_Participante = { type: "text" };
}
export { Tbl_Participantes_Proyectos }
class ViewParticipantesProyectos {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Investigador = { type: "number", primary: true };
	Id_Proyecto = { type: "number" };
	Fecha_Ingreso = { type: "date" };
	Estado_Participante = { type: "text" };
	DescripcionProyecto = { type: "text" };
	Fecha_Inicio = { type: "date" };
	Fecha_Finalizacion = { type: "date" };
	Visibilidad = { type: "text" };
	Cargo = { type: "text" };
	Descripcion_Tipo_Proyecto = { type: "text" };
	Estado_Tipo_Proyecto = { type: "text" };
	Nombre_Proyecto = { type: "text" };
	Estado_Proyecto = { type: "text" };
}
export { ViewParticipantesProyectos }

class ProyectoTableActividades {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	IdActividad = { type: "number", primary: true };
	Titulo = { type: "text" };
	Descripcion = { type: "text", hiddenInTable: true };
	Id_Investigador = { type: "number", hidden: true };
	Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
	Id_Dependencia = { type: "number" };
	Fecha_Inicial = { type: "date" };
	Fecha_Final = { type: "date" };
	Id_Proyecto = { type: "number" };
}
export { ProyectoTableActividades }

class ProyectoTableCalendario {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	IdCalendario = { type: "number", primary: true };
	IdTarea = { type: "number" };
	Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
	Fecha_Inicial = { type: "date" };
	Fecha_Final = { type: "date" };
}
export { ProyectoTableCalendario }

class ProyectoTableTareas {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	IdTarea = { type: "number", primary: true };
	Titulo = { type: "text" };
	IdTareaPadre = { type: "number" };
	IdActividad = { type: "number" };
	Descripcion = { type: "text", hiddenInTable: true };
	Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
}
export { ProyectoTableTareas }

class ViewCalendarioByDependencia {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Dependencia = { type: "number", primary: true };
	IdActividad = { type: "number" };
	IdTareaPadre = { type: "number" };
	Fecha_Inicial = { type: "date" };
	Fecha_Final = { type: "date" };
	Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
	IdCalendario = { type: "number" };
	IdTarea = { type: "number" };
}
export { ViewCalendarioByDependencia }
class ProyectoTableParticipantes {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Investigador = { type: "number", primary: true };
	IdTarea = { type: "number" };
	IdTipoParticipacion = { type: "number" };
}
export { ProyectoTableParticipantes }

class ViewActividadesParticipantes {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	IdActividad = { type: "number", primary: true };
	Titulo = { type: "text" };
	Descripcion = { type: "text", hiddenInTable: true };
	Estado = { type: "Select", Dataset: ["Activo", "Inactivo"] };
	IdUsuario = { type: "number" };
}
export { ViewActividadesParticipantes }

class ProyectoCatCargosDependencias {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	IdCargo = { type: "number", primary: true };
	Descripcion = { type: "text", hiddenInTable: true };
}
export { ProyectoCatCargosDependencias }

class ProyectoCatTipoParticipaciones {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	IdTipoParticipacion = { type: "number", primary: true };
	Descripcion = { type: "text", hiddenInTable: true };
}
export { ProyectoCatTipoParticipaciones }

class ProyectoTableAgenda {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	IdAgenda = { type: "number", primary: true };
	Id_Investigador = { type: "number", hidden: true };
	Id_Dependencia = { type: "number" };
	Dia = { type: "text" };
	Hora_Inicial = { type: "text" };
	Hora_Final = { type: "text" };
	Fecha_Caducidad = { type: "date" };
}
export { ProyectoTableAgenda }

class ProyectoTableDependencias_Usuarios {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	Id_Investigador = { type: "number", hidden: true };
	Id_Dependencia = { type: "number" };
	Id_Cargo = { type: "number" };
}
export { ProyectoTableDependencias_Usuarios }

class ProyectoTableEvidencias {
	constructor(props) {
		for (const prop in props) {
			this[prop] = props[prop];
		}
	}
	IdEvidencia = { type: "number", primary: true };
	IdTipo = { type: "number" };
	Data = { type: "text" };
	IdTarea = { type: "number" };
}
export { ProyectoTableEvidencias }
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

