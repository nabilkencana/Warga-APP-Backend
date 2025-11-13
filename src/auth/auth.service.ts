import { Injectable, UnauthorizedException, InternalServerErrorException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import * as nodemailer from 'nodemailer';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { UsersService } from '../users/users.service'; 

@Injectable()
export class AuthService {
  constructor(
    private readonly usersService: UsersService,
    private jwtService: JwtService,
    private prisma: PrismaService,
    private config: ConfigService,
  ) { }

  async sendOtp(email: string) {
    const user = await this.prisma.user.findUnique({ where: { email } });
    if (!user) throw new UnauthorizedException('Email tidak ditemukan');

    const otp = Math.floor(100000 + Math.random() * 900000).toString();
    const otpExpire = new Date(Date.now() + 5 * 60 * 1000); // 5 menit

    await this.prisma.user.update({
      where: { email },
      data: { otpCode: otp, otpExpire },
    });

    try {
      // 🔥 Gmail Transporter
      const transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 587,
        secure: false, // gunakan TLS
        auth: {
          user: this.config.get('EMAIL_USER'),
          pass: this.config.get('EMAIL_PASS'),
        },
      });


      await transporter.sendMail({
        from: `"WargaApp" <${this.config.get('EMAIL_USER')}>`,
        to: email,
        subject: 'Kode OTP Login Anda',
        text: `Kode OTP Anda adalah ${otp}. Berlaku selama 5 menit.`,
      });

      return { message: 'OTP berhasil dikirim ke email , Cek folder spam' };
    } catch (error) {
      console.error('Gagal mengirim email:', error);
      throw new InternalServerErrorException('Gagal mengirim OTP');
    }
  }

  async verifyOtp(email: string, otp: string) {
    const user = await this.prisma.user.findUnique({ where: { email } });
    if (!user || user.otpCode !== otp)
      throw new UnauthorizedException('OTP salah');
    if (!user.otpExpire || user.otpExpire < new Date())
      throw new UnauthorizedException('OTP sudah kadaluarsa');

    const payload = {
      sub: user.id,
      email: user.email,
      role: user.role,
    };

    const token = this.jwtService.sign(payload, {
      secret: process.env.JWT_SECRET,
      expiresIn: '1d',
    });

    // Reset OTP setelah berhasil login
    await this.usersService.clearOtp(email);

    // Kembalikan data user yang lengkap (tanpa password dan OTP)
    const userResponse = {
      id: user.id,
      email: user.email,
      name: user.namaLengkap,
      role: user.role,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    };

    return {
      message: 'Login berhasil',
      user: userResponse, // Pastikan ini ada
      access_token: token,
    };
  }
}
