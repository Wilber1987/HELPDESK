using System;
using System.Collections.Generic;
using System.Net;
using System.Text;
using CAPA_DATOS;
using OpenPop.Mime;
using OpenPop.Pop3;

namespace CAPA_NEGOCIO.Services
{
    public class POPServices
    {
        public static Pop3Client GetExchangeEWSClient()
        {
            const string HOST = "outlook.office365.com";
            const int PORT = 995;
            //const string username = @"wmatus@unan.edu.ni";
            //const string password = @"";

            const string username = "wilberj1987@hotmail.com";
            const string password = "";
            Pop3Client pop3Client = new Pop3Client();
            pop3Client.Connect(HOST, PORT, true);
            pop3Client.Authenticate(username, password);
            return pop3Client;
        }
        public object getData()
        {
            var client = GetExchangeEWSClient();
            List<Message> messages = new();
            int i = 10;//client.GetMessageCount();
            while (i > 1)
            {
                messages.Add(client.GetMessage(i));
                i--;
            }
            return messages;
        }
    }
}
