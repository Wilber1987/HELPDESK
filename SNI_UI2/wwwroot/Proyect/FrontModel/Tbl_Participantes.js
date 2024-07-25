import {EntityClass} from "../../WDevCore/WModules/EntityClass.js";
import { Cat_Tipo_Participaciones } from "./Cat_Tipo_Participaciones.js";
import { Tbl_Profile } from "./Tbl_Profile.js";

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