using AppGenerate;
using BackgroundJob.Cron.Jobs;
using CAPA_DATOS;
using CAPA_DATOS.Cron.Jobs;
using SNI_UI2;
using SNI_UI2.CAPA_NEGOCIO;


SqlADOConexion.IniciarConexion("sa", "zaxscd", ".", "PROYECT_MANAGER_BD");
//PostgresADOConexion.IniciarConexion("postgres", "zaxscd", "localhost", "pst", 5432);
//var customers = new Customer { MTConnection = PostgresADOConexion.SQLM }.Get<Customer>();
//var AGENCY = new Structure_agency {  }.Get<Structure_agency>();

//SqlADOConexion.IniciarConexion( "sa", "Helpdesk2023",".", "HELPDESK");
//SqlADOConexion.IniciarConexion( "sa_helpdesk01", "Helpdesk2024_07",".", "HELPDESK");
//AppGeneratorProgram.Main(); //generador de codigo
var builder = WebApplication.CreateBuilder(args);

//var test3 = new sptest3{Parameters = new List<object> {1 , 1}}.Execute();

//var test2 = new sptest2().Get<sptest>();

// Add services to the container.
builder.Services.AddRazorPages();
builder.Services.AddControllers().AddJsonOptions(JsonOptions =>
		JsonOptions.JsonSerializerOptions.PropertyNamingPolicy = null);
builder.Services.AddControllersWithViews();
//builder.Services.AddWebOptimizer();
builder.Services.AddSession(options =>
{
	options.IdleTimeout = TimeSpan.FromMinutes(600);
});

builder.Services.AddCronJob<CreateAutomaticsCaseSchedulerJob>(options =>
{
	// Corre cada minuto
	options.CronExpression = "* * * * *";
	options.TimeZone = TimeZoneInfo.Local;
});

// builder.Services.AddCronJob<SendMailNotificationsSchedulerJob>(options =>
// {
//     // Corre cada minuto
//     options.CronExpression = "* * * * *";
//     options.TimeZone = TimeZoneInfo.Local;
// });


var app = builder.Build();
// builder.Services.AddSession(options =>
// {
//     options.Cookie.Name = ".AdventureWorks.Session";
//     options.IdleTimeout = TimeSpan.FromSeconds(10);
//     options.Cookie.IsEssential = true;
// });

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
	app.UseExceptionHandler("/Error");
	// The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
	app.UseHsts();
}

app.UseHttpsRedirection();

//app.UseWebOptimizer();
app.UseStaticFiles();
app.UseDefaultFiles();

app.UseRouting();

app.UseAuthorization();
app.UseSession();

app.MapRazorPages();
app.UseEndpoints(endpoints =>
	{
		endpoints.MapControllers();
		endpoints.MapRazorPages();
		endpoints.MapControllerRoute(
		   name: "default",
		   pattern: "{controller=Home}/{action=Login}/{id?}");
	});

app.Run();
