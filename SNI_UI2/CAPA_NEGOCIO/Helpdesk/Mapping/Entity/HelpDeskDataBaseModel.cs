using CAPA_DATOS;
using CAPA_NEGOCIO.Services;
using API.Controllers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CAPA_DATOS.Security;
using CAPA_DATOS.Services;

namespace CAPA_NEGOCIO.MAPEO
{

	public class Cat_Tipo_Evidencia : EntityClass
	{
		[PrimaryKey(Identity = true)]
		public int? IdTipo { get; set; }
		public string? Descripcion { get; set; }
		public string? Estado { get; set; }

	}


	public class Cat_Paises : EntityClass
	{
		[PrimaryKey(Identity = true)]
		public int? Id_Pais { get; set; }
		public string? Estado { get; set; }
		public string? Descripcion { get; set; }
	}
	public class Security_Users : CAPA_DATOS.Security.Security_Users
	{		
		[OneToMany(TableName = "Security_Users_Roles", KeyColumn = "Id_User", ForeignKeyColumn = "Id_User")]
		public List<Security_Users_Roles>? Security_Users_Roles { get; set; }
		//[ManyToOne(TableName = "Tbl_Profile", KeyColumn = "IdUser", ForeignKeyColumn = "Id_User")]
		public new Tbl_Profile? Tbl_Profile { get; set; }


		public new Security_Users? GetUserData()
		{
			Security_Users? user = this.Find<Security_Users>();
			if (user != null && user.Estado == "ACTIVO")
			{
				user.Security_Users_Roles = new Security_Users_Roles()
				{
					Id_User = user.Id_User
				}.Get<Security_Users_Roles>();
				foreach (Security_Users_Roles role in user.Security_Users_Roles ?? new List<Security_Users_Roles>())
				{
					role.Security_Role?.GetRolData();
				}
				return user;
			}
			if (user?.Estado == "INACTIVO")
			{
				throw new Exception("usuario inactivo");
			}
			return null;
		}

		public new object SaveUser(string identity)
		{
			if (!AuthNetCore.HavePermission(Permissions.ADMINISTRAR_USUARIOS.ToString(), identity))
			{
				throw new Exception("no tiene permisos");
			}
			try
			{
				this.BeginGlobalTransaction();
				if (this.Password != null)
				{
					this.Password = EncrypterServices.Encrypt(this.Password);
				}
				if (this.Id_User == null)
				{
					if (new Security_Users() { Mail = this.Mail }.Exists<Security_Users>())
					{
						throw new Exception("Correo en uso");
					}
					var user = Save();
					if (Tbl_Profile != null)
					{
						var pic = (ModelFiles)FileService.upload("profiles\\", new ModelFiles
						{
							Value = Tbl_Profile.Foto,
							Type = "png",
							Name = "profile"
						}).body;
						Tbl_Profile.Foto = pic?.Value?.Replace("wwwroot", "");
						Tbl_Profile.IdUser = ((Security_Users?)user)?.Id_User;
						Tbl_Profile.Save();
						Tbl_Profile?.SaveDependenciesAndservices();
					}
					else
					{
						Tbl_Profile = new Tbl_Profile()
						{
							Nombres = this.Nombres,
							Estado = this.Estado,
							Correo_institucional = this.Mail,
							Foto = "\\Media\\profiles\\avatar.png",
							IdUser = Id_User
						};
						Tbl_Profile.Save();
					}

				}
				else
				{
					if (this.Estado == null)
					{
						this.Estado = "ACTIVO";
					}
					if (Tbl_Profile != null)
					{
						if (Tbl_Profile.Id_Perfil == null)
						{
							Tbl_Profile.IdUser = Id_User;
							Tbl_Profile.Save();
						}
						else
						{
							Tbl_Profile.Update();
						}
						Tbl_Profile?.SaveDependenciesAndservices();
					}
					this.Update("Id_User");
				}
				if (this.Security_Users_Roles != null)
				{
					Security_Users_Roles IdI = new Security_Users_Roles();
					IdI.Id_User = this.Id_User;
					IdI.Delete();
					foreach (Security_Users_Roles obj in this.Security_Users_Roles)
					{
						obj.Id_User = this.Id_User;
						obj.Save();
					}
				}
				this.CommitGlobalTransaction();
				return this;
			}
			catch (System.Exception)
			{
				this.RollBackGlobalTransaction();
				throw;
			}

		}


