FROM node:18.20.3-alpine3.19

# Instalação das dependências necessárias para o Puppeteer e wget para baixar as fontes
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    wget \
    curl

# Definir variáveis de ambiente necessárias para o Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Copiar todos os arquivos do projeto
WORKDIR /app
COPY . .

# Instalar dependências do projeto e Puppeteer
RUN npm install
RUN npm install highcharts-export-server -g
RUN npm install puppeteer

# Comandos de build e inicialização do projeto
RUN npm run install
RUN npm run prestart

# Executa de build e inicial
CMD [ "npm", "run", "start"]
EXPOSE 8000
