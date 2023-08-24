using System;
using System.Collections.Generic;
using System.Net;
using System.Text;
using AE.Net.Mail;
using CAPA_DATOS;
using CAPA_NEGOCIO.MAPEO;

namespace CAPA_NEGOCIO.Services
{
    public class SMTPCaseServices
    {
        public Boolean sendCaseMailNotifications()
        {
            try
            {
                List<CaseTable_Mails> caseMail = new CaseTable_Mails()
                {
                    Estado = MailState.PENDIENTE.ToString()
                }.Get<CaseTable_Mails>();
                foreach (var item in caseMail)
                {
                    SMTPMailServices.SendMail(item.From,  item.ToAdress, item.Subject, item.Body);
                    item.Estado = MailState.ENVIADO.ToString();
                    item.Update();
                }
                return true;

            }
            catch (System.Exception)
            {
                throw;
            }

        }
    }
}
