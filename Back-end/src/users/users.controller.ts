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

@UseGuards(JwtAuthGuard, RolesGuard)
@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}
  
  
  @Get('All')
  @HasRoles(Role.Admin)
  async getAllUsers() {
    return this.usersService.getAllUsers();
  }

  @Get(':id')
  @UseGuards(JwtAuthGuard)
  async getUser(@Param('id') id: string) {
    return this.usersService.getUser(id);
  }

  @Post()
  @HasRoles(Role.Admin)
  async createUser(@Body() userData) {
    return this.usersService.createUser(userData);
  }

  @Put(':id')
  @HasRoles(Role.Admin)
  async updateUser(@Param('id') id: string, @Body() userData) {
    return this.usersService.updateUser(id, userData);
  }

  @Delete(':id')
  @HasRoles(Role.Admin)
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

