using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Hosting;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

// Endpoint de notificação do Santander
app.MapPost("/notificacao", async (HttpRequest request, HttpResponse response) =>
{
    using var reader = new StreamReader(request.Body);
    var body = await reader.ReadToEndAsync();

    Console.WriteLine("🔔 Notificação recebida do Santander:");
    Console.WriteLine(body);

    response.StatusCode = 200;
    await response.WriteAsync("OK");
});

app.Run();
