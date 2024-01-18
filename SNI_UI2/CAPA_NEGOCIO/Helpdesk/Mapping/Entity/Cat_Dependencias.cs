using CAPA_DATOS;
using CAPA_DATOS.Security;
using API.Controllers;
using CAPA_DATOS.Services;

namespace CAPA_NEGOCIO.MAPEO;

public class Cat_Dependencias : EntityClass
{
    [PrimaryKey(Identity = true)]
    public int? Id_Dependencia { get; set; }
    public string? Descripcion { get; set; }
    public string? Username { get; set; }
    public string? Password { get; set; }
    public string? Host { get; set; }
    public int? Id_Dependencia_Padre { get; set; }
    public int? Id_Institucion { get; set; }
    public string? AutenticationType { get; set; }
    public string? HostService { get; set; }
    //AUTH 2.0
    public string? TENAT { get; set; }
    public string? CLIENT { get; set; }
    public string? OBJECTID { get; set; }
    public string? CLIENT_SECRET { get; set; }
    public string? SMTPHOST { get; set; }



    [ManyToOne(TableName = "Cat_Dependencias", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia_Padre")]
    public Cat_Dependencias? Cat_Dependencia { get; set; }
    [OneToMany(TableName = "Cat_Dependencias", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia_Padre")]
    public List<Cat_Dependencias>? Cat_Dependencias_Hijas { get; set; }
    //[OneToMany(TableName = "CaseTable_Case", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
    // public List<CaseTable_Case>? CaseTable_Case { get; set; }
    [OneToMany(TableName = "CaseTable_Agenda", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
    public List<CaseTable_Agenda>? CaseTable_Agenda { get; set; }
    [OneToMany(TableName = "CaseTable_Dependencias_Usuarios", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
    public List<CaseTable_Dependencias_Usuarios>? CaseTable_Dependencias_Usuarios { get; set; }
    public List<Cat_Dependencias> GetOwDependencies(string identity)
    {
        if (AuthNetCore.User(identity).isAdmin)
        {
            return new Cat_Dependencias().Get<Cat_Dependencias>();
        }
        CaseTable_Dependencias_Usuarios Inst = new CaseTable_Dependencias_Usuarios()
        {
            Id_Perfil = AuthNetCore.User(identity).UserId
        };
        return new Cat_Dependencias().Get_WhereIN<Cat_Dependencias>(
            "Id_Dependencia", Inst.Get<CaseTable_Dependencias_Usuarios>().Select(p => p.Id_Dependencia.ToString()).ToArray()
        );
    }
    [OneToMany(TableName = "Tbl_Servicios", KeyColumn = "Id_Dependencia", ForeignKeyColumn = "Id_Dependencia")]
    public List<Tbl_Servicios>? Tbl_Servicios { get; set; }

    internal List<Cat_Dependencias> GetDependencias<T>()
    {
        return Get<Cat_Dependencias>().Select(m =>
        {
            m.Password = "PROTECTED";
            return m;
        }).ToList();
    }

    internal object GetOwDependenciesConsolidados(string token)
    {
        return GetOwDependencies(token).Select(
            D =>
                new
                {
                    D.Id_Dependencia,
                    D.Descripcion,
                    D.Username,
                    D.CaseTable_Dependencias_Usuarios,
                    NCasos = new CaseTable_Case { Id_Dependencia = D.Id_Dependencia, Estado = Case_Estate.Activo.ToString() }.Get<CaseTable_Case>().Count,
                    NCasosFinalizados = new CaseTable_Case { Id_Dependencia = D.Id_Dependencia, Estado = Case_Estate.Finalizado.ToString() }.Get<CaseTable_Case>().Count
                }
        ).ToList();
    }
}
