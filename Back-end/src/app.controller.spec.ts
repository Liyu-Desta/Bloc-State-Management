
import { Test, TestingModule } from '@nestjs/testing';
import { AppController } from './app.controller';
import { AuthService } from './auth/auth.service';

describe('AppController', () => {
  let appController: AppController;
  let authService: AuthService;

  beforeEach(async () => {
    // Mock AuthService
    const mockAuthService = {
      login: jest.fn((email, password) => {
        return Promise.resolve({
          access_token: 'mockToken',
        });
      }),
      signup: jest.fn((email, password, phoneNumber) => {
        return Promise.resolve({
          user: { email, phoneNumber },
          access_token: 'mockToken',
        });
      }),
    };

    const module: TestingModule = await Test.createTestingModule({
      controllers: [AppController],
      providers: [
        {
          provide: AuthService,
          useValue: mockAuthService,
        },
      ],
    }).compile();

    appController = module.get<AppController>(AppController);
    authService = module.get<AuthService>(AuthService);
  });

  describe('login', () => {
    it('should return a JWT token', async () => {
      const result = await appController.login({
        body: { email: 'test@test.com', password: 'password' },
      });
      expect(result).toEqual({ access_token: 'mockToken' });
      expect(authService.login).toHaveBeenCalledWith(
        'test@test.com',
        'password',
      );
    });
  });

  describe('signup', () => {
    it('should return a JWT token and user data', async () => {
      const result = await appController.signup({
        email: 'newuser@test.com',
        password: 'newpass',
        phoneNumber: '1234567890',
      });
      expect(result).toEqual({
        user: { email: 'newuser@test.com', phoneNumber: '1234567890' },
        access_token: 'mockToken',
      });
      expect(authService.signup).toHaveBeenCalledWith(
        'newuser@test.com',
        'newpass',
        '1234567890',
      );
    });
  });
});
