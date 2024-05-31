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
import { UsersService } from './users.service';
import { User } from './users.model';
const mongoose = require('mongoose');


@UseGuards(JwtAuthGuard, RolesGuard)
@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}
  
  
  @Get('All')
  @HasRoles(Role.Admin)
  async getAllUsers() {
    return this.usersService.getAllUsers();
  }

  @Get('one')
  @UseGuards(JwtAuthGuard)
  async getUser(@Req() req)  {
    const userId = req.user.userId;
  return this.usersService.getUser(userId);
  }

  @Post()
  @HasRoles(Role.Admin)
  async createUser(@Body() userData) {
    return this.usersService.createUser(userData);
  }

  @Put(':id')

  async updateUser(@Param('id') id: string, @Body() userData) {
    return this.usersService.updateUser(id, userData);
  }

  @Delete(':id')
  async deleteUser(@Param('id') id: string) {
    return this.usersService.deleteUser(id);
  }

  @Put(':id/role')
  @HasRoles(Role.Admin)
  async updateRole(@Param('id') id: string, @Body() role: string) {
    return this.usersService.updateRole(id, role);
  }

  @Get(':id/role')
  @HasRoles(Role.Admin)
  async getUserRole(@Param('id') id: string) {
    return this.usersService.getUserRole(id);
  }
}

