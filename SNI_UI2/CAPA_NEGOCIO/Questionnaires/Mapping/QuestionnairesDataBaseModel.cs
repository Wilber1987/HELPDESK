using CAPA_DATOS;
using CAPA_DATOS.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace DataBaseModel
{
    public class Cat_Categorias_Test : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? id_categoria { get; set; }
        public string? descripcion { get; set; }
        public string? imagen { get; set; }
        public string? estado { get; set; }
        public DateTime? created_at { get; set; }
        public DateTime? updated_at { get; set; }
        [OneToMany(TableName = "Tests", KeyColumn = "id_categoria", ForeignKeyColumn = "id_categoria")]
        public List<Tests>? Tests { get; set; }

        internal object SaveCategoria()
        {
            imagen = FileService.setImage(imagen);
            return Save();
        }

        internal object UpdateCategoria()
        {
            imagen = FileService.setImage(imagen);
            return Update();
        }
    }
    public class Cat_Tipo_Preguntas : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? id_tipo_pregunta { get; set; }
        public string? tipo_pregunta { get; set; }
        public string? descripcion { get; set; }
        public string? estado { get; set; }
        public DateTime? fecha_crea { get; set; }
        public DateTime? created_at { get; set; }
        public DateTime? updated_at { get; set; }
        public bool? editable { get; set; }
        public string? descripcion_general { get; set; }
        [OneToMany(TableName = "Cat_Valor_Preguntas", KeyColumn = "id_tipo_pregunta", ForeignKeyColumn = "id_tipo_pregunta")]
        public List<Cat_Valor_Preguntas>? Cat_Valor_Preguntas { get; set; }
        [OneToMany(TableName = "Pregunta_Tests", KeyColumn = "id_tipo_pregunta", ForeignKeyColumn = "id_tipo_pregunta")]
        public List<Pregunta_Tests>? Pregunta_Tests { get; set; }
    }
    public class Cat_Valor_Preguntas : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? id_valor_pregunta { get; set; }
        public string? descripcion { get; set; }
        public int? id_tipo_pregunta { get; set; }
        public string? estado { get; set; }
        public int? valor { get; set; }
        public DateTime? created_at { get; set; }
        public DateTime? updated_at { get; set; }
        [ManyToOne(TableName = "Cat_Tipo_Preguntas", KeyColumn = "id_tipo_pregunta", ForeignKeyColumn = "id_tipo_pregunta")]
        public Cat_Tipo_Preguntas? Cat_Tipo_Preguntas { get; set; }
        [OneToMany(TableName = "Resultados_Pregunta_Tests", KeyColumn = "id_valor_pregunta", ForeignKeyColumn = "id_valor_pregunta")]
        public List<Resultados_Pregunta_Tests>? Resultados_Pregunta_Tests { get; set; }
    }
    public class Pregunta_Tests : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? id_pregunta_test { get; set; }
        public string? estado { get; set; }
        public string? descripcion_pregunta { get; set; }
        public int? id_test { get; set; }
        public int? id_tipo_pregunta { get; set; }
        public DateTime? fecha { get; set; }
        public DateTime? created_at { get; set; }
        public DateTime? updated_at { get; set; }
        public string? seccion { get; set; }
        public string? descripcion_general { get; set; }
        [ManyToOne(TableName = "Cat_Tipo_Preguntas", KeyColumn = "id_tipo_pregunta", ForeignKeyColumn = "id_tipo_pregunta")]
        public Cat_Tipo_Preguntas? Cat_Tipo_Preguntas { get; set; }
        [ManyToOne(TableName = "Tests", KeyColumn = "id_test", ForeignKeyColumn = "id_test")]
        public Tests? Tests { get; set; }
        [OneToMany(TableName = "Resultados_Pregunta_Tests", KeyColumn = "id_pregunta_test", ForeignKeyColumn = "id_pregunta_test")]
        public List<Resultados_Pregunta_Tests>? Resultados_Pregunta_Tests { get; set; }
    }
    public class Resultados_Pregunta_Tests : EntityClass
    {
        [PrimaryKey(Identity = false)]
        public int? Id_Perfil { get; set; }
        [PrimaryKey(Identity = false)]
        public int? id_pregunta_test { get; set; }
        public int? resultado { get; set; }
        public string? respuesta { get; set; }
        public string? estado { get; set; }
        public int? id_valor_pregunta { get; set; }
        public DateTime? created_at { get; set; }
        public DateTime? updated_at { get; set; }
        [PrimaryKey(Identity = false)]
        public DateTime? fecha { get; set; }
        [ManyToOne(TableName = "Cat_Valor_Preguntas", KeyColumn = "id_valor_pregunta", ForeignKeyColumn = "id_valor_pregunta")]
        public Cat_Valor_Preguntas? Cat_Valor_Preguntas { get; set; }
        [ManyToOne(TableName = "Pregunta_Tests", KeyColumn = "id_pregunta_test", ForeignKeyColumn = "id_pregunta_test")]
        public Pregunta_Tests? Pregunta_Tests { get; set; }
    }
    public class Resultados_Tests : EntityClass
    {
        [PrimaryKey(Identity = false)]
        public int? Id_Perfil { get; set; }
        [PrimaryKey(Identity = false)]
        public int? id_test { get; set; }
        [PrimaryKey(Identity = false)]
        public DateTime? fecha { get; set; }
        public string? seccion { get; set; }
        public DateTime? created_at { get; set; }
        public DateTime? updated_at { get; set; }
        public string? valor { get; set; }
        public string? categoria_valor { get; set; }
        public string? tipo { get; set; }
        [ManyToOne(TableName = "Tests", KeyColumn = "id_test", ForeignKeyColumn = "id_test")]
        public Tests? Tests { get; set; }
    }
    public class Tests : EntityClass
    {
        [PrimaryKey(Identity = true)]
        public int? id_test { get; set; }
        public string? titulo { get; set; }
        public string? descripcion { get; set; }
        public int? grado { get; set; }
        public string? tipo_test { get; set; }
        public string? estado { get; set; }
        public int? id_categoria { get; set; }
        public DateTime? fecha_publicacion { get; set; }
        public DateTime? created_at { get; set; }
        public DateTime? updated_at { get; set; }
        public string? referencias { get; set; }
        public int? tiempo { get; set; }
        public int? caducidad { get; set; }
        public string? color { get; set; }
        public string? image { get; set; }
        [ManyToOne(TableName = "Cat_Categorias_Test", KeyColumn = "id_categoria", ForeignKeyColumn = "id_categoria")]
        public Cat_Categorias_Test? Cat_Categorias_Test { get; set; }
        [OneToMany(TableName = "Pregunta_Tests", KeyColumn = "id_test", ForeignKeyColumn = "id_test")]
        public List<Pregunta_Tests>? Pregunta_Tests { get; set; }
        //[OneToMany(TableName = "Resultados_Tests", KeyColumn = "id_test", ForeignKeyColumn = "id_test")]
        public List<Resultados_Tests>? Resultados_Tests { get; set; }

        internal object SaveTets()
        {
            image = FileService.setImage(image);
            return Save();
        }      

        internal object UpdateTest()
        {
            image = FileService.setImage(image);
            return Update();
        }
    }
}
