FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY ./ ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0

# Setup application
WORKDIR /app
COPY --from=build-env /app/out .
EXPOSE 80 443
VOLUME ["/app/logs"]

# Setup Telegraf agent
# https://portal.influxdata.com/downloads/
ENV TELEGRAF_FILE=telegraf_1.21.2-1_amd64.deb
RUN apt-get update && apt-get install -y wget
RUN wget https://dl.influxdata.com/telegraf/releases/${TELEGRAF_FILE}
RUN dpkg -i ${TELEGRAF_FILE}
# TODO: AQUI PRECISA CONFIGURAR SERVICO
#       AQUI PRECISA RESTARTAR SERVICO
RUN rm ${TELEGRAF_FILE}
COPY sample.w3c-mariadb-telegraf.conf /etc/telegraf/telegraf.conf

ENTRYPOINT ["dotnet", "sample-app.dll"]