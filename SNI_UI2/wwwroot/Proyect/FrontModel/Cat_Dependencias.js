import {EntityClass} from "../../WDevCore/WModules/EntityClass.js";

class Cat_Dependencias extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
        ;
        this.NCasos = undefined;
        this.NCasosFinalizados = undefined;
    }

    Id_Dependencia = {type: 'number', primary: true, hiddenFilter: true};
    Descripcion = {type: 'text'};
    Username = {type: 'email'};
    Password = {type: 'text', hiddenInTable: true, require: false, hiddenFilter: true};
    Host = {type: 'text'};
    HostService = {type: 'select', Dataset: ["OUTLOOK", 'GMAIL'], hiddenInTable: true, require: false};
    AutenticationType = {
        type: 'select',
        Dataset: ["AUTH2", "BASIC"],
        hiddenInTable: true,
        require: false,
        hiddenFilter: true
    };
    TENAT = {type: 'text', hiddenInTable: true, require: false, hiddenFilter: true};
    CLIENT = {type: 'text', hiddenInTable: true, require: false, hiddenFilter: true};
    OBJECTID = {type: 'text', hiddenInTable: true, require: false, hiddenFilter: true};
    CLIENT_SECRET = {type: 'text', hiddenInTable: true, require: false, hiddenFilter: true};
    SMTPHOST = {type: 'text', hiddenInTable: true, require: false, hiddenFilter: true};

    //Cat_Dependencia = { type: 'WSelect', hiddenFilter: true, ModelObject: () => new Cat_Dependencias(), require: false };
    Cat_Dependencias_Hijas = {
        type: 'Multiselect',
        hiddenFilter: true,
        ModelObject: () => new Cat_Dependencias(),
        require: false
    };
    Tbl_Agenda = {type: 'MasterDetail', ModelObject: () => new Tbl_Agenda()};
    Tbl_Dependencias_Usuarios = {
        type: 'MasterDetail',
        ModelObject: () => new Tbl_Dependencias_Usuarios(),
        require: false
    };
    GetOwDependencies = async () => {
        return await this.GetData("Proyect/GetOwDependencies");
    }
}

export {Cat_Dependencias};