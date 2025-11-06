// src/files/files.service.ts
import { Injectable, BadRequestException } from '@nestjs/common';
import { existsSync, mkdirSync } from 'fs';
import { join } from 'path';

@Injectable()
export class FilesService {
    private readonly uploadPath = join(__dirname, '..', '..', 'uploads');

    constructor() {
        // Buat folder uploads jika belum ada
        if (!existsSync(this.uploadPath)) {
            mkdirSync(this.uploadPath, { recursive: true });
        }
    }

    async saveFile(file: Express.Multer.File): Promise<string> {
        if (!file) {
            throw new BadRequestException('File tidak ditemukan');
        }

        // Validasi tipe file
        const allowedMimes = ['image/jpeg', 'image/png', 'image/jpg', 'image/gif'];
        if (!allowedMimes.includes(file.mimetype)) {
            throw new BadRequestException('Hanya file gambar (JPEG, PNG, JPG, GIF) yang diizinkan');
        }

        // Validasi ukuran file (max 5MB)
        const maxSize = 5 * 1024 * 1024;
        if (file.size > maxSize) {
            throw new BadRequestException('Ukuran file maksimal 5MB');
        }

        // Generate nama file unik
        const timestamp = Date.now();
        const randomString = Math.random().toString(36).substring(2, 15);
        const fileExtension = file.originalname.split('.').pop();
        const fileName = `report_${timestamp}_${randomString}.${fileExtension}`;
        const filePath = join(this.uploadPath, fileName);

        // Simpan file secara lokal
        const fs = require('fs').promises;
        await fs.writeFile(filePath, file.buffer);

        return `/uploads/${fileName}`;
    }
}