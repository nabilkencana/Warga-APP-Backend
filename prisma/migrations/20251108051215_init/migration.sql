-- CreateTable
CREATE TABLE `admin_dashboards` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `totalUsers` INTEGER NOT NULL DEFAULT 0,
    `totalReports` INTEGER NOT NULL DEFAULT 0,
    `totalEmergencies` INTEGER NOT NULL DEFAULT 0,
    `totalVolunteers` INTEGER NOT NULL DEFAULT 0,
    `totalVerifiedUsers` INTEGER NOT NULL DEFAULT 0,
    `totalActiveEmergencies` INTEGER NOT NULL DEFAULT 0,
    `reportPendingCount` INTEGER NOT NULL DEFAULT 0,
    `reportResolvedCount` INTEGER NOT NULL DEFAULT 0,
    `date` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `adminId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `activity_logs` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `action` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `timestamp` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `ipAddress` VARCHAR(191) NULL,
    `userAgent` VARCHAR(191) NULL,
    `adminId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `admin_dashboards` ADD CONSTRAINT `admin_dashboards_adminId_fkey` FOREIGN KEY (`adminId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `activity_logs` ADD CONSTRAINT `activity_logs_adminId_fkey` FOREIGN KEY (`adminId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
