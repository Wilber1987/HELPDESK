
import { CaseTable_Case } from '../../ModelProyect/ProyectDataBaseModel.js';
import { SolicitudesPendientesComponent } from './SolicitudesPendientesComponent.js';

const OnLoad = async () => {
    const Solicitudes = await new CaseTable_Case().GetSolicitudesPendientesAprobar();
    const AdminPerfil = new SolicitudesPendientesComponent(Solicitudes);
    Main.appendChild(AdminPerfil);
}
window.onload = OnLoad;
