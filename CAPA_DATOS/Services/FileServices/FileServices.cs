using System;
using System.Collections.Generic;
using System.Text;
using AE.Net.Mail;
using CAPA_DATOS;

namespace CAPA_DATOS.Services
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

        public static ModelFiles ReceiveFiles(string path, Attachment Attach)
        {
                string Carpeta = @"\wwwroot\Media\" + path;
                string Ruta = Directory.GetCurrentDirectory() + Carpeta;
                if (!Directory.Exists(Ruta))
                {
                    Directory.CreateDirectory(Ruta);
                }
                string FileType = GetFileType(Attach.ContentType);
                Guid Uuid = Guid.NewGuid();
                string FileName = Uuid.ToString() + FileType;
                string FileRoute = Ruta + FileName;
                File.WriteAllBytes(FileRoute, Attach.GetData());
                string RutaRelativa = Path.GetRelativePath(Directory.GetCurrentDirectory(), FileRoute);

                ModelFiles AttachFiles = new ModelFiles();
                AttachFiles.Name = Attach.Filename;
                AttachFiles.Value = RutaRelativa;
                AttachFiles.Type = FileType;
                return AttachFiles;
        }

        

        public static string GetFileType(string mimeType)
        {
            Dictionary<string, string> TypeFile = new Dictionary<string, string>
        {
            { "image/png;base64,", ".png" },
            { "application/pdf;base64,", ".pdf" },
            { "application/pdf", ".pdf" },
            { "image/jpeg", ".png" },
            { "image/png", ".png" },
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

    public class ModelFiles
    {
        public string? Name { get; set; }
        public string? Value { get; set; }
        public string? Type { get; set; }
    }

}