		public new  object GetUsers()
		{
			var Security_Users_List = this.Get<Security_Users>();
			foreach (Security_Users User in Security_Users_List)
			{
				User.Password = null;
				User.Tbl_Profile = User.Tbl_Profile?.Find<Tbl_Profile>();
			}
			return Security_Users_List;
		}
		internal bool IsAdmin()
		{
			return Security_Users_Roles?.Find(r => r.Security_Role?.Security_Permissions_Roles?.Find(p =>
			 p.Security_Permissions.Descripcion.Equals(Permissions.ADMIN_ACCESS.ToString())
			) != null) != null;
		}
		internal object RecoveryPassword()
		{
			Security_Users? user = this.Find<Security_Users>();
			if (user != null && user.Estado == "ACTIVO")
			{
				string password = Guid.NewGuid().ToString();
				user.Password = EncrypterServices.Encrypt(password);
				user.Update();
				_ = SMTPMailServices.SendMail("heldesk@password.recovery",
				 [user.Mail],
				 "Recuperación de contraseña",
				 $"nueva contraseña: {password}", null, null, null);
				return user;
			}
			if (user?.Estado == "INACTIVO")
			{
				throw new Exception("usuario inactivo");
			}
			return null;
		}

		public new object? changePassword(string? identfy)
		{
			var security_User = AuthNetCore.User(identfy).UserData;
			Password = EncrypterServices.Encrypt(Password);
			Id_User = security_User?.Id_User;
			return Update();
		}

		public new Tbl_Profile Get_Profile()
        {
            return Tbl_Profile.Get_Profile(Id_User.GetValueOrDefault(), this);
        }
	}



	public class Tbl_Servicios_Profile : EntityClass
	{
		[PrimaryKey(Identity = false)]
		public int? Id_Perfil { get; set; }

		[PrimaryKey(Identity = false)]
		public int? Id_Servicio { get; set; }

