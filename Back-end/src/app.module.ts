// app.module.ts
import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose'; // Corrected import
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { AppController } from './app.controller';
import { VolunteerOpportunitiesModule } from './volunteer-opportunities/volunteer-opportunity.module';

@Module({
  imports: [
    MongooseModule.forRoot('mongodb://localhost:27017/Ankelba3'),
    AuthModule,
    UsersModule,
    VolunteerOpportunitiesModule,
  ],
  controllers: [AppController],
  // ... other configurations
})
export class AppModule {}
