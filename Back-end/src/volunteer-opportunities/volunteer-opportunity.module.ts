// src/volunteer-opportunities/volunteer-opportunities.module.ts

import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { VolunteerOpportunitiesController } from './volunteer-opportunity.controller';
import { VolunteerOpportunitiesService } from './volunteer-opportunity.service';
import { VolunteerOpportunitySchema } from './volunteer-opportunity.model';
import { BookingSchema } from './booking.model';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: 'VolunteerOpportunity', schema: VolunteerOpportunitySchema },
      { name: 'Booking', schema: BookingSchema },
    ]),
  ],
  controllers: [VolunteerOpportunitiesController],
  providers: [VolunteerOpportunitiesService],
})
export class VolunteerOpportunitiesModule {}
