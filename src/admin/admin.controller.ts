import { Controller, Get } from '@nestjs/common';
import { AdminService } from './admin.service';

@Controller('admin')
export class AdminController {
    constructor(private readonly adminService: AdminService) { }

    @Get('dashboard')
    async getDashboard() {
        const stats = await this.adminService.getDashboardStats();
        const recentReports = await this.adminService.getRecentReports();
        const recentEmergencies = await this.adminService.getRecentEmergencies();
        const recentAnnouncements = await this.adminService.getRecentAnnouncements();

        return {
            stats,
            recentReports,
            recentEmergencies,
            recentAnnouncements,
        };
    }
}
