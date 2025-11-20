# Gunakan Node.js versi Alpine (ringan)
FROM node:18-alpine

# Tentukan folder kerja
WORKDIR /app

# Copy package.json & package-lock.json
COPY package*.json ./

# Install dependency
RUN npm install

# Copy seluruh project
COPY . .

# Build NestJS (buat folder dist)
RUN npm run build

# Expose port aplikasi
EXPOSE 3000

# Jalankan aplikasi
CMD ["npm", "run", "start:prod"]
