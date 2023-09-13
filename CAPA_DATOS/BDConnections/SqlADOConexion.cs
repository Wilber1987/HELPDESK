using System;
using System.Collections.Generic;
using System.Text;

namespace CAPA_DATOS
{
    public class SqlADOConexion
    {
        private static string UserSQLConexion = "";
        public static SqlServerGDatos? SQLM;
        public static string DataBaseName = "HELPDESK";
        public static bool Anonimo = true;
        // private static string SGBD_USER = "helpdesk";
        // private static string SWGBD_PASSWORD = "Wmatus09%";
        // static string SQLServer = "tcp:helpdesk-app.database.windows.net";

        //static string SQLServer = "DESKTOP-I58J01U";
        //Server=tcp:helpdesk-app.database.windows.net,1433;Initial Catalog=HELPDESK;Persist Security Info=False;User ID=HELPDESK;
        //Password={your_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;

        static string SQLServer = ".";
        private static string SGBD_USER = "sa";
        private static string SWGBD_PASSWORD = "zaxscd";

        // static string SQLServer = "DESKTOP-G6FLNBQ\\SQLSIZM";
        // private static string SGBD_USER = "sa";
        // private static string SWGBD_PASSWORD = "123456"; 
        static public bool IniciarConexion()
        {
            try
            {
                Anonimo = false;
                UserSQLConexion = "Data Source=" + SQLServer +
                    "; Initial Catalog=" + DataBaseName + "; User ID="
                    + SGBD_USER + ";Password=" + SWGBD_PASSWORD + ";MultipleActiveResultSets=true";
                SQLM = new SqlServerGDatos(UserSQLConexion);
                if (SQLM.TestConnection()) return true;
                else
                {
                    SQLM = null;
                    return false;
                }
            }
            catch (Exception)
            {
                Anonimo = true;
                return false;
                throw;
            }
        }
        static public bool IniciarConexion(string user, string password)
        {
            try
            {
                Anonimo = false;
                UserSQLConexion = "Data Source=" + SQLServer +
                    "; Initial Catalog=" + DataBaseName + "; User ID="
                    + user + ";Password=" + password + ";MultipleActiveResultSets=true";
                SQLM = new SqlServerGDatos(UserSQLConexion);
                if (SQLM.TestConnection()) return true;
                else
                {
                    SQLM = null;
                    return false;
                }
            }
            catch (Exception)
            {
                Anonimo = true;
                return false;
                throw;
            }
        }
        static public bool IniciarConexionAnonima()
        {
            try
            {
                Anonimo = false;
                UserSQLConexion = "Data Source=" + SQLServer +
                    "; Initial Catalog=" + DataBaseName +
                    "; User ID=" + SGBD_USER + ";Password=" + SWGBD_PASSWORD + ";MultipleActiveResultSets=true";
                SQLM = new SqlServerGDatos(UserSQLConexion);
                if (SQLM.TestConnection()) return true;
                else
                {
                    SQLM = null;
                    return false;
                }
            }
            catch (Exception)
            {
                return false;
                throw;
            }
        }

        static public bool IniciarConexionSNIBD(string user, string password)
        {
            try
            {
                Anonimo = false;
                UserSQLConexion = "Data Source=" + SQLServer +
                    "; Initial Catalog=" + DataBaseName + "; User ID="
                    + user + ";Password=" + password + ";MultipleActiveResultSets=true";
                SQLM = new SqlServerGDatos(UserSQLConexion);
                if (SQLM.TestConnection()) return true;
                else
                {
                    SQLM = null;
                    return false;
                }
            }
            catch (Exception)
            {
                SQLM = null;
                Anonimo = true;
                return false;
                throw;
            }
        }
    }

}
