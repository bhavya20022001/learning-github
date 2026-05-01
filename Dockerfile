FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy only csproj first (better practice)
COPY ["TaskManagerAPI.csproj", "./"]

RUN dotnet restore

# Copy everything else
COPY . .

RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "TaskManagerAPI.dll"]