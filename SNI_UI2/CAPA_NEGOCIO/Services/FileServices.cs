using System;
using System.Collections.Generic;
using System.Text;
using CAPA_DATOS;
using CAPA_NEGOCIO.MAPEO;
using CAPA_NEGOCIO.Mapping;

namespace CAPA_NEGOCIO.Services
{
    public class FileService
    {
        public static ResponseService upload(string path, ModelFiles Attach)
        {
            try
            {

                string Carpeta = @"\wwwroot\Media\" + path;
                string Ruta = Directory.GetCurrentDirectory() + Carpeta;
                if (!Directory.Exists(Ruta))
                {
                    Directory.CreateDirectory(Ruta);
                }

                byte[] File64 = Convert.FromBase64String(Attach.Value);
                string[] extension = Attach.Type.Split(new string[] { "data:" }, StringSplitOptions.RemoveEmptyEntries);
                string MimeType = "";
                if (extension.Length > 0)
                {
                    MimeType = extension[0];
                }
                string FileType = GetFileType(MimeType);
                Guid Uuid = Guid.NewGuid();
                string FileName = Uuid.ToString() + FileType;
                string FileRoute = Ruta + FileName;
                File.WriteAllBytes(FileRoute, File64);
                string RutaRelativa = Path.GetRelativePath(Directory.GetCurrentDirectory(), FileRoute);

                ModelFiles AttachFiles = new ModelFiles();
                AttachFiles.Value = RutaRelativa;
                AttachFiles.Type = FileType;

                return new ResponseService()
                {
                    status = 200,
                    body = AttachFiles,
                    message = "Archivo creado correctamente"
                };

            }
            catch (Exception ex)
            {
                return new ResponseService()
                {
                    status = 500,
                    value = ex.ToString(),
                    message = "Error, intentelo nuevamente"
                };
            }

        }

        public static string GetFileType(string mimeType)
        {
            Dictionary<string, string> TypeFile = new Dictionary<string, string>
        {
            { "image/png;base64,", ".png" },
            { "application/pdf;base64,", ".pdf" },
        };

            if (TypeFile.TryGetValue(mimeType, out string Type))
            {
                return Type;
            }
            else
            {
                return ".unknown";
            }
        }
    }
}
