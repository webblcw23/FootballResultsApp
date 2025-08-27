# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY . ./
RUN dotnet publish -c Release -o out

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

COPY --from=build /app/out ./

# Copy your results file
COPY Data/rangers-results.json /app/Data/rangers-results.json


EXPOSE 80
ENTRYPOINT ["dotnet", "Rangers.Web.dll"]


# docker build -t rangers-app .
# docker run -p 8080:80 rangers-app
