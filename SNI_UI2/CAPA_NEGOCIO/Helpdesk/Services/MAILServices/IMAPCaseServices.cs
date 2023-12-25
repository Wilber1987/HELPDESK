using System;
using System.Collections.Generic;
using System.Net;
using System.Text;
using AE.Net.Mail;
using CAPA_DATOS;
using CAPA_DATOS.Services;
using CAPA_NEGOCIO.MAPEO;

namespace CAPA_NEGOCIO.Services
{
    public class IMAPCaseServices
    {

        public async void chargeAutomaticCase()
        {
            try
            {
                List<Cat_Dependencias> dependencias = new Cat_Dependencias().Get<Cat_Dependencias>();
                foreach (var dependencia in dependencias)
                {
                    if (dependencia.Host != null && dependencia.Username != null && dependencia.Password != null)
                    {
                        var messages = await new IMAPServices().GetMessages(new MailConfig()
                        {
                            HOST = dependencia.Host,
                            PASSWORD = dependencia.Password,
                            USERNAME = dependencia.Username,
                            CLIENT = dependencia.CLIENT,
                            CLIENT_SECRET = dependencia.CLIENT_SECRET,
                            AutenticationType = dependencia.AutenticationType,
                            TENAT = dependencia.TENAT,
                            OBJECTID = dependencia.OBJECTID
                        });
                        messages.ForEach(m => new CaseTable_Case().CreateAutomaticCase(m, dependencia));
                    }
                }

            }
            catch (System.Exception ex)
            {
                LoggerServices.AddMessageError("Error en chargeAutomaticCase:" + ex.Message, ex);
                throw;
            }

        }
    }
}
