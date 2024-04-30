import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { VolunteerOpportunity } from './volunteer-opportunity.model';
import { Booking } from './booking.model';

@Injectable()
export class VolunteerOpportunitiesService {
  constructor(
    @InjectModel('VolunteerOpportunity')
    private opportunityModel: Model<VolunteerOpportunity>,
    @InjectModel('Booking') private bookingModel: Model<Booking>,
  ) {}

  // Existing opportunity methods...
  async create(opportunityData): Promise<VolunteerOpportunity> {
    const newOpportunity = new this.opportunityModel(opportunityData);
    return newOpportunity.save();
  }

  async findAll(): Promise<VolunteerOpportunity[]> {
    return this.opportunityModel.find().exec();
  }

  async update(id: string, opportunityData): Promise<VolunteerOpportunity> {
    return this.opportunityModel
      .findByIdAndUpdate(id, opportunityData, { new: true })
      .exec();
  }

  async remove(id: string): Promise<VolunteerOpportunity> {
    return this.opportunityModel.findOneAndDelete({ _id: id }).exec();
  }
  // Booking functions

  async bookOpportunity(
    userId: string,
    opportunityId: string,
  ): Promise<Booking> {
    try {
      console.log(`Booking opportunity: ${opportunityId} for user: ${userId}`);
      const newBooking = new this.bookingModel({
        user: userId,
        opportunity: opportunityId,
      });
      return await newBooking.save();
    } catch (error) {
      console.error('Error booking opportunity:', error);
      throw error; // Re-throw the error so it can be handled by NestJS
    }
  }

  async getUserBookings(userId: string): Promise<Booking[]> {
    return this.bookingModel
      .find({ user: userId })
      .populate('opportunity')
      .exec();
  }

  async unbookOpportunity(bookingId: string): Promise<any> {
    return this.bookingModel.findOneAndDelete({ _id: bookingId }).exec();
  }

  async getOpportunityBookings(opportunityId: string): Promise<Booking[]> {
    return this.bookingModel
      .find({ opportunity: opportunityId })
      .populate('user')
      .exec();
  }
}
