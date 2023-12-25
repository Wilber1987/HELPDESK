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
    public class SMTPCaseServices
    {
        public async Task<bool> sendCaseMailNotificationsAsync()
        {
            try
            {
                List<CaseTable_Mails> caseMail = new CaseTable_Mails()
                {
                    Estado = MailState.PENDIENTE.ToString()
                }.Get<CaseTable_Mails>();

                foreach (var item in caseMail)
                {
                    var Tcase = new CaseTable_Case() { Id_Case = item.Id_Case }.Find<CaseTable_Case>();
                    var send = await SMTPMailServices.SendMail(item.FromAdress,
                    item.ToAdress,
                    item.Subject,
                    item.Body,
                    item.Attach_Files,
                    new MailConfig()
                    {
                        HOST = Tcase?.Cat_Dependencias?.SMTPHOST,
                        PASSWORD = Tcase?.Cat_Dependencias?.Password,
                        USERNAME = Tcase?.Cat_Dependencias?.Username,
                        CLIENT = Tcase?.Cat_Dependencias?.CLIENT,
                        CLIENT_SECRET = Tcase?.Cat_Dependencias?.CLIENT_SECRET,
                        AutenticationType = Tcase?.Cat_Dependencias?.AutenticationType,
                        TENAT = Tcase?.Cat_Dependencias?.TENAT,
                        OBJECTID = Tcase?.Cat_Dependencias?.OBJECTID
                    });
                    if (send)
                    {
                        item.Estado = MailState.ENVIADO.ToString();
                        item.Update();
                    }

                    await Task.Delay(5000);
                }
                return true;

            }
            catch (System.Exception)
            {
                return false;
            }

        }
    }
}
