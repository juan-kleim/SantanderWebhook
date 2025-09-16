FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copiar arquivos de projeto
COPY *.csproj ./
RUN dotnet restore

# Copiar código fonte
COPY . ./
RUN dotnet publish -c Release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app
EXPOSE 5000

COPY --from=build /app ./

# Criar usuário não-root (boa prática)
RUN addgroup --system --gid 1001 dotnet
RUN adduser --system --uid 1001 --gid 1001 dotnet
USER dotnet

ENTRYPOINT ["dotnet", "SantanderWebhook.dll"]
