import mongoose, { Document, Schema } from 'mongoose';
import { User } from '../users/users.model'; // Adjust path as necessary
import { VolunteerOpportunity } from './volunteer-opportunity.model';

export interface Booking extends Document {
  userId: mongoose.Types.ObjectId | User;
  opportunityId: mongoose.Types.ObjectId | VolunteerOpportunity;
  selectedDate:String,
  date: String;
 
}

export const BookingSchema = new Schema<Booking>({
  userId: { type: Schema.Types.ObjectId, ref: 'User', required: true },
  opportunityId: {
    type: Schema.Types.ObjectId,
    ref: 'VolunteerOpportunity',
    required: true,
  },
  date : {type: String},
  selectedDate :{type: String },
  
  // Additional fields as necessary
});

// Create the model and export it
export const BookingModel = mongoose.model<Booking>('Booking', BookingSchema);
