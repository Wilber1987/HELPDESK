import {EntityClass} from "../../WDevCore/WModules/EntityClass";

class Tbl_Participantes extends EntityClass {
    constructor(props) {
        super(props, 'EntityHelpdesk');
        for (const prop in props) {
            this[prop] = props[prop];
        }
    }

    Tbl_Profile = {type: 'WSelect', hiddenFilter: true, ModelObject: () => new Tbl_Profile()}
    Cat_Tipo_Participaciones = {type: 'WSelect', hiddenFilter: true, ModelObject: () => new Cat_Tipo_Participaciones()}
}

export {Tbl_Participantes};