		[ManyToOne(TableName = "Tbl_Profile", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
		public Tbl_Profile? Tbl_Profile { get; set; }

		[ManyToOne(TableName = "Tbl_Servicios", KeyColumn = "Id_Servicio", ForeignKeyColumn = "Id_Servicio")]
		public Tbl_Servicios? Tbl_Servicios { get; set; }
	}
	public class Tbl_Profile_CasosAsignados : EntityClass
	{
		[PrimaryKey(Identity = false)]
		public int? Id_Perfil { get; set; }

		[PrimaryKey(Identity = false)]
		public int? Id_Case { get; set; }
		public DateTime? Fecha { get; set; }
		public int? Id_Tipo_Participacion { get; set; }

		[ManyToOne(TableName = "Tbl_Profile", KeyColumn = "Id_Perfil", ForeignKeyColumn = "Id_Perfil")]
		public Tbl_Profile? Tbl_Profile { get; set; }

		[ManyToOne(TableName = "Tbl_Case", KeyColumn = "Id_Case", ForeignKeyColumn = "Id_Case")]
		public Tbl_Case? Tbl_Case { get; set; }
		[ManyToOne(TableName = "Cat_Tipo_Participaciones", KeyColumn = "Id_Tipo_Participacion", ForeignKeyColumn = "Id_Tipo_Participacion")]
		public Cat_Tipo_Participaciones? Cat_Tipo_Participaciones { get; set; }
	}

	public class Cat_Tipo_Servicio : EntityClass
	{
		[PrimaryKey(Identity = true)]
		public int? Id_Tipo_Servicio { get; set; }
		public string? Descripcion { get; set; }
		public string? Estado { get; set; }
		public string? Icon { get; set; }
		//[OneToMany(TableName = "Tbl_Servicios", KeyColumn = "Id_Tipo_Servicio", ForeignKeyColumn = "Id_Tipo_Servicio")]
		public List<Tbl_Servicios>? Tbl_Servicios { get; set; }
	}
	public class Tbl_Servicios : EntityClass
	{
		[PrimaryKey(Identity = true)]
		public int? Id_Servicio { get; set; }
		public string? Nombre_Proyecto { get; set; }
		public string? Descripcion_Servicio { get; set; }
		public int? Id_Tipo_Servicio { get; set; }
		public string? Visibilidad { get; set; }
		public string? Estado { get; set; }
		public DateTime? Fecha_Inicio { get; set; }
		public int? Id_Dependencia { get; set; }
		public DateTime? Fecha_Finalizacion { get; set; }
		[ManyToOne(TableName = "Cat_Tipo_Servicio", KeyColumn = "Id_Tipo_Servicio", ForeignKeyColumn = "Id_Tipo_Servicio")]
		public Cat_Tipo_Servicio? Cat_Tipo_Servicio { get; set; }
		[ManyToOne(TableName = "Cat_Dependencias", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
		public Cat_Dependencias? Cat_Dependencias { get; set; }

	}

	public class Tbl_VinculateCase : EntityClass
	{
		[PrimaryKey(Identity = true)]
		public int? Id_Vinculate { get; set; }
		public string? Descripcion { get; set; }
		public DateTime? Fecha { get; set; }
		[OneToMany(TableName = "Tbl_Case", KeyColumn = "Id_Vinculate", ForeignKeyColumn = "Id_Vinculate")]
		public List<Tbl_Case>? Casos_Vinculados { get; set; }

		internal object DesvincularCaso(Tbl_Case caseDV)
		{
			try
			{
				BeginGlobalTransaction();
				List<Tbl_Case> Tbl_Cases = new Tbl_Case()
				{ Id_Vinculate = caseDV.Id_Vinculate }.Get<Tbl_Case>();
				if (Tbl_Cases.Count == 2)
				{
					foreach (var item in Tbl_Cases)
					{
						if (item.Id_Case != caseDV.Id_Case)
						{
							desvicular(item);
						}
					}
					this.Id_Vinculate = caseDV.Id_Vinculate;
					Delete();
				}
				object? response = desvicular(caseDV);
				CommitGlobalTransaction();
				return response;
			}
			catch (System.Exception)
			{
				RollBackGlobalTransaction();
				throw;
			}
		}

		private static object? desvicular(Tbl_Case caseDV)
		{
			caseDV.Id_Vinculate = null;
			caseDV.Estado = Case_Estate.Activo.ToString();
			var response = caseDV.Update();
			return response;
		}

		internal object? VincularCaso()
		{
			try
			{
				BeginGlobalTransaction();
				Fecha = DateTime.Now;
				Tbl_Case caseV = Casos_Vinculados.FirstOrDefault(c => c.Id_Vinculate != null);
				if (caseV != null)
				{
					Id_Vinculate = caseV.Id_Vinculate;
					List<Tbl_Case> oldCase = new Tbl_Case() { Id_Vinculate = caseV.Id_Vinculate }.Get<Tbl_Case>();
					foreach (var c in oldCase)
					{
						Tbl_Case caseSelected = Casos_Vinculados.FirstOrDefault(cv => cv.Id_Case == c.Id_Case);
						if (caseSelected == null)
						{
							Casos_Vinculados.Add(c);
						}
					}
					foreach (var c in Casos_Vinculados)
					{
						c.Id_Vinculate = Id_Vinculate;
					}

				}
				Descripcion = $"Vinculación de casos: {string.Join(", ", Casos_Vinculados.Select(c => "#" + c.Id_Case).ToList())}";
				int? caseFatherId = Casos_Vinculados.Where(x => x.Id_Case != null).ToList().Select(x => x.Id_Case).ToList().Min();
				foreach (var caseIten in Casos_Vinculados)
				{
					if (caseIten.Id_Case != caseFatherId)
					{
						caseIten.Estado = Case_Estate.Vinculado.ToString();
					}

				}
				if (caseV != null)
				{
					var response = Update();
					CommitGlobalTransaction();
					return response;
				}
				else
				{
					var response = Save();
					CommitGlobalTransaction();
					return response;
				}
			}
			catch (System.Exception)
			{
				RollBackGlobalTransaction();
				throw;
			}

		}
	}
}
