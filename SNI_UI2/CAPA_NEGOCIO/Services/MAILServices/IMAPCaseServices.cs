using System;
using System.Collections.Generic;
using System.Net;
using System.Text;
using AE.Net.Mail;
using CAPA_DATOS;
using CAPA_NEGOCIO.MAPEO;

namespace CAPA_NEGOCIO.Services
{
    public class IMAPCaseServices
    {

        public Boolean chargeAutomaticCase()
        {
            try
            {
                List<Cat_Dependencias> dependencias = new Cat_Dependencias().Get<Cat_Dependencias>();
                foreach (var dependencia in dependencias)
                {
                    using (ImapClient imap = new IMAPServices()
                    .GetClient(new MailConfig() { HOST = dependencia.Host, PASSWORD = dependencia.Password, USERNAME = dependencia.Username }))
                    {
                        imap.SelectMailbox("INBOX");
                        var MailMessage = imap.SearchMessages(SearchCondition.Unseen()).Select(m => m.Value).ToList();
                        foreach (var mail in MailMessage)
                        {
                            new CaseTable_Case().CreateAutomaticCase(mail, dependencia);
                            imap.MoveMessage(mail.Uid, "READY");
                        }
                        imap.Expunge();
                    }
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
