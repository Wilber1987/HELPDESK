﻿using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Mail;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Text;

namespace CAPA_NEGOCIO.Services
{
    public class SMTPMailServices
    {
        //const string USERNAME = "wdevexp@outlook.com";
        //const string PASSWORD = "%WtestDev2023%";
        //const string USERNAME = "amejia@ximtechnology.onmicrosoft.com";
        //const string PASSWORD = "%3e2w1qazsX";
        //const string HOST = "outlook.office365.com";
        const int PORT = 587;
        public static Boolean SendMail(string from, List<string> toMails, string subject, string body, MailConfig config)
        {
            try
            {
                //var templatePage = Path.Combine(System.IO.Path.GetFullPath("../UI/Pages/Mails"), path);
                MailMessage correo = new MailMessage();
                correo.From = new MailAddress(from, "HELPDESK", System.Text.Encoding.UTF8);//Correo de salida
                foreach (string toMail in toMails)
                {
                    correo.To.Add(toMail); //Correos de destino
                }
                correo.Subject = subject; //Asunto
                correo.Body = body;//ContractService.RenderTemplate(templatePage, model);
                correo.IsBodyHtml = true;
                correo.Priority = MailPriority.Normal;
                SmtpClient smtp = new SmtpClient
                {
                    UseDefaultCredentials = false,
                    Host = config.HOST ?? "",
                    Port = PORT, //Puerto de salida 
                    Credentials = new System.Net.NetworkCredential(config.USERNAME, config.PASSWORD)//Cuenta de correo
                };
                ServicePointManager.ServerCertificateValidationCallback +=
                  (sender, cert, chain, sslPolicyErrors) => true;

                smtp.EnableSsl = true;//True si el servidor de correo permite ssl
                smtp.Send(correo);
                return true;
            }
            catch (Exception)
            {
                throw;
            }

        }
    }
}
