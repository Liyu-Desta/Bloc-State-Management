import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { UsersService } from '../users/users.service';
import { User, UserDocument } from '../users/users.model';
;
import { Role } from '../model/role.enum';

@Injectable()
export class AuthService {
  constructor(
    private usersService: UsersService,
    private jwtService: JwtService,
  ) {}

  async validateUser(
    email: string,
    pass: string,
  ): Promise<UserDocument | null> {
    const user = await this.usersService.findOne(email);
    if (user && user.password === pass) {
      return user as UserDocument; 
    }
    return null;
  }

  async login(email: string, password: string) {
    const user: UserDocument | null = await this.validateUser(email, password);

    if (!user) {
      throw new UnauthorizedException('Invalid credentials');
    }

    const payload = { email: user.email, sub: user._id, roles: user.roles };
    return {
      access_token: this.jwtService.sign(payload),
    };
  }

  async signup(
    name: string,
    email: string,
    password: string,
    phoneNumber: string,
  ) {
    const userExists = await this.usersService.findOne(email);
    if (userExists) {
      throw new Error('User already exists');
    }
    const userDto: User = {
      
      email,
      password,
      phoneNumber,
      roles: [Role.User],
    };
    
    const user: UserDocument = await this.usersService.createUser(userDto);
    const payload = { email: user.email, sub: user._id, roles: user.roles };
    
    return {
      user,
      access_token: this.jwtService.sign(payload),
    };
  }
}
