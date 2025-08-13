# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o /app/publish

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

COPY --from=build /app/publish ./

EXPOSE 80
ENTRYPOINT ["dotnet", "Rangers.Web.dll"]


# docker build -t rangersapp .
# docker run -d -p 8080:80 rangersapp
