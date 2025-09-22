using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Hosting;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

// Endpoint básico só pra ver no navegador
app.MapGet("/", () => "✅ Webhook Santander está rodando!");

// Endpoint de teste
app.MapGet("/ping", () => "🏓 pong");

// Endpoint de notificação do Santander (POST)
app.MapPost("/notificacao", async (HttpRequest request, HttpResponse response) =>
{
    using var reader = new StreamReader(request.Body);
    var body = await reader.ReadToEndAsync();

    Console.WriteLine("🔔 Notificação recebida:");
    Console.WriteLine(body);

    response.StatusCode = 200;
    await response.WriteAsync("OK");
});

app.Run();
