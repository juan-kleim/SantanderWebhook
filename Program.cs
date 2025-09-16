var builder = WebApplication.CreateBuilder(args);

// Configurar porta do Render
var port = Environment.GetEnvironmentVariable("PORT") ?? "5000";
builder.WebHost.UseUrls($"http://0.0.0.0:{port}");

// Seus serviços aqui
builder.Services.AddControllers();

var app = builder.Build();

// Pipeline
app.UseRouting();
app.MapControllers();

app.Run();