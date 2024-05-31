import { Injectable, ExecutionContext, UnauthorizedException } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';

@Injectable()
export class LocalAuthGuard extends AuthGuard('local') {
  canActivate(context: ExecutionContext): boolean {
    const request = context.switchToHttp().getRequest();
    console.log('LocalAuthGuard canActivate:', request.body); // Log request body for debugging
    return true; // Allow the request to proceed
  }

  handleRequest(err, user) {
    if (err || !user) {
      throw err || new UnauthorizedException(); // Customize error handling as needed
    }
    return user;
  }
}
