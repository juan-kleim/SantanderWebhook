# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copiar apenas o arquivo de projeto primeiro (para cache)
COPY *.csproj ./
RUN dotnet restore

# Copiar todo o código e fazer build
COPY . .
RUN dotnet publish -c Release -o /app

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app

# Expor a porta (importante para o Render)
EXPOSE 5000

# Copiar os arquivos publicados
COPY --from=build /app .

# Definir ponto de entrada
ENTRYPOINT ["dotnet", "SantanderWebhook.dll"]
