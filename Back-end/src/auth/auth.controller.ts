// auth.controller.ts

import { Controller, Get, Request, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from './jwt-auth.guard'; // Import your JWT authentication guard
import { AuthService } from './auth.service';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @UseGuards(JwtAuthGuard)
  @Get('user')
  async getUser(@Request() req) {
    // The user details, including roles, should be available in req.user
    const userDetails = req.user;
    return userDetails;
  }
}
