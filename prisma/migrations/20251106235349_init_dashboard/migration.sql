/*
  Warnings:

  - You are about to drop the `_emergencytouser` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_usertovolunteer` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `support_tickets` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `two_factor_backups` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user_security` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `users` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `_emergencytouser` DROP FOREIGN KEY `_emergencytouser_A_fkey`;

-- DropForeignKey
ALTER TABLE `_emergencytouser` DROP FOREIGN KEY `_emergencytouser_B_fkey`;

-- DropForeignKey
ALTER TABLE `_usertovolunteer` DROP FOREIGN KEY `_usertovolunteer_A_fkey`;

-- DropForeignKey
ALTER TABLE `_usertovolunteer` DROP FOREIGN KEY `_usertovolunteer_B_fkey`;

-- DropForeignKey
ALTER TABLE `announcement` DROP FOREIGN KEY `Announcement_createdBy_fkey`;

-- DropForeignKey
ALTER TABLE `report` DROP FOREIGN KEY `Report_userId_fkey`;

-- DropForeignKey
ALTER TABLE `support_tickets` DROP FOREIGN KEY `support_tickets_userId_fkey`;

-- DropForeignKey
ALTER TABLE `two_factor_backups` DROP FOREIGN KEY `two_factor_backups_userId_fkey`;

-- DropForeignKey
ALTER TABLE `user_security` DROP FOREIGN KEY `user_security_userId_fkey`;

-- DropIndex
DROP INDEX `Announcement_createdBy_fkey` ON `announcement`;

-- DropIndex
DROP INDEX `Report_userId_fkey` ON `report`;

-- AlterTable
ALTER TABLE `announcement` MODIFY `day` VARCHAR(191) NULL;

-- DropTable
DROP TABLE `_emergencytouser`;

-- DropTable
DROP TABLE `_usertovolunteer`;

-- DropTable
DROP TABLE `support_tickets`;

-- DropTable
DROP TABLE `two_factor_backups`;

-- DropTable
DROP TABLE `user_security`;

-- DropTable
DROP TABLE `users`;

-- CreateTable
CREATE TABLE `User` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `namaLengkap` VARCHAR(191) NOT NULL,
    `nik` VARCHAR(191) NOT NULL,
    `tanggalLahir` DATETIME(3) NOT NULL,
    `tempatLahir` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `nomorTelepon` VARCHAR(191) NOT NULL,
    `instagram` VARCHAR(191) NULL,
    `facebook` VARCHAR(191) NULL,
    `alamat` VARCHAR(191) NOT NULL,
    `kota` VARCHAR(191) NOT NULL,
    `negara` VARCHAR(191) NOT NULL,
    `kodePos` VARCHAR(191) NOT NULL,
    `rtRw` VARCHAR(191) NOT NULL,
    `kkFile` VARCHAR(191) NULL,
    `role` VARCHAR(191) NOT NULL DEFAULT 'user',
    `photo` VARCHAR(191) NULL,
    `bio` VARCHAR(191) NULL,
    `isVerified` BOOLEAN NOT NULL DEFAULT false,
    `twoFactorEnabled` BOOLEAN NOT NULL DEFAULT false,
    `twoFactorSecret` VARCHAR(191) NULL,
    `language` VARCHAR(191) NOT NULL DEFAULT 'id',
    `biometricData` VARCHAR(191) NULL,
    `otpCode` VARCHAR(191) NULL,
    `otpExpire` DATETIME(3) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `User_nik_key`(`nik`),
    UNIQUE INDEX `User_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Announcement` ADD CONSTRAINT `Announcement_createdBy_fkey` FOREIGN KEY (`createdBy`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Report` ADD CONSTRAINT `Report_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `emergencies` ADD CONSTRAINT `emergencies_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `volunteers` ADD CONSTRAINT `volunteers_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
