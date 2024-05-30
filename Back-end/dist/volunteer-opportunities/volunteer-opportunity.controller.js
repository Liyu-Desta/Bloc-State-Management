"use strict";
/* eslint-disable @typescript-eslint/no-unused-vars */
// src/volunteer-opportunities/volunteer-opportunities.controller.ts
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.VolunteerOpportunitiesController = void 0;
const common_1 = require("@nestjs/common");
const jwt_auth_guard_1 = require("../auth/jwt-auth.guard");
const roles_guard_1 = require("../auth/roles.guard");
const has_roles_decorator_1 = require("../auth/has-roles.decorator");
const role_enum_1 = require("../model/role.enum");
const volunteer_opportunity_service_1 = require("./volunteer-opportunity.service");
let VolunteerOpportunitiesController = class VolunteerOpportunitiesController {
    constructor(opportunitiesService) {
        this.opportunitiesService = opportunitiesService;
    }
    async create(opportunityData) {
        return this.opportunitiesService.create(opportunityData);
    }
    async findAll() {
        return this.opportunitiesService.findAll();
    }
    async update(id, opportunityData) {
        return this.opportunitiesService.update(id, opportunityData);
    }
    async remove(id) {
        return this.opportunitiesService.remove(id);
    }
    //volunteers(users) booking
    async bookOpportunity(req, opportunityId) {
        const userId = req.user.userId; // Accessing "userId" from req.user
        return this.opportunitiesService.bookOpportunity(userId, opportunityId);
    }
    async getUserBookings(req) {
        const userId = req.user.userId; // Accessing "userId" from req.user
        return this.opportunitiesService.getUserBookings(userId);
    }
    async unbookOpportunity(bookingId) {
        return this.opportunitiesService.unbookOpportunity(bookingId);
    }
    async getOpportunityBookings(opportunityId) {
        return this.opportunitiesService.getOpportunityBookings(opportunityId);
    }
};
__decorate([
    (0, common_1.Post)(),
    (0, has_roles_decorator_1.HasRoles)(role_enum_1.Role.Admin),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], VolunteerOpportunitiesController.prototype, "create", null);
__decorate([
    (0, common_1.Get)(),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], VolunteerOpportunitiesController.prototype, "findAll", null);
__decorate([
    (0, common_1.Put)(':id'),
    (0, has_roles_decorator_1.HasRoles)(role_enum_1.Role.Admin),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], VolunteerOpportunitiesController.prototype, "update", null);
__decorate([
    (0, common_1.Delete)(':id'),
    (0, has_roles_decorator_1.HasRoles)(role_enum_1.Role.Admin),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], VolunteerOpportunitiesController.prototype, "remove", null);
__decorate([
    (0, common_1.Post)(':id/book'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard) // Open to all authenticated users
    ,
    __param(0, (0, common_1.Req)()),
    __param(1, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String]),
    __metadata("design:returntype", Promise)
], VolunteerOpportunitiesController.prototype, "bookOpportunity", null);
__decorate([
    (0, common_1.Get)('my-bookings'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard) // Open to all authenticated users
    ,
    __param(0, (0, common_1.Req)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], VolunteerOpportunitiesController.prototype, "getUserBookings", null);
__decorate([
    (0, common_1.Delete)('bookings/:bookingId'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard) // Open to all authenticated users
    ,
    __param(0, (0, common_1.Param)('bookingId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], VolunteerOpportunitiesController.prototype, "unbookOpportunity", null);
__decorate([
    (0, common_1.Get)(':id/bookings'),
    (0, has_roles_decorator_1.HasRoles)(role_enum_1.Role.Admin) // Only accessible to admins
    ,
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], VolunteerOpportunitiesController.prototype, "getOpportunityBookings", null);
VolunteerOpportunitiesController = __decorate([
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard, roles_guard_1.RolesGuard),
    (0, common_1.Controller)('volunteer-opportunities'),
    __metadata("design:paramtypes", [volunteer_opportunity_service_1.VolunteerOpportunitiesService])
], VolunteerOpportunitiesController);
exports.VolunteerOpportunitiesController = VolunteerOpportunitiesController;
//# sourceMappingURL=volunteer-opportunity.controller.js.map