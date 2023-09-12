


using CAPA_DATOS;
using CAPA_NEGOCIO.MAPEO;

namespace CAPA_NEGOCIO.Services
{
    public class CaseBlock : TransactionalClass
    {
        private Cat_Dependencias? dependencia { get; set; }
        public List<CaseTable_Comments>? comentarios { get; set; }
        public List<CaseTable_Case> caseTable_Cases { get; set; }

        public object AprobarSolicitudes(string? v)
        {

            try
            {
                BeginGlobalTransaction();
                foreach (var item in caseTable_Cases)
                {
                    item.AprobarSolicitud(v);
                }
                CommitGlobalTransaction();
                return new ResponseService()
                {
                    status = 200,
                    message = "Solicitudes aprobadas"
                };
            }
            catch (System.Exception e)
            {
                RollBackGlobalTransaction();
                return new ResponseService()
                {
                    status = 500,
                    message = e.Message
                };
            }
        }

        public object RechazarSolicitudes(string? v)
        {
            try
            {
                BeginGlobalTransaction();
                foreach (var item in caseTable_Cases)
                {
                    item.CaseTable_Comments = comentarios;
                    item.RechazarSolicitud(v);
                }
                CommitGlobalTransaction();
                return new ResponseService()
                {
                    status = 200,
                    message = "Solicitudes rechazadas"
                };
            }
            catch (System.Exception e)
            {
                RollBackGlobalTransaction();
                return new ResponseService()
                {
                    status = 500,
                    message = e.Message
                };
            }

        }

        public object RemitirCasos(string? v)
        {
            try
            {
                BeginGlobalTransaction();
                foreach (var item in caseTable_Cases)
                {
                    item.Cat_Dependencias = dependencia;
                    item.Update();
                }
                CommitGlobalTransaction();
                return new ResponseService()
                {
                    status = 200,
                    message = "Solicitudes rechazadas"
                };
            }
            catch (System.Exception e)
            {
                RollBackGlobalTransaction();
                return new ResponseService()
                {
                    status = 500,
                    message = e.Message
                };
            }


        }
    }
}
