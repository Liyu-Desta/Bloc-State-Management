import mongoose, { Document, Schema } from 'mongoose';
import { User } from '../users/users.model'; // Adjust path as necessary
import { VolunteerOpportunity } from './volunteer-opportunity.model';

export interface Booking extends Document {
  user: mongoose.Types.ObjectId | User;
  opportunity: mongoose.Types.ObjectId | VolunteerOpportunity;
}

export const BookingSchema = new Schema<Booking>({
  user: { type: Schema.Types.ObjectId, ref: 'User', required: true },
  opportunity: {
    type: Schema.Types.ObjectId,
    ref: 'VolunteerOpportunity',
    required: true,
  },
  // Additional fields as necessary
});

// Create the model and export it
export const BookingModel = mongoose.model<Booking>('Booking', BookingSchema);
