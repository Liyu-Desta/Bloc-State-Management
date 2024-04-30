/* eslint-disable @typescript-eslint/no-unused-vars */
// src/volunteer-opportunities/volunteer-opportunities.controller.ts

import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
  Req,
  UseGuards,
} from '@nestjs/common';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { RolesGuard } from '../auth/roles.guard';
import { HasRoles } from '../auth/has-roles.decorator';
import { Role } from '../model/role.enum';
import { VolunteerOpportunitiesService } from './volunteer-opportunity.service';
import { User } from '../users/users.model';

@UseGuards(JwtAuthGuard, RolesGuard)
@Controller('volunteer-opportunities')
export class VolunteerOpportunitiesController {
  volunteerOpportunityService: any;
  constructor(
    private readonly opportunitiesService: VolunteerOpportunitiesService,
  ) {}

  @Post()
  @HasRoles(Role.Admin)
  async create(@Body() opportunityData) {
    return this.opportunitiesService.create(opportunityData);
  }

  @Get()
  @UseGuards(JwtAuthGuard)
  async findAll() {
    return this.opportunitiesService.findAll();
  }

  @Put(':id')
  @HasRoles(Role.Admin)
  async update(@Param('id') id: string, @Body() opportunityData) {
    return this.opportunitiesService.update(id, opportunityData);
  }

  @Delete(':id')
  @HasRoles(Role.Admin)
  async remove(@Param('id') id: string) {
    return this.opportunitiesService.remove(id);
  }
  //volunteers(users) booking

  @Post(':id/book')
  @UseGuards(JwtAuthGuard) // Open to all authenticated users
  async bookOpportunity(@Req() req, @Param('id') opportunityId: string) {
    const userId = req.user.userId; // Accessing "userId" from req.user
    return this.opportunitiesService.bookOpportunity(userId, opportunityId);
  }

  @Get('my-bookings')
  @UseGuards(JwtAuthGuard) // Open to all authenticated users
  async getUserBookings(@Req() req) {
    const userId = req.user.userId; // Accessing "userId" from req.user
    return this.opportunitiesService.getUserBookings(userId);
  }
  @Delete('bookings/:bookingId')
  @UseGuards(JwtAuthGuard) // Open to all authenticated users
  async unbookOpportunity(@Param('bookingId') bookingId: string) {
    return this.opportunitiesService.unbookOpportunity(bookingId);
  }

  @Get(':id/bookings')
  @HasRoles(Role.Admin) // Only accessible to admins
  async getOpportunityBookings(@Param('id') opportunityId: string) {
    return this.opportunitiesService.getOpportunityBookings(opportunityId);
  }
}
