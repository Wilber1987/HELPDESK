
import { Tbl_Case } from '../FrontModel/Tbl_CaseModule.js';
import { SolicitudesPendientesComponent } from './SolicitudesPendientesComponent.js';

const OnLoad = async () => {
    const Solicitudes = await new Tbl_Case().GetSolicitudesPendientesAprobar();
    const AdminPerfil = new SolicitudesPendientesComponent(Solicitudes);
    Main.appendChild(AdminPerfil);
}
window.onload = OnLoad;
