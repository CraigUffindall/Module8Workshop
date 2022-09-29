# Base image
FROM mcr.microsoft.com/dotnet/sdk:6.0 as base

# Update image
RUN apt-get update

# Download NPM
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

# Install Node
RUN apt-get install -y nodejs

# Copy files
COPY DotnetTemplate.Web DotnetTemplate.Web
WORKDIR /DotnetTemplate.Web

# Build app
RUN dotnet build
RUN npm install
RUN npm run build

# Run app
#RUN dotnet run
ENTRYPOINT [ "dotnet", "run" ]

### In the terminal...build and run
# docker build --tag module8 .
# docker run -p 5000:5000 -d module8

### In the terminal...tag and publish to docker hub
# docker tag module8 cuffindall/module8
# docker push cuffindall/module8