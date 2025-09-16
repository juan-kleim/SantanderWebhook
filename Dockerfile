FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copiar arquivo de projeto
COPY *.csproj ./

# Limpar cache do NuGet e restaurar
RUN dotnet nuget locals all --clear
RUN dotnet restore --no-cache

# Copiar código fonte
COPY . ./

# Publicar sem usar cache anterior
RUN dotnet publish -c Release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app
EXPOSE 5000

COPY --from=build /app ./
ENTRYPOINT ["dotnet", "SantanderWebhook.dll"]
