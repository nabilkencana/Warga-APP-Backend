/*
  Warnings:

  - You are about to alter the column `latitude` on the `emergencies` table. The data in that column could be lost. The data in that column will be cast from `Double` to `VarChar(191)`.
  - You are about to alter the column `longitude` on the `emergencies` table. The data in that column could be lost. The data in that column will be cast from `Double` to `VarChar(191)`.

*/
-- AlterTable
ALTER TABLE `emergencies` MODIFY `latitude` VARCHAR(191) NULL,
    MODIFY `longitude` VARCHAR(191) NULL;
