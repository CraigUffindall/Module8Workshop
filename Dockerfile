### Build stage image
FROM mcr.microsoft.com/dotnet/sdk:6.0 as build-stage
# Download NPM
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
# Install Node
RUN apt-get install -y nodejs
# Update image
RUN apt-get update && apt-get install -y build-essential
# Set working dir
WORKDIR /app
# Copy files
COPY DotnetTemplate.Web/ ./
# Build
RUN dotnet publish -c Release -o /dist


### Final image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
# Set working dir
WORKDIR /dist
# Copy file
COPY --from=build-stage /dist /dist/
# Set entry point
ENTRYPOINT ["dotnet", "DotnetTemplate.Web.dll"]






### In the terminal...build and run
# docker build --tag module8 .
# docker run -p 5000:5000 -d module8

### In the terminal...tag and publish to docker hub
# docker tag module8 cuffindall/module8
# docker push cuffindall/module8